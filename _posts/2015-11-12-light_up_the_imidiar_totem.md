---
layout: post
title:  "Light up the Imidiar Totem"
date:   2015-11-12
category: Programming
tags: 
- Imidiar
- Imidiar-Totem
- python
- parallel-port
- challenge
- pygame
- pyside
- python-PortIO
- PyParallel

assets: /assets/2015-11-12-light_up_the_imidiar_totem
---

### Intro:

One of my jobs is hack some stuff for [Imidiar]("http://www.imidiar.com.br"). 
We make a interactive photo totem (for short Photo Totem) and there are some 
pretty interesting challenges making it like:

* Make a interactive totem with **VERY LOW END** hardware.
(You can thing the interactive totem as a fancy webcam capture application, 
with a nice interface, packaged into a cool box with touchscreen monitors).
* Deal with a myriad of camera devices (like _logitech_, _microsoft_, _genius_), 
resolutions (some cameras are pretty slow in high res, while others have some 
sharpness affected and so on.)
* Make the system reliable - This __was__ a hard task because the monitor drivers
(we use a _Keetouch_ stuff) are very messy. So sometimes the drivers loaded correctly
and sometimes not. Sometimes the precision of touch was very bad and the monitor
was not holding the calibration.   
Fortunately, after several (and nasty) hacks, we managed to make the software very,
very stable.
* A constant change of the requirements - The business was new, so this was pretty
normal, but since we're maturing now, it is becoming a lesser issue.

We make some other products too, but this post is about the Photo Totem :).


<!-- ####################################################################### -->

### What is the Photo Totem?

As I said this can be viewed like a fancy webcam capture application.   
So, the users stand in front of it, touch the screen and voila... The photo is 
taken.

It needs to run a custom software because, since we rent it, the customer is 
able to customize the appearance of the UI and other minor tweaks - I will post
about the Photo Totem and all the specs/features/etc later :).

It runs basically into a very low end hardware with a nice (_sometimes not so nice_) 
camera - Example: The _logitech_ is very neat camera, while the _genius_ is the most
basic (and harder to work) camera that we have.

The box runs [Ubuntu-Mate 15.04](https://ubuntu-mate.org/
) 
and the application itself was developed in 
python using a mix of 
[pygame](http://www.pygame.org/news.html), 
[pyside](https://pypi.python.org/pypi/PySide) 
some shell scripts (the hacks 
that I told before...).

We managed to get __30fps__ running into a very desktop high resolution (~1600x~1200)
and a (enough) high camera resolution (1920x1080).     
This was awesome thing to do, since the CPU is a Intel Atom @1.4Ghz and 2Gb of memory.

Here as some gals using the Photo Totem:
!["Photo Totem"]({{ page.assets }}/gals.jpg)

<!-- ####################################################################### -->
<br>

### Dark side!

The main problem the we're facing now is that __the environments are pretty dark__.   
So as consequence our photo's quality are suffering a lot. No matter how the 
resolution is high, the photo isn't look that good.

So after some brainstorm we decide that if we manage to add some form of flash light
into the Photo Totem we can get a much better results.

#### The solution: 

The first part was decide about the hardware that we want add. This was pretty easy
and a friend of ours made some custom hardware that emulates a flash. Basically 
it's a high bright LED, but with some neat electronics that made possible to better,
__easier__ control of the light. 

The second part __IS__ implementing this stuff into the Photo Totem program.

This is challenging me to thinking in a neat implementation, since the flash 
hardware that came to me is basically:

{% highlight bash %}

 ,---.
/     \
|     | <--- LED :) (Man, imagination is all)
\     /
 `._.´
  | |
  | |
  | ---[Some electronics]- +5
  ----------------------- GND

Are you impressed with my ascii skill, aren't you?

{% endhighlight %}

Yep... that is, a lamp and two wires.    

When I high the ```+5```, the lamp will flash and that's all. The good thing 
is that the electronics handle the light off and all this stuff.   
Actually is pretty easy, I just need to send a pulse into ```+5```.

#### The Solution's problem:

So, the first thing that came to my mind was: __PARALLEL PORT__

But honestly, I never did anything with parallel port in linux, the close thing
that I did was (when I was starting to program) for __DOS__ in C.

So I started to search something that let me do this in python and for linux.  

#### What I've found:

After some _googling_ I found two packages that seems promising - I'd no time 
to test them yet, so I cannot go any futher describing the package itself.   
Of course when I implement the Flash feature into Photo Totem I'll make a 
post how I achieve it. 

But the packages...

* [PortIO](http://portio.inrim.it/) - It seems pretty low-level, actually this 
is exactly what is on the project's page, nevertheless I think that I'll try 
this first because looks that the package is more _stable_ and mature.

* [PyParallel](https://github.com/pyserial/pyparallel) - The PortIO page, recommends
this package for the guys that doesn't want mess with _low level_ stuff.   
Reading the examples I liked a lot the API (but again, I'd not test any of the 
two options yet). But the project page states that this isn't a mature API and
I'm afraid of introducing another (possible) vector of crash into the Photo Totem.


<!-- ####################################################################### -->

### So, what's next:

Next week I'll develop the feature, first I'll try the PortIO package and if 
it fails or shows as very complex for little outcome, the PyParallel. 

When I finish the implementation I'll write another post about the package, 
in the same manner of the 
[Termcolor post](https://n2omatt.github.io/programming/2015/11/08/python-package-termcolor.html).

Of course I'll update the links too - So no matter post you read the other 
will be just one click far :).

See ya!

