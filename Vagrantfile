Vagrant.configure("2") do |config|

  config.vm.define "dc" do |dc|
  dc.vm.box = "windows_2008_r2_dc.box"
  #tar.vm.hostname = "Win7Target"
  dc.vm.guest = :windows
  dc.windows.halt_timeout = 30
  dc.windows.set_work_network = true
  dc.winrm.retry_limit = 30
  dc.winrm.retry_delay = 20
  dc.vm.boot_timeout = 700
  dc.vm.network :private_network, ip: "192.168.40.2", gateway: "192.168.40.1", dns: "8.8.8.8"

  # Enable Shared Folders
  dc.vm.synced_folder ".", "/vagrant", disabled: false

  # System Administrator Credentials
  dc.winrm.username = "vagrant"
  dc.winrm.password = "vagrant"

  # Provisioning scripts
  dc.vm.provision "shell", path: "scripts/WinDC/Set-DNS-and-Timezone.ps1", powershell_elevated_interactive: true
  dc.vm.provision "shell", path: "scripts/WinDC/Create-OUs.ps1", powershell_elevated_interactive: true
  dc.vm.provision "shell", path: "scripts/WinDC/Download-palantir-wef.ps1", powershell_elevated_interactive: true
  dc.vm.provision "shell", path: "scripts/WinDC/Install-wef-subscriptions.ps1", powershell_elevated_interactive: true
  dc.vm.provision "shell", path: "scripts/WinDC/Create-auditpolicy-gpos.ps1", powershell_elevated_interactive: true
  dc.vm.provision "shell", path: "scripts/WinDC/Create-powershell-gpo.ps1", powershell_elevated_interactive: true
  dc.vm.provision "shell", path: "scripts/WinDC/Create-wef-gpo.ps1", powershell_elevated_interactive: true

  dc.vm.provider "virtualbox" do |vb, override|
    vb.gui = false
    vb.customize ["modifyvm", :id, "--memory", 1024]
    vb.customize ["modifyvm", :id, "--cpus", 1]
    vb.customize ["modifyvm", :id, "--vram", "32"]
    vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    vb.customize ["setextradata", "global", "GUI/SuppressMessages", "all" ]
    end  
  end

 config.vm.define "target" do |tar|
  tar.vm.box = "windows_7_target.box"
  #tar.vm.hostname = "Win7Target"
  tar.vm.guest = :windows
  tar.windows.halt_timeout = 30
  tar.windows.set_work_network = true
  tar.winrm.retry_limit = 30
  tar.winrm.retry_delay = 10
  tar.vm.boot_timeout = 700
  tar.vm.network :private_network, ip: "192.168.40.4", gateway: "192.168.40.1", dns: "192.168.40.2"

  # Enable Shared Folders
  tar.vm.synced_folder ".", "/vagrant", disabled: false

  # System Administrator Credentials
  tar.winrm.username = "vagrant"
  tar.winrm.password = "vagrant"

  # Provisioning scripts

  tar.vm.provision "shell", path: "scripts/Target/Join-domain.ps1", powershell_elevated_interactive: true
  tar.vm.provision "reload"
  tar.vm.provision "shell", path: "scripts/Target/Add-local-admin.ps1", powershell_elevated_interactive: true
  tar.vm.provision "reload"
  tar.vm.provision "link-folder", type: "shell", path: "scripts/Target/Create-tools-folder-link.ps1", privileged: true

  tar.vm.provider "virtualbox" do |vb, override|
    vb.gui = true
    vb.customize ["modifyvm", :id, "--memory", 1024]
    vb.customize ["modifyvm", :id, "--cpus", 1]
    vb.customize ["modifyvm", :id, "--vram", "32"]
    vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    vb.customize ["setextradata", "global", "GUI/SuppressMessages", "all" ]
    end  
  end
  
  config.vm.define "danderspritz" do |dsz|
  dsz.vm.box = "windows_10_danderspritz.box"
  dsz.vm.hostname = "DanderSpritz10"
  dsz.vm.guest = :windows
  dsz.vm.communicator = "winrm"
  dsz.vm.boot_timeout = 300
  dsz.vm.network :private_network, ip: "192.168.40.3", gateway: "192.168.40.1", dns: "8.8.8.8"

  # Enable Shared Folders
  dsz.vm.synced_folder ".", "/vagrant", disabled: false

  # System Administrator Credentials
  dsz.winrm.username = "vagrant"
  dsz.winrm.password = "vagrant"

  dsz.vm.provider "virtualbox" do |vb, override|
    vb.gui = true
    vb.customize ["modifyvm", :id, "--memory", 2048]
    vb.customize ["modifyvm", :id, "--cpus", 2]
    vb.customize ["modifyvm", :id, "--vram", "32"]
    vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    vb.customize ["setextradata", "global", "GUI/SuppressMessages", "all" ]
    end  
  end
end
