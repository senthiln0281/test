import boto3
import os
dynamodb = boto3.resource('dynamodb')
fleet = [
    {
        Name: 'Bucephalus',
        Color: 'Golden',
        Gender: 'Male',
    },
    {
        Name: 'Shadowfax',
        Color: 'White',
        Gender: 'Male',
    },
    {
        Name: 'Rocinante',
        Color: 'Yellow',
        Gender: 'Female',
    },
];
def requestunicorn.handler(event, context):
    if (!event.requestContext.authorizer) {
      errorResponse('Authorization not configured', context.awsRequestId, callback);
      
    }
    
    rideId = toUrlString(os.urandom(16))
    console.log('Received event (', rideId, '): ', event)
    username = event.requestContext.authorizer.claims['cognito:username']
    requestBody = JSON.parse(event.body)
    pickupLocation = requestBody.PickupLocation
    unicorn = findUnicorn(pickupLocation)

