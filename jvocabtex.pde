import java.io.InputStreamReader;
import java.awt.Desktop;

// up to 43 vocab words

Table data = loadTable("vocab.csv", "header, tsv");
PrintWriter out = createWriter("data/latex/out.tex");

out.println("\\documentclass{article}");
out.println("\\usepackage{CJKutf8}");
out.println("\\usepackage[margin=.5in]{geometry}");
out.println("\\usepackage{array}");
out.println("\\usepackage{pdflscape}");
out.println("\\usepackage{multicol}");
out.println("\\newcolumntype{L}[1]{>{\\raggedright\\let\\newline\\\\\\arraybackslash\\hspace{0pt}}m{#1}}");
out.println("\\newcolumntype{R}[1]{>{\\raggedleft\\let\\newline\\\\\\arraybackslash\\hspace{0pt}}m{#1}}");
out.println("\\twocolumn");

out.println("\\begin{document}");
out.println("\\pagestyle{empty}");
out.println("\\begin{landscape}");
out.println("\\begin{CJK}{UTF8}{min}");
out.println("\\begin{multicols}{2}");
out.println("\\noindent");


out.println("\\begin{tabular}{R{.15in} | l}");
out.println("\\ & \\LARGE Japan International Relations Vocab\\");
out.println("\\end{tabular}\n\\normalsize\n");
out.println("\\bigskip\\medskip");
out.println("\\noindent");

out.println("\\begin{tabular}{R{.15in} | L{.5in} L{1in} L{2in}}");
out.println(" & 漢字 & ひらがな & English \\\\\\hline");

int i = 1;
for (TableRow row : data.rows())
  out.println(i++ + " & " + row.getString(0) + " & " + row.getString(1) + " & "
              + row.getString(2) + "\\\\");

out.println("\\end{tabular}");
out.println("\\vfill\\null\n\\columnbreak");
out.println("\\raggedleft");
out.println("\\noindent");
out.println("\\begin{tabular}{R{.15in} | L{3.833in}}");
out.println("\\ & \\LARGE Japan International Relations Vocab\\");
out.println("\\end{tabular}\n\\normalsize\n");
out.println("\\bigskip\\medskip");
out.println("\\noindent");
out.println("\\begin{tabular}{R{.15in} | L{.5in} L{1in} L{2in}}");
out.println(" & 漢字 & ひらがな & English \\\\\\hline");

i = 1;
for (TableRow row : data.rows())
  out.println(i++ + " & " + row.getString(0) + " & " + row.getString(1) + " & "
              + row.getString(2) + "\\\\");

out.println("\\end{tabular}");

out.println("\\end{multicols}");
out.println("\\end{CJK}");
out.println("\\end{landscape}");
out.println("\\end{document}");

out.flush();
out.close();

try {
  String folder = dataPath("/latex/");
  println(folder);
  ProcessBuilder builder = new ProcessBuilder(
          "cmd.exe", "/c", "cd \"" + folder + "\" && pdflatex out.tex");
  builder.redirectErrorStream(true);
  Process p = builder.start();
  BufferedReader r = new BufferedReader(new InputStreamReader(p.getInputStream()));
  String line;
  while (true) {
    line = r.readLine();
    if (line == null)
      break;
    System.out.println(line);
  }
} catch (IOException e) {
  e.printStackTrace();
}

try {
  Desktop.getDesktop().open(new File(dataPath("/latex/out.pdf")));
} catch (IOException e) {
  e.printStackTrace();
}

exit();
