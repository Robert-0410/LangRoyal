# TODO: append a time stamp

date +"%Y-%m-%d %H:%M:%S" >> output.log

for i in {1..1000};\
	do\
		curl\
			-s\
			-w "%{time_total}\n"\
			-o /dev/null\
			http://localhost:8080/perform >> output.log;\
		done