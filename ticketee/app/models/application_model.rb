class ApplicationModel < ROM::Struct
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  constructor_type :schema

  def persisted?
    respond_to?(:id) && id.present?
  end
end
