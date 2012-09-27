Feature: User receives more reminders as he reports being less aware
  As a user
  In order to improve my level of awareness over time
  I want my reminders to happen more often as I report being less aware

  Scenario: User receives reminders more often when he reports that he is not aware
    Given I am a Presence user
    And I have set a starting interval of 30 minutes
    Then the first reminder should occur in 30 minutes
    When I report being unaware
    Then the next reminder should occur in 25 minutes
    When I report being unaware again
    Then the next reminder should occur in 20 minutes
