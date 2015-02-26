exports.keen = ->
	new Keen(
		projectId: '54ed8c642fd4b14d3bc9a823'
		writeKey: 'c4aaeb6bf7c70d14951ecc8148d42ed8a5fe3ed1cef64c039ade9c57d56da2fb87b4b63e0c7ebac6d15168085f7b7d4a13b14a7cc974b2edfa825b2c1ea081af76e8cc7f342dcdef3485a6aca4518d51164f9cb83c36b4627fd225b80f8f8a2fc1446b7421638242457aec071ff12ce0')

exports.log = (keen, name, state, action) ->
	keenEvent = {
		click: name
		state: state
		action: action
		keen: { "addons" : [
				{
					"name" : "keen:ip_to_geo"
					"input" : {
						"ip" : "ip_address"
					}
					"output" : "ip_geo_info"
				}, {
					"name" : "keen:ua_parser"
					"input" : {
						"ua_string" : "user_agent"
					}
					"output" : "parsed_user_agent"
				}
			]
		},
		"ip_address" : "${keen.ip}"
		"user_agent" : "${keen.user_agent}"
	}
	keen.addEvent("clicks", keenEvent)
	keenEventSimple = {
		click: name
		state: state
		action: action
	}
	keen.addEvent("clicks-simple", keenEventSimple)