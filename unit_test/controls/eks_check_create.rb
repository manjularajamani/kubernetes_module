title 'EKS Section'

aws_eks_cluster_name = input('aws_eks_cluster_name')
aws_vpc_id = input('aws_vpc_id')
cluster_role_arn = input('cluster_role_arn')
security_group_id = input('security_group_id')
cluster_endpoint = input('eks_cluster_endpoint')

control 'eks-cluster' do
  title 'Verify Cluster'
  impact 0.7

  describe aws_eks_cluster(cluster_name: aws_eks_cluster_name) do
    it { should exist }
    its('status') { should eq 'ACTIVE' }
    its('vpc_id') { should eq aws_vpc_id }
    its('subnets_count') { should be > 1 }
    its('role_arn') { should cmp cluster_role_arn  }
    its('security_group_ids') { should include security_group_id }
    its('endpoint') {should eq cluster_endpoint }
  end
end

