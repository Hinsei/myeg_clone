alias Myeg.Repo
alias Myeg.{Services, Accounts}
alias Myeg.Services.{Bureau, Specialty}
alias Myeg.Accounts.{User, Submission}

admin = Repo.insert!(User.create_changeset(%User{}, 
                     %{email: "admin@admin.com", password: "testing1234",}))

admin
|> User.update_changeset(%{role: :superadmin})
|> Repo.update()

user = Repo.insert!(User.create_changeset(%User{}, %{email: "test@test.com", password: "testing1234"}))

jpj     = Repo.insert!(Bureau.changeset(%Bureau{}, 
                       %{email: "jpj@gmail.com", 
                         location: "Malaysia", 
                         logo: "https://www.myeg.com.my/images/agency-jpj.png", 
                         mobile: "0123456789", 
                         name: "Road Transport Department"}))

pdrm    = Repo.insert!(Bureau.changeset(%Bureau{}, 
                       %{email: "pdrm@gmail.com", 
                         location: "Malaysia", 
                         logo: "https://app1.myeg.com.my/eservices/img/Dboard_PDRM.gif", 
                         mobile: "0123456789", 
                         name: "Polis Diraja Malaysia"}))

ptptn   = Repo.insert!(Bureau.changeset(%Bureau{}, 
                       %{email: "ptptn@gmail.com", 
                         location: "Malaysia", 
                         logo: "http://www.ptptn.gov.my/docs/eform-images/logo-ptptn-new-gif.gif", 
                         mobile: "0123456789", 
                         name: "Perbadanan Tabung Pendidikan Tinggi Nasional"
                       }))
syabas  = Repo.insert!(Bureau.changeset(%Bureau{}, 
                       %{email: "syabas@gmail.com", 
                         location: "Malaysia", 
                         logo: "http://www.thesundaily.my/sites/default/files/imagecache/article/thesun/Catalogue/syabas_003_c1795704_16510_885.jpg", 
                         mobile: "0123456789",
                         name: "Syabas"
                       }))

Repo.insert!(Specialty.changeset(%Specialty{}, %{title: "summons_checking", form_data: ["name", "ic_number"], bureau_id: jpj.id}))
Repo.insert!(Specialty.changeset(%Specialty{}, %{title: "summons_payment", form_data: ["summon_identification_number"], bureau_id: jpj.id, payable: true}))
Repo.insert!(Specialty.changeset(%Specialty{}, %{title: "driving_license_renewal", form_data: ["id_number", "category", "expiry_date", "renewal_period", "mobile_number", "email", "collection_method"], bureau_id: jpj.id, payable: true}))
Repo.insert!(Specialty.changeset(%Specialty{}, %{title: "road_tax_renewal", form_data: ["id_number", "owner_mobile_number", "owner_category", "owner_name", "vehicle_registration_number", "email", "renewal_period"], bureau_id: jpj.id, payable: true}))
Repo.insert!(Specialty.changeset(%Specialty{}, %{title: "ldl_application", form_data: ["id_number", "category", "license_class", "duration"], bureau_id: jpj.id}))

Repo.insert!(Specialty.changeset(%Specialty{}, %{title: "summons_checking", form_data: ["ic_number"], bureau_id: pdrm.id}))
Repo.insert!(Specialty.changeset(%Specialty{}, %{title: "summons_payment", form_data: ["summon_identification_number"], bureau_id: pdrm.id, payable: true}))
Repo.insert!(Specialty.changeset(%Specialty{}, %{title: "accident_document_purchasing_system", form_data: ["ic_number", "vehicle_number"], bureau_id: pdrm.id, payable: true}))

Repo.insert!(Specialty.changeset(%Specialty{}, %{title: "check_balance", form_data: ["id_number", "name", "email", "mobile"], bureau_id: ptptn.id}))
Repo.insert!(Specialty.changeset(%Specialty{}, %{title: "make_payment", form_data: ["service_identification_number"], bureau_id: ptptn.id, payable: true}))

Repo.insert!(Specialty.changeset(%Specialty{}, %{title: "check_balance", form_data: ["ic_number"], bureau_id: syabas.id}))
Repo.insert!(Specialty.changeset(%Specialty{}, %{title: "make_payment", form_data: ["service_identification_number"], bureau_id: syabas.id, payable: true}))
