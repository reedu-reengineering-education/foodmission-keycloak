<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=false; section>
    <#if section = "header">
        ${msg("oauthGrantTitle")}
    <#elseif section = "form">
    <div id="kc-form">
      <div id="kc-form-wrapper">
        <form id="kc-form-oauth" action="${url.oauthAction}" method="post">
            <div class="${properties.kcFormGroupClass!}">
                <div id="kc-oauth-client-name" class="${properties.kcFormGroupClass!}">
                    <label class="${properties.kcLabelClass!}">${msg("oauthGrantRequest")}</label>
                    <div class="kc-oauth-client-name">
                        <#if client.name?has_content>
                            ${client.name}
                        <#else>
                            ${client.clientId}
                        </#if>
                    </div>
                </div>

                <#if oauth?? && oauth.clientScopesRequested??>
                    <div id="kc-oauth-scopes" class="${properties.kcFormGroupClass!}">
                        <label class="${properties.kcLabelClass!}">${msg("oauthGrantInformation")}</label>
                        <ul class="kc-oauth-scopes">
                            <#list oauth.clientScopesRequested as clientScope>
                                <li>
                                    <span class="kc-oauth-scope-name">${clientScope.consentScreenText!clientScope.name}</span>
                                    <#if clientScope.dynamicScopeParameter??>
                                        <div class="kc-oauth-scope-parameter">${clientScope.dynamicScopeParameter}</div>
                                    </#if>
                                </li>
                            </#list>
                        </ul>
                    </div>
                </#if>
            </div>

            <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcFormButtonsWrapperClass!}">
                    <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!}" 
                           name="accept" id="kc-accept" type="submit" value="${msg("doYes")}"/>
                    <input class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!}" 
                           name="cancel" id="kc-cancel" type="submit" value="${msg("doNo")}"/>
                </div>
            </div>
        </form>
      </div>
    </div>
    </#if>
</@layout.registrationLayout>