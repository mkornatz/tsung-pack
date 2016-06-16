aws_access_key=""
aws_secret_key=""

# Used to identify the resources in the AWS account. This is arbitrary and used for tags only.
app_name="tsung"

# This keypair is used to login to the instances. You need to set this up on your own using the AWS console or CLI tools.
ssh_keypair_name="my-keypair-name"

# Keep in mind that networking performance is important with large amounts of data
# It's been recommended to use large instance types with moderate to high network
# performance. tsung is compute heavy. So, the "c" series is the best bet.
instance_type="c4.large"

# Number of instances to spin up. A duo or trio can do a lot of damage.
instance_count=2
