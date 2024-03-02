resource "aws_vpc_peering_connection" "vpc_peering_jenkins" {
  peer_owner_id = var.peer_owner_id
  peer_vpc_id   = var.peer_vpc_id_created
  vpc_id        = var.vpc_id_jenkins
  auto_accept   = true

accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

resource "aws_route" "peer_route" {
  count           = length(var.route_table_ids_from_vpc_peering)
  route_table_id  = var.route_table_ids_from_vpc_peering[count.index]
  destination_cidr_block = var.vpc_id_jenkins_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering_jenkins.id
}
