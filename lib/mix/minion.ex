defmodule Mix.Tasks.Minion do
  use Mix.Task

  @shortdoc "Creates a new minion-bases Elixir project"

  @moduledoc """
  Creates a new minion-bases Elixir project 
  """
  def run(args) do
    [project_name] = args

    Mix.Task.run("new", [project_name])

    old_mixfile = "#{project_name}/mix.exs"
    new_mixfile = "#{project_name}/mix.new.exs"

    File.open(old_mixfile, [:read], fn(read_pid) ->
      File.open(new_mixfile, [:write], fn(write_pid) ->
        modify_mixfile(read_pid, write_pid, project_name)
      end)
    end)

    receive do
      :modify_mixfile_done ->
        overwrite(new_mixfile, old_mixfile)
        IO.puts("Downloading minion dependencies ...")
        System.cmd("cd #{project_name} && mix deps.get")
        IO.puts("DONE")
    end
  end

  defp modify_mixfile(read_pid, write_pid, project_name) do
    case IO.read(read_pid, :line) do
      "  def application do\n" ->
        insert_application_block(write_pid, project_name)
        skip_line(read_pid)
        modify_mixfile(read_pid, write_pid, project_name)
      "  defp deps do\n" ->
        insert_deps_block(write_pid)
        skip_line(read_pid)
        modify_mixfile(read_pid, write_pid, project_name)
      :eof ->
        self <- :modify_mixfile_done
      line ->
        IO.write(write_pid, line)
        modify_mixfile(read_pid, write_pid, project_name)
    end
  end

  defp insert_application_block(pid, project_name) do
    IO.write(pid, "  def application do\n    [ registered: [:#{project_name}],\n      mod: { Minion, [] } ]\n")
  end

  defp insert_deps_block(pid) do
    IO.write(pid, "  defp deps do\n    [ { :minion, github: \"BananaLtd/minion\" } ]\n")
  end

  defp skip_line(pid) do
    _ = IO.read(pid, :line) #skip line
    :ok
  end

  defp overwrite(source, destination) do
    if File.exists?(source) do
      :ok = File.rm!(destination)
      :ok = File.cp!(source, destination)
      :ok = File.rm!(source)
    end
  end
end
