# CDC Wonder API Ruby Gem

Hi! I wrote this ruby gem to interact with the CDC Wonder API. Through Wonder, you can access all kinds of amazing (hence Wonder?) datasets like Births, Cancer Statistics and Mortality. 

## Installing the Wonder Gem

Open up Terminal.App or your favorite shell, and install the gem:

    $ gem install wonder-ruby

Or, add to your gemfile:

    gem 'wonder-ruby'


#Documentation - THIS IS UNDER DEVELOPMENT

##Using the Wonder Gem Command Line Interface (CLI)

You can interact with the Wonder API datasets leveraging the wonder-cli:

    $ cdcwonder dataset list
    #births, cancer, aids, mortality, 
    #returns a list of available datasets

    $ cdcwonder births get
    #grabs birth data

    $ cdcwonder births years|variables|regions
    #outputs available years, variables, regions
