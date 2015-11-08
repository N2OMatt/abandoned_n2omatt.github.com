import termcolor;

#Very basic usage.
print termcolor.colored("Hi", "blue");
termcolor.cprint("there", "red");

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
