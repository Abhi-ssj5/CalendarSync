# CalendarSync


# TODO:
Calendar Sync ToDo List

- UI create (Dummy Done)
    - Created 2 buttons 
        - One to trigger Permission check (will be removed later) (Done - Ankush)
        - One to trigger Google oAuth from User (Done - Abhijeet)
            - Check google auth permissions before triggering
- Fetch existing Reminders and Calendar Events from Google Calendar (Abhijeet)
    - Add compression to fetch requests to reduce data size [Phase 2]
    - Optimise response to partial response [Phase 2]
    - Add options for users regarding what type of calendar events to sync. I.e [Phase 2]
        - Holidays
        - Reminders
        - Meetings/Events
    - Handle reoccurring events if fetched [need to check what kind of data does that has] [Phase 3]
- Fetch existing Reminders and Calendar Events from Apple calendar (Ankush)
    - Check authentication for cloudSync within apple device [Phase 2]
        - Can be used for keeping log of sync time and creation time
- Add logic to Compare the diff in events
    - Create missing events in Apple Calendar
    - Update modified events in Apple Calendar [Phase 2]
- Handle Syncing from multiple google accounts [Phase 2]
- Add Test Cases
    - Unit
    - Integration

