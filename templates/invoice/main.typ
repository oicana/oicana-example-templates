#import "invoice.typ": *
#import "@preview/oicana:0.1.1": setup

#let read-project-file(path) = read(path, encoding: none)
#let (input, oicana-image, _) = setup(read-project-file)

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
