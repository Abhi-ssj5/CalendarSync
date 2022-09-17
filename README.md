# CalendarSync


# TODO:
Calendar Sync ToDo List

- Fetch existing Reminders and Calendar Events from Google Calendar
    - Add compression to fetch requests to reduce data size [Phase 2]
    - Optimise response to partial response [Phase 2]
    - Add options for users regarding what type of calendar events to sync. I.e [Phase 2]
        - Holidays
        - Reminders
        - Meetings/Events
    - Handle reoccurring events if fetched [need to check what kind of data does that has] [Phase 3]
- Add logic to Compare the diff in events
    - Create missing events in Apple Calendar
    - Update modified events in Apple Calendar [Phase 2]
- Handle Syncing from multiple google accounts [Phase 2]
- Add Test Cases
    - Unit
    - Integration

