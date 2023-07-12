#!/bin/bash

# Set initial time
initial_time=$(date +"%Y-%m-%d %H:%M:%S")
year=$(date -d "$initial_time" +"%Y")
month=$(date -d "$initial_time" +"%m")
day=$(date -d "$initial_time" +"%d")
hour=$(date -d "$initial_time" +"%H")
minute=$(date -d "$initial_time" +"%M")
second=$(date -d "$initial_time" +"%S")

# Function to validate date
isValidDate(){
  date -d "$1" > /dev/null 2>&1
  if [[ $? -eq 1 ]]; then
    echo "Error: The input time '$1' is not a valid date/time."
    usage
    exit 1
  fi
}

# Define usage function
usage() { 
  echo "Usage: $0 [-h hour] [-m minute] [-s second] [-d day] [-M month] [-y year] [-a full_date]" 1>&2
  echo "Examples:"
  echo "- To modify hour and minute: -h $hour -m $minute"
  echo "- To modify hour and minute relatively: -h -1 -m +3"
  echo "- To modify month and day: -M $month -d $day"
  echo "- To specify a full date: -a $initial_time"
}

rerun(){
  usage
  read -p "Please enter the time or options: " input_time
  # Run this script again with the input_time as arguments
  eval "$0 $input_time"
  exit 0
}

# If there are no arguments, ask for user input
if [ $# -eq 0 ]; then
  rerun
fi

# Parse input arguments
while getopts ":h:m:s:d:mo:M:y:a:" o; do
  case "${o}" in
    h)
      if [[ ${OPTARG:0:1} == "+" ]]; then
        hour=$(date -d "$initial_time ${OPTARG#'+'} hour" +"%H")
      elif [[ ${OPTARG:0:1} == "-" ]]; then
        hour=$(date -d "$initial_time ${OPTARG#"-"} hour ago" +"%H")
      else
        hour=${OPTARG}
      fi
      ;;
    m)
      if [[ ${OPTARG:0:1} == "+" ]]; then
        minute=$(date -d "$initial_time ${OPTARG#'+'} minute" +"%M")
      elif [[ ${OPTARG:0:1} == "-" ]]; then
        minute=$(date -d "$initial_time ${OPTARG#"-"} minute ago" +"%M")
      else
        minute=${OPTARG}
      fi
      ;;
    s)
      if [[ ${OPTARG:0:1} == "+" ]]; then
        second=$(date -d "$initial_time ${OPTARG#'+'} second" +"%S")
      elif [[ ${OPTARG:0:1} == "-" ]]; then
        second=$(date -d "$initial_time ${OPTARG#"-"} second ago" +"%S")
      else
        second=${OPTARG}
      fi
      ;;
    d)
      if [[ ${OPTARG:0:1} == "+" ]]; then
        day=$(date -d "$initial_time ${OPTARG#'+'} day" +"%d")
      elif [[ ${OPTARG:0:1} == "-" ]]; then
        day=$(date -d "$initial_time ${OPTARG#"-"} day ago" +"%d")
      else
        day=${OPTARG}
      fi
      ;;
    M)
      if [[ ${OPTARG:0:1} == "+" ]]; then
        month=$(date -d "$initial_time ${OPTARG#'+'} month" +"%m")
      elif [[ ${OPTARG:0:1} == "-" ]]; then
        month=$(date -d "$initial_time ${OPTARG#"-"} month ago" +"%m")
      else
        month=${OPTARG}
      fi
      ;;
    y)
      if [[ ${OPTARG:0:1} == "+" ]]; then
        year=$(date -d "$initial_time ${OPTARG#'+'} year" +"%Y")
      elif [[ ${OPTARG:0:1} == "-" ]]; then
        year=$(date -d "$initial_time ${OPTARG#"-"} year ago" +"%Y")
      else
        year=${OPTARG}
      fi
      ;;
    a)
      isValidDate "${OPTARG}"
      year=$(date -d "${OPTARG}" +"%Y")
      month=$(date -d "${OPTARG}" +"%m")
      day=$(date -d "${OPTARG}" +"%d")
      hour=$(date -d "${OPTARG}" +"%H")
      minute=$(date -d "${OPTARG}" +"%M")
      second=$(date -d "${OPTARG}" +"%S")
      ;;
    *)
      rerun
      ;;
  esac
done
shift $((OPTIND-1))

# Create time string and validate it
time="$year-$month-$day $hour:$minute:$second"
isValidDate "$time"
time=$(date -d "$time")

echo "Changing the last commit's time to $time"
read -n1 -p "Continue? (y/n)" answer
echo
if [[ $answer == "y" ]]; then
  echo "Changing time..."
  GIT_AUTHOR_DATE="$time" GIT_COMMITTER_DATE="$time" git commit --amend --date="$time"
  echo "Done!"
else
  echo "Exiting..."
fi
exit 0
