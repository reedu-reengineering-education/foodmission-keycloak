import type { KcContext } from "../kcContext";
import type { I18n } from "../i18n";
import { TwoColumnLayout } from "../components/layout/TwoColumnLayout";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { CheckCircle, Shield, Info } from "lucide-react";

// Extract the OAuth Grant page context specifically
type OAuthGrantKcContext = Extract<KcContext, { pageId: "login-oauth-grant.ftl" }>;

type Props = {
  kcContext: OAuthGrantKcContext;
  i18n: I18n;
};

export function OAuthGrant({ kcContext, i18n }: Props) {
  const { url, client, oauth, messagesPerField } = kcContext;
  const { msg } = i18n;

  const clientName = client.name || client.clientId;
  const scopes = oauth?.clientScopesRequested || [];

  return (
    <TwoColumnLayout kcContext={kcContext} i18n={i18n}>
      <Card className="w-full max-w-md mx-auto">
        <CardHeader className="text-center">
          <div className="flex justify-center mb-4">
            <Shield className="h-12 w-12 text-blue-600" />
          </div>
          <CardTitle className="text-2xl font-bold">
            Application Authorization
          </CardTitle>
          <CardDescription>
            The following application is requesting access to your account:
          </CardDescription>
        </CardHeader>

        <CardContent className="space-y-6">
          {/* Client Information */}
          <div className="text-center">
            <div className="text-lg font-semibold text-gray-900 mb-2">
              {clientName}
            </div>
            <p className="text-sm text-gray-600">
              This application is requesting permission to:
            </p>
          </div>

          {/* Requested Permissions */}
          {scopes.length > 0 && (
            <div className="space-y-3">
              <h3 className="font-medium text-gray-900 flex items-center gap-2">
                <Info className="h-4 w-4" />
                Requested Permissions
              </h3>
              <div className="space-y-2">
                {scopes.map((scope, index) => (
                  <div key={index} className="flex items-start gap-3 p-3 bg-gray-50 rounded-lg">
                    <CheckCircle className="h-5 w-5 text-green-600 mt-0.5 flex-shrink-0" />
                    <div className="flex-1">
                      <div className="font-medium text-sm">
                        {scope.consentScreenText || (scope as any).name || "Permission"}
                      </div>
                      {scope.dynamicScopeParameter && (
                        <div className="text-xs text-gray-600 mt-1">
                          {scope.dynamicScopeParameter}
                        </div>
                      )}
                    </div>
                  </div>
                ))}
              </div>
            </div>
          )}

          {/* Warning Message */}
          <Alert>
            <AlertDescription className="text-sm">
              By clicking 'Allow', you give this application permission to access your account information as described above.
            </AlertDescription>
          </Alert>

          {/* Error Messages */}
          {messagesPerField.existsError('oauth') && (
            <Alert variant="destructive">
              <AlertDescription>
                {messagesPerField.getFirstError('oauth')}
              </AlertDescription>
            </Alert>
          )}

          {/* Action Buttons */}
          <form action={url.oauthAction} method="post" className="space-y-3">
            <Button 
              type="submit" 
              name="accept" 
              className="w-full bg-blue-600 hover:bg-blue-700"
              size="lg"
            >
              {msg("doYes")}
            </Button>
            
            <Button 
              type="submit" 
              name="cancel" 
              variant="outline" 
              className="w-full"
              size="lg"
            >
              {msg("doNo")}
            </Button>
          </form>

          {/* Additional Information */}
          <div className="text-xs text-gray-500 text-center space-y-1">
            <p>
              Your privacy and security are important to us.
            </p>
            <p>
              You can revoke these permissions at any time in your account settings.
            </p>
          </div>
        </CardContent>
      </Card>
    </TwoColumnLayout>
  );
}