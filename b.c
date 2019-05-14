#include <stdio.h>
#include <string.h>
#define filename "a.txt"

FILE *fp;

void backpatch(int* arr, int len, int x)
{
	fseek(fp,0,0);
	int currLineNumber = 1;
	for (int i = 0; i < len; ++i)
	{
		while(1)
		{
			if(currLineNumber == arr[i])
			{
				char temp[100];
				sprintf(temp, "%d: goto %d", currLineNumber,x);
				char cln[100];
				sprintf(cln, "%d", currLineNumber);
				int totallinelen = strlen(cln) + 12;
				int spaceleft = totallinelen-strlen(temp);
				while(spaceleft--)
					sprintf(temp, "%s ", temp);
				fputs(temp, fp);
				break;
			}
			char c = getc(fp);
			if(c=='\n')
			{
				currLineNumber++;
			}
		}
	}
	fseek(fp, 0, SEEK_END);
}

int main()
{
	int arr[2] = {5,10};
	int len = 2;
	int x = 11;
	fp=fopen(filename, "r+");

	backpatch(arr, len, x);
	return 0;
}