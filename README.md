# Midterm Reviewer - HAUDEX

This is a **reviewer**: a practice run for the midterm practical, in the same
shape but with a different roster. You are given a mostly-working **HAUDEX** app -
a Flutter mobile app with a home screen (a stats card over a list of monsters)
and a detail screen - that has five **bugs** and two **TODOs**. Fix them so every
panel and screen shows the correct value. The moves are exactly the ones the real
exam asks for; the monsters and numbers are different on purpose, so practise the
fixing, not the answers.

This reviewer is **not the exam and is not closed-book.** Use your notes, the
Module 4 and 5 pages, and take your time. It is just practice, so there is nothing
to submit and no grade attached - fixing it is the whole point.

## Setup and run

```bash
flutter pub get
flutter run            # pick an emulator, a device, or Chrome
```

In a Codespace (no browser inside the container):

```bash
flutter run -d web-server --web-port=8080 --web-hostname=0.0.0.0
```

Codespaces forwards port 8080 - open it from the pop-up or the **Ports** tab.
Prefer the terminal? `dart run tool/report.dart` prints the stats-card values.

## What to fix

Five bugs, marked in the code with `BUG A` ... `BUG E`, plus two `TODO`s:

- **lib/stats.dart (the numbers):**
  - BUG A - "most common type" is showing the least common one.
  - BUG B - "high HP" should count HP **greater than** the threshold.
  - BUG C - "top region" is grouping by the wrong field, so it shows an element.
  - **TODO 2** - `strongest()` always returns the first monster; make it return
    the highest-HP one.
- **lib/home_screen.dart (the list):**
  - BUG D - choosing a type in the filter does not update the list or the count.
  - BUG E - every row in the list shows the same monster.
  - **TODO 1** - tapping a tile does nothing; open the detail screen for that
    monster, and finish the detail screen so it shows Type, Element and Attack.

## The ten practice questions

Once the app is fixed, read these off the app (or the Actions run summary):

1. Total monsters.
2. Most common type.
3. High HP - how many have HP more than 70.
4. Top region.
5. Filter to "ghoul" - the "Showing N of 200" count.
6. Before you fix the list, what one name does every row show?
7. Open monster id 42 - its type.
8. Open monster id 42 - its attack.
9. Open monster id 42 - its element.
10. The "Strongest" panel - the name it shows.

## No Flutter on your machine? Fix it in the browser

You do not have to run anything locally. Edit the files right on github.com (open
a file, click the pencil, commit), and every push runs your app for you on
GitHub. Open the run under the **Actions** tab and its **summary** lists your
current answers to the ten practice questions and saves a screenshot of your app.
The green check is **not a grade** - it just tells you how far you have got.

## The data

A generated roster of 200 monsters (`lib/data.dart`) - do not edit it. Good luck.
