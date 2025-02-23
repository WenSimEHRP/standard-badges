#let _find_icon(category: none, id: none, path: none, image_paths: ()) = {
  // test if path is not none
  if path in image_paths {
    return image(path)
  } else {
    // there isn't a manually specified path, so we will try to find the icon
    // based on the category and id
    let img_path = "gfx/" + category + "/" + id + ".png"
    if img_path in image_paths {
      box(height: 2em, width: auto, image(img_path, scaling: "pixelated", alt: img_path))
    } else {
      none
    }
  }
}

#let badges(contents, image_paths) = {
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
        let icon = _find_icon(
          category: i,
          id: id,
          image_paths: image_paths,
          path: if content != none { (content.at("icon", default: none)) } else { none },
        )
        let name = none
        if type(content) == dictionary {
          name = content.at("name", default: none)
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
        rows: 2em,
        align: (x, y) => if (x == 0) { center + horizon } else { horizon },
        ..d
      )
    } else {
      [_There are no badges specified under this category._]
    }
  }
}
