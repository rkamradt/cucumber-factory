Feature: A supervisor, or company's designated confirmation person must confirm that a new user represents the company in the role they specified.


   Background:
       Given That I receive a confirmation email
       
   Scenario: email concerns an unknown user
       When I click on the unknown user link
       Then an email should be sent to user indicating they are not confirmed because they are not known
       And the account should be deleted
       And I should be navigated to a splash screen saying the account was deleted

   Scenario: email concerns a user but the role is incorrect
       When I click the incorrect role link
       Then an email should be sent to user indicating they are not confirmed because their role is incorrect and they should consult their supervisor and sign up again
       And the account should be deleted
       And I should be navigated to a splash screen saying the account was deleted
              
   Scenario: email concerns a user with the correct role listed
       When I click the confirm link in the email
       And the account has not been previously deleted
       Then an email should be sent to the user indicating they are confirmed and can sign in to the system
       And the account should be set to confirmed
       And I should be navigated to a splash screen saying the user was confirmed

   Scenario: email concerns a user with the correct role listed but the account has been culled
       When I click the confirm link in the email
       And the account has been previously deleted
       Then an email should be sent to the user indicating should they sign up again if they havent already.
       And I should be navigated to a splash screen saying the user was not confirmed in time
