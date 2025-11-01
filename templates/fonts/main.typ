// This Oicana template demonstrates usage of custom fonts.
#import "@preview/oicana:0.1.0": setup

#set document(date: datetime.today())

#show raw: it => [
  #text(fill: luma(42%))[#it]
]

#let read_project_file(path) = return read(path, encoding: none);
#let (input, _, _) = setup(read_project_file);

#show heading: it => [
  #set align(center)
  #set text(13pt, weight: "regular")
  #block(smallcaps(it.body))
]

= Custom fonts in an Oicana template

#v(2cm)

// As the focus of this template are the fonts there is only minimal input.
#align(center, input.data.description)

#v(1cm)

To use a font in an Oicana template, add a `.ttf`, `.ttc`, `.otf`, or `.otc` file to the project. The location is not relevant. In this example, you can find the two fonts "Inria Serif" and "Noto Sans Arabic" in the `fonts` directory. Some Typst editors, like the official web app, also support font files as part of a Typst project and will use them in their preview.

The fonts "Libertinus Serif", "New Computer Modern", "DejaVu Sans Mono", and "New Computer Modern Math" are included in Typst by default and always available in Oicana templates.



#v(1cm)


#set text(font: "Libertinus Serif")
This is Latin in Libertinus Serif. \

#set text(font: "New Computer modern")
This is Latin in New Computer Modern. \

#set text(font: "DejaVu Sans Mono")
This is Latin in DejaVu Sans Mono. \

#set text(font: "Inria Serif")
This is Latin in Inria Serif. #sym.arrow.l custom font\

#v(0.5cm)

#set text(font: "Noto Sans Arabic")
هذا عربي.

Arabic in Noto Sans Arabic #sym.arrow.l custom font

#set text(font: "New Computer modern")
هذا عربي.

Glyphs that are not in the current font will fall back to the next font that includes them. The arabic above is still in Noto Sans Arabic, because New Computer modern does not contain the right Glyphs.


