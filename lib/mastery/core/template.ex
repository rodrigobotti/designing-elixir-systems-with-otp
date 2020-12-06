defmodule Mastery.Core.Template do
  @type t :: %__MODULE__{
          name: atom(),
          category: atom(),
          instructions: String.t(),
          raw: String.t(),
          compiled: Macro.t(),
          generators: %{atom() => list() | function()},
          checker: (%{atom() => term()}, String.t() -> boolean())
        }
  defstruct ~w[name category instructions raw compiled generators checker]a

  def new(fields) do
    raw = Keyword.fetch!(fields, :raw)

    struct!(
      __MODULE__,
      Keyword.put(fields, :compiled, EEx.compile_string(raw))
    )
  end
end
