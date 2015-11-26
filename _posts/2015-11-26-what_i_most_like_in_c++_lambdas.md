---
layout: post
title:  "What I most like in C++ - [lambdas]"
date:   2015-11-26
category: Programming
tags: 
- C++
- std
- standard-library
- lambda
---

<!-- ####################################################################### -->
<!-- ####################################################################### -->


### Intro

Starting the series of posts of the 
[What I most like in C++](https://n2omatt.github.io/programming/2015/11/10/what_i_most_like_in_c++_intro.html)
we gonna talk today about ```lambdas```.

This is a great feature in C++ that enable us to write very conside and 
yet clear code.

So let's start...


<!-- ####################################################################### -->
<!-- ####################################################################### -->

### Lambdas:

This is the __MOST__ (__IMHO__) important and cool feature that was added in C++11. 
Before ```lambdas``` some STL algorithms was very cumbersome to use (like 
```std::for_each```), not to say that some patterns was __very__ hard to achieve 
with a clean style.

So, for a formal description you can read: 

* [cppreference.com](http://en.cppreference.com/w/cpp/language/lambda).
* [cprogramming](http://www.cprogramming.com/c++11/c++11-lambda-closures.html).
* [msdn](https://msdn.microsoft.com/en-us/library/dd293608.aspx).
* [stackoverflow](http://stackoverflow.com/questions/7627098/what-is-a-lambda-expression-in-c11).
* [drdobbs.com](http://www.drdobbs.com/cpp/lambdas-in-c11/240168241).
* [wikipedia [1]](https://en.wikipedia.org/wiki/C%2B%2B11)
* [wikipedia [2]](https://en.wikipedia.org/wiki/Anonymous_function)


<!-- ####################################################################### -->
<br>

Let's show some examples of usage of ```lambdas```:

#### Example 1

{% highlight c++ %}
//Declare the lambda object - Notice that I'm using
//the auto specifier that will be covered later.
auto callback = [](){
    cout << "Done..." << endl;  
};

//Use the lambda object - WOW... This is like a function call.
callback();
{% endhighlight %}

In this example, I'm just creating a lambda object that accepts no 
arguments, has a return of type ```void``` and doesn't capture anything 
from the outer scope.   
In a less restrictive view, is like as I just declare a function in place.


<!-- ####################################################################### -->
<br>

Let's create a ```lambda``` that accepts some arguments and returns 
something useful.

#### Example 2

{% highlight c++ %}
//Creating a lambda that accepts two ints and returns the 
//first power the second.
//Notice that I'm not specifying the return type, so it's 
//gets assumed from the type of the return type.
auto power = [](int base, int exp) {
    return pow(base, exp);
}

cout << power(2, 10) << endl; // Prints 1024.
cout << power(3,  3) << endl; // Prints    9.
{% endhighlight %}

So again, I'm creating a ```lambda``` object, but now it gets two 
arguments of the type ```int``` and returns the same type that the 
function ```pow(x,y)``` returns. This is very cool feature, 
you aren't enforced to declare the type of the return ( _in this case_ ). 

But the magic happens when use some more advanced capture specifiers.   
This enables you to create very powerful and yet clean code that wasn't 
possible (easily at least), before the C++11.


<!-- ####################################################################### -->
<br>

So now, let's create a simple ```lambda``` by using the ```[=]``` capture 
specifier. This specifier means that we "capture" everything from the outer 
scope by value i.e everything gets copied.

#### Example 3a - Using Lambdas.

{% highlight c++ %}
int x = 10;
int y = 100;
auto lambda = [=](int z){
    return (x < z) && (z < y); //z is in the range (x,y)?
}

cout << lambda(20)  << endl; // Prints 1 (true).
cout << lambda(0)   << endl; // Prints 0 (false).
cout << lambda(100) << endl; // Prints 0 (false).
{% endhighlight %}


<!-- ####################################################################### -->

Still, very simple, but consider what was required to be done 
without the ```lambda```

#### Example3b - Using Function Objects (Functors).
{% highlight c++ %}

//Declare the Functor class.
class Functor
{
public:
    //Since we cannot capture anything we must initialize
    //our function with the arguments that we want.
    Function(int xx, int yy) :
        x(xx), y(yy)
    {
        //Empty...
    }

    //Overload the operator() - This has the effect 
    //that makes or object "callable" i.e. we 
    //can use it in some form like:
    //auto f = Functor(1, 100);
    //cout << f(10) << endl;
    bool operator ()(int z)
    {
       return (x < z) && (z < y); //z is in the range (x,y)?
    }

private:
    int x, y;
};

//Somewhere - like in the middle of another function...
//...
auto functor = Functor(10, 100);
cout << functor(20)  << endl; // Prints 1 (true).
cout << functor(0)   << endl; // Prints 0 (false).
cout << functor(100) << endl; // Prints 0 (false).
//...
{% endhighlight %}

Man, I don't know how you feel about this, but in my opinion it is __very ugly__. 
Of course there are places that a Functor is a very valuable tool and worths 
all its verbosity, but in the example above (and similar stuff) definitely 
this is a bazooka to kill one mosquito.

You can find more about Functors in: 

* [wikipedia](https://en.wikipedia.org/wiki/Function_object), 
* [stackoverflow](http://stackoverflow.com/questions/356950/c-functors-and-their-uses), 
* [cprograming](http://www.cprogramming.com/tutorial/functors-function-objects-in-c++.html).

Besides the ```[=]``` capture specifier, C++ has the ```[this]``` and 
```[&]``` capture specifiers too - In addition with some others that
won't be covered here.


<!-- ####################################################################### -->
<br>

Let's make a quick example about these specifiers:

#### Example4a - The ```[&]``` capture specifier.
{% highlight c++ %}
auto x = 10;
auto lambda = [&](){
    ++x; //Notice that I'm capturing the 'x' by reference, 
         //so it will get modified into the outer scope too.
}
cout << x << endl; // Prints 11 (Indeed it was modified inside the lambda).
{% endhighlight %}

#### Example4b - The ```[this]``` capture specifier.
{% highlight c++ %}
// In Monster.h ...
class Monster
{
    // Usual stuff.

    // Public Methods //
public:
    void someMethod();

    // iVars //
private:
    int m_heath;
};

// In Monster.cpp ...
void Monster::someMethod()
{
    auto lambda = [this]()
    {
        //With the 'this' specifier I'm enable
        //to mess with the instance attributes 
        //and methods. This has the "same" effect
        //as receiving implicit the 'this' pointer
        //inside the lambda.
        m_health -= 10; 
    };

    //Call the lambda, now the monster health
    //is something - 10.
    lambda(); 
}
{% endhighlight %}

Of course, this is a stupid example, why not just...
{% highlight c++ %}
Monster::someMethod()
{
    //Same effect... :)
    m_heath -= 10;
}
{% endhighlight %}

One possibility is return the lambda to be called later, like:
{% highlight c++ %}
//In Monster.h ...
class Monster
{
    // Usual stuff...

    // Public Methods //
public:
    std::function<void ()> getHitFunctionCallback();

    // iVars //
private:
    int m_health;
};

//In Monster.cpp ...
std::function <void ()> Monster::getHitFunctionCallback()
{
    return [this]() { m_health -= 10; };
}

//In Somewhere.cpp
void hitTheMonster(Monster &monster)
{
    auto hitCallback = monster.getHitFunctionCallback();
    hitCallback();
}
{% endhighlight %}

Yet this is a study example, but you can see the big picture :).

Don't worry, we gonna cover ```std::function``` in the later posts, but briefly 
you can bind lambdas in ```std::function``` objects meaning that now, you can 
make callback objects much, but __much__ more easier.


That's it... I hope that you enjoyed :)


<!-- ######################################################################## -->
---

### Code for this post:

All code for this (and other posts) are located in 
the dir ```code``` from this repo.    

You can find them 
[here](https://github.com/N2OMatt/n2omatt.github.com/tree/master/code).
