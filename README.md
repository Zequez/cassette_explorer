# CassetteExplorer

CasetteExplorer is a command line utility that allow you to mount a webserver to load the
[VCR](https://github.com/vcr/vcr) cassettes in the browser.

## Installation

```
$ gem install cassette_explorer
```

## Usage

```
$ cassette_explorer -h
Usage: cassette_explorer /path/to/vcr/cassettes/directory [options]
    -r, --no-replace-urls            Replace relative URLs with absolute URLs. Default: true
    -f, --load-in-iframe             Default the views to load in an iframe (it can be toggled from the page). Default: false
    -w, --watch                      Watches the cassettes for changes. Default: true
    -p, --port PORT                  Port to mount the server
    -h, --help                       Prints this help
```

## TODO

- Write better tests
- Make the view a folder tree

## Contributing

1. Fork it ( https://github.com/Zequez/cassette_explorer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
