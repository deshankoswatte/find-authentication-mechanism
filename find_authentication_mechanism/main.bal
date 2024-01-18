import ballerina/http;
import ballerina/os;

service / on new http:Listener(8090) {

   resource function post findAuthenticationMechanism(@http:Payload AuthenticationMechanismRequest authenticationMechanismRequest) returns AuthenticationMechanismResponse|error {

    http:Client httpEndpoint = check new (os:getEnv("CS_TECH_PULSE_API_SERVICE_URL"));
    AuthenticationMechanismResponse authenticationMechanismResponse = check httpEndpoint->get(authenticationMechanismRequest.username);
    
    return authenticationMechanismResponse;
   }
}
