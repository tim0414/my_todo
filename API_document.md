# API Document

## POST <host>/users/auth/facebook

## POST <host>/users

- input
  - payload
  ```json
    {
      "user":{
        "email": <string>,
        "password": <string>,
        "password_confirmation": <string>
      }
    }
  ```

-output
  - header
    ```json
      Set-Cookie: <cookie>
    ```

## GET <host>/tasks

- input
  - header
    ```json
      Content-Type: application/json
      Cookie: <cookie>
    ```

- output
  ```json
    [
      {
        "uid": <string>,
        "name": <string>,
        "status": <string>, // incompletion, partial_completion, delay, completion, delayed_completion
        "due_date": <string> // date format example: 2018-12-10T13:49:51.141Z
      },
      ......
    ]
  ```

## POST <host>/tasks

- input
  - header
    ```json
      Content-Type: application/json
      Cookie: <cookie>
    ```
  - payload
    ```json
      {
        "name": <string>,
        "note": <string>,
        "due_date": <string> // date format example: 2018-12-10T13:49:51.141Z
      }
    ```

- output
  ```json
  {
    "uid": <string>,
    "name": <string>,
    "status": <string>, // incompletion, partial_completion, delay, completion, delayed_completion
    "due_date": <string> // date format example: 2018-12-10T13:49:51.141Z
  }
  ```

## DELETE <host>/tasks/<task_uid>

- input
  - header
    ```json
      Content-Type: application/json
      Cookie: <cookie>
    ```

- output
  ```json
  {
    "uid": <string>,
    "name": <string>,
    "status": <string>, // incompletion, partial_completion, delay, completion, delayed_completion
    "due_date": <string> // date format example: 2018-12-10T13:49:51.141Z
  }
  ```

## PUT <host>/tasks/<tasks_uid>/status

- input
  - header
    ```json
      Content-Type: application/json
      Cookie: <cookie>
    ```
  - payload
    ```json
      {
        "update_value": <string> // partial_completion, completion
      }
    ```

- output
  ```json
  {
    "uid": <string>,
    "name": <string>,
    "status": <string>, // incompletion, partial_completion, delay, completion, delayed_completion
    "due_date": <string> // date format example: 2018-12-10T13:49:51.141Z
  }
  ```

## PUT <host>/tasks/<tasks_uid>/due_date
- 當 task 的狀態為 delay 或是 delayed_completion 時，前端不應該要讓使用者改 due_date

- input
  - header
    ```json
      Content-Type: application/json
      Cookie: <cookie>
    ```
  - payload
    ```json
      {
        "update_value": <string> // date format example: 2018-12-10T13:49:51.141Z
      }
    ```

- output
  ```json
  {
    "uid": <string>,
    "name": <string>,
    "status": <string>, // incompletion, partial_completion, delay, completion, delayed_completion
    "due_date": <string> // date format example: 2018-12-10T13:49:51.141Z
  }
  ```

## PUT <host>/tasks/<tasks_uid>/name

- input
  - header
    ```json
      Content-Type: application/json
      Cookie: <cookie>
    ```
  - payload
    ```json
      {
        "update_value": <string>
      }
    ```

- output
  ```json
  {
    "uid": <string>,
    "name": <string>,
    "status": <string>, // incompletion, partial_completion, delay, completion, delayed_completion
    "due_date": <string> // date format example: 2018-12-10T13:49:51.141Z
  }
  ```

## PUT <host>/tasks/<tasks_uid>/note

- input
  - header
    ```json
      Content-Type: application/json
      Cookie: <cookie>
    ```
  - payload
    ```json
      {
        "update_value": <string>
      }
    ```

- output
  ```json
  {
    "uid": <string>,
    "name": <string>,
    "status": <string>, // incompletion, partial_completion, delay, completion, delayed_completion
    "due_date": <string> // date format example: 2018-12-10T13:49:51.141Z
  }
  ```


## GET <host>/routine_task_infos

- input
  - header
    ```json
      Content-Type: application/json
      Cookie: <cookie>
    ```

- output
  ```json
    [
      {
        "uid": <string>,
        "name": <string>,
        "note": <string>,
        "period": <string>, // year, month, weekday, day
        "routine_time": <integer>
        // 根據不同的 period 有不同的起始時間，例如 year 的起始時間是每年 1/1 00:00，從起始時間開始到欲重複時間所經過的秒數。假設此重複性事項是每年的 1/1 3:00，則此欄位的值為 10800
      },
      ......
    ]
  ```

## PUT <host>/routine_task_infos/<routine_task_info_uid>/period

- input
  - header
    ```json
      Content-Type: application/json
      Cookie: <cookie>
    ```
  - payload
    ```json
      {
        "period": <string>, // year, month, weekday, day
        "routine_time": integer
      }
    ```

- output
  ```json
    {
      "uid": <string>,
      "name": <string>,
      "note": <string>,
      "period": <string>, // year, month, weekday, day
      "routine_time": <integer>
    }
  ```

## PUT <host>/routine_task_infos/<routine_task_info_uid>/routine_time

- input
  - header
    ```json
      Content-Type: application/json
      Cookie: <cookie>
    ```
  - payload
    ```json
      {
        "routine_time": integer
      }
    ```

- output
  ```json
    {
      "uid": <string>,
      "name": <string>,
      "note": <string>,
      "period": <string>, // year, month, weekday, day
      "routine_time": <integer>
    }
  ```

## PUT <host>/routine_task_infos/<routine_task_info_uid>/name

- input
  - header
    ```json
      Content-Type: application/json
      Cookie: <cookie>
    ```
  - payload
    ```json
      {
        "update_value": <string>
      }
    ```

- output
  ```json
    {
      "uid": <string>,
      "name": <string>,
      "note": <string>,
      "period": <string>, // year, month, weekday, day
      "routine_time": <integer>
    }
  ```

## PUT <host>/routine_task_infos/<routine_task_info_uid>/note

- input
  - header
    ```json
      Content-Type: application/json
      Cookie: <cookie>
    ```
  - payload
    ```json
      {
        "update_value": <string>
      }
    ```

- output
  ```json
    {
      "uid": <string>,
      "name": <string>,
      "note": <string>,
      "period": <string>, // year, month, weekday, day
      "routine_time": <integer>
    }
  ```

## POST <host>/routine_task_infos

- input
  - header
    ```json
      Content-Type: application/json
      Cookie: <cookie>
    ```
  - payload
    ```json
      {
        "name": <string>,
        "period": <string>, // year, month, weekday, day
        "routine_time": <integer>
      }
    ```

- output
  ```json
    {
      "uid": <string>,
      "name": <string>,
      "note": <string>,
      "period": <string>, // year, month, weekday, day
      "routine_time": <integer>
    }
  ```

## DELETE <host>/routine_task_infos/<task_uid>

- input
  - header
    ```json
      Content-Type: application/json
      Cookie: <cookie>
    ```

- output
  ```json
    {
      "uid": <string>,
      "name": <string>,
      "note": <string>,
      "period": <string>, // year, month, weekday, day
      "routine_time": <integer>
    }
  ```

## GET <host>/routine_task_infos/<routine_task_info_uid>/routine_tasks

- input
  - header
    ```json
      Content-Type: application/json
      Cookie: <cookie>
    ```

- output
  ```json
    [
      {
        "uid": <string>,
        "status": <string>, // incompletion, partial_completion, delay, completion, delayed_completion
        "due_date": <string> // date format example: 2018-12-10T13:49:51.141Z
      },
      ......
    ]
  ```

## PUT <host>/routine_task_infos/<routine_task_info_uid>/routine_tasks/<routine_task_uid>/status

- input
  - header
    ```json
      Content-Type: application/json
      Cookie: <cookie>
    ```
  - payload
    ```json
      {
        "status": <string> // partial_completion, completion
      }
    ```

- output
  ```json
    {
      "uid": <string>,
      "status": <string>, // incompletion, partial_completion, delay, completion
      "due_date": <string> // date format example: 2018-12-10T13:49:51.141Z
    }
  ```

