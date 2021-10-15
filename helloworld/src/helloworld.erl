%%%-------------------------------------------------------------------
%%% @author Fred Youhanaie <fyrlang@anydata.co.uk>
%%% @copyright (C) 2021, Fred Youhanaie
%%% @doc
%%%
%%% The `Hello World' example from
%%% https://docs.wxwidgets.org/trunk/overview_helloworld.html.
%%%
%%% @end
%%% Created : 15 Oct 2021 by Fred Youhanaie <fyrlang@anydata.co.uk>
%%%-------------------------------------------------------------------
-module(helloworld).

-behaviour(wx_object).

-include_lib("wx/include/wx.hrl").

%% API
%%
-export([start_link/0]).

%% wx_object callbacks
%%
-export([init/1, handle_event/2]).

-record(state, {}).

-define(myID_HELLO, 1).

%%%===================================================================
%%% API
%%%===================================================================

%%--------------------------------------------------------------------
%% Starts the server
%%
-spec start_link() -> wxWindow:wxWindow().
start_link() ->
    wx_object:start_link(?MODULE, [], []).

%%%===================================================================
%%% wx_object callbacks
%%%===================================================================

%%--------------------------------------------------------------------
%% Initializes the server
%%
-spec init([]) -> {wxWindow:wxWindow(), term()}.
init([]) ->
    wx:new([]),
    Frame = wxFrame:new(wx:null(), -1, "Hello World"),

    wxFrame:createStatusBar(Frame),
    wxFrame:setStatusText(Frame, "Welcome to wxWidgets!"),

    wxFrame:setMenuBar(Frame, make_menubar()),
    wxFrame:connect(Frame, command_menu_selected),

    wxWindow:show(Frame),
    {Frame, #state{}}.

%%--------------------------------------------------------------------
%% Handle wx_object events
%%
-spec handle_event(term(), term()) -> {noreply, term()}.
handle_event(WX=#wx{id=ID}, State) ->
    handle_event_id(ID, WX),
    {noreply, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================

%%--------------------------------------------------------------------
%% Create the menubar.
%% This is called from the `init' callback above.
%%
-spec make_menubar() -> wx:wx_object().
make_menubar() ->
    MenuBar = wxMenuBar:new(),

    Menu_file = wxMenu:new([]),
    wxMenu:append(Menu_file, ?myID_HELLO, "&Hello...\tCtrl-H"),
    wxMenu:appendSeparator(Menu_file),
    wxMenu:append(Menu_file, ?wxID_EXIT, "&Quit"),

    Menu_help = wxMenu:new([]),
    wxMenu:append(Menu_help, ?wxID_ABOUT, "&About"),

    wxMenuBar:append(MenuBar, Menu_file, "&File"),
    wxMenuBar:append(MenuBar, Menu_help, "&Help"),

    MenuBar.

%%--------------------------------------------------------------------
%% Handle events based on `ID'.
%% This is called from the `handle_event' callback above.
%%
-spec handle_event_id(integer(), term()) -> any().
handle_event_id(?myID_HELLO, WX) ->
    Dialog = wxMessageDialog:new(WX#wx.obj,
                                 "Hello world from wxWidgets!",
                                 [{caption, "Hello"},
                                   {style, ?wxOK bor ?wxICON_INFORMATION}]),
    wxDialog:showModal(Dialog);

handle_event_id(?wxID_ABOUT, WX) ->
    Dialog = wxMessageDialog:new(WX#wx.obj,
                                 "This is a wxWidgets Hello World example",
                                 [{caption, "About Hello World"},
                                  {style, ?wxOK bor ?wxICON_INFORMATION}]),
    wxDialog:showModal(Dialog);

handle_event_id(?wxID_EXIT, WX) ->
    wxWindow:close(WX#wx.obj).

%%--------------------------------------------------------------------
