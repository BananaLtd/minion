defmodule Mix.Tasks.Docs.Publish do
  use Mix.Task

  @shortdoc "Publishes docs to gh-pages"

  @moduledoc """
  Generates documentation and commits to gh-pages branch 
  """
  def run(_) do
    System.cmd "git co master"
    System.cmd "mix do deps.get, docs"
    System.cmd "mv -R docs/ /tmp/minion-docs/"
    System.cmd "git co gh-pages"
    System.cmd "rm -rf docs/"
    System.cmd "mv -R /tmp/minion-docs/ docs/"
    System.cmd "git add docs"
    System.cmd "git commit -m 'Updated docs'"
    System.cmd "git co master"
  end
end
