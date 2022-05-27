WITH valor_compra AS (
	SELECT
		t.valor_total - (t.valor_total * (COALESCE(t.percentual_desconto, 0)/100)) AS vl_c_desconto,
		t.contrato_id 
	FROM dbo.transacao t
	), Resultado AS (
		SELECT
			con.cliente_id,
			cli.nome,
			con.ativo,
			SUM(valor_compra.vl_c_desconto * (con.percentual/100)) AS Lucro
		FROM dbo.contrato con INNER JOIN valor_compra ON con.contrato_id  = valor_compra.contrato_id
		INNER JOIN dbo.cliente cli ON con.cliente_id = cli.cliente_id
		WHERE con.ativo != 0
		GROUP BY con.cliente_id, con.ativo, cli.nome)
		SELECT nome, round(Lucro,2) AS Lucro FROM Resultado;
