# Check if a VPC exists in AWS

title "VPC Section"

aws_vpc_id = input('aws_vpc_id')
aws_public_subnets = input('aws_public_subnets')
aws_igw_id = input('aws_igw_id')
aws_route_table_id = input('aws_route_table_id')


control 'check-aws-vpc' do
  impact 1.0
  title 'Check if VPC exists in AWS'

  describe aws_vpc(vpc_id: aws_vpc_id) do
    it { should exist }
  end
end

control 'check-public-subnets' do
  impact 1.0
  title 'Check if public subnets are connected to VPC'

  aws_public_subnets.each do |subnet_id|
    describe aws_subnet(subnet_id: subnet_id) do
      it { should exist }
      its('vpc_id') { should eq aws_vpc_id }
    end
  end
end

control 'check-route-table' do
  impact 1.0
  title 'Check if route table is connected to subnets'

  describe aws_route_table(aws_route_table_id) do
    it { should exist }
    its('vpc_id') { should eq aws_vpc_id }
  end

  aws_subnets.each do |subnet_id|
    describe aws_subnet(subnet_id: subnet_id) do
      its('route_table_ids') { should include aws_route_table_id }
    end
  end
end

control 'check-internet-gateway' do
  impact 1.0
  title 'Check if Internet Gateway is connected to VPC'

  describe aws_internet_gateway(id: aws_igw_id) do
    it { should exist }
    its('vpc_id') { should eq aws_vpc_id }
  end
end
