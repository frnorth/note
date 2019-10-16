sum=0
for i in `cat bill.md | awk '{print $NF}' | grep -v 2019 | grep -v '^ *$'`
do
	echo -ne "$i\t"
	let "sum = $sum + $i"
	echo $sum
done
echo $sum
