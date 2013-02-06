require 'enumerator'
module Frostbitten
	class Score
		attr_accessor :team_one,:team_two
		class << self
			def scores_from_list(list,index)
				element_count = list.slice!(index).to_i
				return [].tap do |scores| 
					list.slice!(index+1,element_count).each_slice(2) do |slice|
						scores << Score.new(slice)
					end
				end
			end
		end

		def initialize(scores)
			self.team_one = scores[0]
			self.team_two = scores[1]
		end
	end
end