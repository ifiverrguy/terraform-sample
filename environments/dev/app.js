exports.handler = async (event) => {
    console.log("Event: ", event);
    let responseMessage = 'Hello World';

    // Check if there's a name in the event data
    if (event.name) {
        responseMessage = 'Hello ' + event.name;
    }

    const response = {
        statusCode: 200,
        body: JSON.stringify({
            message: responseMessage
        })
    };

    return response;
};
