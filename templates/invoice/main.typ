#import "invoice.typ": *
#import "@local/oicana:0.1.0": setup

#let read_project_file(path) = return read(path, encoding: none);
#let (input, oicana-image, _) = setup(read_project_file);

#show: invoice.with(
  language: "en",
  banner-image: oicana-image("banner"),
  invoice-id: input.invoice.id,
  // // Uncomment this to create a cancellation invoice
  // cancellation-id: "2024-03-24t210835",
  issuing-date: input.invoice.issuingDate,
  delivery-date: input.invoice.deliveryDate,
  due-date: input.invoice.dueDate,
  biller: input.invoice.biller,
  hourly-rate: 100, // For any items with `dur-min` but no `price`
  recipient: input.invoice.recipient,
  items: input.invoice.items,
)
