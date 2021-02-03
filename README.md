# README

* Database initialization
```bash
rails db:setup
rails db:migrate
rails db:seed #to create sample user data
```
* API Docs

View current user time tracks

(default is first user, you can specific another user by passing `assign_user_id` params for testing)
```
GET /v1/time_tracks
```

Create time tracks
```
POST /v1/time_tracks
```

Follow user

```
POST /v1/follows/follow
params: {
        	"user_follow": {
        		"followed_user_id": user_id
        	}
        }
```

Unfollow user
```
DELETE /v1/follows/:follow_id/follow
```

View time track of a following user
```
GET /v1/follows/:follow_id/time_tracks
```