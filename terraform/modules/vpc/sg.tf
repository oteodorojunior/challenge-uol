resource "aws_security_group" "public" {
  name        = "uol-${var.infra_env}-public-sg"
  description = "Internet Access Public"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name        = "uol-${var.infra_env}-public-sg"
    Role        = "public"
    Projetct    = "uol-teste"
    Environment = "var.infra_env"
  }
}

resource "aws_security_group_rule" "public_out" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.public.id

}

resource "aws_security_group_rule" "public_in_ssh" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  #Liberado para 0.0.0.0/0 para efeitos de teste, 
  # extremamente importante para segurança usar um /32,
  # ou vpn site to site para ssh.

  security_group_id = aws_security_group.public.id

}

resource "aws_security_group_rule" "private_in" {
  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "-1"
  cidr_blocks = [module.vpc.vpc_cidr_block]

  security_group_id = aws_security_group.public.id

}