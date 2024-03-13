public class PacerCallouts {

    public static String PacerCaseFetch(String token) {

    }


    public static String makeAuthCall() {
        //use the external named credetial setup in Salesforce as the endpoint
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:PACERAUTH_QA/services/cso-auth');
        req.setMethod('POST');
        //set the header and body to include the target
        req.setHeader('Content-Type','application/json');
        req.setHeader('Accept','application/json');
        //now use the merge fields from the named credential to send the username and pwd
        req.setBody(' { "loginId" : "{!$Credential.Username}", "password" : "{!$Credential.Password}"} ');
        //System.debug(req);

        // send it & get the response
        Http http = new Http();
        HTTPResponse res = http.send(req);
        //system.debug(res.getBody());
         
        if(res.getStatusCode()!=200)
        {
            //bail if there's an error
            CalloutException e = new CalloutException();
            e.setMessage('Failed auth call, reason: '+res.getStatus());
            throw e;
        }else{
            //extract the token from the response
            Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
            String token = (String)m.get('nextGenCSO');
        }
    }

    public static String makeLogoutCall() {
            //use the external named credetial setup in Salesforce as the endpoint
            HttpRequest req = new HttpRequest();
            req.setEndpoint('callout:PACER_QA/services/cso-logout');
            req.setMethod('POST');
            //set the header and body to include the target
            req.setHeader('Content-Type','application/json');
            req.setHeader('Accept','application/json');
            //now use the merge fields from the named credential to send the username and pwd
            req.setBody(' { "loginId" : "{!$Credential.Username}", "password" : "{!$Credential.Password}"} ');
            //System.debug(req);
    
            // send it & get the response
            Http http = new Http();
            HTTPResponse res = http.send(req);
            system.debug(res.getBody());
    }
}