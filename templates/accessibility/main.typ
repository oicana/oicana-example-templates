// This example Oicana template demonstrates exporting PDFs with Universal Access (PDF/UA-1).
#import "@preview/oicana:0.1.0": setup

#set document(date: datetime.today(), title: "Universal Access")

#let read_project_file(path) = return read(path, encoding: none);
#let (input, _, _) = setup(read_project_file);

#title()

#input.data.description
The PDF standard used for the export is defined in the template manifest `typst.toml`.

#image(
  "oicana.svg",
  alt: "The logo of Oicana. A large blue letter 'O' with a smaller 'i' in the middle. The dot of the 'i' is star shaped.",
  width: 20%,
)
Images are forced to have alt texts when exporting to PDF/UA-1.

#v(2cm)

#math.equation(
  alt: "e equals m times c squared",
  block: true,
  $e = m c^2$,
)
The same goes for equations.

#v(2cm)

See https://typst.app/docs/guides/accessibility/ for more information on accessibility with Typst.
