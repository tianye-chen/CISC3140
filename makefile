lab1:
	@awk -f './Lab1/lab1.awk' ./d66a59b6db4e59c16efd4c42ad411f8e/data.csv | awk 'NR<=1{print $0; next}{print $0 | "sort -t ',' -n -k8 -r"}' | awk '{if(NR==1) printf("Rank, "); else printf("%s ," ,NR-1);print;}' > ./Lab1/resultdata.csv
	@echo Result file outputted to ./Lab1/resultdata.csv
	@echo Top 3 cars:
	@awk 'NR<5{print $0}' ./Lab1/resultdata.csv

lab2:
	@awk -F "," '{for(i = 1; i <= 8; i++) { if (i==1) {if(NR != 1) {split($$1, date, /[/ ]/); $$1 = date[3] "/" date[1] "/" date[2] " " date[4];} printf("%s ,", $$1)} else if(i == 8) printf("%s ", $$i); else printf("%s ,", $$i)}; print ""}' ./d66a59b6db4e59c16efd4c42ad411f8e/data.csv > ./Lab2/table1.csv
	@awk -F "," '{for(i = 8; i <= 9; i++) {if (i == 9) printf("%s ", $$i); else printf("%s ,", $$i)}; print ""}' ./d66a59b6db4e59c16efd4c42ad411f8e/data.csv > ./Lab2/table2.csv
	@awk -F "," '{for(i = 7; i <= NF; i++) {if(i == 7 || i >= 10) if(i == NF) printf("%s ", $$i); else printf("%s ,", $$i)}; print ""}' ./d66a59b6db4e59c16efd4c42ad411f8e/data.csv > ./Lab2/table3.csv