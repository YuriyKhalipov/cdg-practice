require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:laboratory_works) }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }

  it { is_expected.to validate_length_of(:first_name).is_at_most(100) }
  it { is_expected.to validate_length_of(:last_name).is_at_most(100) }

  it { is_expected.to_not allow_value('1231not email pattern!1231').for(:email) }
  it { is_expected.to allow_value('default@gmail.com').for(:email) }
end
