## Email Exercise
This repo contains my response to the email exercise set forth by Intercom. I have rewritten the Array method, flatten (now called 'compress'). I have also included a class which allows a user to find customers within 100km of Intercom's Dublin office.

### Resources
My solution is written in Ruby and tested in RSpec.
I used the Vincenty formula, laid out in the [Great-circle distance wikipedia page](https://en.wikipedia.org/wiki/Great-circle_distance) as a reference for my distance calculator.

### How to use
Clone this repo and cd into it. Run my tests by typing rspec into the command line.
To find nearby users, either with the sample .txt file or your own:

```
$ irb
> require './lib/intercom_distance'
> intercom = IntercomDistance.new
> intercom.print_nearby_customers("test_examples.txt")
> intercom.print_nearby_customers("customers.txt")
```

### My proudest accomplishment
You can read about what I consider one of my proudest accomplishments [here]("accomplishment.md").
