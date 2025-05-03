#import "title.typ": title

#let acronyms = state("x", (:))

#let acr(acronym, definition) = {
  context {
    let acr_dict = acronyms.get()
    if acr_dict.keys().contains(acronym) {
      acronym
    } else {
      acronyms.update(x => {
        x.insert(acronym, definition)
        x
      })
      [#acronym - #definition]
    }
  }
}

#let masters(
  author: none,
  index: none,
  topic: none,
  faculty: none,
  abstract: none,
  promotor: none,
  institute: none,
  speciality: none,
  degree: none,
  city: none,
  date: none,
  bibliography: none,
  doc,
) = {
  set page(
    paper: "a4",
    columns: 1
  )
  set par(justify: true)
  set text(
    font: "Libertinus Serif",
    size: 11pt,
  )

  show: title.with(
    topic: topic,
    faculty: faculty,
    author: author,
    index: index,
    promotor: promotor,
    city: city,
    date: date,
    degree: degree,
    speciality: speciality,
    institute: institute,
  )

  set page(
    paper: "a4",
    margin: (y: 25mm, inside: 30mm, outside: 20mm),
    numbering: "1",
    footer: context {
      let page = counter(page).get().first()
      let alignment = if calc.odd(page) { right } else { left }
      align(alignment, str(page))
    }
  )

  set align(left)
  set text(size: 12pt)
  set par(justify: true, spacing: 20pt)
  set std.bibliography(title: "Bibliografia")

  pagebreak()

  if abstract != none [
    #par(justify: false)[
      *Streszczenie* \
      #abstract.pl
    ]
    #pagebreak()
    #par(justify: false)[
      *Abstract* \
      #abstract.en
    ]
  ]

  set heading(numbering: "1.1.1")
  show heading.where(level: 1, numbering: "1.1.1"): it => {
    v(10%)
    [Rozdział #counter(heading).display()]
    linebreak()
    v(10pt)
    text(size: 25pt, it.body)
    linebreak()
    v(10pt)
  }
  show figure.where(kind: image): set figure(supplement: "Rysunek")
  show figure.where(kind: table): set figure(supplement: "Tabela")

  pagebreak()
  outline(title: "Spis treści")
  pagebreak()
  doc
  pagebreak()
  bibliography
  context {
    let acronym_dict = acronyms.get()
    if acronym_dict.len() > 0 [
      #pagebreak()
      #heading("Wykaz symboli i skrótów", numbering: none)
      #terms(
        ..acronym_dict
          .pairs()
          .sorted(key: k => k.at(0))
          .map(a => terms.item(a.at(0), a.at(1)))
      )
    ]

    if counter(figure.where(kind: image)).get().first() > 0 [
      #pagebreak()
      #outline(title: "Spis rysunków", target: figure.where(kind: image))
    ]
    if counter(figure.where(kind: table)).get().first() > 0 [
      #pagebreak()
      #outline(title: "Spis tabel", target: figure.where(kind: table))
    ]
  }
}
