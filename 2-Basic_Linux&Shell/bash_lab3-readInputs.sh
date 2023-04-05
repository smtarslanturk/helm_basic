mission_name=lunar-mission
mkdir $mission_name
rocket-add $mission_name
rocket-start-power $mission_name
rocket-internal-power $mission_name
rocket-start-sequence $mission_name
rocket-start-engine $mission_name
rocket-lift-off $mission_name
rocket-status $mission_name
./create-lunar.sh 

mission_name=$1
mkdir $mission_name
rocket-add $mission_name
rocket-start-power $mission_name
rocket-internal-power $mission_name
rocket-start-sequence $mission_name
rocket-start-engine $mission_name
rocket-lift-off $mission_name
rocket-status $mission_name
./create-lunar.sh lunar-mission
------------------------------------
echo "Capital city of UK is London"
./print-capital.sh

echo "Capital city of $1 is $2"
./print-capital.sh Turkey Ankara 

------------------------------------
# This script creates a backup of a given file by creating a copy as bkp
# For example some-file is backed up as some-file_bkp
set -e
file_name=$1
cp $file_name ${file_name}_bkp
echo "Done"
./backup-file.sh create-and-launch-rocket

------------------------------------
new_shell="$2"
user_name="$1"
usermod -s  $new_shell $user_name 