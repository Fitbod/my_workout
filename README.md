# My Workout

The following is a trivial application for storing user workout
information.

## Getting Started
Install Gems
```
bundle install
```
Create Databases
```
rake db:create
```
Migrate Databases
```
rake db:migrate
```
Seed the Database
```
rake db:seed
```
Run the Server
```
rails s
```

## Models
- User
- Workout

## Relationships
A User has many Workouts

## Services

### RESTful API Service
Process incoming requests from the devices to save and receive workout
information. The api service handles authentication via Basic Auth. The endpoints are as follows:

```
                         exercises GET        /api/v1/exercises(.:format)                                                              api/exercises#index
                                   POST       /api/v1/exercises(.:format)                                                              api/exercises#create
                      new_exercise GET        /api/v1/exercises/new(.:format)                                                          api/exercises#new
                     edit_exercise GET        /api/v1/exercises/:id/edit(.:format)                                                     api/exercises#edit
                          exercise GET        /api/v1/exercises/:id(.:format)                                                          api/exercises#show
                                   PATCH      /api/v1/exercises/:id(.:format)                                                          api/exercises#update
                                   PUT        /api/v1/exercises/:id(.:format)                                                          api/exercises#update
                                   DELETE     /api/v1/exercises/:id(.:format)                                                          api/exercises#destroy
          user_workout_single_sets GET        /api/v1/users/:user_id/workouts/:workout_id/single_sets(.:format)                        api/single_sets#index
                                   POST       /api/v1/users/:user_id/workouts/:workout_id/single_sets(.:format)                        api/single_sets#create
       new_user_workout_single_set GET        /api/v1/users/:user_id/workouts/:workout_id/single_sets/new(.:format)                    api/single_sets#new
      edit_user_workout_single_set GET        /api/v1/users/:user_id/workouts/:workout_id/single_sets/:id/edit(.:format)               api/single_sets#edit
           user_workout_single_set GET        /api/v1/users/:user_id/workouts/:workout_id/single_sets/:id(.:format)                    api/single_sets#show
                                   PATCH      /api/v1/users/:user_id/workouts/:workout_id/single_sets/:id(.:format)                    api/single_sets#update
                                   PUT        /api/v1/users/:user_id/workouts/:workout_id/single_sets/:id(.:format)                    api/single_sets#update
                                   DELETE     /api/v1/users/:user_id/workouts/:workout_id/single_sets/:id(.:format)                    api/single_sets#destroy
                     user_workouts GET        /api/v1/users/:user_id/workouts(.:format)                                                api/workouts#index
                                   POST       /api/v1/users/:user_id/workouts(.:format)                                                api/workouts#create
                  new_user_workout GET        /api/v1/users/:user_id/workouts/new(.:format)                                            api/workouts#new
                 edit_user_workout GET        /api/v1/users/:user_id/workouts/:id/edit(.:format)                                       api/workouts#edit
                      user_workout GET        /api/v1/users/:user_id/workouts/:id(.:format)                                            api/workouts#show
                                   PATCH      /api/v1/users/:user_id/workouts/:id(.:format)                                            api/workouts#update
                                   PUT        /api/v1/users/:user_id/workouts/:id(.:format)                                            api/workouts#update
                                   DELETE     /api/v1/users/:user_id/workouts/:id(.:format)                                            api/workouts#destroy
                             users GET        /api/v1/users(.:format)                                                                  api/users#index
                                   POST       /api/v1/users(.:format)                                                                  api/users#create
                          new_user GET        /api/v1/users/new(.:format)                                                              api/users#new
                         edit_user GET        /api/v1/users/:id/edit(.:format)                                                         api/users#edit
                              user GET        /api/v1/users/:id(.:format)                                                              api/users#show
                                   PATCH      /api/v1/users/:id(.:format)                                                              api/users#update
                                   PUT        /api/v1/users/:id(.:format)                                                              api/users#update
                                   DELETE     /api/v1/users/:id(.:format)                                                              api/users#destroy
```

NOTE: Although multiple endpoints are defined, a user is only
authorized to CRUD certain resouces.

### Front-end User Web App
Allow user to view a list of workouts in the user’s workout history.
Users can also save new workouts and modify existing workout
durations. Users can log into the web interface by going to:

```
/profile
```
>NOTE: This does not include a UI for single_sets or exercises

### Front-end Admin Web App
Admin users have complete control over user resources. Admins can
access the admin interface by going to

```
/admin
```

## Tests

### rspec
The tests are written in rspec and can be run using:

```
rspec
```

Within the request specs, there are benchmarks to get an idea of how
fast the request can be processed.

```
$ rspec -f d

Profile
  ProfileUserWorkouts
    List profile_user_workouts
       user     system      total        real
   0.268184   0.036775   0.304959 (  0.307584)
      works! (now write some real specs)
    Create profile_user_workout
       user     system      total        real
   0.038396   0.019587   0.057983 (  0.058499)
      works! (now write some real specs)
    Update profile_user_workout
       user     system      total        real
   0.026901   0.019281   0.046182 (  0.046524)
      works! (now write some real specs)

API
  UserWorkouts
    List user_workouts
       user     system      total        real
   0.049741   0.004697   0.054438 (  0.054661)
      works! (now write some real specs)
    Create user_workout
       user     system      total        real
   0.013563   0.004166   0.017729 (  0.017734)
      works! (now write some real specs)
    Update user_workout
       user     system      total        real
   0.015485   0.003971   0.019456 (  0.019564)
      works! (now write some real specs)

Finished in 0.58914 seconds (files took 1.36 seconds to load)
6 examples, 0 failures
```

### curl
There is a curl script that will perform some basic api operations
given a host. It can be run like this:

```
HOST=http://localhost:3000 bin/basic_test
```
