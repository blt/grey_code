-module(grey_code_SUITE).

-export([all/0]).
-export([all_returns_are_2expn_sized/1,
         succesive_values_differ_by_one_bit/1]).
-export([diffs/2, differs/3]).

-include_lib("../include/test.hrl").
-include_lib("common_test/include/ct.hrl").

all() -> ?CT_REGISTER_TESTS(?MODULE).

all_returns_are_2expn_sized(_Config) ->
    Codes = grey_code:binref(20),
    length(Codes) rem 2 =:= 0.

succesive_values_differ_by_one_bit(_Config) ->
    Codes = grey_code:binref(20),
    lists:all(fun(X) -> X =:= 1 end, diffs(Codes, [])).

-type integers() :: list( pos_integer() ).
-type binaries() :: list( binary() ).

-spec diffs(binaries(), integers()) -> integers().
diffs([], Accum) ->
    Accum;
diffs([X, Y | Rest], Accum) ->
    diffs(Rest, [differs(X, Y, 0) | Accum]).

-spec differs(binary(), binary(), non_neg_integer()) -> pos_integer().
differs(<<>>, <<>>, Total) ->
    Total;
differs(<<X, Xs/binary>>, <<Y, Ys/binary>>, Total) ->
    case X =:= Y of
        true  -> differs(Xs, Ys, Total);
        false -> differs(Xs, Ys, Total+1)
    end.
