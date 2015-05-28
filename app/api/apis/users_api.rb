class UsersApi < Grape::API
	resources :users do
		
		desc "测试"
		get :test do
			present :success, true
			present :msg, "hello world"
		end
	end
end