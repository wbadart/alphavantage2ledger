function stocks2ledger -d "My package"
  function i_need
    set -l gtg 0
    for prog in $argv
      if not command -v $prog >/dev/null 
        echo "Please install \"$prog\" to continue"
        set -l gtg 1
      end
    end
    return $gtg
  end
  
  
  function try_fetch_price
    set -l symbol $argv[1]
    set -l price \
      (curl -sS "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$ALPHAVANTAGE_API_KEY" \
      | jq -r '.["Global Quote"]|.["05. price"]')
    if [ "$price" = 'null' ]
      echo 'Rate limited. Resuming in 60s...' >&2
      sleep 60
      try_fetch $argv
    else
      echo -n $price
    end
  end
  
  function exclude
    if [ -n "$STOCKS_EXCLUDE" ]
      grep -Ev "($STOCKS_EXCLUDE)"
    else
      cat
    end
  end
  
  i_need curl hledger jq
  echo "; Prices collected" (date)
  
  set -l commodities (hledger commodities | exclude)
  for symbol in $commodities
    if [ "$argv[1]" = '-d' ]
      echo P (date +%Y/%-m/%-d) $symbol USD '<not fetched>'
    else
      set -l price (try_fetch_price $symbol)
      echo P (date +%Y/%-m/%-d) $symbol USD $price
      sleep 15
    end
  end
end
