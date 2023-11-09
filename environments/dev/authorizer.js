exports.handler = async (event, context) => {
  const policyDocument = {
    Version: '2012-10-17',
    Statement: [{
      Action: 'execute-api:Invoke',
      Effect: 'Allow',
      Resource: '*' // You can specify '*' to allow all resources
    }]
  };

  return {
    principalId: 'user', // The principal user identification associated with the token sent by the client.
    policyDocument: policyDocument,
    context: {
      // You can pass additional key-value pairs to the context
      stringKey: 'value',
      numberKey: 123,
      booleanKey: true
    }
  };
};

