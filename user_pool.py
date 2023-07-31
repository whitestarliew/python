import boto3

# Set your AWS SSO region
sso_region = 'eu-west-2'

# Set the AWS SSO start URL and AWS CLI named profile
sso_start_url = 'YOUR_SSO_START_URL'
profile_name = 'YOUR_PROFILE_NAME'

# Create an SSO client
sso_client = boto3.client('sso', region_name=sso_region)

try:
    # Get the SSO user access token
    response = sso_client.get_role_credentials(
        roleName='YOUR_ROLE_NAME',
        account='your-aws-account-id',
        accessToken='YOUR_SSO_ACCESS_TOKEN',
    )

    # The response contains temporary AWS credentials
    access_key = response['roleCredentials']['accessKeyId']
    secret_key = response['roleCredentials']['secretAccessKey']
    session_token = response['roleCredentials']['sessionToken']

    print("Authentication successful!")
    print("Access Key:", access_key)
    print("Secret Key:", secret_key)
    print("Session Token:", session_token)

except Exception as e:
    print("An error occurred:", str(e))
