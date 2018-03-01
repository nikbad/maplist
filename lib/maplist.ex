defmodule Maplist do

  @moduledoc """
 Simplifies operations with MapLists (lists containing exclusively maps).
 """

 @doc """
  Returns MapList, in where in the map at the given index the given key or keys and their value or values are dropped.

  ## Examples
      iex> maplist = [%{farmers: 45, beekeepers: 4}, %{farmers: 31, beekeepers: 7}, %{farmers: 24, beekeepers: 8}, %{farmers: 29, beekeepers: 8}]
      [%{beekeepers: 4, farmers: 45, tool: "tractor"}, %{beekeepers: 7, farmers: 31},
      %{beekeepers: 8, farmers: 24}, %{beekeepers: 8, farmers: 29}]]
      iex> Maplist.drop(maplist, 0, [:tool, :farmers])
      [%{beekeepers: 4}, %{beekeepers: 7, farmers: 31}, %{beekeepers: 8, farmers: 24},
      %{beekeepers: 8, farmers: 29}]
  """
def drop(maplst, index, keys) do
  a = maplst |> Enum.at(index) |> Map.drop(keys)
  List.replace_at(maplst, index, a)
end


  @doc """
   Returns the value of the given key at the given index within the given Maplist.

   ## Examples
       iex> listofmaps = [%{result: 10, channel: 4}, %{ok: 3, result: 0.7}, %{comp: 1.4, result: "literature"}]
       [%{channel: 4, result: 10}, %{ok: 3, result: 0.7},
       %{comp: 1.4, result: "literature"}]
       iex> Maplist.get(listofmaps, 0, :result)
       10
   """
  def get(maplst, index, key) do
    maplst |> Enum.at(index) |> Map.get(key)
  end


  @doc """
   Returns list of unchanged map or maps, in where the maximum value or values for the given key within the given MapList was found.

   ## Examples
       iex> maplist = [%{farmers: 45, beekeepers: 4}, %{farmers: 31, beekeepers: 7}, %{farmers: 24, beekeepers: 8}, %{farmers: 29, beekeepers: 8}]
       [%{beekeepers: 4, farmers: 45}, %{beekeepers: 7, farmers: 31},
       %{beekeepers: 8, farmers: 24}, %{beekeepers: 8, farmers: 29}]]
       iex> Maplist.getmax(maplist, :beekeepers)
       [%{beekeepers: 8, farmers: 24}, %{beekeepers: 8, farmers: 29}]
   """
  def getmax(maplst, key) do
    m = maplst |> Enum.map(fn(x) -> Map.get(x, key) end) |> Enum.filter(fn(x) -> x != :nil end) |> Enum.max
    Enum.filter(maplst, fn(x) -> Map.get(x, key) == m end)
  end


  @doc """
   Returns list of unchanged map or maps, in where the minimum value or values for the given key within the given MapList was found.

   ## Examples
       iex> listofmaps = [%{result: 10, channel: 4}, %{ok: 3, result: 0.7}, %{comp: 1.4, result: "literature"}]
       [%{channel: 4, result: 10}, %{ok: 3, result: 0.7},
       %{comp: 1.4, result: "literature"}]
       iex> Maplist.getmin(listofmaps, :result)
       [%{ok: 3, result: 0.7}]
   """
  def getmin(maplst, key) do
    m = maplst |> Enum.map(fn(x) -> Map.get(x, key) end) |> Enum.filter(fn(x) -> x != :nil end) |> Enum.min
    Enum.filter(maplst, fn(x) -> Map.get(x, key) == m end)
  end


  @doc """
   Returns true if term is a MapList, (a list which contains exclusively maps, at least one and nothing but); otherwise returns false.


   ## Examples
       iex> maplst = [%{"str" => :number, 1 => "new"}, %{number: "str", true: "other"}]
       [%{1 => "new", "str" => :number}, %{number: "str", true: "other"}]
       iex> Maplist.is_maplist(maplst)
       true

       iex> Maplist.is_maplist(:atom)
       false

       iex> Maplist.is_maplist([])
       false

       iex> Maplist.is_maplist([%{}])
       true
   """
   def is_maplist(term) do
   cond do
     term |> is_list and term != [] ->
     boollist = for n <- term, do: is_map(n)
     cond do
       boollist |> Enum.uniq |> length == 1 ->
       [bool] = boollist |> Enum.uniq
       bool == true
       true -> false
     end
    true -> false
   end
   end


  @doc """
   Returns a list of one or more lists of the given keys within the given list that are keys within the given MapList.

   ## Examples
       iex> maplist = [%{farmers: 45, beekeepers: 4}, %{farmers: 31, beekeepers: 7}, %{farmers: 24, beekeepers: 8}, %{farmers: 29, beekeepers: 8}]
       [%{beekeepers: 4, farmers: 45}, %{beekeepers: 7, farmers: 31},
       %{beekeepers: 8, farmers: 24}, %{beekeepers: 8, farmers: 29}]]
       iex> Maplist.keysvalues(maplist, [:farmers, :beekeepers])
       [[45, 31, 24, 29], [4, 7, 8, 8]]
   """
  def keysvalues(maplst, listofkeys) do
    for key <- listofkeys, do: maplst |> Enum.map(fn (x) -> x[key] end)
  end

  @doc """
  Returns a list of values of the given key within the given MapList.

   ## Examples
      iex> listofmaps = [%{result: 10, channel: 4}, %{ok: 3, result: 0.7}, %{comp: 1.4, result: "literature"}]
      [%{channel: 4, result: 10}, %{ok: 3, result: 0.7},
      %{comp: 1.4, result: "literature"}]
      iex> Maplist.keyvalues(listofmaps, :result)
      [10, 0.7, "literature"]
   """
  def keyvalues(maplst, key) do
    maplst |> Enum.map(fn (x) -> x[key] end)
  end


  @doc """
   Returns the maximum value for the given key within the given MapList.

   ## Examples
       iex> listofmaps = [%{result: 10, channel: 4}, %{ok: 3, result: 0.7}, %{comp: 1.4, result: "literature"}]
       [%{channel: 4, result: 10}, %{ok: 3, result: 0.7},
       %{comp: 1.4, result: "literature"}]
       iex> Maplist.maxofkey(listofmaps, :result)
       "literature"
   """
  def maxofkey(maplst, key) do
    maplst |> Enum.map(fn(x) -> Map.get(x, key) end) |> Enum.max
  end


  @doc """
   Returns the minimum value for the given key within the given MapList.

   ## Examples
       iex> listofmaps = [%{result: 10, channel: 4}, %{ok: 3, result: 0.7}, %{comp: 1.4, result: "literature"}]
       [%{channel: 4, result: 10}, %{ok: 3, result: 0.7},
       %{comp: 1.4, result: "literature"}]
       iex> Maplist.minofkey(listofmaps, :result)
       0.7
   """
  def minofkey(maplst, key) do
    maplst |> Enum.map(fn(x) -> Map.get(x, key) end) |> Enum.min
  end


  @doc """
   Removes all keys and their respective values; except the given key and its respective values within the given Maplist.

   ## Examples
       iex> listofmaps = [%{result: 10, channel: 4}, %{ok: 3, result: 0.7}, %{comp: 1.4, result: "literature"}]
       [%{channel: 4, result: 10}, %{ok: 3, result: 0.7},
       %{comp: 1.4, result: "literature"}]
       iex> Maplist.onekey(listofmaps, :result)
       [%{result: 10}, %{result: 0.7}, %{result: "literature"}]
   """
  def onekey(maplst, key) do
    lst = for n <- maplst, do: Map.take(n, [key])
    lst |> Enum.filter(fn(x) -> x != %{} end)
  end


  @doc """
   Returns MapList, in where the given key and value are put in the map at the given index; except for the case when the given key already exists within the map at the given index.

   ## Examples
       iex> maplist = [%{farmers: 45, beekeepers: 4}, %{farmers: 31, beekeepers: 7}, %{farmers: 24, beekeepers: 8}, %{farmers: 29, beekeepers: 8}]
       [%{beekeepers: 4, farmers: 45}, %{beekeepers: 7, farmers: 31},
       %{beekeepers: 8, farmers: 24}, %{beekeepers: 8, farmers: 29}]]
       iex> Maplist.put(maplist, 0, :newtool, "tractor")
       [%{beekeepers: 4, farmers: 45, newtool: "tractor"},
       %{beekeepers: 7, farmers: 31}, %{beekeepers: 8, farmers: 24},
       %{beekeepers: 8, farmers: 29}]
   """
  def put(maplst, index, key, value) do
    a = maplst |> Enum.at(index) |> Map.put(key, value)
    List.replace_at(maplst, index, a)
  end


  @doc """
   Returns MapList, in where in the map at the given index the given key's value is replaced with the given value; the key has to exist for this operation to successfully execute.

   ## Examples
       iex> maplist = [%{farmers: 45, beekeepers: 4, tool: "tractor"}, %{farmers: 31, beekeepers: 7}, %{farmers: 24, beekeepers: 8}, %{farmers: 29, beekeepers: 8}]
       [%{beekeepers: 4, farmers: 45, tool: "tractor"}, %{beekeepers: 7, farmers: 31},
       %{beekeepers: 8, farmers: 24}, %{beekeepers: 8, farmers: 29}]]
       iex> Maplist.replace!(maplist, 0, :tool, "destemmer")
       [%{beekeepers: 4, farmers: 45, tool: "destemmer"},
       %{beekeepers: 7, farmers: 31}, %{beekeepers: 8, farmers: 24},
       %{beekeepers: 8, farmers: 29}]
   """
  def replace!(maplst, index, key, value) do
    a = maplst |> Enum.at(index) |> Map.replace!(key, value)
    List.replace_at(maplst, index, a)
  end


  @doc """
   Returns a map where each unique key within the given Maplist is one key with their respective values put together in one list as their respective value.

   ## Examples
       iex> listofmaps = [%{result: 10, channel: 4}, %{ok: 3, result: 0.7}, %{comp: 1.4, result: "literature"}]
       [%{channel: 4, result: 10}, %{ok: 3, result: 0.7},
       %{comp: 1.4, result: "literature"}]
       iex> Maplist.to_map(listofmaps)
       %{channel: [4], comp: [1.4], ok: [3], result: [10, 0.7, "literature"]}
   """
  def to_map(maplst) do
    a = for m <- maplst, do: m |> Map.keys
    b = a |> List.flatten |> Enum.uniq
    c = for n <- b, do: Maplist.keyvalues(maplst, n)
    d = for k <- c, do: Enum.filter(k, & !is_nil(&1))
    Enum.zip(b, d) |> Enum.into(%{})
  end
end
