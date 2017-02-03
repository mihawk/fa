-ifndef(FA_HRL).
-define(FA_HRL, true).

-record(fa, {id     = [],
             style  = "vertical-align:middle;",
             width  = 50,
             height = 50,
             fill   = "#fff",
             class  = [],
             onclick= []
        }).

-endif.