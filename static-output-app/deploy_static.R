#--- This section is only for deploying

library(rsconnect)
rsconnect::setAccountInfo(name='acn-strategy',
                          token='D6B2733F1DBF60AD5694816965C75ED0',
                          secret='TrY3FiHiJHYF9xOzBj0bBRLEowivh9/rFSbC4Awr')

deployApp()
