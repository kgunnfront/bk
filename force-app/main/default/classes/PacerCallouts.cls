public class PacerCallouts {

    public static String fetchCase(String token, String caseNum) {

        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:PACER_CL_QA/pcl-public-api/rest/cases/find');
        req.setMethod('POST');
        //set the header and body to include the target
        req.setHeader('Content-Type','application/json');
        req.setHeader('Accept','application/json');
        req.setHeader('X-NEXT-GEN-CSO',token);
        //now use the merge fields from the named credential to send the username and pwd
        req.setBody(' { "caseNumberFull" : "'+caseNum+'" }'); 
        //System.debug(req);

        // send it & get the response
        Http http = new Http();
        HTTPResponse res = http.send(req);
        system.debug(res.getStatus());
        system.debug(res.getBody());
        Object obj = JSON.deserializeUntyped(res.getBody());
        String caseResp = JSON.serializePretty(obj);
        system.debug('/n here is pretty /n'+caseResp);
        return caseResp;

    }


    public static String authCall() {
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
            return token;
        }
    }

    public static String logoutCall() {
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