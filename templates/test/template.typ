#import "@local/oicana:0.1.0": setup

#let read_project_file(path) = return read(path, encoding: none);
#let (input, _, _) = setup(read_project_file);

a test template
#input.data.test

#set table(
  stroke: none,
  gutter: 0.2em,
  fill: (x, y) => if x == 0 or y == 0 {
    gray
  },
  inset: (right: 1.5em),
)

#table(
  columns: 4,
  [], [Exam 1], [Exam 2], [Exam 3],
  ..for (name, one, two, three) in input.data.items {
    (name, one, two, three)
  },
)
