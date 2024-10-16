<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("confirmLinkIdpTitle")}
    <#elseif section = "form">
        <form id="kc-register-form" action="${url.loginAction}" method="post">
            <div class="${properties.kcFormGroupClass!}">
                <h3>Please reach out to your application's access team to reset the identity provider link.</h3>
                <a href="mailto:ITSB.AccessTeam@gov.bc.ca">ITSB.AccessTeam@gov.bc.ca</a>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>