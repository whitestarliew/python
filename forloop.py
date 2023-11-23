import subprocess
import boto3

def lambda_handler(event, context):
    # Replace these with your own values
    docker_hub_repo = "docker.com/your-docker-repo"  # Replace with your Docker Hub repository
    ecr_repo_uri = "123456789012.dkr.ecr.us-west-2.amazonaws.com/your-ecr-repo"  # Replace with your ECR repository URI

    try:
        # AWS ECR login
        ecr_client = boto3.client('ecr')
        ecr_login_info = ecr_client.get_authorization_token()
        ecr_token = ecr_login_info['authorizationData'][0]['authorizationToken']
        subprocess.run(["docker", "login", "-u", "AWS", "-p", ecr_token, ecr_login_info['proxyEndpoint']])

        # Pull image from Docker Hub
        subprocess.run(["docker", "pull", docker_hub_repo])

        # Tag the Docker image for ECR
        subprocess.run(["docker", "tag", docker_hub_repo, ecr_repo_uri])

        # AWS ECR login (sometimes required after tagging)
        subprocess.run(["docker", "login", "-u", "AWS", "-p", ecr_token, ecr_login_info['proxyEndpoint']])

        # Push the image to AWS ECR
        subprocess.run(["docker", "push", ecr_repo_uri])

        return {
            'statusCode': 200,
            'body': 'Image successfully pulled from Docker Hub and pushed to AWS ECR.'
        }

    except subprocess.CalledProcessError as e:
        # Handle subprocess errors
        error_message = f"Error running subprocess command: {e.returncode}, {e.output.decode('utf-8')}"
        return {
            'statusCode': 500,
            'body': error_message
        }

    except Exception as e:
        # Handle other exceptions
        return {
            'statusCode': 500,
            'body': f'Error: {str(e)}'
        }
