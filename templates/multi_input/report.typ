#let exam-table(data) = {
  data.description
  parbreak()
  table(
    columns: 4,
    [], [Exam 1], [Exam 2], [Exam 3],
    ..for (name, one, two, three) in data.rows {
      (name, one, two, three)
    },
  )
}

// Lay out the report: one `exam-table` per dataset in `sections`.
#let report(sections: (), body) = {
  set document(date: datetime.today())
  set table(
    stroke: none,
    gutter: 0.2em,
    fill: (x, y) => if x == 0 or y == 0 {
      gray
    },
    inset: (right: 1.5em),
  )

  [A template with multiple `json` inputs.]

  for section in sections {
    parbreak()
    exam-table(section)
  }

  body
}
