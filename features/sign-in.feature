Feature: In order to access the manufacturing system as a user I must sign in to identify myself.  I must provide the email address that I signed up with, and a password.  I must be validated and confirmed first before I will be allowed into the system, and my email address and password must match. Email and password may be hashed together to provide quick lookup and hidden password.


   Background:
       Given That I try to sign in by navigating to the sign-in screen
       And I enter my email and password
       
   Scenario: Sign in with an unverified account
       When I submit the information
       And my email and password match
       But my account is unverifieded
       Then return that I am not yet verified and to check my email 
       And be navigated to the please have patience screen

   Scenario: Sign in with an unconfirmed account
       When I submit the information
       And my email and password match
       But my account is unconfirmed
       Then return that I am not yet confirmed and to check with my organization or supervisor 
       And be navigated to the please have patience screen

   Scenario: Sign in with a confirmed account
       When I submit the information
       And my email and password match
       And my account is confirmed
       Then return a key to the vendor, buyer, or internal user system
       And be navigated to the role-home screen

   Scenario: Sign in without an account
       When I submit the information
       But my email and password dont match
       Then return that my email and password dont match any in the system
       And be navigated back to the sign in screen

