module Asset
  extend self

  def remote_to_local(cap)
    servers = cap.find_servers :roles => :app
    port = cap.port rescue 22
    [cap.assets_dir].flatten.each do |dir|
      system("rsync -a --del -L -K -vv --progress --rsh='ssh -p #{port}' #{cap.user}@#{servers.first}:#{cap.deploy_to}/current/#{dir} #{cap.local_assets_dir}")
    end
  end

  def local_to_remote(cap)
    servers = cap.find_servers :roles => :app
    port = cap.port rescue 22
    [cap.assets_dir].flatten.each do |dir|
      system("rsync -a --del -L -K -vv --progress --rsh='ssh -p #{port}' #{cap.local_assets_dir} #{cap.user}@#{servers.first}:#{cap.deploy_to}/current/#{dir}")
    end
  end

  def to_string(cap)
    [cap.assets_dir].flatten.join(" ")
  end
end
