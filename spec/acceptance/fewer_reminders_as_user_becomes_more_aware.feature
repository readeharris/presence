Feature: User receives fewer reminders as he reports being more aware
  As a user
  In order to remove unnecessary interruptions as my awareness improves
  I want my reminders to happen less often as I report being more aware

  Scenario: User receives reminders less often when he reports that he is aware
    Given I am a Presence user
    And I have set a starting interval of 10 minutes
    Then the first reminder should occur in 10 minutes
    When I report being aware
    Then the next reminder should occur in 15 minutes
    When I report being aware again
    Then the next reminder should occur in 20 minutes
