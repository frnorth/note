for i in `echo "keys *" | redis-cli`; do echo -en "\033[36m$i\t\033[0m: " ;echo "get $i" | redis-cli ; done
