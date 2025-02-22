_:
    @just --list

# build and copy
def: build cp

# build the newgrf
build:
    python3 nml/nmlc -c cstbe.nml

# copy to the newgrf folder (linux)
cp:
    cp cstbe.grf ~/.local/share/openttd/newgrf/

# generate badges documentation
doc:
    typst c doc.typ --input "commit=$(git rev-parse HEAD)"

# install the experimental petern newgrf-badges nml branch
install_deps:
    rm -rf ./nml
    git clone --single-branch --branch newgrf-badges --depth 1 https://github.com/petern/nml.git
