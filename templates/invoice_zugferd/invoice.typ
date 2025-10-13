// Adapted from https://github.com/ad-si/invoice-maker

// Copyright 2015 Adrian Sieber
//
// Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted, provided that the above copyright notice and this permission notice appear in all copies.
//
// THE SOFTWARE IS PROVIDED “AS IS” AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#let nbh = "‑"

// Truncate a number to 2 decimal places
// and add trailing zeros if necessary
// E.g. 1.234 -> 1.23, 1.2 -> 1.20
#let add-zeros = num => {
  // Can't use trunc and fract due to rounding errors
  let frags = str(num).split(".")
  let (intp, decp) = if frags.len() == 2 {
    frags
  } else {
    (num, "00")
  }
  str(intp) + "." + (str(decp) + "00").slice(0, 2)
}

#let parse-date = date-str => {
  let parts = date-str.split("-")
  if parts.len() != 3 {
    // Disabled until the json schema fuzzer supports fuzzing string patterns
    //panic(
    //  "Invalid date string: " + date-str + "\n" + "Expected format: YYYY-MM-DD",
    //)
    return auto
  }
  datetime(
    year: int(parts.at(0)),
    month: int(parts.at(1)),
    day: int(parts.at(2)),
  )
}

#let signature-line = line(length: 5cm, stroke: 0.4pt)

#let texts = (
  id: "en",
  country: "GB",
  recipient: "Recipient",
  biller: "Biller",
  invoice: "Invoice",
  cancellation-invoice: "Cancellation Invoice",
  cancellation-notice: (id, issuing-date) => [
    As agreed, you will receive a credit note
    for the invoice *#id* dated *#issuing-date*.
  ],
  invoice-id: "Invoice ID",
  issuing-date: "Issuing Date",
  delivery-date: "Delivery Date",
  items: "Items",
  closing: "Thank you for the good cooperation!",
  number: "№",
  date: "Date",
  description: "Description",
  duration: "Duration",
  quantity: "Quantity",
  price: "Price",
  total-time: "Total working time",
  subtotal: "Subtotal",
  discount-of: "Discount of",
  vat: "VAT of",
  reverse-charge: "Reverse Charge",
  total: "Total",
  due-text: val => [Please transfer the money onto following bank account due to *#val*:],
  owner: "Owner",
  iban: "IBAN",
)

#let invoice(
  country: none,
  title: none,
  banner-image: none,
  invoice-id: none,
  cancellation-id: none,
  issuing-date: none,
  delivery-date: none,
  due-date: none,
  biller: (:),
  recipient: (:),
  keywords: (),
  hourly-rate: none,
  styling: (:), // font, font-size, margin (sets defaults below)
  items: (),
  discount: none,
  vat: 0.19,
  data: none,
  doc,
) = {
  // Set styling defaults
  styling.font = styling.at("font", default: "Libertinus Serif")
  styling.font-size = styling.at("font-size", default: 11pt)
  styling.margin = styling.at(
    "margin",
    default: (
      top: 20mm,
      right: 25mm,
      bottom: 20mm,
      left: 25mm,
    ),
  )

  if data != none {
    country = data.at("country", default: texts.country)
    title = data.at("title", default: title)
    banner-image = data.at("banner-image", default: banner-image)
    invoice-id = data.at("invoice-id", default: invoice-id)
    issuing-date = data.at("issuing-date", default: issuing-date)
    delivery-date = data.at("delivery-date", default: delivery-date)
    due-date = data.at("due-date", default: due-date)
    biller = data.at("biller", default: biller)
    recipient = data.at("recipient", default: recipient)
    keywords = data.at("keywords", default: keywords)
    hourly-rate = data.at("hourly-rate", default: hourly-rate)
    styling = data.at("styling", default: styling)
    items = data.at("items", default: items)
    discount = data.at("discount", default: discount)
    vat = data.at("vat", default: vat)
  }

  let issuing-date = if issuing-date != none {
    issuing-date
  } else {
    datetime.today().display("[year]-[month]-[day]")
  }

  set document(
    title: title,
    keywords: keywords,
    date: parse-date(issuing-date),
  )
  set page(
    numbering: "1 von 1",
    margin: styling.margin,
    header: [#h(1fr) #biller.company],
  )
  set par(justify: true)
  set text(
    lang: texts.id,
    font: if styling.font != none {
      styling.font
    } else {
      ()
    },
    size: styling.font-size,
  )
  set table(stroke: none)

  // Offset page top margin for banner image
  [#pad(top: -10mm, banner-image)]

  align(center)[#block(inset: 2em)[
    #text(weight: "bold", size: 2em)[
      #(
        if title != none {
          title
        } else {
          texts.invoice
        }
      )
    ]
  ]]

  align(
    center,
    table(
      columns: 2,
      align: (right, left),
      inset: 4pt,
      [#texts.invoice-id:], [*#invoice-id*],
      [#texts.issuing-date:], [*#issuing-date*],
      [#texts.delivery-date:], [*#delivery-date*],
    ),
  )

  v(2em)

  box(height: 10em)[
    #columns(2, gutter: 4em)[
      === #texts.recipient
      #v(0.5em)
      #recipient.name \
      #{
        if "title" in recipient {
          [#recipient.title \ ]
        }
      }
      #recipient.address.city #recipient.address.postal-code \
      #recipient.address.street \
      #{
        if recipient.vat-id.starts-with("DE") {
          "USt-IdNr.:"
        }
      }
      #recipient.vat-id


      === #texts.biller
      #v(0.5em)
      #biller.name \
      #{
        if "title" in biller {
          [#biller.title \ ]
        }
      }
      #biller.address.city #biller.address.postal-code \
      #biller.address.street \
      #{
        if biller.vat-id.starts-with("DE") {
          "USt-IdNr.:"
        }
      }
      #biller.vat-id
    ]
  ]


  if cancellation-id != none {
    (texts.cancellation-notice)(invoice-id, issuing-date)
  }

  [== #texts.items]

  v(1em)

  let getRowTotal = row => {
    if row.at("dur-min", default: 0) == 0 {
      row.price * row.at("quantity", default: 1)
    } else {
      calc.round(hourly-rate * (row.dur-min / 60), digits: 2)
    }
  }

  let cancel-neg = if cancellation-id != none {
    -1
  } else {
    1
  }

  let entry(index, row) = {
    let dur-min = row.at("dur-min", default: 0)
    let dur-hour = dur-min / 60

    (
      [#row.at("number", default: index + 1)],
      [#str(row.date)],
      [#block(breakable: false)[#row.description]],
      [#str(if dur-min == 0 {
        ""
      } else {
        dur-min
      })],
      [#str(
        row.at(
          "quantity",
          default: if dur-min == 0 {
            "1"
          } else {
            ""
          },
        ),
      )],
      [#str(
        add-zeros(
          cancel-neg
            * row.at(
              "price",
              default: calc.round(hourly-rate * dur-hour, digits: 2),
            ),
        ),
      )],
      [#str(add-zeros(cancel-neg * getRowTotal(row)))#metadata(
          getRowTotal(row),
        )<table-value>],
    )
  }

  table(
    columns: (auto, auto, 1fr, auto, auto, auto, auto),
    align: (col, row) => if row == 0 {
      (right, left, left, center, center, center, right).at(col)
    } else {
      (right, left, left, right, right, right, right).at(col)
    },
    inset: 6pt,
    table.header(
      table.hline(stroke: 0.5pt),
      [*#texts.number*],
      [*#texts.date*],
      [*#texts.description*],
      [*#texts.duration*\ #text(size: 0.8em)[( min )]],
      [*#texts.quantity*],
      [*#texts.price*\ #text(size: 0.8em)[( € )]],
      [*#texts.total*\ #text(size: 0.8em)[( € )]],
      table.hline(stroke: 0.5pt),
    ),
    ..items.enumerate().map(((index, item)) => entry(index, item)).flatten(),
    table.footer(
      table.hline(stroke: 0.5pt),
      table.cell(align: right)[*#texts.number*],
      table.cell(align: left)[*#texts.date*],
      table.cell(align: left)[*#texts.description*],
      table.cell(align: center)[*#texts.duration*\ #text(size: 0.8em)[( min )]],
      table.cell(align: center)[*#texts.quantity*],
      table.cell(align: center)[*#texts.price*\ #text(size: 0.8em)[( € )]],
      table.cell(align: right)[#context {
        if (
          query(<table-value>).find(el => (
            el.location().page() > here().page()
          ))
            != none
        ) {
          let values = query(<table-value>).filter(el => (
            el.location().page() <= here().page()
          ))
          [*Zwischensumme*\ #text(size: 0.8em)[( € )]\ #values.map(it => it.value).sum()]
        } else {
          [*#texts.total*\ #text(size: 0.8em)[( € )]\ ]
        }
      }],
      table.hline(stroke: 0.5pt),
      [],
    ),
  )

  [#metadata("")#label("table-end")]

  let sub-total = items.map(getRowTotal).sum()

  let total-duration = items
    .map(row => int(row.at("dur-min", default: 0)))
    .sum()

  let discount-value = if discount == none {
    0
  } else {
    if (discount.type == "fixed") {
      discount.value
    } else if discount.type == "proportionate" {
      sub-total * discount.value
    } else {
      panic(["#discount.type" is no valid discount type])
    }
  }
  let discount-label = if discount == none {
    0
  } else {
    if (discount.type == "fixed") {
      str(discount.value) + " €"
    } else if discount.type == "proportionate" {
      str(discount.value * 100) + " %"
    } else {
      panic(["#discount.type" is no valid discount type])
    }
  }
  let has-reverse-charge = {
    biller.vat-id.slice(0, 2) != recipient.vat-id.slice(0, 2)
  }
  let tax = if has-reverse-charge {
    0
  } else {
    sub-total * vat
  }
  let total = sub-total - discount-value + tax

  let table-entries = (
    if total-duration != 0 {
      ([#texts.total-time:], [*#total-duration min*])
    },
    if (discount-value != 0) or (vat != 0) {
      (
        [#texts.subtotal:],
        [#{ add-zeros(cancel-neg * sub-total) } €],
      )
    },
    if discount-value != 0 {
      (
        [#texts.discount-of #discount-label
          #{
            if discount.reason != "" {
              "(" + discount.reason + ")"
            }
          }],
        [-#add-zeros(cancel-neg * discount-value) €],
      )
    },
    if not has-reverse-charge and (vat != 0) {
      (
        [#texts.vat #{ vat * 100 } %:],
        [#{ add-zeros(cancel-neg * tax) } €],
      )
    },
    if (has-reverse-charge) {
      ([#texts.vat:], text(0.9em)[#texts.reverse-charge])
    },
    (
      [*#texts.total*:],
      [*#add-zeros(cancel-neg * total) €*],
    ),
  ).filter(entry => entry != none)

  let grayish = luma(245)

  align(
    right,
    table(
      columns: 2,
      fill: (col, row) => // if last row
      if row == table-entries.len() - 1 { grayish } else { none },
      stroke: (col, row) => // if last row
      if row == table-entries.len() - 1 { (y: 0.5pt, x: 0pt) } else { none },
      ..table-entries.flatten(),
    ),
  )

  v(1em)
  block(breakable: false)[
    #if cancellation-id == none {
      let due-date = if due-date != none {
        due-date
      } else {
        (
          parse-date(issuing-date) + duration(days: 14)
        ).display("[year]-[month]-[day]")
      }

      (texts.due-text)(due-date)

      v(1em)
      align(center)[
        #table(
          fill: grayish,
          columns: (8em, auto),
          inset: (col, row) => if col == 0 {
            if row == 0 { (top: 1.2em, right: 0.6em, bottom: 0.6em) } else {
              (top: 0.6em, right: 0.6em, bottom: 1.2em)
            }
          } else {
            if row == 0 {
              (top: 1.2em, right: 2em, bottom: 0.6em, left: 0.6em)
            } else { (top: 0.6em, right: 2em, bottom: 1.2em, left: 0.6em) }
          },
          align: (col, row) => (right, left).at(col),
          table.hline(stroke: 0.5pt),
          [#texts.owner:], [*#biller.name*],
          [#texts.iban:], [*#biller.iban*],
          table.hline(stroke: 0.5pt),
        )
      ]
      v(1em)

      texts.closing
    } else {
      v(1em)
      align(center, strong(texts.closing))
    }
  ]

  doc
}
