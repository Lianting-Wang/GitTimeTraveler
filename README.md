# GitTimeTraveler
A versatile script that allows you to travel through time... in your Git repository! GitTimeTraveler enables you to easily modify the timestamp of your last commit, either by setting an absolute date/time or by specifying a relative change. Journey through the timeline of your project with ease.

## Usage

You can use GitTimeTraveler in two ways: passing arguments directly when running the script or interactively entering your options after running the script without arguments.

### Arguments passing

```bash
./GitTimeTraveler.sh [-h hour] [-m minute] [-s second] [-d day] [-M month] [-y year] [-a full_date]
```

The flags can be used as follows:

* `-h hour` : To change the hour of the timestamp.
* `-m minute` : To change the minute of the timestamp.
* `-s second` : To change the second of the timestamp.
* `-d day` : To change the day of the timestamp.
* `-M month` : To change the month of the timestamp.
* `-y year` : To change the year of the timestamp.
* `-a full_date` : To set a complete timestamp.

Both absolute values and relative changes (+/-) can be provided.

Examples
* To modify hour and minute:
    ```bash
    ./GitTimeTraveler.sh -h 19 -m 59
    ```
* To modify hour and minute relatively:
    ```bash
    ./GitTimeTraveler.sh -h -1 -m +3
    ```
* To modify month and day:
    ```bash
    ./GitTimeTraveler.sh -M 07 -d 11
    ```
* To specify a full date:
    ```bash
    ./GitTimeTraveler.sh -a "2023-07-11 19:29:03"
    ```

### Without Arguments

Alternatively, run the script without any arguments and you'll be prompted to enter your options based on the usage guide:

```bash
./GitTimeTraveler.sh
```

After running with the desired options, the script will ask for confirmation before changing the timestamp of the last commit.

## Requirements
* bash
* git
* date utility (usually pre-installed in Unix-based systems)

## Contribution
Feel free to fork the project, open issues, and submit PRs. For major changes, please open an issue first.
