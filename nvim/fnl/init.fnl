(module nvim-config
  {:require {a aniseed.core
             nvim aniseed.nvim}})

; (def _G.fib_fnl [n]
;     (let start (os.clock))
;     (start))

; (a.println (nvim.fn.getwininfo))

;     local a, b = 0, 1

;     for _ = 1, n do
;         a, b = b, a + b
;     end

;     print("Milliseconds: " .. os.clock() - start)
;     return a
