# README
I am sorry that this is incomplete documentation wise.  I had Claude generate the API documentation below.  I am leaving my initial notes in my project planning.  Some of the method name obviously have changed but you get the picture.

Notes:

Backend for a shared note taking and organizing system.

1.  Do as an API backend with access to anyone that has the access to the hosted API
2.  There will be one table called notes with the following fields.
    a. title - string
    b. category - string
    c. author - string
    d. description - string
    e. note - string/text
3.  APIs
    a. create
    b. get_note
    c. get_all
    d. update
    e. delete 
    f. search
4.  Read, update and delete can be accessed by title/name
    a. /get_note/:id
    b. /get_note_by_author?author=fred
    c. /get_note_by_category?category=sales
    d. /search?search_str=xxxxx
    e. /get_all
    f. /update/:id
    g. /delete/:id
5.  It is better to get or update an individual record by id which would be passed in by the UI for the item selcted. 
6.  Return status for my api
    a. {"status":"success", "message":"id: #{id}, successfully delete"}
    b. {"status":"error", "message": "Id: #{id}, was not successfully deleted"}
    c. {"status":"success", json}

## API Reference

All endpoints accept and return JSON. Send request bodies with the header
`Content-Type: application/json`.

Base URL (development): `http://localhost:3000`

### Note object

| Field         | Type     | Required | Notes                       |
|---------------|----------|----------|-----------------------------|
| `id`          | integer  | —        | Assigned by the server      |
| `title`       | string   | no       |                             |
| `author`      | string   | yes      |                             |
| `category`    | string   | yes      |                             |
| `description` | string   | no       |                             |
| `note`        | text     | yes      | The body of the note        |
| `created_at`  | datetime | —        | Set by the server           |
| `updated_at`  | datetime | —        | Set by the server           |

Example:

```json
{
  "id": 1,
  "title": "First Note",
  "author": "fred",
  "category": "sales",
  "description": "First Note description",
  "note": "this is my first note",
  "created_at": "2026-11-06T22:55:00.000Z",
  "updated_at": "2026-11-06T22:55:00.000Z"
}
```

### Endpoints

| Method      | Path                                    | Description                          |
|-------------|-----------------------------------------|--------------------------------------|
| `GET`       | `/notes`                                | List all notes                       |
| `GET`       | `/notes/:id`                            | Get one note by id                   |
| `POST`      | `/notes`                                | Create a note                        |
| `PATCH/PUT` | `/notes/:id`                            | Update a note                        |
| `DELETE`    | `/notes/:id`                            | Delete a note                        |
| `GET`       | `/notes/get_by_author?author=NAME`      | Notes by author (case-insensitive)   |
| `GET`       | `/notes/get_by_category?category=NAME`  | Notes by category (case-insensitive) |
| `GET`       | `/notes/search?search_str=TEXT`         | Notes whose title contains TEXT      |

#### List all notes

```
GET /notes
```

`200 OK` with an array of note objects. An empty array (`[]`) means there are no notes.

#### Get a note

```
GET /notes/:id
```

- `200 OK` with the note object.
- `404 Not Found` if no note has that id.

#### Create a note

```
POST /notes
```

Request body (flat; do not wrap the fields in a `note` key):

```json
{
  "title": "First Note",
  "author": "fred",
  "category": "sales",
  "description": "First Note description",
  "note": "this is my first note"
}
```

- `201 Created` with the new note object.
- `422 Unprocessable Entity` if a required field is missing or blank:

  ```json
  { "errors": ["Author can't be blank"] }
  ```

#### Update a note

```
PATCH /notes/:id
PUT   /notes/:id
```

Request body: any of the note fields to change.

- `200 OK` with the updated note object.
- `404 Not Found` if no note has that id.
- `422 Unprocessable Entity` with an `errors` array if validation fails.

#### Delete a note

```
DELETE /notes/:id
```

- `200 OK` with the deleted note object.
- `404 Not Found` if no note has that id.

#### Notes by author

```
GET /notes/get_by_author?author=fred
```

Exact match on `author`, ignoring case. `200 OK` with an array of notes (empty if none match).

#### Notes by category

```
GET /notes/get_by_category?category=sales
```

Exact match on `category`, ignoring case. `200 OK` with an array of notes (empty if none match).

#### Search

```
GET /notes/search?search_str=first
```

Returns notes whose `title` contains `search_str` anywhere, ignoring case.
`%` and `_` in the search text are matched literally. `200 OK` with an array of
notes (empty if none match).

### Examples (curl)

```bash
# Create
curl -X POST http://localhost:3000/notes \
  -H "Content-Type: application/json" \
  -d '{"title":"First Note","author":"fred","category":"sales","note":"hello"}'

# List / get one
curl http://localhost:3000/notes
curl http://localhost:3000/notes/1

# Update
curl -X PATCH http://localhost:3000/notes/1 \
  -H "Content-Type: application/json" \
  -d '{"category":"marketing"}'

# Delete
curl -X DELETE http://localhost:3000/notes/1

# Filter and search
curl "http://localhost:3000/notes/get_by_author?author=Fred"
curl "http://localhost:3000/notes/get_by_category?category=sales"
curl "http://localhost:3000/notes/search?search_str=first"
```
