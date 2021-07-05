defmodule Playground do

  def open() do
    spawn(fn -> loop(0) end)
  end

  def show(pid) do
    send(pid, {:show, self()})

    receive do
      {:response, value} ->
        value
    end
  end

  def store(pid, amount) do
    send(pid, {:store, amount})
  end

  def loop(balance) do
    new_balance =
      receive do
        {:store, amount} ->
          balance + amount
        {:withdraw, amount} ->
          balance - amount
        {:show, pid} ->
          send(pid, {:response, balance})
          balance
        _ ->
          IO.puts("error")
      end
    loop(new_balance)
  end
end
