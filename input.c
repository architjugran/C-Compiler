int fact(int x)
{
	if(x==0)
	{
		return 1;
	}
	return x*fact(x-1);
}
int main()
{
	int x;
	x=4;
	int y;
	y=fact(x)-1;

}
