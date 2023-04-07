defmodule IfscServiceWeb.BankLive do
  use IfscServiceWeb, :live_view

  def mount(_params, %{}, socket) do
    {:ok, socket |> assign(:bank, nil)}
  end

  def handle_event("search_ifsc", %{"query" => ifsc}, socket) do
    bank = IfscService.Repo.get_by!(IfscService.IfscData.Bank, ifsc: String.upcase(ifsc))
    {:noreply, socket |> assign(:bank, bank)}
  end

  def render(assigns) do
    ~H"""
    <div class="my-12 text-2xl">Search for IFSC Code and get Bank Details</div>

    <.form for={%{}} as={:form} phx-submit="search_ifsc" class="flex gap-1">
      <div class="w-3/4">
        <input
          type="text"
          name="query"
          value=""
          placeholder='Try "HDFC0001993"'
          class="outline-none border border-gray-300 rounded w-full"
        />
      </div>
      <div class="w-1/4">
        <button class="border rounded bg-blue-700 h-full text-white w-full">Search</button>
      </div>
    </.form>
    <div class="flex flex-col my-4">
      <%= case @bank do %>
        <% nil -> %>
          <p></p>
        <% _other -> %>
          <ul class="flex flex-col my-4 py-4 rounded-lg border border-blue-700 border-b-8 gap-1 shadow">
            <li class="flex p-2">
              <div class="w-1/4 font-bold text-right pr-4">IFSC</div>
              <div class="w-3/4"><%= @bank.ifsc %></div>
            </li>
            <li class="flex p-2">
              <div class="w-1/4 font-bold text-right pr-4">Bank</div>
              <div class="w-3/4"><%= @bank.bank %></div>
            </li>
            <li class="flex p-2">
              <div class="w-1/4 font-bold text-right pr-4">Branch</div>
              <div class="w-3/4"><%= @bank.branch %></div>
            </li>

            <li class="flex p-2">
              <div class="w-1/4 font-bold text-right pr-4">City</div>
              <div class="w-3/4"><%= @bank.city1 %></div>
            </li>
            <li class="flex p-2">
              <div class="w-1/4 font-bold text-right pr-4">State</div>
              <div class="w-3/4"><%= @bank.state %></div>
            </li>
            <li class="flex p-2">
              <div class="w-1/4 font-bold text-right pr-4">Address</div>
              <div class="w-3/4"><%= @bank.address %></div>
            </li>
          </ul>
      <% end %>
    </div>
    <div class="my-24 text-sm">
      Powered by
      <a href="https://www.phoenixframework.org/" class="text-blue-700" target="_blank">
        Phoenix Framework
      </a>
    </div>
    """
  end
end
