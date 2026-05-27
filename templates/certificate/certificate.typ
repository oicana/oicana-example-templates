#import "@preview/curvly:0.1.0": *

#let gold = rgb("#b08a3e")
#let muted = rgb("#7a6a3a")

#let ornament = {
  let stroke = (paint: gradient.linear(white, gold, white))
  let l = line(length: 8cm, stroke: stroke)
  v(0.2cm)
  $#l #move(dy: -0.4cm, text(15pt, fill: gold)[#sym.star]) #l$
  v(0.2cm)
}

#let certificate(name: none, body) = {
  let today = datetime.today()
  set document(date: today)
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

  v(1.0cm)
  text(20pt, fill: muted, style: "italic")[is hereby awarded to]

  v(0.5cm)
  text(44pt, weight: "semibold")[#name]

  move(dy: -0.75cm)[#ornament]

  text(20pt)[for mastering document templating with Oicana]

  place(bottom + left, dx: 1.5cm, dy: -1.5cm, text(
    16pt,
    fill: muted,
  )[https://oicana.com])
  place(bottom + center, dy: -1.5cm, text(16pt, fill: muted)[
    Issued #today.display("[month repr:long] [day padding:none], [year]")
  ])
  place(bottom + right, dx: -1cm, dy: -1cm, image("medal.svg", height: 5cm))

  body
}
