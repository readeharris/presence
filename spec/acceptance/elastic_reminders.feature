Feature: Elastic Reminder Interval
  As a user
  In order to remove unnecessary interruptions as I improve my awareness
  I want my reminders to happen less often as I report being more aware

  Scenario: User receives reminders less often when he reports that he is aware
    Given I am a Presence user
    And I have set a starting interval of 10 minutes
    Then the first reminder should occur in 10 minutes
    When I confirm the most recent reminder
    Then the next reminder should occur in 15 minutes
    When I confirm the most recent reminder
    Then the next reminder should occur in 20 minutes
