Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/tasks' => 'tasks#index'
  put '/tasks/:task_uid/status' => 'tasks#update_status'
  put '/tasks/:task_uid/:field' => 'tasks#update'
  post '/tasks' => 'tasks#create'
  delete '/task/:task_uid' => 'tasks#delete'

  get '/routine_task_infos' => 'routine_task_infos#index'
  put '/routine_task_infos/:routine_task_info_uid/period' => 'routine_task_infos#update_period'
  put '/routine_task_infos/:routine_task_info_uid/routine_time' => 'routine_task_infos#update_routine_time'
  put '/routine_task_infos/:routine_task_info_uid/:field' => 'routine_task_infos#update'
  post '/routine_task_infos' => 'routine_task_infos#create'
  delete '/routine_task_info' => 'routine_task_infos#delete'

  get '/routine_task_infos/:routine_task_info_uid/routine_tasks' => 'routine_tasks#index'
  put '/routine_task_infos/:routine_task_info_uid/routine_tasks/:routine_task_uid/status' => 'routine_tasks#update'

end
