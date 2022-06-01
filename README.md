# ARQUITETURA

![Uol -Test drawio](https://user-images.githubusercontent.com/105077314/171049097-c8d67f15-3b8e-4445-be53-33219c57af87.png)

# Infraestrutura

## VPC
- Pensando em alta disponibilidade, escalabilidade e redundância, criei uma vpc com 6 subnets sendo 3 publicas e 3 privadas, uma em cada AZ da AWS, pensando na segurança do ambiente e nas melhores práticas, para as subnets públicas foi criado um internet gateway, e para as subnets privadas foi criado um nat gateway, utilizando um Module Community do terraform.

## EC2
- Criei um módulo padrão para as ec2 "terraform/modules/ec2/", assim podendo trabalhar com mais facilidade e flexibilidade no arquivo main.tf trabalhando com as váriaveis de ambiente, a intenção foi ter autonomia para lançar máquinas em qualquer AZ pública ou privada atraves do módulo.

## DYNAMODB
- Foi usado uma table do dynamodb para fazer um lock no state do terraform nos momentos de uso para não gerar conflitos em um ambiente com vários colaboradores.

## S3
- Criado um bucket s3 para armazenar nosso statefile de forma remota para não gerar conflitos com os deploys do terraform se ficasse localmente.

- Usei EC2 com a intenção de ajustar o ansible para instalação do Kubernetes + Rancher, formando um cluster IaaS na rede privada e outro cluster IaaS na rede pública, possibilitando a comunicação entre os clusters com uma Api Gateway.
  - Cada host ficaria em uma AZ diferente atendendo ao requisito de H.A de uma aplicação/ambiente e o banco de dados multiAZ também.
- Abortei a configuração com o ansible porque irei "arriscar" subir a infra toda enquanto estiver no tempo de entrevista com a equipe, e notei que iria tomar muito tempo apresentando o terraform, aws, monitorias, ci/cd e o ansible instalando tudo junto, abortei a utilização do ansible mas não abortei a infraestrutura pensada inicialmente mesmo sabendo que não é a infra mais "fácil" (PaaS, ECS ou EKS) de se manter.

# CI/CD
- Para o CI/CD utilizei o Actions do próprio Github:

 https://github.com/oteodorojunior/challenge-uol/actions/runs/2411015026

- Procurei utilizar os steps de melhores práticas, última versão do ubuntu, checkout, setup do terraform e também se caso no terraform plan o status for 'FAILURE' o deploy não é realizado segue:

https://github.com/oteodorojunior/challenge-uol/blob/master/.github/workflows/terraform.yml#L46

# MONITORIA E MÉTRICAS
- Para monitorias e métricas utilizo cloudwatch e zabbix digamos que como "backend" e o Grafana como "frontend".

![ev_grafana](https://user-images.githubusercontent.com/42479203/120553431-dd651280-c3ce-11eb-8d2c-9ba394c14a15.jpeg)

- Assim podendo ter uma visão unificada de ambas monitorias, criando dashboards personalizadas.

![ev_dash](https://user-images.githubusercontent.com/42479203/120553781-4ba9d500-c3cf-11eb-9ad9-defbf7cb22a8.jpeg)

- Também podendo criar webscenarios para monitoriar urls e disponibilidade das api e páginas web, sem custo adicional.

O exemplo a seguir, se a url da api retornar o status 200 tudo OK, se caso mudar de status o zabbix alerta e atraves de uma webhook envia mensagens. (Slack, Google Chat, etc)

![ev_webscenario](https://user-images.githubusercontent.com/42479203/120554083-b4914d00-c3cf-11eb-82c5-89e2eaa797e7.jpeg)

Segue evidência do envio do alerta.

![ev_alerta](https://user-images.githubusercontent.com/42479203/120554370-0a65f500-c3d0-11eb-8ecc-aab14d9c216d.jpeg)

- No alerta é possível ver rapidamente o um problema ou o recovery da trigger, o tempo de downtime e a severidade da problema.

## VULNERABILIDADES

- Segue uma análise de vulnerabilidades que realizei em algumas imagens para exemplificar e evidenciar a importância do alpine, na imagem criada temos apenas 1 vulnerabilidade média, já em outras imagens teriamos mais de 40 vulnerabilidades, baixas, médias e altas.

![ev_images1](https://user-images.githubusercontent.com/42479203/120828597-16b69300-c533-11eb-9378-4c9aa829704e.png)

- A seguir segue o detalhamento da vulnerabilidade encontrada na imagem criada.

![ev_images_2](https://user-images.githubusercontent.com/42479203/120828701-377ee880-c533-11eb-932d-41424cf25331.png)

- Como sugerido, se fizermos a atualização do Jinja2 para a versão 2.11.3, não teremos mais essa vulnerabilidade média em nosso ambiente.

# OBSERVAÇÃO
- Não utilizei toda a parte do Gitflow para tornar resumido o bate papo, utilizei apenas um branch (master) para ser mais dinâmico nas explicações, mesmo tendo em mente a importância de criarmos branches e aplicarmos a partide de pull requests (PRS) na branch master.

- Os endereços nos security groups estão abertos para internet (0.0.0.0/0) apenas por se tratar de um teste, com toda certeza em um ambiente empresarial isso não é uma boa prática.
