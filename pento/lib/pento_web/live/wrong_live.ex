defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, score: 0, message: "Guess a number", answer: Enum.random(1..10))}
  end

  def render(assigns) do
    ~L"""
    <h1>Your score: <%= @score %></h1>
    <h2>
    <%= @message %>
    </h2>
    <h2>
      <%=for n<-1..10 do%>
        <a href="#" phx-click= "guess" phx-value-number="<%= n %>"> <%= n %> </a>
      <%end%>
    </h2>
    <h3> <%= @answer %> </h3>

    <br>
    <h4><%= live_patch("Restart", to: Routes.live_path(@socket, PentoWeb.WrongLive)) %></h4>
    """
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    if guess == "#{socket.assigns.answer}" do
      message = "Your guess: #{guess} is correct!!! Continue playing"
      score = socket.assigns.score + 1
      {:noreply, assign(socket, message: message, score: score, answer: Enum.random(1..10))}
    else
      message = "Your guess: #{guess} is wrong! Guess again"
      score = socket.assigns.score - 1
      {:noreply, assign(socket, message: message, score: score)}
    end
  end

end
