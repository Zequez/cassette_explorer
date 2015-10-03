# CassetteExplorer

CasetteExplorer allow you to mount a webserver to load the
[VCR](https://github.com/vcr/vcr) cassettes in the browser

## Installation

$ gem install cassette_explorer

## Usage

```
cassette_explorer /path/to/vcr/cassettes/directory [-r --replace-urls]
```

`[-r --replace-urls]` will replace all the relative URLs in each page with an absolute
URLs of the page original domain. This allows the styles, images and scripts with
relative URLs to load.

## TODO

- Write better tests
- Make the view a folder tree

## Contributing

1. Fork it ( https://github.com/[my-github-username]/cassette_explorer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
