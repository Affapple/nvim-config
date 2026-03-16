local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("tex", {
	-- Subfigure snippet
	s("subfigure", {
		t({ "\\begin{figure}[h]", "\t\\centering" }),
		t({ "", "\t\\begin{subfigure}[b]{" }),
		i(1, "0.45"),
		t("\\textwidth}"),
		t({ "", "\t\t\\centering", "\t\t\\includegraphics[width=\\textwidth]{figures/" }),
		i(2, "image1"),
		t("}"),
		t({ "", "\t\t\\caption{" }),
		i(3, "Caption 1"),
		t("}"),
		t("\\label{fig:"),
		i(4, "label1"),
		t("}"),
		t({ "", "\t\\end{subfigure}", "\t~", "\t\\begin{subfigure}[b]{" }),
		i(5, "0.45"),
		t("\\textwidth}"),
		t({ "", "\t\t\\centering", "\t\t\\includegraphics[width=\\textwidth]{figures/" }),
		i(6, "image2"),
		t("}"),
		t({ "", "\t\t\\caption{" }),
		i(7, "Caption 2"),
		t("}"),
		t("\\label{fig:"),
		i(8, "label2"),
		t("}"),
		t({ "", "\t\\end{subfigure}", "\\end{figure}" }),
	}),

	-- Code listing snippet
	s("codesnippet", {
		t("\\begin{lstlisting}[language="),
		i(1, "Python"),
		t({ "]", "\t" }),
		i(2, "% code here"),
		t({ "", "\\end{lstlisting}" }),
	}),
})
