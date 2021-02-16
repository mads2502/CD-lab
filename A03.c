//MADHUMITHA S
//185001086
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
main(){
	int n,i=0,j=0,pos,k=0,v=0;
	char starr[30][30],st[30];//starr is the array containg the strings/productions
	char c;
	char alp[30],beta[30];
	printf("\nELIMINATING IMM. LEFT RECURSION \nINPUT GRAMMAR");
	printf("\n---------------------------------------\n");
	printf("\nEnter no of productions:");scanf("%d",&n);
	for(i=0;i<n;i++){
		printf("\nTYPE Production : ");            
		scanf("%s",st);
		strcpy(starr[j++],st);
		printf("Typed production is: %s\n",st);
	}

printf("\nOUTPUT GRAMMAR\n");
printf("Rectified productions\n");
	for(i=0;i<j;i++){
       if(starr[i][3]==starr[i][0]){
       	//printf("LR present\n");
       	strcpy(alp,"");
       	strcpy(beta,"");
       	k=0;
       	pos=3;//the 3rd element is the possible place of direct/immediate recursion
       	pos=pos+1;
        while(starr[i][pos]!='|'){
             alp[k++]=starr[i][pos];

             pos++;//extracting alpha value
        }
        alp[k]='\0';
        //printf(" ---------\n");
        //printf("|%s-ALPHA|\n",alp);
        //printf(" ---------\n");
        v=0;
        pos++;
        while(starr[i][pos]!='\0'){
        	beta[v++]=starr[i][pos];
        	pos++; //extracting beta value
        }
        beta[v]='\0';
        //printf(" ---------\n");
        //printf("|%s-BETA\n|",beta); these are check values after isolating alpha and beta
        //printf(" ---------\n");
        printf("\n");
        //printf("\nRectified production for %s :",starr[i]);
        printf(" %c->%s%c\'\n",starr[i][3],beta,starr[i][3] );
        printf(" %c\'->%s%c\'/Epsilon\n",starr[i][3],alp,starr[i][3] );
      

       }
       else{
       	//printf("NO LR\n");
       	printf("\n%s\n",starr[i]);}
	}
	return 0;
}