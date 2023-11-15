let
    Fonte = Web.Page(Web.Contents("https://www.gov.br/receitafederal/pt-br/assuntos/orientacao-tributaria/pagamentos-e-parcelamentos/taxa-de-juros-selic#Taxa_de_Juros_Selic")),
    #"Linhas Superiores Removidas" = Table.Skip(Fonte,1),
    #"Primeiras Linhas Mantidas" = Table.FirstN(#"Linhas Superiores Removidas",4),
    #"Personalização Adicionada" = Table.AddColumn(#"Primeiras Linhas Mantidas", "Personalizar", each Table.UnpivotOtherColumns(Table.PromoteHeaders([Data], [PromoteAllScalars=true]), {"Mês/Ano"}, "Atributo", "Valor")),
    #"Outras Colunas Removidas" = Table.SelectColumns(#"Personalização Adicionada",{"Personalizar"}),
    #"Personalizar Expandido" = Table.ExpandTableColumn(#"Outras Colunas Removidas", "Personalizar", {"Mês/Ano", "Atributo", "Valor"}, {"Mês/Ano", "Atributo", "porc"}),
    #"Colunas Mescladas" = Table.CombineColumns(#"Personalizar Expandido",{"Mês/Ano", "Atributo"},Combiner.CombineTextByDelimiter("-", QuoteStyle.None),"Data"),
    #"Prefixo Adicionado" = Table.TransformColumns(#"Colunas Mescladas", {{"Data", each Date.FromText("1-" & _, [Format="d-MMMMM-yyyy", Culture="pt-BR"] ), type date}}),
    #"Linhas Classificadas" = Table.Sort(#"Prefixo Adicionado",{{"Data", Order.Ascending}}),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Linhas Classificadas",{{"porc", Percentage.Type}}),
    #"Personalização Adicionada1" = Table.AddColumn(#"Tipo Alterado", "Mult", each 1+[porc], type number)
in
    #"Personalização Adicionada1"