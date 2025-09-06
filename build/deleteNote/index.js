const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { DynamoDBDocumentClient, DeleteCommand } = require("@aws-sdk/lib-dynamodb");

const client = new DynamoDBClient();
const docClient = DynamoDBDocumentClient.from(client);

exports.handler = async (event) => {
    const body = JSON.parse(event.body || "{}");
    const noteId = body.noteId;

    if (!noteId) {
        return { statusCode: 400, body: JSON.stringify({ error: "noteId is required" }) };
    }

    try {
        await docClient.send(new DeleteCommand({
            TableName: process.env.DYNAMODB_TABLE,
            Key: { noteId }
        }));

        return {
            statusCode: 200,
            headers: {
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Headers": "Content-Type",
                "Access-Control-Allow-Methods": "OPTIONS,POST,GET,PUT,DELETE"
            },
            body: JSON.stringify({ message: "Note deleted", noteId })
        };
    } catch (err) {
        return {
            statusCode: 500,
            headers: { "Access-Control-Allow-Origin": "*" },
            body: JSON.stringify({ error: err.message })
        };
    }
};