Feature: User Registration

  User registers with a simple form, which consists of required fields and a button. After registration user is logged in and application is ready to be used.

   Scenario: User registers successfully via a rerister form.
     Given I am a guest
     When I fill a register form with a valid data
     Then I should be registered in application
     And I should be logged in
