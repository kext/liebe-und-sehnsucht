# Liebe & Sehnsucht

*Ein Forum mit Ruby on Rails*

## Installation

```
$ git clone https://github.com/kext/liebe-und-sehnsucht.git
$ cd liebe-und-sehnsucht
$ rake db:migrate
$ rails server
```

Boards müssen momentan auf der Konsole erstellt werden.

```ruby
Board.create title: 'Liebe'
Board.create title: 'Sehnsucht'
```
