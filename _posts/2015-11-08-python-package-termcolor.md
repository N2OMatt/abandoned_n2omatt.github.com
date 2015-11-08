---
layout: post
title:  "Termcolor - A very cool output coloring package for python."
date:   2015-11-08
category: Programming
tags: 
- python
- python-packages
- termcolor 

assets: /assets/2015-11-08-python-package-termcolor
code: /code/2015-11-08-python-package-termcolor
---

<!-- ######################################################################## -->

### Intro

Did you ever wanted that the output from your python scripts be more colored?   
I did and I do... I find that colored output is __very__ more organized than plain output. 

As example let's take a look on the same 
	[COWTODO](http://www.github.com/amazingcow/COWTODO)
output for
	[MonsterFramework](http://www.github.com/amazingcow/MonsterFramework).

The plain version:
![plain output]({{ page.assets }}/plain-output.png)

The colored version:
![colored output]({{ page.assets }}/colored-output.png)

As you can see is much easier to read the colored version, since the colors 
does a great job in "split out" the sections.   

But the question is - How can I add this into my scripts...?


<!-- ######################################################################## -->

### Termcolor - Intro

This is a python package that does the job for you in a very, very easy fashion.   
No need of messing with [terminal escape sequences]() - (This is exactly the 
way that ```termcolor``` put the colors into the output).
No need of doing nothing actually :) 

The ```termcolor``` has very nice features like:

* Text colors.
* Text highlights.
* Attributes (like: Bold, blink, underline, reverse and so on...)

_(Notice however that not all features are available under all terminals)._


The very basic usage can be simple as:
{% highlight python %}
import termcolor;
#The return value is the string Hi with the escapes sequences added.
print termcolor.colored("Hi", "blue"); 
#This in the other side, will print the string directly.
termcolor.cprint("there", "red");
{% endhighlight %}

As you can see, is very easy to use the ```termcolor``` and this can helps you
to bring a lot of structure in your script's output.

The page of ```termcolor``` is:
[https://pypi.python.org/pypi/termcolor](https://pypi.python.org/pypi/termcolor)


<!-- ######################################################################## -->

### Termcolor - Installation

* You can use the [pip](https://pypi.python.org/pypi/pip):
{% highlight bash %}
$ pip install termcolor
{% endhighlight %}

* You can use the your distro package management tool (if available):
{% highlight bash %}
## On Ubuntu-Mate 15.04 termcolor is named python-termcolor
$ sudo apt-get install python-termcolor
{% endhighlight %}

* Or you can download it directly from the ```termcolor``` 
[page](https://pypi.python.org/pypi/termcolor).   
So you can grab the files, add them to your project and voilà - (This have a benefit)
that your users doesn't need to have the ```termcolor``` installed) - The sources
are very small and all the relevant stuff is into a single file.

<!-- ######################################################################## -->

### Termcolor - Usage samples

{% highlight python %}
#Print all text colors.
for text_color in termcolor.COLORS:
    print termcolor.colored("Hi in color({})".format(text_color), text_color);

#Print all text colors with all highlights.
for text_color in termcolor.COLORS:
    for highlight_color in termcolor.HIGHLIGHTS:
        msg = "Hi in color({}) with hightlight({})".format(text_color, highlight_color);
        termcolor.cprint(msg, color=text_color, on_color=highlight_color);

#Print all text colors with all highlights using attributes.
for text_color in termcolor.COLORS:
    for highlight_color in termcolor.HIGHLIGHTS:
        for attribute in termcolor.ATTRIBUTES:
            msg = "Hi in color({}) with hightlight({}) with attribute({})".format(text_color, highlight_color, attribute);

            termcolor.cprint(msg, 
                             color=text_color, 
                             on_color=highlight_color,
                             attrs=[attribute]);

{% endhighlight %}


<!-- ######################################################################## -->
---

### Code for this post:

All code for this (and other posts) are located in the dir ```code``` from this
repo.    
You can find them 
[here](https://github.com/N2OMatt/n2omatt.github.com/tree/master/code).
