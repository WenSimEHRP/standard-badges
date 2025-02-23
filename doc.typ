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
    align(it.align)[#box(inset: it.inset)[_N/A_]]
  } else { it }
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

// read all files under the data directory and sort
// compile with --input "data=$(python3 -c 'import json, glob; print(json.dumps(glob.glob("data/*.yaml")))')"
#let yamls = if "data" in sys.inputs {
  json(bytes(sys.inputs.data)).sorted()
} else {
  (
    "data/company.yaml",
    "data/flag.yaml",
    "data/generic.yaml",
    "data/power.yaml",
    "data/rci.yaml",
  ).sorted()
}


// --input "images=$(python3 -c 'import json, glob; print(json.dumps(glob.glob("gfx/**/*.png", recursive=True)))')"
#let images = if "images" in sys.inputs {
  json(bytes(sys.inputs.images))
} else {
  (
    "gfx/rci/low_density_residential.png",
    "gfx/rci/medium_density_residential.png",
    "gfx/rci/high_density_residential.png",
    "gfx/rci/low_density_commercial.png",
    "gfx/rci/medium_density_commercial.png",
    "gfx/rci/high_density_industrial.png",
    "gfx/rci/industrial.png",
    "gfx/rci/commercial.png",
    "gfx/rci/commercial_residential.png",
  )
}

#for file in yamls {
  badges(yaml(file), images)
}

#pagebreak()

#cmarker.render(read("changelog.md"))

#pagebreak()

= License

Standard Badges is licensed under the GNU General Public License v2.0,
or any later versions, at your discretion. You should have received a copy
of the license along with this work. If not, see https://www.gnu.org/licenses/gpl-2.0.html.

Additionally, the graphics (i.e. image files by general standards) are dual-licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
You should have received a copy of the license along with this work. If not, see https://creativecommons.org/licenses/by-nc-sa/4.0/.

#{
  set heading(outlined: false)
  line(length: 100%)
  cmarker.render(read("license.md"))
  pagebreak()
  cmarker.render(read("license2.md"))
}
