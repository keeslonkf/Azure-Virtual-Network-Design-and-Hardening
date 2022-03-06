#!/bin/bash

#Create List of favorite states
fav_states=( 'Georgia' 'Texas' 'Hawaii' 'Tennessee' 'Florida' )

#Create a for loop that checks if the state is Hawaii
for state in ${fav_states[@]}
do
 if [ $state == 'Hawaii' ];
 then
  echo " Hawaii is the best! "
 else
  echo " I'm not fond of Hawaii "
 fi
done

#Create a list of numbers
nums=$(echo {0..9})

#Create a for loop that prints out 1,3,5,7 from list
for num in ${nums[@]}
do
  if [ $num == 3 ] || [ $num == 5 ] || [ $num == 7 ];
  then
   echo $num
  fi
done


#Create a variable that holds the output of the "ls" command
list=$(ls)

#Create a for loop that prints out each item of the variable
for i in ${list[@]};
 do
  echo $i
done
