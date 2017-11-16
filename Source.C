#include <iostream>
#include <iomanip>
#include <time.h>
#include <stdlib.h>
using namespace std;

typedef long long LONG;

const LONG NOT_REL_PRIME=-999;

LONG euclid_gcd(LONG a,LONG b)
{
	LONG r;
	if(a==0)
	return b;
if(b==0)
return a;
r=a%b;
return euclid_gcd(b,r);
}

void euclid(LONG n,LONG e, LONG &d)
{
LONG k;
LONG q;
LONG r;
LONG c=d;
LONG temp;
q=n/e;
r=n%e;
if(r==1)
{
d=-q;
}
else
{
euclid(e,r,temp);
if(temp==NOT_REL_PRIME)
{
d=NOT_REL_PRIME;
return;
}
k=(r*temp-1)/e;
d=-(q*temp+k);
}
d%=n;
if(d<0)
d+=n;
}


int main()
{
LONG a;
LONG b;
LONG c;
LONG d;
LONG j;
LONG k;
LONG r;
float diff;
float sec1;
float sec2;
int n;
cout.setf(ios::showpoint|ios::fixed);
cout<<"Enter a and b:";
cin>>a>>b;
cout<<"ENter the valu of c: ";
cin>>c;
if(cin.fail())
return 1;
if((a>0) && (b>0))
{
sec1=clock()/float(CLOCKS_PER_SEC);
d=euclid_gcd(a,b);

sec2=clock()/float(CLOCKS_PER_SEC);
diff=sec2-sec1;
}

if(c%d!=0)
cout<<"NO Solution exists"<<endl;
else
{
r=c/d;
k=c;
euclid(a/d,b/d,k);
j=(d-(b*k))/a;
if(j<0)
{
j=b+j;
k=k-a;
}
n=int((j*r)/(b/d));

if((k*r+(n*a/d))<0)
cout<<a<<" * "<<j*r-(n*b/d)<<" - "<<b<< " * "<<abs(k*r + (n*a/d))<< " = " <<c;
else
cout<<a<<" * "<<j*r-(n*b/d)<<" + "<<b <<" * "<<k*r+(n*a/d)<<" = "<<c;
}
}
