defmodule Mix.Tasks.Docs.Publish do
  use Mix.Task

  @shortdoc "Publishes docs to gh-pages"

  @moduledoc """
  Generates documentation and commits to gh-pages branch 
  """
  def run(_) do
    Mix.Project.get!
    version = Mix.Project.config[:version]

    System.cmd "git co master"
    System.cmd "mix do deps.get, docs"
    System.cmd "mv docs/ /tmp/minion-docs-#{version}"
    System.cmd "git co gh-pages"
    System.cmd "rm -rf docs/#{version}/"
    System.cmd "mv /tmp/minion-docs-#{version}/ docs/#{version}"
    System.cmd "git add docs"
    System.cmd "git commit -m 'Updated docs'"
    System.cmd "git co master"
  end
end

defmodule Mix.Tasks.Archive.Publish do
  use Mix.Task

  @shortdoc "Publishes archive to gh-pages"

  @moduledoc """
  Generates archive and commits to gh-pages branch 
  """
  def run(_) do
    Mix.Project.get!
    version = Mix.Project.config[:version]

    System.cmd "git co master"
    System.cmd "mix do archive"
    System.cmd "rm -f /tmp/minion-#{version}.ez"
    System.cmd "mv minion-#{version}.ez /tmp/"
    System.cmd "git co gh-pages"
    System.cmd "rm -f archive/minion-#{version}.ez"
    System.cmd "mv /tmp/minion-#{version}.ez archive/"
    System.cmd "git add archive/"
    System.cmd "git commit -m 'Updated archive'"
    System.cmd "git co master"
  end
end
