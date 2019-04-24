# Simple::Hash

safe simple way to render a liquid template

## installation

    $ gem install simple-liquid

**or**

```ruby
gem 'simple-liquid'
```

    $ bundle

## usage

```ruby
Simple::Liquid.render('hello {{ name | default: "?" }}', { name: nil })
# => hello ?

Simple::Liquid.render('hello {{ location }}', { name: "0xfabe" })
# => Simple::Liquid::Error (undefined variable location)

Simple::Liquid.render('hello {{ location }} {{ something }}', { name: "0xfabe" })
# => Simple::Liquid::Error (undefined variable location, undefined variable something)

Simple::Liquid.render("{{ a | oops }}", { a: 1 })
# => Simple::Liquid::Error (undefined filter oops)
```
