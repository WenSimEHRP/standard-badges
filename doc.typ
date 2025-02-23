#import "lib.typ": *
#import "@preview/cmarker:0.1.2"

#set page(
  paper: "us-letter",
  footer: context [#h(1fr) #counter(page).display("1") #h(1fr)],
  margin: .75in,
)

#set document(
  title: "Standard Badges Documentation",
  author: "Jeremy Gao (WenSimEHRP)",
  date: datetime.today(offset: 0),
)

#set text(font: "Noto Serif", size: 10pt)
#show raw: set text(font: "Hack")
#show heading: smallcaps
#show table.cell: it => {
  if it.body == [] {
    box(inset: it.inset)[_N/A_]
  } else {it}
}
#set par(justify: true)

#table(columns: (1fr, 100% / 3), gutter: 1em, inset: 1em)[

  #cmarker.render(read("readme.md"))

  #line(length: 100%)

  Documentation built #datetime.today(offset: 0).display() UTC+0\
  // compile with --input "commit=$(git rev-parse HEAD)"
  Commit #raw(sys.inputs.at("commit", default: "unknown"))
][
  #outline(depth: 2)
]

#let yamls = (
  "data/company.yaml",
  "data/flag.yaml",
  "data/generic.yaml",
  "data/power.yaml",
  "data/rci.yaml",
  "data/role.yaml",
  "data/speed_limit.yaml",
  "data/traffic.yaml",
  "data/weather.yaml",
).sorted()

#for file in yamls {
  badges(yaml(file))
}

#pagebreak()

#cmarker.render(read("changelog.md"))

#pagebreak()


= License

Standard Badges is licensed under the GNU General Public License v2.0,
or any later versions, at your discretion. You should have received a copy
of the license along with this work. If not, see https://www.gnu.org/licenses/gpl-2.0.html.

#set heading(outlined: false)
#cmarker.render(read("license.md"))
