---
layout: post
title:  "Why I prefer two separated files like C++."
date:   2015-11-09
category: Programming
tags: 
- C++
- Objective-C
- C# 
- include-guards

---

<!-- ####################################################################### -->

### Intro:

In this post I'll try to explain why I like the implementation file being 
separated from the interface file.
This is the common practice in many languages like C++, Objective-C, C and so on.   

I'll try to enumerate the points that makes this approach (for me) much better than 
having a single file for  all of stuff. Of course, _as always_, not everything is 
perfect and so, I'll point some bad things that happens
when you have two files like that.

So let's begin...

<!-- ####################################################################### -->

#### Good points:

First let's summarize the good things.

* Is very ease to read the file (Small size, [doxygen comments](http://www.doxygen.org)).
* The functions pop in the eye.
* The implementation almost doesn't matter, you read the API and _voilà_.
* Since you have (or should not have) no implementation code, it tends to be 
better organized.
* If you keep your code sections very separated is very easy to search want you want.
* In Obj-C is better yet, because you can (and should) keep you private stuff 
into a private category in the implementation file. [[1]](#1)
* Like in Obj-C you can add really _private_ stuff (not only from the OPP
perspective but in the sense
of the API users doesn't event need to know about it) in the implementation 
file. [[2]](#2)
* Not __really__ an issue (I guess) but some SVC locks the file when the check 
out occurs, so your work flow can be _slowed_ _down_ because you cannot edit 
the file anymore. But nowadays seems that everyone is using GIT anyway, so this
is not so bad.
 

<!-- ####################################################################### -->

#### Bad points:

Now what is not perfect in this approach.

* More files to manage (almost the double, or more...).
* You show the private stuff from your class, but in the single file 
it will be shown too.
* In C/C++ you should be __very__ careful with your include guard, or 
use ```#pragma once``` if it is supported. [[3]](#3), [[4]](#4)
* If the point above is not respected is __very easy__ to get the linker errors, 
and them aren't pretty in any sense.


<!-- ####################################################################### -->
   
#### Other thoughts:

* The C# has partial classes but this is a different matter, while you can 
separate your files into logical sections I think that the C# way causes more 
pain than good (__IMHO__). [[5]](#5)  


<!-- ######################################################################## -->

------

#### Code:

All code for this (and other posts) are located in the dir ```code``` 
from this repo.    
You can find them 
[here](https://github.com/N2OMatt/n2omatt.github.com/tree/master/code).



<!-- ######################################################################## -->

------

#### Footnotes:

<div id="1"></br></div>
[1] Private Categories in Obj-C - More in 
[Apple documentation](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/CustomizingExistingClasses/CustomizingExistingClasses.html).

{% highlight objc %}
//In SpaceShip.h
@interface SpaceShip 
//Properties
@property (retain, nonatomic) NSString *name;
@property (retain, nonatomic) CGRect    boundingBox;
//A lot of other cool stuff here...
@end

//In SpaceShip.m (or .mm)
//This is a private category, it's acts like the all definitions 
//be as in the @interface part, but note that we're in the .m (.mm)
//file, so users of this class might even not know that this exists.
//I think that is one of most cooler things in Obj-C
@interface SpaceShip ()
//Properties
@property (retain, nonatomic) NSString *_noOneShouldNeedToKnow;
//Methods
- (void)someCoolMethod;
@end

@implementation SpaceShip
// Public Methods //
- (id)init 
{
    //Our custom init;
    return self;
}

// Private Methods //
//Here we're implementing the stuff from our private category.
- (void)someCoolMethod
{
    //Do anything cool.
}
@end
{% endhighlight %}


<!-- ####################################################################### -->
<div id="2"><br></div>

__[2]__ In C++ you can do this too, but is not so cooler as Obj-C   
This is called pimpl idiom : <b>P</b>ointer to <b>IMPL</b>mentation.

More on [stack overflow](http://stackoverflow.com/questions/60570/why-should-the-pimpl-idiom-be-used), 
[wikipedia](https://en.wikipedia.org/wiki/Opaque_pointer) and on [c2.com](http://c2.com/cgi/wiki?PimplIdiom)

Furthermore, there are some challenges to implement this idiom correctly.  

1. You cannot use all smart pointers with the compiler generated destructor. 
This is described in these posts 
[[1]](http://stackoverflow.com/questions/9954518/stdunique-ptr-with-an-incomplete-type-wont-compile) 
[[2]](http://stackoverflow.com/questions/9020372/how-do-i-use-unique-ptr-for-pimpl) 
[[3]](http://stackoverflow.com/questions/6012157/is-stdunique-ptrt-required-to-know-the-full-definition-of-t)
of stack overflow and in this other post 
[[4]](http://forums.4fips.com/viewtopic.php?f=3&t=715) - (You can use a custom deleter too. or shared_ptr).

2. Is not straightforward make the implementation class knows about the main class.
(But as pointed in this 
[post](http://stackoverflow.com/questions/6466352/pimpl-idiom-and-internal-object-collaboration-without-friend-declaration) 
in stack overflow, this is not a good thing too).

3. One could want avoid all this stuff and use a naked pointer, but this is 
a (IMHO) very, very bad idea. Why messing with memory management when its not
required to do?


{% highlight c++ %}
//In our SpaceShip.h - (Interface file)
class SpaceShip 
{
    // Inner Types //
private:
    class SpaceShipPrivate; //Don't make it visible to anyone.

    // CTOR/DTOR //
public:
    SpaceShip();
    ~SpaceShip();

    // Public Methods //
public:
    void killAllUglyAliens();

    // iVars //
private:
    //We don't want mess with the memory mangement by ourselves, 
    //so the unique_ptr, but as pointed in the blog post, 
    //we must declare explicity the Desctructor **AND DEFINE IT 
    //IN THE .cpp FILE**
    std::unique_ptr<SpaceShipPrivate> m_pSpaceShipPrivate; 
};

// In our SpaceShip.cpp - (Implementation file)

//Here we're defining our private class.
class SpaceShip::SpaceShipPrivate 
{
    // Vars //
public:
    int someVar;

    // Methods //
public:
    //It can be placed outside the class definition too.
    void someCoolMethod() 
    {
        //Anything...
    }
};

// Definition of SpaceShip Stuff..
SpaceShip::SpaceShip() :
    m_pSpaceShipPrivate(new SpaceShipPrivate()) //This will be deleted automagically :).
{
    //Anything...
}

SpaceShip::~SpaceShip()
{
    //This must be defined here.
}

// Public Methods //
void SpaceShip::killAllUglyAliens()
{
    //Here we're using our private class.
    m_pSpaceShipPrivate->someVar = 10;
    m_pSpaceShipPrivate->someCoolMethod();
}

{% endhighlight %}


<!-- ####################################################################### -->
<div id="3"><br></div>

[3] Include guard errors are very like to appear when you copy a file and paste 
into another file, perhaps you could save a lot of time by removing/appending 
the needed things but if you aren't careful you'll instead lose **TOO MUCH** 
time figuring out why your code suddenly stops working.  

__PS__: Check out the Amazing Cow's 
[CppGuardChecker](https://github.com/AmazingCow/CppGuardChecker), 
it can be useful to you too.


1) Two files with the same include guard, but with different stuff:

{% highlight c++ %}
//In SomeFile1.h
#ifndef _HI_I_AM_A_VERY_NASTY_INCLUDE_
#define _HI_I_AM_A_VERY_NASTY_INCLUDE_
//A lot of stuff..
#endif 

//In SomeFile2.h
#ifndef _HI_I_AM_A_VERY_NASTY_INCLUDE_
#define _HI_I_AM_A_VERY_NASTY_INCLUDE_
//A lot of other stuff..
#endif 

{% endhighlight %}

Bang... you have a big problem...   

2) ```#ifndef``` and ```#define``` parts doesn't match... 
{% highlight c++ %}
//In SomeFile1.h
#ifndef _HI_I_AM_A_VERY_NASTY_INCLUDE_
#define _HI_I_AM_A_VERY_NASTY_INCLUDE__ //Notice the trailing underscore?
//A lot of stuff..
#endif 
{% endhighlight %}

Bang... You're defining ```_HI_I_AM_A_VERY_NASTY_INCLUDE__``` with __two__ 
underscores, but checking the ```_HI_I_AM_A_VERY_NASTY_INCLUDE_``` with __one__
underscore - This file will be redefined __EVERY__ time that it is included.

<!-- ####################################################################### -->
<div id="4"><br></div>

[4] If your compiler supports, a good alternative is use the ```#pragma once```.
More info about it can be found on 
[wikipedia](https://en.wikipedia.org/wiki/Pragma_once), 
[stack overflow](http://stackoverflow.com/questions/787533/is-pragma-once-a-safe-include-guard),
[MSDN](https://msdn.microsoft.com/en-us/library/4141z1cx.aspx) and 
[cppprogramming.com](http://www.cprogramming.com/reference/preprocessor/pragma.html).

You can use it like:

{% highlight c++ %}
//In SomeFile1.h
#pragma once 
class Monster 
{
    //As usual..
};
{% endhighlight %}

Or if you must support several compilers and some of them doesn't support it 
correctly, you can still use it, just do something like:
{% highlight c++ %}
//In SomeFile1.h
#pragma once 

#ifndef _HI_OLD_STYLE_ 
#define _HI_OLD_STYLE_ 
class Monster 
{
    //As usual..
};
#endif // _HI_OLD_STYLE_
{% endhighlight %}

So you get the all good thing from ```#pragma once``` if you compiler supports
and still have the correct behaviour in the compilers that doesn't support it yet 
__(!)__.


<!-- ####################################################################### -->
<div id="5"><br></div>

[5] You can find more info into the 
[MSDN](https://msdn.microsoft.com/en-us/library/wa80x488.aspx).
