#<-----
UADE
----->#

def test_uade(f) =
mime = file.mime(f)
  if
      mime != "application/octet-stream"
    then
     0
    else
     (-1)
  end
end

def run_uade(file) =
  "uade123 --stderr -f - -e wav -s 2 " ^ file ^ " 2> /dev/null "
end

decoder.oblivious.add(name="UADE", description="Decode files using the uade123 decoder binary.",priority=100, test=test_uade, run_uade)
