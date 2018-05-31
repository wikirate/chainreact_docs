namespace :deploy do
  desc "Set www-data permissions on config.ru / log"
  after :updated, :deploy_chown do
    on roles(:app) do
      execute :sudo, "/opt/bin/deploy_chown", release_path
    end
  end

  desc "clear cache"
  after :published, :clear_cache do
    on roles(:app) do
      within release_path do
        execute :rake, "decko:reset_cache"
      end
    end
  end
end
