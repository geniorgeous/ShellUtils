#!/bin/bash


pipeGitLog () {
  let index=0
  while IFS= read line; do
    let "index+=1"
    if [[ `echo "${line}" | grep -e "commit [a-z0-9]\{7\}" | wc -l` -eq 1 ]]; then
      let "index=0"
      echo "$year-$month-$day $commit $author $comment"
    fi
    #echo "Line ${i}: ${line}"
    if [[ $index -eq 0 ]]; then
      commit="$line"
    elif [[ $index -eq 1 ]]; then
      author=`echo "$line" | cut -d \  -f 2`
    elif [[ $index -eq 2 ]]; then
      month=`echo "$line" | egrep -o "Jan...|Feb...|Mar...|Apr...|May...|Jun...|Jul...|Aug...|Sep...|Oct...|Nov...|Dec..." | sed "s/Jan/01/g" | sed "s/Feb/02/g" | sed "s/Mar/03/g" | sed "s/Apr/04/g" | sed "s/May/05/g" | sed "s/Jun/06/g" | sed "s/Jul/07/g" | sed "s/Aug/08/g" | sed "s/Sep/09/g" | sed "s/Oct/10/g" | sed "s/Nov/11/g" | sed "s/Dec/12/g"`
      year=`echo "$line" | egrep -o "2023|2022|2021|2020|2019|2018"`
      if [[ `echo "$month" | sed "s/\s//g" | wc -c` -eq 4 ]]; then
        day="0"`echo $month | cut -c4`
      else
        day=`echo $month | cut -c-5 | cut -c4-`
      fi
      month=`echo $month | cut -c-2`
    elif [[ $index -eq 4 ]]; then
      comment=`echo $line | sed "s/\t//g"`
    fi
  done
} 

gitlog=`git --no-pager log --abbrev-commit --no-merges`

echo -e "$gitlog" | pipeGitLog

