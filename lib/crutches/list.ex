defmodule Crutches.List do
  @type t :: List
  @type i :: Integer
  @type f :: Function
  @type a :: Any

  @doc ~S"""
  Returns a copy of the List without the specified elements.

  ## Examples

      iex> List.without(["David", "Rafael"], ["David"])
      ["Rafael"]

      iex> List.without(["David", "Rafael", "Aaron", "Todd"], ["Aaron", "Todd"])
      ["David", "Rafael"]

      iex> List.without([1, 1, 2, 1, 4], [1, 2])
      [4]
  """
  @spec without(t, t) :: t
  def without(collection, elements) do
    Enum.filter(collection, fn(x) -> !Enum.member?(elements, x) end)
  end

  @doc ~S"""
  Returns the tail of the array from +position+.

  ## Examples


      iex> List.from(["a", "b", "c", "d"], 0)
      ["a", "b", "c", "d"]

      iex> List.from(["a", "b", "c", "d"], 2)
      ["c", "d"]

      iex> List.from(["a", "b", "c", "d"], 10)
      []

      iex> List.from([], 0)
      []

      iex> List.from(["a", "b", "c", "d"], -2)
      ["c", "d"]

      iex> List.from(["a", "b", "c", "d"], -10)
      []

  """
  @spec from(t, i) :: t
  def from(collection, position) do
    Enum.slice(collection, position, Enum.count(collection))
  end

  @doc ~S"""
  Converts the array to a comma-separated sentence where the last element is
  joined by the connector word.

  You can pass the following options to change the default behavior. If you
  pass an option key that doesn't exist in the list below, it will raise an
  <tt>ArgumentError</tt>.

  ## Options

  * <tt>:words_connector</tt> - The sign or word used to join the elements
   in arrays with two or more elements (default: ", ").
  * <tt>:two_words_connector</tt> - The sign or word used to join the elements
   in arrays with two elements (default: " and ").
  * <tt>:last_word_connector</tt> - The sign or word used to join the last element
   in arrays with three or more elements (default: ", and ").
  * <tt>:locale</tt> - If +i18n+ is available, you can set a locale and use
   the connector options defined on the 'support.array' namespace in the
   corresponding dictionary file.

  ## Examples

      iex> List.to_sentence([])
      ""

      iex> List.to_sentence(["one"])
      "one"

      iex> List.to_sentence(["one", "two"])
      "one and two"

      iex> List.to_sentence(["one", "two", "three"])
      "one, two, and three"

      iex> List.to_sentence(["one", "two"], [{:passing, "invalid option"}])
      ** (ArgumentError) Unknown key passing

      iex> List.to_sentence(["one", "two"], [{:two_words_connector, "-"}])
      "one-two"

      iex> List.to_sentence(["one", "two", "three"], [{:words_connector, " or "}, {:last_word_connector, " or at least "}])
      "one or two or at least three"

      Using <tt>:locale</tt> option:

      Given this locale dictionary:

       es:
         support:
           array:
             words_connector: " o "
             two_words_connector: " y "
             last_word_connector: " o al menos "

      iex> es = [support: [array: [words_connector: " o ", two_words_connector: " y ", last_word_connector: " o al menos "]]]
      iex> List.to_sentence(['uno', 'dos'], [{:locale, es}])
      "uno y dos"

      iex> es = [support: [array: [words_connector: " o ", two_words_connector: " y ", last_word_connector: " o al menos "]]]
      iex> List.to_sentence(['uno', 'dos', 'tres'], [{:locale, es}])
      "uno o dos o al menos tres"

  """
  @spec to_sentence(t) :: t
  def to_sentence(words, options \\ []) do
    allowed_keys = [:words_connector, :two_words_connector, :last_word_connector, :locale]
    bad_keys = Enum.reject(Keyword.keys(options), &Enum.member?(allowed_keys, &1))
    if length(bad_keys) > 0 do
      raise ArgumentError, message: "Unknown key #{hd(bad_keys)}"
    end

    default_connectors = [
      {:words_connector, ", "},
      {:two_words_connector, " and "},
      {:last_word_connector, ", and "}
    ]

    new_options = Keyword.merge(default_connectors, options)
    if new_options[:locale] do
      new_options = Keyword.merge(new_options, options[:locale][:support][:array])
    end
    case length(words) do
      0 ->
        ""
      1 ->
        "#{List.first(words)}"
      2 ->
        "#{List.first(words)}#{new_options[:two_words_connector]}#{List.last(words)}"
      _ ->
        "#{Enum.join(Enum.reverse(tl(Enum.reverse(words))), new_options[:words_connector])}#{new_options[:last_word_connector]}#{List.last(words)}"
    end
  end

  @doc ~S"""
  Divides the List into one or more sublists based on a delimiting +value+
  or the result of a function.

  ## Examples

      iex> List.split([1, 2, 3, 4, 5], 3)
      [[1, 2], [4, 5]]

      iex> List.split([1, 2, 3], 4)
      [[1, 2, 3]]

      iex> List.split(Enum.to_list(1..10), fn(x) -> rem(x, 3) == 0 end)
      [[1, 2], [4, 5], [7, 8], [10]]

      iex> List.split([1, 2], fn(x) -> rem(x, 3) == 0 end)
      [[1, 2]]
  """
  @spec split(t, f) :: [t]
  def split(list, function) when is_function(function) do

  end

  @spec split(t, a) :: [t]
  def split(list, item) do

  end


end
