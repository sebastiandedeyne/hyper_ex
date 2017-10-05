# HyperEx

[![Hex.pm](https://img.shields.io/hexpm/v/hyper_ex.svg)](https://hex.pm/packages/hyper_ex)
[![Hex.pm](https://img.shields.io/hexpm/dt/hyper_ex.svg)](https://hex.pm/packages/hyper_ex)
[![Travis](https://img.shields.io/travis/sebastiandedeyne/hyper_ex.svg)](https://travis-ci.org/sebastiandedeyne/hyper_ex)

A [HyperScript](https://github.com/hyperhype/hyperscript) clone written in Elixir.

HyperScript is a JavaScript library to render html with a functional API. HyperScript exposes one main function, `h`.

Here's what that looks like in HyperEx:

```elixir
HyperEx.h("div#foo.bar", "Hello world!")
~s{<div id="foo" class="bar">Hello world!</div>}

HyperEx.h("div#foo.bar", [class: "baz"], "Hello world!")
~s{<div class="bar baz" id="foo">Hello world!</div>}
```

Besides `h`, HyperEx exposes a few more helper functions: `open`, `close` and `wrap`. Read the [API reference](https://hexdocs.pm/hyper_ex/HyperEx.html) for a detailed overview.

## Installation

Add `hyper_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:hyper_ex, "~> 0.1.0"}]
end
```

## Usage

See [https://hexdocs.pm/hyper_ex/](https://hexdocs.pm/hyper_ex/)

## Changelog

Please see [CHANGELOG](https://github.com/sebastiandedeyne/hyper_ex/blob/master/CHANGELOG.md) for more information what has changed recently.

## Testing

```bash
$ mix test
```

## Contributing

Pull requests are welcome!

## Credits

- [Sebastian De Deyne](https://github.com/sebastiandedeyne)
- [All Contributors](../../contributors)

## License

The MIT License (MIT). Please check the [LICENSE](https://github.com/sebastiandedeyne/hyper_ex/blob/master/LICENSE.md) for more information.

