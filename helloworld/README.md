# helloworld

The `Hello World` example from the wxWidgets
[docs](https://docs.wxwidgets.org/trunk/overview_helloworld.html).

## Notes

1. The example has been implemented as a `wx_object` behaviour.
1. Only the `init/1` and `handle_event/2` callbacks have been
   implemented.

## Build and test

All the usual `rebar3` commands work here:

```
$ rebar3 compile
$ rebar3 dialyzer
```

The simpleset way to run the example is with the shell:

```
$ rebar3 shell
1> helloworld:start_link().
```
