require_dependency 'issue'

module CalculatingHours
  module IssueCalculatingHoursPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      
      base.class_eval do
        safe_attributes 'performer_occupancy'
      end
    end
    
    module InstanceMethods
      # Extra methods if needed...
    end
  end
end

Issue.send(:include, CalculatingHours::IssueCalculatingHoursPatch)
