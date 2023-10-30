syntax region CustomMarkdownLink concealends contained matchgroup=markdownUrl start="\[" end="](.\+)"
syntax match CustomPossibleMarkdownLink contains=CustomMarkdownLink "\[.\+](.\+)"
