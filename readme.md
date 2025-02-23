# Standard Badges

This GRF provides standard badges for OpenTTD.
Country/region flags will not be included for obvious reasons.

<https://github.com/WenSimEHRP/standard-badges>

### Goals of this GRF

This GRF aims to provide a large set of standardized badges with rich internationalization,
graphics, and various other support that can be instantly used in NewGRF production.

### Building

The following utilities are required for building:

- [`PeterN/nml` branch `newgrf-badges`](https://github.com/PeterN/nml/tree/newgrf-badges)
- python3

Optional:

- typst: for documentation
- just: for better code execution.

Simply execute `just install_deps` to download `nmlc`, then execute `just build` to build the GRF.

### Internationalization

The two main languages (English, and Simplified Chinese as the author is Chinese) will be always up-to-date.
If you want to contribute translations, please [submit a pull request on GitHub](https://github.com/WenSimEHRP/standard-badges/pulls).

### Contributors

(In alphabetical order)

- [WenSimEHRP](https://github.com/wensimehrp)
