#let _test_icon(category: none, id: none, path: none) = {
  if type(path) == str {
    return image(path, alt: id)
  }
}

#let badges(contents) = {
  for (i, j) in contents {
    let class_name = if type(j) == dictionary { j.at("name", default: none) } else { none }
    let class_desc = if type(j) == dictionary { j.at("desc", default: none) } else { none }
    [
      == #(if class_name == none { raw(i) } else { class_name })
      ID: #raw(i)

      #(if class_desc == none { [_No description_] } else { class_desc })
      \
    ]
    let t = (:)
    if type(j) == dictionary and type(j.at("badges", default: none)) == dictionary {
      for (id, content) in j.badges {
        let icon = none
        let name = none
        if type(content) == type(none) { } else {
          let n = content.at("name", default: [_No name_])
          if n != none {
            name = n
          }
        }
        t.insert(id, (icon, name))
      }
      let d = ()
      for id in t.keys().sorted() {
        d.push(t.at(id).at(0))
        d.push(raw(id))
        d.push(t.at(id).at(1))
      }
      table(
        columns: (auto, 2fr, 3fr),
        table.header([*Icon*], [*ID*], [*Name*]),
        ..d
      )
    } else {
      [_There are no badges specified under this category._]
    }
  }
}
