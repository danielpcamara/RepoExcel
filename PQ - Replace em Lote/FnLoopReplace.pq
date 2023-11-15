let
    Fonte = (Lista as list, Alteracoes as record, Text as text, optional Position as number) =>
let
    totalLoops = List.Count(Lista) -1,
    currentPosition = if Position is null then 0 else Position + 1,
    currentText = Text.Replace(Text, "@" & Lista{currentPosition} & "@", Record.Field(Alteracoes, Text.Upper(Lista{currentPosition}))),
    output =
        if currentPosition = totalLoops
        then currentText
        else @#"FnLoopReplace"(Lista, Alteracoes, currentText, currentPosition)
in
    output
in
    Fonte