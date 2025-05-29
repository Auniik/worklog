# worklog

A simple shell script to generate a date-wise, project-wise commit worklog for the past month — grouped by day, with support for displaying weekday names and optional holiday labels (e.g. national holidays in Bangladesh).

> Perfect for developers and teams who want a quick, human-readable summary of their Git activity across multiple repos.

---

## 📦 Features

- 🗂️ Supports multiple Git repositories in subdirectories
- ⏱️ Filters commits from the **last 1 month**
- 🧑 Shows commits by the current Git user
- ❌ Excludes merge commits
- 📅 Groups commits by **date**, adds **weekday names**
- 🎉 Optionally shows **holiday names** if `holidays.txt` is present

---

## 🛠️ Setup

1. Clone the repo or copy `worklog.sh` into your root workspace.
2. Make it executable:

```bash
chmod +x worklog.sh
```

3.	(Optional) Create a holidays.txt file in the same directory:
```txt
2025-03-26: Independence Day
2025-03-28: Shab-e-Qadr
2025-12-25: Christmas Day
```

## 🚀 Usage

```bash
./worklog.sh
```
Output will look like:
```
2025-03-26 (Wednesday, Independence Day)
 - [project1] Fix bug in reports
 - [project2] Add dark mode toggle

2025-03-27 (Thursday)
 - [project1] Update unit tests
```
## 📁 Folder Structure

```
.
├── worklog.sh
├── holidays.txt          # optional
├── project1/
├── project2/
```
## 📜 License
MIT — use it freely, improve it boldly.


