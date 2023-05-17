class SamlController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: :callback

  def login
    if user_signed_in?
      flash[:notice] = "Already logged in"
      redirect_to(:root) and return
    end
    request = OneLogin::RubySaml::Authrequest.new
    redirect_to(request.create(saml_settings))
  end 

  def callback
    response = OneLogin::RubySaml::Response.new(
      params[:SAMLResponse],
      :settings => saml_settings
    )
  
    if response.is_valid?
      @user = User.find_or_initialize_by(email: response.try(:attributes).try(:attributes).dig("email").first)
      @user.skip_password_validation = true
      @user.create_type = "saml"
      @user.save!
      sign_in(@user)
      redirect_to(:root)
    else
      raise response.errors.inspect
    end
  end

  def metadata
    meta = OneLogin::RubySaml::Metadata.new
    render xml: meta.generate(saml_settings), content_type: "application/samlmetadata+xml"
  end

  private

  def saml_settings
    settings = OneLogin::RubySaml::Settings.new
    
    # You provide to IDP
    settings.assertion_consumer_service_url = "http://#{request.host_with_port}/saml/callback"
    settings.sp_entity_id                   = "http://#{request.host_with_port}/saml/metadata"
    
    # IDP provides to you
    settings.idp_sso_target_url             = "http://localhost:8080/simplesaml/saml2/idp/SSOService.php"
    settings.idp_cert                       = Rails.application.credentials.idp_cert
    
    settings
  end
end
