#!/bin/bash

evaluation(){
  #$1 => letter_one
  #$2 => letter_two
  #$3 => option_one
  #$4 => option_two
  #$5 => TYPE
  echo "$3 or $4[$1/$2]"
  local input
  read input
  if [[ "$input" == "$1" || "$input" == "${1^^}" ]];then
    eval "$5"=$3
  elif [[ "$input" == "$2" || "$input" == "${2^^}" ]];then
    eval "$5"=$4
  else
    echo "Invalid input!"
    evaluation "$1" "$2" "$3" "$4" "$5"
  fi
  #A global variable name $TYPE is declared
}

extract_data(){
  # Get test data
  # $1 => input(y/n)
  # $2 => year
  # $3 => level
  # $4 => question number
  # $5 => destination
  if [[ "$1" != "N" || "$1" != "n" ]];then
    num=$RANDOM
    mkdir ~/data-"$num"
    cd ~/data-"$num"
    if (("$2" >= 2009));then
      wget https://cemc.math.uwaterloo.ca/contests/computing/"$2"/stage1/Stage1Data/UNIX_OR_MAC.zip
    else
      wget https://cemc.math.uwaterloo.ca/contests/computing/"$2"/stage1/Stage1Data/data.zip
    fi
    local zip_name
    zip_name=$(ls | grep .zip)
    if [[ -e "$zip_name" ]];then
      unzip "$zip_name"
      rm -r "$zip_name"
      # Since there is only one file/directory in the current dir
      local folder
      if (("$2" >= 2009));then
        folder=$(ls | grep .*_.*_.*)
      else
        folder=$(ls | grep .)
      fi
      cd "$folder"
      if (($(ls -1 | wc -l) <= 3));then
        # cd into senior/junior
        # Bash 4.0 sytax, downcase all the letters of the string $level
        # "${3,,}"
        cd "${3,,}"
        local name_file_
        name_file_=$(ls | grep "$4")
        cp "$name_file_"/* "$5"
        echo "Success"
        clean_garbage
      else
        echo "The operation is not currently supported"
        clean_garbage
        exit 1
      fi

      # Substring, get the first letter of $level
      # "${3:0:1}"
      #if [[ -d "$5" ]];then
      #  cp "${3,,}"/"${3:0:1}"/* "$5"
      #  echo "success"
      #else
      #  echo "Unable to find directory: $5"
      #  exit 1
      #fi
    else
      echo "Unable to download the required file from cemc.math.uwaterloo.ca"
      clean_garbage
      exit 1
    fi
  fi
}

clean_garbage(){
  rm -r ~/data-"$num"
}

clear
echo "Please input the year"
read year

evaluation "s" "j" "Senior" "Junior" "level" 
# Return $level
evaluation "p" "c" "python" "cplusplus" "language"
# Return $language

echo "Which question(1..5)"
read number
echo "Question name?"
read name

destination=~/workspaces/ccc/"$year"/"$language"/"$level"/"$number"."$name"/

mkdir -p "$destination"
cd "$destination"
echo "Please input the name of the file"
read filename
if [[ $language == "python" ]];then
  touch "$filename".py
elif [[ $language == "cplusplus" ]];then
  touch "$filename".cpp
else
  echo "Error! exiting"
  exit 1
fi

echo "With test data[y/n]"
read data
extract_data "$data" "$year" "$level" "$number" "$destination"
