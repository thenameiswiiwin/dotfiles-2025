;; Treesitter conceal rules for Python
;; Place this file in `after/queries/python/highlights.scm`

;; Logical operators
((identifier) @operator (#eq? @operator "not") (#set! conceal "¬"))
((identifier) @operator (#eq? @operator "or") (#set! conceal "∨"))
((identifier) @operator (#eq? @operator "and") (#set! conceal "∧"))
((identifier) @operator (#eq? @operator "in") (#set! conceal "∈"))

;; Comparison operators
((identifier) @operator (#eq? @operator "==") (#set! conceal "≡"))
((identifier) @operator (#eq? @operator "!=") (#set! conceal "≢"))
((identifier) @operator (#eq? @operator "<=") (#set! conceal "≤"))
((identifier) @operator (#eq? @operator ">=") (#set! conceal "≥"))

;; Arithmetic operators
((identifier) @operator (#eq? @operator "*") (#set! conceal "∙"))

;; Type annotations for int and float
((type (identifier) @type (#eq? @type "int")) (#set! conceal "ℤ"))
((type (identifier) @type (#eq? @type "float")) (#set! conceal "ℝ"))
