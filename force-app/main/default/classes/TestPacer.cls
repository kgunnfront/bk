@IsTest
public with sharing class TestPacer {
    public testPacerAuth() {
        @IsTest
        static void testPacerAuth() {
            String token = PacerCallouts.authCall();
            System.debug('auth res is '+res);
            System.Assert.isNotNull(res);
        }
    }

    public testPacerAuth() {
        @IsTest
        static void testPacerFetchCase() {
            String token = PacerCallouts.authCall();
            String caseRes = PacerCallouts.fetchCase(token,'2:2011cr00642');
            System.debug('auth res is '+res);
            System.Assert.isNotNull(res);
        }
    }

}