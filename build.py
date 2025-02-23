import yaml
import glob

badge_name_table = {}
nml_f = "sb.nml"
lang_f = "lang/english.lng"
version = 1
min_version = 1

for file in glob.glob("data/*.yaml"):
    with open(file, "r") as f:
        data = yaml.safe_load(f)
        for category, cprop in data.items():
            badge_name_table[category] = cprop.get("name", None)
            if type(cprop) is dict:
                n = cprop.get("badges", None)
                if n is not None:
                    for badge, bprop in n.items():
                        badge_name_table[f"{category}/{badge}"] = (
                            bprop.get("name", None) if bprop is not None else None
                        )

with open(nml_f, "w+") as f:
    print(
        rf"""grf {{
    grfid: "WS\01\01";
    name: string(STR_GRF_NAME);
    desc: string(STR_GRF_DESC);
    version: {version};
    min_compatible_version: {min_version};
}}""",
        file=f,
    )
    print("badgetable {", file=f)
    for b in sorted(badge_name_table):
        print(f'    "{b}",', file=f)
    print("}", file=f)
    for b in sorted(badge_name_table):
        print(
            rf"""item (FEAT_BADGES, {b.replace("/", "_")}) {{
    property {{
        label: "{b}";""",
            file=f,
        )
        if (name := badge_name_table[b]) is not None:
            print(
                "        name: string(STR_" + b.replace("/", "_").upper() + ");", file=f
            )
        print("    }\n}\n", file=f)

    with open(lang_f, "w+") as f2:
        print("##grflangid 0x01", file=f2)
        print(file=f2)
        print("STR_GRF_NAME    :Standard Badges", file=f2)
        print("STR_GRF_DESC    :Standard badges", file=f2)
        for b in sorted(badge_name_table):
            if (name := badge_name_table[b]) is not None:
                print(
                    f"{f'STR_{b.replace("/", "_").upper()}':<50}:{name}",
                    file=f2,
                )
