require 'pp'
module Frostbitten
	module Methods
		# Methods not requiring admin rcon priveleges
		module NormalCommands
			# Authenticate connection using password or pregiven password in uri.
			def auth(password=nil)
				unless password
					raise ArgumentError, "No password supplied" unless self.server and self.server.password
				end

				password = password ? password : self.server.password

				data = send("login.hashed")

				salt = [data.first].pack("H*")
				hashed = Digest::MD5.hexdigest("#{salt}#{password}")
				if send(["login.hashed", hashed.upcase])
					@logged_in = true
				else
					@logged_in = false
				end

				return self
			end

			# Lists players and will return list of players
			def players(list="all")
				data = send(['listPlayers', list])
				if data
					return Player.players_from_list(data,0)
				end
			end

			# General server information
			def serverinfo
				score_data = send("serverinfo")
				score_data.insert(7,Frostbitten::Score.scores_from_list(score_data,7))
				return Server.new {}.tap do |hash| 
					score_data.to_enum.with_index(1).each do |value,key| 
						hash["data#{key}"] = value
					end
				end
			end
		end
	end
end