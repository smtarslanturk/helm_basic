mission_name=lunar-mission

mkdir $mission_name

rocket-add $mission_name
rocket-start-power $mission_name
rocket-internal-power $mission_name
rocket-start-sequence $mission_name
rocket-start-engine $mission_name
rocket-lift-off $mission_name

rocket-status $mission_name

------------------------------------
# Variable should be encapsulated in { }. Change variable to ${file_name}_bkp
up_time=$(uptime)
echo "The uptime of the system is ${up_time}"
------------------------------------
Make sure that the variable names that are defined are actually the ones being used in the script.


NOT: 
- design your script re-useable. 
- Script shouldnt be require to be edited before running. 
- Use command line arguments to pass input. 

- Comand line argumanda direk $1 gibi argumani kod satirinda vererek islem yapiyoruz. 
Bunun yerine kullanicidan input isteyecek sekilde de duzenlemeyi yapabiliriz. 
Mesela bu girdiyi asagidaki gibi alabiliriz.    
### read –p "Enter mission name:" mission_name
