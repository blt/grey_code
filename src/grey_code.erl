-module(grey_code).
-export([binref/1]).

-spec binref(pos_integer()) -> [binary()].
binref(0) ->
    [];
binref(N) ->
    binref(1, N, [<<0>>, <<1>>]).

-spec binref(pos_integer(), pos_integer(), [binary()]) -> [binary()].
binref(N, N, Accum) ->
    Accum;
binref(M, N, Accum) when M < N ->
    Top = lists:map(fun(X) -> <<0, X/binary>> end, Accum),
    Bottom = lists:map(fun(X) -> <<1, X/binary>> end, lists:reverse(Accum)),
    binref(M+1, N, lists:append(Top, Bottom)).
