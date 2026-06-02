#import "@preview/oicana:0.1.1": setup
#import "report.typ": report

#let read-project-file(path) = read(path, encoding: none)
#let (input, _, _) = setup(read-project-file)

#show: report.with(sections: (input.one, input.two, input.three))
