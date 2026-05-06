#import "@preview/oicana:0.1.1": setup
#import "certificate.typ": *

#let read-project-file(path) = read(path, encoding: none)
#let (input, oicana-image, _) = setup(read-project-file)

#let name = input.certificate.name

#show: certificate.with(name: name)
