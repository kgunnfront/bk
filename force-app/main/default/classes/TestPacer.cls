@IsTest
public with sharing class TestPacer {
    public TestPacer() {
        @IsTest
        static void testPacerAuth() {
            String res = PacerAuth.PacerAuth();
            System.debug('auth res is '+res);
            System.Assert.isNotNull(res);
        }
    }
}