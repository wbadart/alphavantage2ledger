function stocks2ledger -d "My package"

  function i_need
    # Ensure dependencies are available
    set -l gtg 0
    for prog in $argv
      if not command -v $prog >/dev/null 
        echo "Please install \"$prog\" to continue"
        set -l gtg 1
      end
    end
    return $gtg
  end
  i_need curl hledger jq
  
  function fetch_price
    # Grab a stock's price from the API
    set -l symbol $argv[1]
    set -l price \
      (curl -sS "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$ALPHAVANTAGE_API_KEY" \
      | jq -r '.["Global Quote"]|.["05. price"]')
    echo -n $price
  end
  
  function exclude
    # Read STOCKS_EXCLUDE to filter out commodities we don't want prices for
    if [ -n "$STOCKS_EXCLUDE" ]
      grep -Ev "($STOCKS_EXCLUDE)"
    else
      cat
    end
  end
  
  echo "; Prices collected" (date)
  
  set -l commodities (hledger commodities | exclude)
  for symbol in $commodities
    if [ "$argv[1]" = '-d' -o "$argv[1]" = '--dry-run' ]
      echo P (date +%Y/%-m/%-d) $symbol USD '<not fetched>'
    else
      set -l price (fetch_price $symbol)
      echo P (date +%Y/%-m/%-d) $symbol USD $price
      sleep 15
    end
  end
end
