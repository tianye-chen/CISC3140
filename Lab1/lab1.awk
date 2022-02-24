#!/bin/awk -f

BEGIN{
	FPAT = "([^,]+)|(\"[^\"]+\")";	
}

{
	for (i = 1; i <=8; ++i){
		if (i <= 7)
			printf("%s , ", $i);
		else if(NR == 1)
			print("total");		
	}
	if(NR != 1){
		total = 0;
		for (i=8; i <= 32; ++i){
			total += $i;
		}
		printf("%s, \n", total);
	
	}
}
END{
}
