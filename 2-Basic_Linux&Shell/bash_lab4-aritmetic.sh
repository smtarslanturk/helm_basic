A=20
B=10
echo "Sum is $(( A + B))"
echo "Difference is $(( A - B))"
echo "Product is $(( A * B))"
echo "Quotient is $(( A / B))"
./calculate.sh 
------------------------------------

A=$1
B=$2
echo "Sum is $(( A + B))"
echo "Difference is $(( A - B))"
echo "Product is $(( A * B))"
echo "Quotient is $(( A / B))"
./calculation.sh 4 2

A=$1
B=$2
echo "Sum is $(( $1 + $2 ))"
echo "Difference is $(( $1 - $2 ))"
echo "Product is $(( $1 * $2 ))"
echo "Quotient is $(( $1 / $2 ))"
./calculation.sh 4 2

------------------------------------
number1=$1
number2=$2
echo "The total price for items is $(( number1 * number2 )) dollars"
./calculate-price.sh 2 5 

price=$(( $1 * $2 ))
echo "The total price for items is ${price} dollars"
./calculate-price.sh 2 5 

------------------------------------
baskets=4
apples_per_basket=5
total_apples=`expr $baskets \* $apples_per_basket`
echo "Total Apples = ${total_apples}"
./calculate-price.sh

------------------------------------
avr=$(echo "scale=2; ($1+$2+$3)/3" | bc -l)
echo "average of 3 numbers = ${avr}"
# Scale ifadesi virgulden sonra kac basamak kullanilacagi hakkinda bilgi verir. 


num1=$1
num2=$2
num3=$3
sum=$(( num1 + num2 + num3 ))
average=$(echo "$sum / 3" | bc -l)
echo $average