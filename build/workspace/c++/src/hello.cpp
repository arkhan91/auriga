#include <iostream>
#include <cmath>
using namespace std;
using std::cout;
using std::cin;

int mulitply(int , int );

template<typename T> 
T adders (T a, T b) 
{
    return a+b;
}

int  main(int argc, const char** argv) {
    cout << "Hello World" <<endl;

    int slice = 5;
    int num_a;

    cout << "Slice x Slice " << mulitply(slice,slice) <<endl;
    
    cout << "Enter a number" <<endl;
    /* cin>>num_a;*/
    num_a = slice;
    cout << "Power of entered number is "<< mulitply(num_a,num_a) <<endl;


    char x = 'A';

    cout << "Char  " << x << " Casting "<<int(x)  <<endl;
    const int y =4;
    cout << "Char  " << y << " Casting "<<int(y)  <<endl;
    cout << mulitply(y,2)<<endl;
    cout << adders(5.9,2.8)<<endl;


   return 0; 
}

int mulitply(int x, int y)
{
    return x * y;
}