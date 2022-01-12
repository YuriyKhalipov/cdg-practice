require 'rails_helper'

RSpec.describe LabReport, type: :model do
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_length_of(:title).is_at_most(250) }

  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_length_of(:description).is_at_most(500) }

  it { is_expected.to validate_numericality_of(:grade) }
end