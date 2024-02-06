# Website for the OSCAR book

## Installing Jekyll

First install bundler. On Ubuntu, that means

```bash
apt install git bundler
```

Then, clone (a fork of) this repo and cd into it. Then use bundler to install jekyll 
(and other required gems) as defined in the `Gemfile`.

```bash
bundle install
```

## How to contribute

Fork this repository on GitHub, and provide a Pull Request to it.
To test your changes locally, run

```bash
jekyll serve
```
in the main directory.

## How to use syntax highlighting in Markdown files

You can use Jekylls highlighter to get syntax highlighting.
For Julia code, do the following
````
```julia
function foo(x)
  return x
end
```
````

For code samples involving the Julia REPL mode, use this:
````
```console?lang=julia
julia> print(2)
2
```
````

Note however that the triple-backtick syntax does not work when nested inside
HTML elements. In that case, you can also use the following Jekyll syntax:
```
{% highlight julia %}
function foo(x)
  return x
end
{% endhighlight %}
```

A full list of supported languages can be found [here](https://github.com/rouge-ruby/rouge/blob/master/docs/Languages.md).
