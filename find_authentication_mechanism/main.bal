import ballerina/http;
import ballerina/lang.value;
import ballerina/os;

service / on new http:Listener(8090) {

   resource function post findAuthenticationMechanism(http:Caller caller, http:Request request) returns error? {
    
    string jsonString = check request.getTextPayload();
    json jsonObj = check value:fromJsonString(jsonString);
    string username = <string> check jsonObj.username;

    http:Client httpEndpoint = check new (os:getEnv("CS_TECH_PULSE_API_SERVICE_URL"));
    http:Response getResponse = check httpEndpoint->get(username);

    var jsonPayload = check getResponse.getJsonPayload();
    string name = <string> check jsonPayload.name;
    string authenticationMechanism = <string> check jsonPayload.authentication;

    http:Response response = new;
    response.statusCode = http:STATUS_OK;
    response.setJsonPayload  ({"name" : name, "authentication" : authenticationMechanism});
    
    check caller->respond(response);
   }
}