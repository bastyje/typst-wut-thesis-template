// this file should be in template directory, but for the sake of development it is temporarily here, because one cannot import packages from outside project root

#import "template.typ": masters

#show: masters.with(
    faculty: "Wydział Elektryczny",
    institute: "Instytut Elektrotechniki Teoretycznej i Systemów Informacyjno-Pomiarowych",
    degree: "Informatyka Stosowana",
    speciality: "Inżynieria Danych",
    topic: "Analiza i porównianie frameworków frontendowych",
    author: "Janusz Kowalski",
    index: "123456",
    promotor: "prof. dr hab. inż. Pan Dziekan",
    city: "Warszawa",
    date: "2025",
    abstract: (pl: [#lorem(300)], en: [#lorem(300)]),
    bib_path: "template/sources.bib",
)

= Angular vs React
== Angular jest super
#lorem(100) @netwok2022

== React jest super
#lorem(100) @netwok2020