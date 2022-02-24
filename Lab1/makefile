lab1_awk:
	@awk -f 'lab1.awk' ../d66a59b6db4e59c16efd4c42ad411f8e/data.csv | awk 'NR<=1{print $0; next}{print $0 | "sort -t ',' -n -k8 -r"}' | awk '{if(NR==1) printf("Rank, "); else printf("%s ," ,NR-1);print;}' > resultdata.csv
	@echo Top 3 cars:
	@awk 'NR<5{print $0}' resultdata.csv



