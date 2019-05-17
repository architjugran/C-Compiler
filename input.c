int main()
{
	int x;
	x=4;


	switch(x)
	{
		case 1:printf(1);
				break;
		case 2:printf(2);
		case 3:printf(3);
		default: printf(5);
	}
	x=0;
	while(x<=3)
	{
		int j;
		for(j=0;j<3;j=j+1)
		{
			printf(j);
			if(j==1)
				{break;}
			
		}
		x=x+1;
		if(x==2)
			{break;}
	}
	break;


	return 1;
}
