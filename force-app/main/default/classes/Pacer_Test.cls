@IsTest
private class Pacer_Test {

    @IsTest
    static void testPacerAuth() {
        String token = PacerCallouts.authCall();
        System.Assert.isNotNull(token);
    }
    
    @IsTest
    static void testPacerFetchCase() {
        String token = PacerCallouts.authCall();
        String caseRes = PacerCallouts.fetchCase(token,'2:2011cr00642');
        System.Assert.isNotNull(caseRes);
    }
}