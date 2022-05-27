# Entregavel 4 - Pipeline

Para essa pipeline optei por um modelo de arquitetura como padrão Lambda.
Onde temos duas Layers de processamento, Batch e Streamming ou Speed Layer.

A Speed Layer segue o modelo enviado para o teste onde temos o AWS Forecast que realizará as previsões enviando o resultado para um Bucket no S3. Após isso catalogamos esses resultados como AWS Glue e disponibilizaremos estes resultados via AWS Athena para consultas.

Já na Batch Layer recebemos os dados em um Bucket no S3 onde salvaremos os dados brutos. A ideia aqui é acumular uma certa quantidade de dados e processa-los de uma só vez, repetindo isso diariamente ou até mais de uma vez por dia.
Para isso usaremos o MWAA (Airflow) com um Sensor que vai ler a quantidade de arquivos em uma partição desde bucket, quando tivermos a quantidade de arquivos desejados iniciaremos nossa pipeline.
A pipeline consiste em 4 passos:
    - Subir um cluster EMR Efemero
    - Processas os dados com Pyspark ou Spark SQL
    - Salvar os dados em um Bucket diferente da origem
    - Desligar o cluster criado no começo da pipeline para otimização de gastos
    - Executar o comando de Copy para o Redshift

Não foi contemplada na ilustração mas também podemos ter steps de data quality e enriquecimento desses dados antes da disponibilização dos mesmos no Redshift.