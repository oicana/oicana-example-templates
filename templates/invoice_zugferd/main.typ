#import "invoice.typ": *
#import "@preview/oicana:0.1.0": setup
#import "@local/invoice-harness:0.1.0": zugferd

#let read_project_file(path) = return read(path, encoding: none);
#let (input, oicana-image, _) = setup(read_project_file);

// This does not yet create a valid ZUGFeRD e-invoice! We
// are missing https://github.com/typst/typst/issues/5667 in Typst to set the
// required metadata. That said, if the xml file you pass into this template is
// complete, you can get a "yellow validation" result from online validators.
#zugferd(input.zugferd.bytes)

#show: invoice.with(
  banner-image: oicana-image("banner"),
  invoice-id: input.invoice.id,
  issuing-date: input.invoice.issuingDate,
  delivery-date: input.invoice.deliveryDate,
  due-date: input.invoice.dueDate,
  biller: input.invoice.biller,
  hourly-rate: 100, // For any items with `dur-min` but no `price`
  recipient: input.invoice.recipient,
  items: input.invoice.items,
)
