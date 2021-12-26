require 'rails_helper'

RSpec.describe LaboratoryWork, type: :model do
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_length_of(:title).is_at_most(250) }

  it { is_expected.to validate_presence_of(:text) }
  it { is_expected.to validate_length_of(:text).is_at_most(500) }
end
