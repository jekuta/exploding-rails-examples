require 'dry-transaction'

module Projects
  class Create
    include Dry::Transaction
    include Ticketee::Import["project_repo"]

    step :validate
	  map :persist

		def validate(input)
			validation = ProjectSchema.(input)
			if validation.success?
				Success(input)
			else
				Failure(validation.errors)
			end
		end

		def persist(input)
			project_repo.create(input)
		end
  end
end
