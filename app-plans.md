# Mobile App MVP

I am building a mobile application for iOS and android with Flutter. It is called Picks Leagues. The app is for friends who want to compete with each other to see who is the best at making NFL picks against the spread or straight up. The app will have several screens that I will describe below. Lets start building screens 1 at a time, where you build the screen, I provide feedback, and then we move onto the next screen. For styling, the primary color of the app should be green (has a betting/financial connotation, and support light and dark theme. I want to use NativeWind with reacrt native reusables for styling. The backend will be a node js, fastify, drizzle orm and sqllite database. For now though, just mock out API endpoints and responses.

Lets get started. Below are all the screens, lets start with the Sign in Screen.

- Users sign in using Google or Discord
  - If signing in for the first time, users enter
    - a unique username (8-20 characters)
    - profile pic URL (optional)
    - first name
    - last name.
  - Once info is entered, the user can press a button to go to the user home page.
  - These settings can be edited on a users profile screen at anytime.
- Users must authenticate to use any part of the app
- On every screen except the sign in screen, there is a top bar that includes the users profile avatar (or their first initial if no avatar exists). When clicked a drawer opens where the user can
  - switch between dark mode and light mode
  - navigate to the profile screen,
  - sign out
  - see a list of their leagues (league name, sport league, pick type) that when pressed the user is navigated to the home page for the league
- On the user home page, users can navigate to the the create league screen, join league screen, see any picks league invites that they have open and accept/reject them, and view the leagues they are in. Pressing on a league navigates to the league home screen.
- On the create picks league screen, a user can create a picks league and specify the following
  - league name: max chars 32
  - profile image URL: optional
  - sports league (only NFL to start)
  - sports league season: would be the current NFL season (if one is active) and the next/upcoming NFL season
  - start week (week 1, 2, wild card, super bowl, etc.)
  - end week
  - pick type: against the spread or straight up
  - picks per week: 1-16
  - league visibility: private (invite only), public (anyone can join)
  - league size: 1-20 (number of members in league)
  - Once a league is created, the user is navigated to the league home screen
  - When created, the user has a commissioner role for the league
- On the join picks league screen, users can filter picks leagues by
  - name
  - sport league
  - sport league season, only available if sport league is selected
  - start week, only available if sport league season is selected
  - end week, only available if sport league season is selected
  - pick type
  - picks per week
  - league size
  - only leagues that are not current in the middle of a season and that have capacity are visible
  - The leagues that are visible based on the filter are paginated and can be scrolled through. Each league has a card where pressing join has the user join the league and navigates the user to the league home page. When joining, a user has a member role for the league
- League Screens
  - All league screens have a tab bar at the top (below the app bar) where they can navigate between the league home screens, standings screen, my picks screen, league picks screen, and league settings screen
  - League Home
    - league members can see all other league members (names, usernames, profile picture, league role (commissioner, member)
    - commissioners can also edit member roles, remove members (if not in season), and invite new league members (if not in season and if capacity is available)
      - Commissioners can invite users with app deep links and also search for existing users by name or username to invite within the app. Invites expire when the next season starts.
      - Open invites can be viewed by commissioners, and can be revoked
  - League Standings
    - league members view league standings (rank, points (1 for wins, .5 for pushes), wins, losses, and pushes
    - standings can be sorted by any of the above criteria
    - if in season, standings are for current season
    - if out of season and there was a previous season, standings are for that season
    - if out of season and no previous season, standings are for the upcoming season
  - My picks
    - if in season, no picks were made for the current week, and before pick lock time (when users must make their picks by), user can pick games for the week based on league, picks per week, and pick type
      - if pick type is against the spread, odds are displayed for the games that can be picked and sports book that provides the odds is created
      - game display includes away team abbreviation and logo, home team abbreviation and logo, and game start time
    - If in season and no picks were made for the current week and it is after pick lock time, there are no picks to view or make
    - If in season and user made picks for the week, they can see the picks they made for the week.
      - game pick display includes away team abbreviation and logo, home team abbreviation and logo, and game start time/game period time and period/final, scores for teams, and an indication of if a pick has been made, was correct, push, or loss for the user
    - If in season, user can navigate to their picks for previous weeks in the season
    - If out of season and there was a previous season, the user can view and navigate between their picks for the previous season, starting with the last week of the previous season
    - if out of season and there was no previous season, there are no picks to view
  - League picks
    - if in season and before pick lock time for the week, league picks cannot be viewed for the week
    - if in season and after pick lock time for the week, user can view picks made by other league members for the week. This will be a small expandable card. The minified version of the card just includes a user’s username, name, profile pic, rank during the current week, rank in the overall season standings, points earned so far, and points available to be gained
      - when expanded, the user’s picks for the week are displays in game pick display that is identical to that for the my picks tab
    - If in season, user can navigate to league picks for previous weeks in the season
    - If out of season and there was a previous season, the user can view league picks for the weeks of the previous season, starting with the last week in that season
    - If out of season and there is no previous season, there are no picks to view
  - League Settings
    - For league commissioners
      - if in season, the user can only edit league name and profile image url
      - if not in season, the user can also change
        - start week (week 1, 2, wild card, super bowl, etc.) (would be for the upcoming season)
        - end week
        - pick type: against the spread or straight up
        - picks per week: 1-16
        - league visibility: private (invite only), public (anyone can join)
        - league size: 1-20 (number of members in league), cannot shrink size below current number of members
      - If not in season and there is no next season, user is prompted to start the next season
        - this is where commissioner would set
          - start week (week 1, 2, wild card, super bowl, etc.) (would be for the upcoming season)
          - end week
          - pick type: against the spread or straight up
          - picks per week: 1-16
          - league visibility: private (invite only), public (anyone can join)
          - league size: 1-20 (number of members in league), cannot shrink size below current number of members
    - For league members
      - can view league settings, but not edit

# UI Layout

Given how simple the MVP is in terms of features, there actually doesn’t need to be any tabs.

## Top Bar

- Profile
  - when clicked, drawer opens with link to profile page, link to sign out, and color theme switcher

## Pages

### Login

- Sign in with Google/Discord

### Account Setup

- Set username, profile pic url, first name, last name, time zone

### Profile

- Edit username, profile pic url, first name, last name, time zone

### Home

- See picks leagues that you are in.
- See any picks leagues invites
- link to create leagues and join leagues

### Create Leagues

- Create league with the following
  - Name
  - Logo url
  - sport league
  - sport league season
  - start week
  - end week
  - pick type
  - picks per week
  - league visibility (public/private)
  - league members capacity

### Join Leagues

- Join picks leagues
- Can filter by
  - sport league
  - sport league season
  - start week
  - end week
  - pick type
  - picks per week
  - league member capacity

### League

Comprised of tabs (at top screen, part top app bar, for a league

**League Members**

- View League Members and their roles (commissioner or member)
- If commissioner, change roles, add/remove people from league
- If available spots, send invites (copy link, or in app invite by searching for user)

**League Standings**

- View league standings for current season if applicable, otherwise past season

**My Picks**

- If in season and before pick lock, make picks based on available games and league pick type
- If in season and after pick lock time, view picks for the week
- Can toggle through current week and past weeks
- If out of season and previous season, can view last season’s last week picks and toggle through other weeks

**League Picks**

- If in season and before pick lock, indicate picks are locked and can’t be viewed yet
- If in season and after pick lock time, view picks for the week for all users
- Can toggle through current week and past weeks
- If out of season and previous season, can view last season’s last week picks and toggle through other weeks

**League Settings**

- If commissioner, can edit settings
  - if in season, only edit league name and logo url
  - if out of season can edit all league settings except for sports league
- If member, just view settings
