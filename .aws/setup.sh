# Just source this to set the ENV vars.

# https://github.com/michaelcontento/awsenv and my fork
if [ -d ~/.awsenv/bin ]; then
    export PATH=$PATH:$HOME/.awsenv/bin
    eval "$(awsenv init -)"
fi

# pip install awscli -- http://aws.amazon.com/cli/
if [ -f ~/.aws/awscli.ini ]; then
    export AWS_CONFIG_FILE="$HOME/.aws/awscli.ini"
fi

if [[ "$(uname -s)" = "Darwin" ]]; then
    export EC2_HOME="/usr/local/Library/LinkedKegs/ec2-api-tools/jars"
    export AWS_IAM_HOME="/usr/local/Cellar/aws-iam-tools/HEAD/jars"
    export AWS_CLOUDWATCH_HOME="/usr/local/Library/LinkedKegs/cloud-watch/jars"
    export AWS_AUTO_SCALING_HOME="/usr/local/Library/LinkedKegs/auto-scaling/jars"
    export AWS_CLOUDFORMATION_HOME="/usr/local/Library/LinkedKegs/aws-cfn-tools/jars"
fi

export SERVICE_HOME="$AWS_CLOUDWATCH_HOME"
