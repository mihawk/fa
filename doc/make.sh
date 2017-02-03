#!/bin/bash
cat > ../src/fa.erl << EOF
-module(fa).
-behaviour(supervisor).
-behaviour(application).
-export([icon/1]).
-compile(export_all).
-include("fa.hrl").
-include_lib("svg/include/svg.hrl").

start(_,_) -> supervisor:start_link({local,fa }, fa,[]).
stop(_)    -> ok.
init([])   -> sup().
sup()      -> { ok, { { one_for_one, 5, 100 }, [] } }.

%% generated from https://github.com/encharm/Font-Awesome-SVG-PNG/white/svg
%% cd doc
%% ./make.sh 

icon(#fa{id=Name}=Fa) -> apply(?MODULE,Name,[Fa]). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

EOF

for i in $(ls svg|grep -v try|grep -v stop|grep -v 500px); do  n=`echo $i|awk -F. '{print $1}' | tr - _`; d=`cat svg/$i | gawk 'BEGIN { RS="<[^>]+>" } { print RT, $0 }' | grep path | awk -F'"' '{print "\"",$2"\""}'`;echo "$n(F) ->"; echo "  #svg{class=F#fa.class, style=F#fa.style, onclick=F#fa.onclick, width=F#fa.width, height=F#fa.height, viewBox=\"0 0 1792 1792\",xmlns=\"http://www.w3.org/2000/svg\", body=[" ; echo "       #path{d=$d,"; echo "             fill=F#fa.fill}"; echo "  ]}." ; echo ""; done >> ../src/fa.erl
