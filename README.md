SpreeImporterCore
=================

Spree Importer engine. Adds an easy way to massively load  different Spree models, the way you need it.

Installation
------------

_spree\_importer\_core_ supports:

+ Ruby 2.1+
+ Rails 4.2+
+ Spree 3.0+

Add _spree\_importer\_core_ to your Gemfile

```ruby
gem 'spree_importer_core'
```

`bundle install` your dependencies and run the installation generator:

```shell
bundle install
bundle exec rails g spree:importer_core:install
```

Note: `SpreeImporterCore` uses `ActiveJob` for background processing. You may want to specify an adapter before importing, otherwise the job is immediately executed.

Usage
-----

You can generate an importer file running

```ruby
rails g spree:importer_core:importer Thing
```

This will generate the needed files in order to make the importer to work as intended.

- Create new *importer* file
- Insert importer locales for new *importer* class
- Add *sample* importer template
- And, update *importers* list

Then, just restart your rails server

### New importer Class

The new importer class will be placed at `app/models/spree/importer_core/thing_importer.rb`

Importer behavior must be defined in order to correctly import spreadsheet rows. e.g: Updating stock

```ruby
class Spree::ThingImporter < Spree::ImporterCore::BaseImporter
  # Load a file and the get data from each file row
  def load_data(row:)
    sku = row[0]
    stock = row[1]
    if variant = Spree::Variant.find_by(sku: sku)
   	  stock_item = Spree::StockItem.find_by variant_id: variant.id
      stock_item.update_attribute(:count_on_hand, stock)
    end
  end
end
```

Note: you can give the importer any name you want, thou it is highly recommended to give one that describes its content


### Locales

Locales will be placed at `config/spree_importer_core.en.yml`

```
en:
  spree:
    spree_importer_core:
      importers:
        thing:
          title: Thing Importer
          name: Thing
```

Every importer needs `title` for views and `name` for the menu


### Add sample importer template

`ImporterCore` create a sample importer template at `lib/templates/spree_importer_core/`, you need to replace with their correct content. In the last example, file be called `thing.xlsx`.



### Importer List

`ImporterCore` defines a list with the available importers, you may want to add or remove your own importers. Remember to make your classes to inherit from `Spree::ImporterCore::BaseImporter`, otherwise needed methods won't be defined.

Edit `config/initializers/spree.rb` to define/modify the available importers.


```ruby
Spree::ImporterCore::Config.importers << Spree::ThingImporter
```


Testing
-------

First bundle your dependencies, then run `rake`. `rake` will build the dummy app if it does not exist, then it will run specs. The dummy app can be regenerated by running `rake test_app`.

```shell
bundle
bundle exec rake
```

When testing your application you will want to use its factories. Simply add this require statement to your spec_helper:

```ruby
require 'spree/importer_core/factories'
```

Licence
-------

The MIT License (MIT)

Copyright (c) 2015 - [Acid Labs](http://acid.cl)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
