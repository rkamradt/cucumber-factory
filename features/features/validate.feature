Feature: A user must verify the email address they entered when signing up.

   Background:
       Given That I receive a verification email
       
   Scenario: I didnt actually try to sign up, or wish to reverse or re-do that action
       When I click on the dont verify link
       Then the account should be deleted
       And I should be navigated to a splash screen saying the account was deleted

   Scenario: I want to verify my email
       When I click the verify link
       Then an email should be sent to the supervisor or company indicating I should be confirmed
       And the account should be verified
       And I should be navigated to a splash screen saying the account is awaiting confirmation
              
