cask "chef-workstation" do
  version "21.8.555"
  sha256 "71be8ed28241734f11fbfda17f79fafdc3cfaeaa5256e4f8ab2989b76fca41e0"

  url "https://packages.chef.io/files/stable/chef-workstation/#{version}/mac_os_x/10.15/chef-workstation-#{version}-1.x86_64.dmg"
  name "Chef Workstation"
  desc "All-in-one installer for the tools you need to manage your Chef infrastructure"
  homepage "https://docs.chef.io/workstation/"

  livecheck do
    url "https://omnitruck.chef.io/stable/chef-workstation/metadata?p=mac_os_x&pv=10.15&m=x86_64&v=latest"
    regex(/version\s*(\d+(?:\.\d+)+)/i)
  end

  depends_on macos: ">= :mojave"

  pkg "chef-workstation-#{version}-1.x86_64.pkg"

  uninstall quit:      "sh.chef.chef-workstation",
            pkgutil:   "com.getchef.pkg.chef-workstation",
            launchctl: "io.chef.chef-workstation.app",
            script:    {
              executable: "/opt/chef-workstation/bin/uninstall_chef_workstation",
              sudo:       true,
            }

  zap trash: "~/.chef-workstation/"
end
