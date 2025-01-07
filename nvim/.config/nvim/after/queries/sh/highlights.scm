;; Highlight and conceal variable assignments in Bash
;; Place this file in `after/queries/bash/highlights.scm`

(variable_assignment
  value: (word) @string
) (#set! conceal ".")
