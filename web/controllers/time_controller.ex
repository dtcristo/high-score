defmodule HighScore.TimeController do
  use HighScore.Web, :controller
  use Timex

  def current(conn, _params) do
    time = Date.local
           |> DateFormat.format("%r", :strftime)
           |> elem(1)
    text conn, time
  end
end
