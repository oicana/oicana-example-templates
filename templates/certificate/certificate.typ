#import "@preview/curvly:0.1.0": *

#let certificate(name: none, body) = {
  let line-with-gradient = line(length: 8cm, stroke: (
    paint: gradient.linear(white, black, white),
  ))

  let ornamentLine = [
    #v(0.2cm)
    $#line-with-gradient #move(dy: -0.4cm, text(15pt)[#sym.star]) #line-with-gradient$
    #v(0.2cm)
  ]

  set page(
    height: 30cm,
    width: 40cm,
    background: image("background.svg", height: 100%, width: 100%),
  )
  set block(above: 0pt, below: 0pt)
  set align(center)
  set text(150pt)

  v(1.5cm)
  text-on-arc("Certificate", 25cm, 60deg)

  v(3cm)
  text(40pt)[#name]

  move(dy: -0.75cm)[#ornamentLine]

  text(20pt)[has mastered PDF templating with Typst using Oicana]

  place(bottom + left)[#text(20pt)[https://oicana.com]]
  place(bottom + right)[#image("medal.svg")]

  body
}
