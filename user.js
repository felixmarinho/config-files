// Firefox privacy & security hardening
// Personal configuration — organized by category

// ============================================================================
// PRIVACY / TRACKING PROTECTION
// ============================================================================

// Use Firefox's custom Enhanced Tracking Protection configuration.
// Configure the specific protections through Firefox Settings:
//   - Tracking content: All windows
//   - Cryptominers: ON
//   - Known fingerprinters: ON
//   - Suspected fingerprinters: ON
user_pref("browser.contentblocking.category", "custom");

// Global Privacy Control (GPC)
user_pref("privacy.globalprivacycontrol.enabled", true);

// Total Cookie Protection / cookie partitioning
user_pref("network.cookie.cookieBehavior", 5);

// Disable Do Not Track-style legacy behavior; GPC is used instead.

// Firefox Containers
user_pref("privacy.userContext.enabled", true);
user_pref("privacy.userContext.ui.enabled", true);

// Disable Beacon API tracking
user_pref("beacon.enabled", false);

// ============================================================================
// NETWORK / DNS
// ============================================================================

// DNS is handled externally by AdGuard + Mullvad DNS.
// Firefox DNS-over-HTTPS (TRR) is explicitly disabled.
user_pref("network.trr.mode", 5);

// Intentionally disable IPv6.
user_pref("network.dns.disableIPv6", true);

// Disable captive portal and connectivity checks.
user_pref("network.captive-portal-service.enabled", false);
user_pref("network.connectivity-service.enabled", false);

// ============================================================================
// CONNECTION / WEBRTC
// ============================================================================

// Disable WebRTC to prevent WebRTC network/IP exposure.
user_pref("media.peerconnection.enabled", false);

// Do not allow HTTPS-Only mode to make background HTTP requests.
user_pref("dom.security.https_only_mode_send_http_background_request", false);

// ============================================================================
// HTTPS / TLS / CERTIFICATES
// ============================================================================

// HTTPS-Only Mode for all windows.
user_pref("dom.security.https_only_mode", true);
user_pref("dom.security.https_only_mode_ever_enabled", true);

// Certificate pinning.
user_pref("security.cert_pinning.enforcement_level", 2);

// Block mixed-content display resources.
user_pref("security.mixed_content.block_display_content", true);

// CRLite certificate revocation checking.
user_pref("security.pki.crlite_mode", 2);
user_pref("security.remote_settings.crlite_filters.enabled", true);

// Disable TLS 1.3 0-RTT to avoid replay-related privacy/security concerns.
user_pref("security.tls.enable_0rtt_data", false);

// ============================================================================
// BROWSER FEATURES / CONTENT
// ============================================================================

// Disable PDF JavaScript.
user_pref("pdfjs.enableScripting", false);

// Keep WebGL enabled for compatibility.
// Fingerprinting protection is handled by Firefox's tracking protection.
user_pref("webgl.disabled", false);

// Preserve normal color management.
user_pref("gfx.color_management.mode", 1);
user_pref("gfx.color_management.rendering_intent", -1);
user_pref("gfx.color_management.enablev4", true);

// Disable DRM / Encrypted Media Extensions.
// Re-enable if a site requiring DRM playback does not work.
user_pref("media.eme.enabled", true);

// Disable Firefox's built-in location provider.
user_pref("geo.provider.use_corelocation", false);

// Allow clipboard events to function normally.
user_pref("dom.event.clipboardevents.enabled", true);

// Allow HTTP authentication in subresources.
user_pref("network.auth.subresource-http-auth-allow", 1);

// ============================================================================
// TELEMETRY / DATA COLLECTION
// ============================================================================

// Disable Firefox telemetry/data submission.
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);

// Disable Firefox coverage reporting.
user_pref("toolkit.coverage.endpoint.base", "");
user_pref("toolkit.coverage.opt-out", true);
user_pref("toolkit.telemetry.coverage.opt-out", true);

// Disable crash report submission.
user_pref("browser.tabs.crashReporting.sendReport", false);

// ============================================================================
// FIREFOX SERVICES / RECOMMENDATIONS
// ============================================================================

// Disable Normandy / Shield studies.
user_pref("app.normandy.first_run", false);
user_pref("app.normandy.api_url", "");
user_pref("app.normandy.enabled", false);
user_pref("app.shield.optoutstudies.enabled", false);

// Disable Firefox UI recommendations / sponsored suggestions.
user_pref(
  "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons",
  false,
);
user_pref(
  "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features",
  false,
);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);

user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false);
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);

user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);

// Disable Pocket integration.
user_pref("extensions.pocket.enabled", false);

// Disable Firefox telemetry-oriented UI tours.
user_pref("browser.uitour.enabled", false);

// ============================================================================
// SEARCH / URL BAR
// ============================================================================

// Disable search suggestions.
user_pref("browser.search.suggest.enabled", false);

// ============================================================================
// FORMS / PASSWORDS / AUTOFILL
// ============================================================================

// Disable form-history/autocomplete storage.
user_pref("browser.formfill.enable", false);

// Keep Firefox's form autofill mechanism available while disabling
// saved addresses and credit cards through Firefox's normal settings.
user_pref("dom.forms.autocomplete.formautofill", true);

// Do not save passwords in Firefox.
user_pref("signon.rememberSignons", false);

// Disable Firefox's breach-alert UI for saved credentials.
user_pref("signon.management.page.breach-alerts.enabled", false);

// ============================================================================
// HISTORY / SESSION DATA
// ============================================================================

// Disable persistent browsing history.
user_pref("places.history.enabled", false);

// Restrict information stored by session restore.
user_pref("browser.sessionstore.privacy_level", 2);

// ============================================================================
// DOWNLOADS
// ============================================================================

// Ask where downloaded files should be saved.
user_pref("browser.download.useDownloadDir", false);

// ============================================================================
// ACCESSIBILITY / UI
// ============================================================================

// Disable accessibility services unless explicitly needed.
user_pref("accessibility.force_disabled", 1);

// Enable normal spell checking.
user_pref("layout.spellcheckDefault", 1);

// Disable Firefox page thumbnail generation.
// user_pref("browser.pagethumbnails.capturing_disabled", true);

// ============================================================================
// FIREFOX ACCOUNT
// ============================================================================

// Keep Firefox Account functionality enabled for Sync.
user_pref("identity.fxaccounts.enabled", true);
