import boto3

# Set your AWS region and Cognito User Pool ID
region = 'YOUR_AWS_REGION'
user_pool_id = 'YOUR_USER_POOL_ID'

# Set the username and password for the user you want to authenticate
username = 'YOUR_USERNAME'
password = 'YOUR_PASSWORD'

# Create a Cognito identity provider client
client = boto3.client('cognito-idp', region_name=region)

try:
    # Authenticate with the Cognito User Pool
    response = client.initiate_auth(
        ClientId='YOUR_APP_CLIENT_ID',
        AuthFlow='USER_PASSWORD_AUTH',
        AuthParameters={
            'USERNAME': username,
            'PASSWORD': password
        }
    )

    # If the authentication is successful, the response will contain an "AuthenticationResult"
    authentication_result = response['AuthenticationResult']
    access_token = authentication_result['AccessToken']
    id_token = authentication_result['IdToken']

    print("Authentication successful!")
    print("Access Token:", access_token)
    print("ID Token:", id_token)

except client.exceptions.NotAuthorizedException as e:
    print("Authentication failed. Incorrect username or password.")
except client.exceptions.UserNotConfirmedException as e:
    print("Authentication failed. User not confirmed.")
except Exception as e:
    print("An error occurred:", str(e))
