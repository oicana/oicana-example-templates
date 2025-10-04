#import "@preview/oicana:0.1.0": setup

#let read_project_file(path) = return read(path, encoding: none);
#let (input, _, _) = setup(read_project_file);

A template with multiple `json` inputs.

#set table(
  stroke: none,
  gutter: 0.2em,
  fill: (x, y) => if x == 0 or y == 0 {
    gray
  },
  inset: (right: 1.5em),
)

#input.one.description

#table(
  columns: 4,
  [], [Exam 1], [Exam 2], [Exam 3],
  ..for (name, one, two, three) in input.one.rows {
    (name, one, two, three)
  },
)


#input.two.description

#table(
  columns: 4,
  [], [Exam 1], [Exam 2], [Exam 3],
  ..for (name, one, two, three) in input.two.rows {
    (name, one, two, three)
  },
)


#input.three.description

#table(
  columns: 4,
  [], [Exam 1], [Exam 2], [Exam 3],
  ..for (name, one, two, three) in input.three.rows {
    (name, one, two, three)
  },
)
