#import "@preview/cetz:0.3.2"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/oicana:0.1.0": setup

#let read_project_file(path) = return read(path, encoding: none);
#let (input, _, _) = setup(read_project_file);

#show heading: it => [
  #set align(center)
  #set text(13pt, weight: "regular")
  #block(smallcaps(it.body))
]

= Using third party Typst packages in an Oicana template

#v(2cm)

You can use any third party or local Typst package in an Oicana template. Simply import them and you are good to go.

Packages from the `@preview` scope are downloaded from the official registry. Packages from other scopes like `@local` or `@my-company` have to be installed on the machine where the template is packed.
Take a look at the tool #link("https://github.com/sjfhsjfh/typship")[`typship`] for installing private Typst packages.

#v(1cm)

#align(center, input.data.description)
#v(1cm)

#let data = (
  ([Belgium], 24),
  ([Germany], input.data.germany),
  ([Greece], 18),
  ([Spain], 21),
  ([France], 23),
  ([Hungary], 18),
  ([Netherlands], 27),
  ([Romania], 17),
  ([Finland], 26),
)

#cetz.canvas({
  import cetz-plot: *
  import cetz.draw: *

  let colors = gradient.linear(red, blue, green, yellow)

  chart.piechart(
    data,
    value-key: 1,
    label-key: 0,
    radius: 4,
    slice-style: colors,
    inner-radius: 1,
    outset: 1,
    inner-label: (
      content: (value, label) => [#text(white, str(value))],
      radius: 110%,
    ),
    outer-label: (content: "%", radius: 110%),
  )
})
