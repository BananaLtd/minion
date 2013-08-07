# How to create a Minion-based project

Download the minion Mix task and install it to your local mix tasks:
```
mix local.install http://bananaltd.github.io/minion/archive/minion-0.0.1.ez
```

Create a elixir project with minion dependecies:
```
mix minion your_project_name
```

Then, enter your project directory:
```
cd your_project_name
```

Now, you can start your minion project in an interactive shell:
```
iex --name minion --cookie minion -S mix
```

Or, you can start it as a silent background task:
```
mix compile
elixir --name minion --cookie minion --no-halt -pa ebin --app minion
```

# What can Minion do for me
If you have multiple instances of your minion-based project you can distribute tasks to all of your nodes. It works just like magic!

*We will show you some demo code soon. Meanwhile have a look at [Gru](http://bananaltd.github.io/gru/), it uses Minion.*


# Documentation

Look, there is [beautifully generated documentation](http://bananaltd.github.io/minion/docs/) for you! It describes all the features on the master branch.

To generate the documetation on your own, just run:
```
mix deps.get
mix docs
```

Then, have a look into your projects `/docs` folder.


# Contributors

* Steffen Schröder ([@ChaosSteffen](https://github.com/ChaosSteffen))
* Christoph Grabo ([@asaaki](https://github.com/asaaki))
* Sascha Depold ([@sdepold](https://github.com/sdepold))
