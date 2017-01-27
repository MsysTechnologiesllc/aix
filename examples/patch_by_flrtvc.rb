# recipe example flrtvc script on nim clients

aix_flrtvc 'patch aix machine(s)' do
  # targets '*'
  # csv '/apar.csv'
  # apar 'all'
  # path '/flrtvc'
  action [:install, :patch]
  # verbose true
  # clean false
  # check_only true
  # download_only true
end

aix_nim 'reboot aix machine(s)' do
  # targets '*'
  action :reboot
end
