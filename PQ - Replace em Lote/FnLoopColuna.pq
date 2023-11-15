let
    Fonte = (Tipo as any, ListaDeColunas as any, Fn as any) => let
        Tp = try if Tipo = "text" then type text else Tipo otherwise Tipo,
        FuncaoAplicada = try if Fn = "Fn" then each Date.ToText(_, "yyyy-MM-dd") else Fn otherwise Fn,
        FuncaoDaColuna = each {_, "DATAEMISSAO", each FuncaoAplicada, type text},
        ListCol = try if ListaDeColunas = "A,B" then {"DATAENTRADA", "DATALCTOFIS", "DATAEMISSAO"} else ListaDeColunas otherwise ListaDeColunas,
        Personalizar1 = List.Transform(ListCol, each {_, FuncaoAplicada, type text})
    in
        Personalizar1
in
    Fonte