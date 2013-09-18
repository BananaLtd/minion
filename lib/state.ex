defmodule State do
  @moduledoc """
  This module allows you to save key-value style states on disk.
  """

  def all pid // nil do
    if File.exists?("states") do
      case File.read("states") do
        {:error, :enoent} ->
          {:ok, []}
        {:ok, foo} ->
          {:ok, contents} = JSON.decode(foo)
        _ ->
          {:ok, HashDict.new}
      end
    else
      {:ok, HashDict.new}
    end
  end

  def all pid do
    {:ok, contents} = State.all

    pid <- {self, contents}
  end

  def persist states do
    {:ok, contents} = JSON.encode(states)

    File.write("states", contents)
  end

  def get pid // nil, key do
    {:ok, states} = State.all

    if pid do
      pid <- {self, HashDict.get(states, key)}
    else 
      HashDict.get(states, key)
    end
  end

  def set key, value do
    {:ok, states} = State.all

    State.persist HashDict.put(states, key, value)
  end

  def delete_state key do
    {:ok, states} = State.all

    State.persist HashDict.delete(states, key)
  end
end
