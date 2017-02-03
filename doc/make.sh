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

icon(#fa{name=Name}=Fa) -> apply(?MODULE,Name,[Fa]). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

EOF

ICON="info-circle.svg \
info.svg \
cab.svg \
taxi.svg \
shopping-bag.svg \
shopping-basket.svg \
shopping-cart.svg \
cc-mastercard.svg \
credit-card-alt.svg \
credit-card.svg \
comment-o.svg \
comment.svg \
commenting-o.svg \
commenting.svg \
comments-o.svg \
comments.svg \
paper-plane-o.svg \
paper-plane.svg \
plane.svg \
hashtag.svg \
instagram.svg \
tag.svg \
tags.svg \
dollar.svg \
rmb.svg \
euro.svg \
rouble.svg \
yen.svg \
btc.svg \
won.svg \
gbp.svg \
usd.svg"

for i in ${ICON}; do  n=`echo $i|awk -F. '{print $1}' | tr - _`; d=`cat svg/$i | gawk 'BEGIN { RS="<[^>]+>" } { print RT, $0 }' | grep path | awk -F'"' '{print "\"",$2"\""}'`;echo "$n(F) ->"; echo "  #svg{id=F#fa.id, class=F#fa.class, style=F#fa.style, onclick=F#fa.onclick, width=F#fa.width, height=F#fa.height, viewBox=\"0 0 1792 1792\",xmlns=\"http://www.w3.org/2000/svg\", body=[" ; echo "       #path{d=$d,"; echo "             fill=F#fa.fill}"; echo "  ]}." ; echo ""; done >> ../src/fa.erl
