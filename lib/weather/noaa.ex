defmodule Weather.NOAA do
  @user_agent ["User-agent": "Elixir Kronic.Deth@gmail.com"]

  def fetch(station) do
    response = HTTPotion.get(station_url(station), @user_agent)

    flag = if HTTPotion.Response.success? response do
      :ok
    else
      :error
    end

    {flag, response.body}
  end

  defp station_url(station) do
    "http://w1.weather.gov/xml/current_obs/#{station}.xml"
  end
end
