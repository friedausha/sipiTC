class Authenticator
  def initialize(authorization:)
    @authorization = authorization
  end

  def permitted?
    laboratory = Laboratory.find_by(name: authorization_tokens[0])
    return false unless laboratory
    authorization_tokens[1] == laboratory.password
  end

  def authorization_tokens
    @authorization.split(':')
  end
end
