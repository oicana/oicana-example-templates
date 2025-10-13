#import "@preview/oicana:0.1.0": setup
#import "certificate.typ": *

#let read_project_file(path) = return read(path, encoding: none);
#let (input, oicana-image, _) = setup(read_project_file);

#let name = input.certificate.name

#show: certificate.with(name: name)
