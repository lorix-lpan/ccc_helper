#!/bin/bash

validation(){
  #$1 => requirement(regex)
  #$2 => input instruction
  #$3 => returned variable name(TYPE)
  #$4 => error messages
  echo "$2"
  local input
  read input
  if ! [[ "$input" =~ $1 ]];then
    echo "$4"
    validation "$1" "$2" "$3" "$4"
  else
    eval "$3"="$input"
  fi
}


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
  # This function only supports up to 2004
  if (("$2" < 2004));then
    echo "This year is not supported"
    exit 1
  fi
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

    # Since the site is extremely not consistent :-). It is necessary to use a
    # simple if statement to resolve the route of the file
    local first
    local second
    local download_zip
    if (("$2" >= 2009 && "$2" <= 2013));then
      first="stage1/"
      second="Stage1Data/"
      download_zip="UNIX_OR_MAC.zip"
    elif (("$2" >= 2014));then
      first=""
      second=""
      download_zip="UNIX_OR_MAC.zip"
    elif (("$2" >= 2004 && "$2" < 2009));then
      first="stage1/"
      second=""
      download_zip="data.zip"
    fi
    wget https://cemc.math.uwaterloo.ca/contests/computing/"$2"/"$first""$second""$download_zip"

    # Check if it is successfully downloaded
    if [[ -e "$download_zip" ]];then
      unzip "$download_zip" > /dev/null
      rm -r "$download_zip"
      local folder
      local regex_dir
      regex_unix='.+_.+_.+'
      regex_general='.+'
      possible_name=("$regex_unix" "$regex_general")
      for i in ${possible_name[@]}; do
        folder=$(ls | grep -E -w "$i")
        echo "$folder"
        if [[ "$folder" != "" ]];then
          break
        fi
      done

      cd "$folder"
      # In case if the files are duplicated and placed in two directories namely
      # Windows and Unix_or_mac
      if ! [[ $folder =~ $regex_dir ]];then
        folder_sub=$(ls | grep -E -w "$regex_dir")
        # This action has no harm even if $folder_sub contains an empty string
        cd $folder_sub
      fi

      # Substring, get the first letter of $level
      # "${3:0:1}"
      # grep -i ignores case
      folder_path=$(find . | grep -i "${3:0:1}$4$")
      cp "$folder_path"/* "$5"
      echo "Success"
      clean_garbage
      exit 1
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

# Beginning of the script
clear

validation '^[12][09][019][0-9]$' "Which year" "year" "Invalid input, input year between 199* to 201*"
# Return $year

evaluation "s" "j" "Senior" "Junior" "level" 
# Return $level
evaluation "p" "c" "python" "cplusplus" "language"
# Return $language

validation '^[1-5]$' "Which question(1..5)" "number" "Your input has to be in range 1-5"
# Return $number

validation '^.+' "Question name?" "name" "The name cannot be blank"
# Return $name

validation '^.+' "Please input the name of the file" "filename" "The name cannot be blank"
# Return $filename

destination=~/workspaces/ccc/"$year"/"$language"/"$level"/"$number"."$name"/

mkdir -p "$destination"
cd "$destination"

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
