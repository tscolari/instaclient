Instaclient
==========

A very simple instagram client.


Usage
-----

```
  require 'instaclient'
  client = Instaclient::Client.new(my_client_id, my_client_secret)

  result = client.recent(user_id, count)

  result.each do |media|
    puts "Link: #{media.link}"
    puts "ID: #{media.id}"
    puts "Image: #{media.image_url(:standard_resolution)}"
    ...
  end

  embed = client.embed("https://instagram.com/p/somemedia/")

  embed.html
  #=> "<blockquote ..."
  embed.title
  #=> "media title"
  embed.author
  #=> "author name"
```

Methods
------

There is only the `recent` method, it's all I need at the moment!

Official Instagram Gem
-------------

Yeah, there is an official instagram gem but it's not multi-tenant friendly

License
------

MIT
