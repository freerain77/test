#!/bin/bash
# test the using of function
# get the result using:result=$(fun) all echo in fun will be saved in result
myfun(){
  echo "hello,This is my first function"
  echo "which line will be returned?"
  a=10
  echo "$[ $a + 6 ]"
}
result=$(myfun)
echo "$result"

#using global variant get result 利用全局变量获取返回值
#using 'local' to define local var name to avoid conflicting with varname in  main shell
get= 1 #返回值全局变量
myfun2(){
  if [ -z $1 ];then #函数中的参数$1..n 与脚本参数不冲突
	local a=0  #local var a局部变量不影响全局变量a
        echo "input a numbwer"
        read a
        get=$[ $a * 2 ]
  else
	get=$[ $1 * 2 ]  
  fi 
  }
a=9 #gloabal var a全局变量a
#myfun2			#不带参数
#echo "$get"
#myfun2 2		#带参数
#echo "$get" # 4
#echo $a #a=9

#数组参数
arr=(1 2 3 4 5)
myfun3(){
  echo "\$1=$1 \$*=$* \$@=$@"
  localarr=$1 #是五个独立参数，$1-$5因此只获取第一个值
  echo "localarr=${localarr[*]} size=${#localarr[*]}"
  #要使用数组必须重新将五个参数组合成数组
  newarray=($(echo "$@"))

  echo "newarray=${newarray[*]}"
  for i in ${newarray[*]};do
	  echo "\$i=$i"
	  echo "${resultarr[*]} $[$i * 2]"
	  resultarr=($(echo "${resultarr[*]} $[$i * 2]"))
	  echo "resultarr=${resultarr[*]}"
  done	 
  echo "resultarr=${resultarr[*]}"
}
myfun3 ${arr[*]} #这样传递会将arr值作为五个独立参数传递

#数组参数和返回数组参数
myfun4(){
  orignalarr=($(echo "$@")) #参数重组为数组
  count=$[$# - 1]
  for((i=0;i<=$count;i++)){
    orignalarr[i]=$[${orignalarr[i]} * 2]
  }
  echo "${orignalarr[*]}"
}

echo "======myfun4=========="
arr=(1 2 3 4 5)
b=($(myfun4 ${arr[*]}))  #返回数组 完成任务
echo "bsize=${#b[*]} b=${b[*]}"
ra=($(echo "$b")) #$b只返回第一个元素
echo "size=${#ra[*]} ${ra[*]}"

