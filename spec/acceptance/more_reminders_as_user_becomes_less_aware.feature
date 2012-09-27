Feature: User receives more reminders as he reports being less aware
  As a user
  In order to improve my level of awareness over time
  I want my reminders to happen more often as I report being less aware

  Background:
    Given I am a Presence user

  Scenario: User receives reminders more often when he reports that he is not aware
    Given I have set a starting interval of 30 minutes
    Then the first reminder should occur in 30 minutes
    When I report being unaware
    Then the next reminder should occur in 25 minutes
    When I report being unaware again
    Then the next reminder should occur in 20 minutes

  Scenario: User cannot receive reminders more often than every 5 minutes
    Given I have set a starting interval of 10 minutes
    Then the first reminder should occur in 10 minutes
    When I report being unaware
    Then the next reminder should occur in 5 minutes
    When I report being unaware again
    Then the next reminder should still occur in 5 minutes
