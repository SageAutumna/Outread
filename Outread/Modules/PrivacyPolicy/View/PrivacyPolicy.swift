import SwiftUI

struct PrivacyPolicyView: View {
    //MARK: - Properties
    @EnvironmentObject private var router: Router<AppRoutes>
    
    //MARK: - Body
    var body: some View {
        VStack {
            HStack {
                Button {
                    router.pop()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.backward")
                            .tint(.white)
                        
                        Text("Back")
                            .font(.poppins(weight: .regular, size: 18))
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
                Text("Privacy Policy")
                    .font(.poppins(weight: .regular, size: 24))
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding(.horizontal, 15)
            .frame(height: 60.asDeviceHeight)
            
            ScrollView {
                Text("""
                Your rights as a user of our services

                You have the right to information, correction, blocking or deletion of your data at any time. Any given consent can be revoked at any time and you may partially object to the processing of your data, even if no consent was required from you for the processing. You can contact our data protection officer at any time for further information on privacy issues. Our data protection officer Rebecca Santios can be reached by email [outread2000@gmail.com].

                Data we collect about you

                On the one hand, your data is captured because you communicate it to us. This may, for example, be data that you enter in our contact form. Other data is collected automatically when visiting the website through our IT systems. These are above all technical data (e.g. Internet browser, operating system or time of the page request). The collection of this data is automatic as soon as you visit our platform.

                Registration Information: When you register for Outread (for our free offer, paid subscription, or use of a code), we collect the personal information that you voluntarily provide to us when registering through your access device.
                Mobile Advertising ID: If not disabled by the user, we collect the Mobile Advertising ID provided by your mobile device. If you do not want us to collect this Mobile Advertising ID, you can always disable or change this on your device. Please see this manual for iOS devices and this manual for Android devices.
                Cookies and Cookie-Policy: For the provision of the Outread service and to make our offer more user-friendly, effective and secure, we also use so-called cookies for data collection and storage. Cookies are small data packets that are stored on your device and do no harm. We collect Cookies in the following categories:
                Necessary technical or functional cookies: They help make a website usable by enabling basic functions like page navigation and access to secure areas of the website. The website cannot function properly without these cookies.
                Preference cookies: They enable a website to remember information that changes the way the website behaves or looks, like your preferred language or the region that you are in.
                Statistical cookies: They help website owners to understand how visitors interact with websites by collecting and reporting information anonymously.
                Marketing cookies: They are used to track visitors across websites. The intention is to display ads that are relevant and engaging for the individual user.
                Tracking Services: We use tracking services to collect information about the behavior of visitors to our pages. This way we can ensure an optimal user experience. These services use pseudonymised user profiles with the help of cookies, so that a direct inference to persons is not possible. Of course you can object to the creation of these profiles at any time. Incidentally, each access device can be configured in such a way that basically no cookies can be created at all, or they can be deleted directly after the session.
                Social Plugins: Our pages contain buttons from various social networks so that you can recommend our offers, services and / or products to other interested people. If you click on such a button, data such as your current IP address, browser and access device information (type and operating system), the resolution of the screen, if you have plug-ins installed will be the referrer (from where you came to the site) and the current URL to the site operator.
                Newsletter: When you sign up for our newsletter, your email address will be used for information on advertising and advertising purposes. Of course, this is voluntary and you can even after the consent at any time unsubscribe.
                Payment Information: If you use our free access, any of our trial phases or any of our subscriptions or you purchase anything through the Service, credit card information and other financial information we need to process the payment will be collected and stored with a payment service provider. We ourselves receive very little information from the payment providers about you.
                Personal Data of Children: We are not aware of collecting personal data from children under 16 years of age; if you are under 16 years of age, please do not register for Outread or send us any personal data. If we learn we have collected personal data from a child under 16 years of age, we will delete that information as quickly as possible. If you believe that a child under 16 may have provided us personal data, please contact us at privacy@Outread.com
                How we collect your data

                We collect your data in three different ways:

                automated when you visit our website
                through cookies
                through your voluntary input
                What we use your data for

                We want to offer you a faultless use of our services. Therefore, data is needed for the administration and troubleshooting of our websites. We pass on the collected data for processing to the respective internal departments as well as to other affiliated companies of Outread labs or to external service providers and contract processors according to the required purposes. However, as we are constantly improving ourselves and offering you optimized services, data in pseudonymised form (through usage profiles) are also needed for advertising and / or market research. Of course, this can be contradicted at any time.

                How we work with partners

                In some cases, your data is also processed with the help of third-party providers of various online services (please refer to our privacy policy in detail further below). However, this is exclusively regulated by data processing agreements and the processing is instruction-bound, so that we always keep the responsibility for the processing. Processors from a third country outside the European Economic Area only receive access to personal data if these third countries offer an appropriate level of data protection in connection with an adequacy decision by the EU Commission or if we have suitable guarantees with these service providers (so-called Standard Contractual Clauses in accordance with Art. 46 GDPR) or recognized Binding Corporate Rules in accordance with Art. 47 GDPR.

                Use of your data for other purposes

                In addition to the purposes already mentioned, we are also subject to legal requirements. These are:

                any request for information (and the related disclosure) to governmental authorities
                any request for information (and the related disclosure) to copyright holders
                for the misuse recognition of our provided services
                trouble-shooting or -avoidance
                Our Privacy Policy in detail

                General and Responsible Entity

                We are glad that you are interested in Outread. In order to provide you with our service, we need certain information about you (including personally identifiable information – information that identifies you personally). This Privacy Policy explains what information we collect about you for what purpose and what we use it for. It also explains what rights you have with regard to the data processing operations affecting you.

                Outread labs, Adelaide 5000, Australia (hereafter referred to as “Outread” or “we”) operates on the internet sites https://www.Outread.com and https://www.Outread.de as well as via the mobile application a platform for mobile learning (hereinafter “platform”).

                Responsible body is the natural or legal person who, alone or together with others, decides on the purposes and means of processing personal data (e.g. names, email addresses, etc.).

                Revocation of consent

                Many data processing operations are only possible with your express consent. You can revoke an existing consent at any time. An informal message by email to privacy@Outread.com is sufficient. The legality of the data processing carried out until the revocation remains unaffected by the revocation.

                Right to complain to the competent supervisory authority

                In the event of data protection violations, you, the person concerned, have the right of appeal to the competent supervisory authority. The competent supervisory authority for data protection issues is the state data protection officer of the federal state in which our company is based or in which you have your residence.

                SSL or TLS Encryption

                We use SSL or Internet security for security reasons and to protect the transmission of sensitive content, such as orders or requests you send to us. TLS encryption. An encrypted connection is indicated by the browser’s address bar switching from “http: //” to “https: //” and the lock icon in your browser bar. If SSL or TLS encryption is enabled, the data you submit to us can not be read by third parties.

                Information, Correction, Deletion, Blocking, Data Transferability

                You have the right at any time to request information about your personal data processed by us free of charge. In particular, you may request us to provide information about the processing purposes, the category of personal data, the categories of recipients to whom your data has been disclosed, the planned retention period, the right of rectification, deletion, limitation of processing or opposition, passing a right of appeal, the origin of their data, if not collected by us, and the existence of automated decision-making including profiling and, where appropriate, meaningful information about your details.

                You have the right to request the immediate correction of incorrect or incomplete personal data of you stored by us.

                You have the right to request the deletion of your personal data stored by us, except in cases where the processing of the data is required for the exercise of the right to freedom of expression and information, for the fulfillment of a legal obligation, for reasons of public interest or for the assertion, exercise or defense of legal claims.

                You have the right to demand the restriction of the processing of your personal data, as far as the accuracy of the data is disputed by you, the processing is unlawful, but you reject its deletion and we no longer need the data and you the data for the assertion, exercise or defense of legal claims or if you have objected to the processing in accordance with Art. 21 GDPR.

                You have the right to receive your personal information that you have provided to us in a structured, common and machine-readable format or to request that it is sent to another person in charge.

                Right to Object

                If your personal data is processed based on legitimate interests in accordance with Art. 6 para. 1 sentence 1 lit. f GDPR, you have the right to file an objection against the processing of your personal data in accordance with Art. 21 GDPR, provided that there are reasons for this arising from your particular situation or the objection is directed against direct mail. In the latter case, you have a general right to objection, which is implemented by us without specifying any particular situation.

                If you want to exercise your right to object, please send an email to privacy@Outread.com.

                Data Collection and Use

                Server Log Files

                Our provider of the platform automatically collects and stores information in so-called server log files, which your browser automatically transmits to us. These are browser type and browser version, operating system used, referrer URL, host name of the accessing computer, time of the server request and the IP address.

                The data is for data security and error analysis only. A merge of this data with other data sources will not be done.

                The basis for data processing is Art. 6 (1) lit. b GDPR, which allows the processing of data to fulfill a contract or pre-contractual measures. The server log files are automatically deleted after 2 weeks.

                Cookies and Cookiebot

                We use so-called cookies. Cookies do not harm your access device and do not contain viruses. Cookies serve to make our offer more user-friendly, effective and secure. Cookies are small text files that are stored on your access device and stored by your browser.

                Most of the cookies we use are so-called “session cookies”. They will be deleted automatically at the end of your visit. Other cookies remain stored on your device until you delete them. These cookies allow us to recognize your browser on your next visit.

                You can set your browser so that you are informed about the setting of cookies and allow cookies only in individual cases, exclude the acceptance of cookies for certain cases or in general, and enable the automatic deletion of cookies when closing the browser. Disabling cookies may limit the functionality of our website.

                Cookies which are required to carry out the electronic communication process or to provide certain functions which you wish to use (e.g. shopping basket function) are processed on the basis of Art. 6 (1) lit. f GDPR saved. We as website operators have a legitimate interest in the storage of cookies for the technically error-free and optimized provision of our services. If other cookies (e.g. cookies for the analysis of your surfing behavior) are stored, they will be treated separately in this privacy policy. We collect Cookies in the following categories:

                Necessary technical or functional cookies: Functional cookies help make our website usable by enabling basic functions like page navigation and access to secure areas of the website. The website cannot function without these cookies.
                Analytical cookies: These cookies collect information about how visitors use the website. We might also use analytics cookies to test new ads, pages, or features.
                Marketing cookies: These cookies are placed by third-party advertising platforms to deliver ads and track ad performance, enabling advertising networks to deliver ads that may be relevant to you.
                Cookie settings: You can change your cookie settings anytime using this Link.
                Cookiebot: We use services from Cookiebot. Cookiebot is operated by Cybot A / S, Havnegade 39, 1058 Copenhagen, Denmark (“Cookiebot”). Cookiebot informs the user about the use of cookies on the website and enables the user to make a decision about their use. If the user gives their consent to the use of cookies, the following data is automatically logged at Cookiebot:
                The anonymized IP number of the user
                Date and time of consent
                The URL of the website provider
                An anonymous, random and encrypted key
                The user’s approved cookies (as proof of consent)
                The encrypted key and the cookie status are stored on the user’s end device using a cookie in order to establish the corresponding cookie status when the page is called up in the future. This cookie is automatically deleted after 12 months. The legal basis here is Art. 1 Para. 1 lit. 1 f GDPR. The legitimate interest of the website operator is the user-friendliness of the website and the fulfillment of the legal requirements from the GDPR. You can find more information about Cookiebot in the Cookiebot privacy policy.

                Registration on this Website

                You can register on our platform to use our services. We only use the data entered for the purpose of using the respective offer for which you have registered. The mandatory information requested during registration, such as name and email address, must be provided, otherwise the registration can not be completed.

                For important changes such as the scope of the offer or in case of technical changes, we use the email address given at registration to inform you in this way.

                The processing of the data entered during registration takes place at your request and is required in accordance with Art. 6 para. 1 p. 1 lit. b GDPR in order to be able to comply with the user contract, including precontractual measures.

                The data collected during registration will be stored by us as long as you are registered for our services and will subsequently be deleted. Legal retention periods remain unaffected.

                Registration and Login with Auth0

                Instead of registering directly on our website, you can sign up using Single-Sign-On (SSO) with Auth0. Provider of this service is Auth0, Inc, 10800 NE 8th St, Suite 700 Bellevue, WA 98004, USA (“Auth0”).

                If you decide to register with Auth0 and click on the Sign Up button, your data required for registration will be transferred to the Auth0 servers, which can also be operated in the USA.

                The transferred data is mainly: Email addresses, hashed passwords, phone numbers and IP addresses.

                This information is used to set up, provision and personalize your account as part of the provision of a contractual service. The legal basis for this is your consent (Art. 6 Para. 1 S. 1 lit. a. GDPR), contract fulfillment and pre-contractual inquiries (Art. 6 Para. 1 S. 1 lit. b. GDPR) and legitimate interest (Art. 6 Par . 1 S. 1 lit. f. GDPR). Your access data for the SSO service, on the other hand, will never be saved by us. The data protection and terms of use of Auth0 apply to the registration and use of Auth0.

                We have entered into a so-called “Data Processing Agreement” with Auth0, in which we commit Auth0 to protect the data of our customers, to not disclose them to third parties and to comply with the provisions of the standard contractual clauses according to Art. 46 GDPR in the case of a transfer of personal data to the USA.

                Registration and Login with Facebook Connect

                Instead of registering directly on our website, you can sign up with Facebook Connect. Provider of this service is the Facebook Ireland Limited, 4 Grand Canal Square, Dublin 2, Ireland, Parent company: Facebook Inc, 1 Hacker Way, Menlo Park, CA 94025, USA (“Facebook”).

                If you decide to register with Facebook Connect and click on the “Sign Up with Facebook” button, you will automatically be redirected to the Facebook platform. There you can log in with your usage data. This links your Facebook profile to our website or services. This link gives us access to your data stored on Facebook. These are above all:

                Inventory data (e.g. names, addresses), contact details (e.g. e-mail, telephone numbers), event data (“event data” are data that can be transmitted by us to Facebook e.g. via Facebook pixels via apps or in other ways and relate to people or their actions; The data includes, for example, information about visits to websites, interactions with content, functions, installations of apps, purchases of products, etc .; the event Data is processed for the purpose of creating target groups for content and advertising information (custom audiences); event data does not contain the actual content (such as written comments), no login information and no contact information (i.e. no names, e-mail addresses). Event data will be deleted by Facebook after a maximum of two years).

                This information is used to set up, provision and personalize your account as part of the provision of a contractual service. The legal basis for this is your consent (Art. 6 Para. 1 S. 1 lit. a. GDPR), contract fulfillment and pre-contractual inquiries (Art. 6 Para. 1 S. 1 lit. b. GDPR) and legitimate interest (Art. 6 Par . 1 S. 1 lit. f. GDPR).

                Together with Facebook Ireland Ltd., we are jointly responsible for the collection or receipt as part of a transmission (but not further processing) of “event data” that Facebook collects using the Facebook single sign-on registration process that is carried out on our online offer or as part of a transmission for the following purposes: a) Display of content advertising information that corresponds to the presumed interests of the users; b) Delivery of commercial and transaction-related messages (e.g. addressing users via Facebook Messenger); c) Improving the delivery of advertisements and personalizing functions and content (e.g. improving the recognition of which content or advertising information presumably corresponds to the interests of the users). We have concluded a special agreement with Facebook (“”Controller Addendum””), which regulates in particular which security measures Facebook must observe and in which Facebook has agreed to fulfill the rights of the data subject (i.e. users can, for example, provide information or deletion requests directly to Facebook). Note: If Facebook provides us with measured values, analytics and reports (which are aggregated, i.e. they do not receive any information about individual users and are anonymous to us), then this processing does not take place within the framework of joint responsibility, but on the basis of an data processing addendum (“”data processing terms””), the “data security terms and with regards to processing in the USA on the basis of standard contractual clauses (“Facebook-EU data transfer addendum”). The rights of users (in particular to information, deletion, objection and complaint to the competent supervisory authority) are not restricted by the agreements with Facebook.

                For more information, see the Facebook Terms of Use and the Facebook Privacy Policy.. Facebook offers an objection option via this Opt-Out-Link.

                Register and Login with Google Connect

                Instead of a direct registration / login on our website, you can also register via Google. Provider of this service is Google Ireland Limited, Gordon House, Barrow Street, Dublin 4, Ireland, Parent company: Google LLC, 1600 Amphitheatre Parkway, Mountain View, California 94043 USA (“Google”).

                If you decide to register / login with Google and click the “Sign in with Google” button, you will automatically be redirected to Google’s platform. There you can log in with your usage data. This will link your Google profile to our website or services. This link gives us access to your data stored on Google. These are above all:

                First name | Surname | E-mail address | Username | Google Profile URL | Featured Image

                This information is used to set up, provision and personalize your accounts.

                For more information, see the Google Terms of Service and the Google Privacy Policy.

                Social Media

                Facebook Plugins

                On our pages plugins of the social network Facebook, provider Facebook Ireland Limited, 4 Grand Canal Square, Dublin 2, Ireland, Parent company: Facebook Inc, 1 Hacker Way, Menlo Park, CA 94025, USA (“Facebook”), are integrated. The Facebook plug-ins can be recognized by the Facebook logo or the “Like-Button” (“Like”) on our site. An overview of the Facebook plugins can be found here.

                When you visit our platform, a direct connection between your browser and the Facebook server is established via the plugin. Facebook receives the information that you have visited our site with your IP address. If you click on the Facebook “Like-Button” while you are logged in to your Facebook account, you can link the contents of our pages to your Facebook profile. This allows Facebook to associate your visit to our pages with your user account. We point out that we as the provider of the pages are not aware of the content of the data transmitted and their use by Facebook. If you do not want Facebook to associate visiting our pages with your Facebook user account, please log out of your Facebook user account. More information can be found in the Facebook Privacy Policy.

                Analysis Tools and Advertising

                Google

                For marketing optimization purposes, we send, if not disabled by the user in the system settings of its device, the Mobile Advertising ID, the hashed email address given during registration and the parameters specified in the section “Social Plugins” (such as IP address, browser and access device information) to Google Ireland Limited, Gordon House, Barrow Street, Dublin 4, Ireland, Parent company: Google LLC, 1600 Amphitheatre Parkway, Mountain View, California 94043 USA (“Google”). The data processing takes place on the basis of our legitimate interests (Art. 6 (1) lit. f GDPR) of analyzing user behavior and optimization of our website and our advertising. If you do not want us to collect the Mobile Advertising ID and send it to Google, you can find a manual for deactivation under the topic “Mobile Advertising ID”. We have entered into a so-called “Data Processing Agreement” with Google, in which we commit Google to protect the data of our customers, to not disclose them to third parties and to comply with the provisions of the standard contractual clauses according to Art. 46 GDPR in the case of a transfer of personal data to the USA. Further details to different Google services are mentioned below.

                Google AdSense

                Our website uses Google AdSense, a service for integrating advertisements. Provider is Google Ireland Limited, Gordon House, Barrow Street, Dublin 4, Ireland, Parent company: Google LLC, 1600 Amphitheatre Parkway, Mountain View, California 94043 USA (“Google”). Google AdSense uses so-called “cookies”, text files that are stored on your computer and that allow an analysis of the use of the website. Google AdSense also uses so-called web beacons (invisible graphics). These web beacons can be used to evaluate information such as visitor traffic on these pages. The information generated by cookies and web beacons on the use of this website (including your IP address) and the delivery of advertising formats are transmitted to and stored by Google on servers in the USA. The generated information may be shared by Google with Google affiliates. However, Google will not merge your IP address with other data you have stored.

                The storage of AdSense cookies is based on Art. 6 (1) lit. f GDPR. We have a legitimate interest in analyzing user behavior in order to optimize both our website and our advertising. You can prevent the installation of cookies by setting your browser accordingly; however, we point out that in this case you may not be able to fully use all features of this website.

                We have entered into a so-called “Data Processing Agreement” with Google, in which we commit Google to protect the data of our customers, to not disclose them to third parties and to comply with the provisions of the standard contractual clauses according to Art. 46 GDPR in the case of a transfer of personal data to the USA.

                Google AdWords und Google Conversion-Tracking

                This website uses Google AdWords. AdWords is an online advertising program of Google Ireland Limited, Gordon House, Barrow Street, Dublin 4, Ireland Parent company: Google LLC, 1600 Amphitheatre Parkway, Mountain View, California 94043 USA (“Google”). As part of Google AdWords, we use the so-called conversion tracking. When you click on an ad served by Google, a conversion tracking cookie is set. Cookies are small text files that the Internet browser stores on the user’s computer. These cookies lose their validity after 30 days and are not used for the personal identification of the users. If the user visits certain pages of this website and the cookie has not expired yet, Google and we can recognize that the user clicked on the ad and was redirected to this page.

                Each Google AdWords customer receives a different cookie. The cookies can not be tracked through the websites of advertisers. The information gathered using the conversion cookie is used to generate conversion statistics for AdWords advertisers who have opted for conversion tracking. Customers are told the total number of users who clicked on their ad and were redirected to a conversion tracking tag page. However, they do not receive information that personally identifies users. If you do not wish to participate in tracking, you can opt-out of this use by disabling the Google Conversion Tracking cookie from your Internet browser under User Preferences. You will not be included in the conversion tracking statistics.

                You can set your browser so that you are informed about the setting of cookies and cookies only on a case by case basis, the acceptance of cookies for certain cases or generally exclude and can activate the automatic deletion of cookies when closing the browser. Disabling cookies may limit the functionality of this website.

                The storage of “conversion cookies” is based on Art. 6 (1) lit. f GDPR. We have a legitimate interest in analyzing user behavior in order to optimize both our website and our advertising.

                More information about Google AdWords and Google Conversion Tracking can be found in the Google Privacy Policy. We have entered into a so-called “Data Processing Agreement” with Google, in which we commit Google to protect the data of our customers, to not disclose them to third parties and to comply with the provisions of the standard contractual clauses according to Art. 46 GDPR in the case of a transfer of personal data to the USA.

                Google Analytics

                Our sites use functions of the web analytics service Google Analytics for the purpose of needs-based design and continuous optimization. Provider is Google Ireland Limited, Gordon House, Barrow Street, Dublin 4, Irland, Parent company: Google LLC, 1600 Amphitheatre Parkway, Mountain View, California 94043 USA (“Google”). Google Analytics uses so-called “cookies”. These are text files that are stored on your computer and that allow an analysis of the use of the website by you. The information generated by the cookie about your use of this website is usually transmitted to a Google server in the United States and stored there.

                Google Analytics cookies are stored on the basis of Art. 6 (1) lit. f GDPR. We have a legitimate interest in analyzing user behavior in order to optimize both our website and our advertising.

                We have entered into a so-called “Data Processing Agreement” with Google, in which we commit Google to protect the data of our customers, to not disclose them to third parties and to comply with the provisions of the standard contractual clauses according to Art. 46 GDPR in the case of a transfer of personal data to the USA.

                Here’re the details in regard to how we’re using Google Analytics:

                IP Anonymization: We have activated the function IP anonymization on this website. As a result, your IP address will be truncated by Google within member states of the European Union or other parties to the Agreement on the European Economic Area prior to transmission to the United States. Only in exceptional cases will the full IP address be sent to a Google server in the US and shortened there. On behalf of the operator of this website, Google will use this information to evaluate your use of the website, to compile reports on website activity and to provide other services related to website activity and internet usage to the website operator. The IP address provided by Google Analytics as part of Google Analytics will not be merged with other Google data.
                Browser Plugin: ou can prevent the storage of cookies by setting your browser software accordingly; however, we point out that in this case you may not be able to use all the features of this website in full. In addition, you may prevent the collection by Google of the data generated by the cookie and related to your use of the website (including your IP address) as well as the processing of this data by Google by downloading and installing the browser plug-in available under this link.
                Opposition to Data Collection: With the help of this browser add-on for disabling Google Analytics JavaScript, you can prevent Google Analytics from using your data during future visits to this website. For more information about how to handle user data on Google Analytics, see the Google Privacy Policy.
                Commissioned Data Processing: We have entered into a so-called “Data Processing Agreement” with Google, in which we commit Google to protect the data of our customers, to not disclose them to third parties and to comply with the provisions of the standard contractual clauses according to Art. 46 GDPR in the case of a transfer of personal data to the USA and fully implement the strict requirements of the German data protection authorities when using Google Analytics.
                Demographic Data: his website uses the “demographics” feature of Google Analytics. As a result, reports can be produced that contain statements on the age, gender and interests of the site visitors. This data comes from interest-based advertising from Google and third-party visitor data. This data can not be assigned to a specific person. You can disable this feature at any time through the Ads settings in your Google account, or generally prohibit Google Analytics from collecting your data as outlined in the “Opposition to Data Collection” section.
                Google Analytics Remarketing

                Our websites use the features of Google Analytics Remarketing in conjunction with the cross-device features of Google AdWords and Google DoubleClick. Provider is Google Ireland Limited, Gordon House, Barrow Street, Dublin 4, Irland, Parent company: Google LLC, 1600 Amphitheatre Parkway, Mountain View, California 94043 USA (“Google”). This feature allows you to link the advertising audiences created with Google Analytics Remarketing to the cross-device capabilities of Google AdWords and Google DoubleClick. In this way, interest-based, personalized advertising messages that have been adapted to you based on your previous usage and surfing behavior on one device (i.e. mobile phone) can also be displayed on another of your devices (i.e. tablet or PC).

                Once you have given your consent, Google will link your web and app browsing history to your Google account for this purpose. That way, the same personalized advertising messages can appear on any device you sign in to with your Google account. To support this feature, Google Analytics collects Google-authenticated IDs of users who are temporarily linked to our Google Analytics data to define and create audiences for cross-device ad promotion. You can permanently opt out of cross-device remarketing / targeting by disabling personalized ads in your Google account; to do so follow this link.

                The aggregation of the collected data in your Google account is based solely on your consent, which you can give or revoke on Google (Art.6 Abs.1 a. GDPR). For data collection operations that are not merged into your Google account (e.g., because you do not have a Google account or have objected to the merge), the collection of the data is based on Art. 6 (1) lit. f GDPR. The legitimate interest arises from the fact that the website operator has an interest in the anonymous analysis of the website visitors for advertising purposes.

                For more information and privacy policy, see the Google Privacy Policy. We have entered into a so-called “Data Processing Agreement” with Google, in which we commit Google to protect the data of our customers, to not disclose them to third parties and to comply with the provisions of the standard contractual clauses according to Art. 46 GDPR in the case of a transfer of personal data to the USA.

                Facebook

                For marketing optimization purposes, we send, if not disabled by the user in the system settings of its device, the Mobile Advertising ID, the hashed email address given during registration and the parameters specified in the section “Social Plugins” (such as IP address, browser and access device information) to Facebook Ireland Limited, 4 Grand Canal Square, Dublin 2, Ireland, Parent company: Facebook Inc, 1 Hacker Way, Menlo Park, CA 94025, USA (“Facebook”). The data processing takes place on the basis of our legitimate interests (Art. 6 (1) lit. f GDPR) of analyzing user behavior and optimization of our website and our advertising. If you do not want us to collect the Mobile Advertising ID and send it to Facebook, you can find a manual for deactivation under the topic “Mobile Advertising ID”.

                We have concluded a special agreement with Facebook (“”Controller Addendum””), which regulates in particular which security measures Facebook must observe and in which Facebook has agreed to fulfill the rights of the data subject (i.e. users can, for example, provide information or deletion requests directly to Facebook). Note: If Facebook provides us with measured values, analytics and reports (which are aggregated, i.e. they do not receive any information about individual users and are anonymous to us), then this processing does not take place within the framework of joint responsibility, but on the basis of an data processing addendum (“”data processing terms””), the “data security terms and with regards to processing in the USA on the basis of standard contractual clauses (“Facebook-EU data transfer addendum”). The rights of users (in particular to information, deletion, objection and complaint to the competent supervisory authority) are not restricted by the agreements with Facebook.

                You will find more information on the protection of your privacy in the Facebook Privacy Policy.

                Hotjar

                We use Hotjar, a web analytics service of Hotjar Ltd., St. Julian’s Business Center, Elia Zammit Street 3, St Julian’s STJ 1000 (Malta) (“Hotjar”). With Hotjar, interactions of randomly selected, individual visitors to our website are recorded anonymously. Logs of mouse movements and clicks, for example, are created from the recordings with the aim of making Outread even more intuitive and user-friendly. Hotjar also uses “cookies”, text files that are stored on your computer. In order to exclude a personal relationship, IP addresses are stored only anonymously and information is processed only anonymously. It also provides information, including about your operating system | Browser | geographical origin (country), evaluated for statistical purposes. This information is not personal and will not be disclosed to third parties by us or by Hotjar.

                If you do not want your data to be tracked by Hotjar, just follow this guide. For more information about Hotjar, see the Hotjar Privacy Policy and Terms of Use.

                We have entered into a so-called “Data Processing Agreement” with Hotjar, in which we commit Hotjar to protect the data of our customers and not to disclose them to third parties.

                Pinterest

                We use services of the short message service Pinterest. Pinterest is operated by Pinterest Europe Limited, 2nd Floor, Palmerston House, Fenian Street, Dublin 2, Parent company: Pinterest Inc., 651 Brannan Street, San Francisco, CA 94103 (USA) (“Pinterest”). Pinterest allows us to use target group-based advertising, re-targeting and conversion measurements for online advertising via the so-called visitor interaction pixel. Here, offers for specific target groups are played out based on a selection of general criteria, such as demographic characteristics, regions or interests. Pinterest also allows us to target ads based on your recent page views. For example, you may see ads and notices about our offers and content if you are interested in specific services, information, or offers at the online trade show. Here only general and technical information on accessed pages are evaluated. If you generally do not want to be tracked by Pinterest, you can prevent the storage of cookies at any time by your browser settings, which could limit functionality.

                For more information about Pinterest, please refer to the Pinterest Privacy Policy.

                The storage of “conversion cookies” is based on Art. 6 (1) lit. f GDPR. We have a legitimate interest in analyzing user behavior in order to optimize both our website and our advertising.

                Quora

                We use services of the short message service Quora. Quora is operated by Quora, Inc., 650 Castro Street, Suite 450, Mountain View, CA 94041 (“Quora”). Quora allows us to use target group-based advertising, re-targeting and conversion measurements for online advertising via the so-called visitor interaction pixel. Here, offers for specific target groups are played out based on a selection of general criteria, such as demographic characteristics, regions or interests. Quora also allows us to target ads based on your recent page views. For example, you may see ads and notices about our offers and content if you are interested in specific services, information, or offers at the online trade show. Here only general and technical information on accessed pages are evaluated. If you generally do not want to be tracked by Quora, you can prevent the storage of cookies at any time by your browser settings, which could limit functionality.

                For more information about Quora, please refer to the Quora Privacy Policy.

                The storage of “conversion cookies” and the data processing and the data processing is based on Art. 6 (1) lit. f GDPR. We have a legitimate interest in analyzing user behavior in order to optimize both our website and our advertising.

                Newsletter

                Newsletter Data

                If you would like to receive the newsletter offered on the website, we need an email address from you, as well as information that allows us to verify that you are the owner of the email address provided and that you agree to receive the newsletter. Further data are not collected or only on a voluntary basis.

                We use this data exclusively for the delivery of the requested information and do not pass it on to third parties. The processing of the data entered into the newsletter application form is based exclusively on your consent (Art.6 (1) (a) GDPR). Of course, you can revoke your consent to the storage of the data, the email address and its use for sending the newsletter at any time, for example via the “unsubscribe” link in the newsletter. The legality of the already completed data processing operations remains unaffected by the revocation.

                The data deposited with us for the purpose of obtaining the newsletter will be saved by us from the newsletter until your cancellation and deleted after the cancellation of the newsletter. Data stored for other purposes with us (e.g. email addresses for logging on to our services) remain unaffected.

                Payment Information

                When you make payments for our services, no credit or debit card information is stored on our servers. This information is stored by our third party PCI-compliant payment processing companies. We work with the following providers:

                Recurly Inc., 400 Alabama Street Suite 202. San Francisco, CA 94110 (USA)
                Stripe Inc., 185 Berry Street, Suite 550, San Francisco, CA 94107 (USA)
                All credit and debit card transactions occur between the computer from which the transaction originates and our payment processor. When you use one of our trial phases or subscriptions or you purchase something through the service, credit card information and other financial information we need to process the payment is collected and stored with a payment service provider. We also collect certain limited information, such as your zip code, mobile phone number and details of your transaction history. In addition, these payment service providers usually provide us with very limited information about you, such as the unique “token”, which enables you to make further purchases using the data stored by the service providers, as well as your card type, expiration date and last four digits of the number.

                We have entered into separate so-called “Data Processing Agreements” with both Recurly and Stripe, in which we commit Recurly and Stripe to protect the data of our customers, to not disclose them to third parties and to comply with the provisions of the standard contractual clauses according to Art. 46 GDPR in the case of a transfer of personal data to the USA.

                Request Refunds

                If you purchased a subscription via iTunes and consider that a payment for one of our products has been wrongly debited to your account, you may, as an iOS user, request a refund directly through your user account within the iOS app, which will then be processed directly by Apple (Apple Inc., One Apple Park Way, CA Cupertino 95014, USA, “Apple”) through the Appstore. In order to enable Apple to make a decision about the legitimacy of your refund request, we may transfer data about your usage history to Apple. You agree to this data transfer by requesting a refund in your account. The legal basis for the transfer is your consent (Art. 6 para. 1 p. 1 lit. a. GDPR) as well as our legitimate interest in making the refund process as convenient as possible (Art. 6 para. 1 p. 1 lit. f. GDPR).

                Hosting & Analysis

                Amazon Web Services

                We use the following services from Amazon Web Services, Inc, Montgomery Street 420, San Francisco CA 94163, USA (“Amazon Web Services” or “AWS”):

                AWS Data Center

                This AWS service helps us to host our backend applications. The AWS Data Center stores user data such as email, address, first name, last name, interaction data. The data processing takes place on the basis of our legitimate interests (Art. 6 (1) lit. f GDPR) for the technically error-free and optimized provision of our services.

                Data Virtuality

                We use the Pipes service of Data Virtuality GmbH, Katharinenstrasse 15, 04109 Leipzig, to transfer data that we store with external partners into our Business Intelligence Tool. The data processing takes place on the basis of our legitimate interests (Art. 6 (1) lit. f GDPR) of analyzing user behavior and optimization of our website and our advertising. Here user data such as email, address, first name, last name, interaction data are transferred via interfaces.

                For more information about data processing by Data Virtuality, see the Data Virtuality Privacy Policy. We have concluded a so-called “Data Processing Agreement” with Data Virtuality, in which we oblige Data Virtuality to protect the data of our customers and not to pass them on to third parties.

                Google Cloud Platform

                We use services of the Google Cloud Platform, a developer platform operated by Google Ireland Limited, Gordon House, Barrow Street, Dublin 4, Irland, Parent company: Google LLC, 1600 Amphitheatre Parkway, Mountain View, California 94043 USA (“Google”) to find bugs in the Outread app by using the service Firebase Crashlytics. The data processing takes place on the basis of our legitimate interests (Art. 6 (1) lit. f GDPR) for the technically error-free and optimized provision of our services. Google Cloud Platform / Firebase Crashlytics receives user data for error analysis such as Mobile ad IDs, installation UUID (universally unique ID), Android IDs and IP addresses.

                For more information about Firebase Crashlytics’ data processing via the Google Cloud Platform, see the Google Privacy Policy. GWe have entered into a so-called “Data Processing Agreement” with Google, operator of the Google Cloud Platform and the Firebase Crashlytics service, in which we commit Google to protect the data of our customers, to not disclose them to third parties and to comply with the provisions of the standard contractual clauses according to Art. 46 GDPR in the case of a transfer of personal data to the USA.

                YouTube

                On our website and based on our legitimate interests under Art. 6 para. 1 sentence 1 lit. f GDPR to display video content we use components (videos) of the company YouTube, LLC 901 Cherry Ave., 94066 San Bruno, CA, (“YouTube”), a company of Google Ireland Limited, Gordon House, Barrow Street, Dublin 4, Ireland, Parent company: Google LLC, 1600 Amphitheatre Parkway, Mountain View, California 94043 USA (“Google”). Here we use the option provided by YouTube of “extended privacy mode”.

                When you visit a page that has an embedded video, it will connect to the YouTube servers and display the content by notifying your browser on the website.

                According to information provided by YouTube, in the “extended privacy mode” only your data – in particular, which of our websites you have visited and device-specific information including the IP address – is transmitted to the YouTube server in the US when you watch the video. By clicking on the video you confirm this transmission. If you do not want the transmission, stop playing the video.

                If you are logged in to YouTube at the same time, this information will be associated with your Membership account on YouTube. You can prevent this by logging out of your member account before visiting our website.

                For more information about data protection related to YouTube, please see the Google Privacy Policy Google. We have entered into a so-called “Data Processing Agreement” with Google, in which we commit Google to protect the data of our customers, to not disclose them to third parties and to comply with the provisions of the standard contractual clauses according to Art. 46 GDPR in the case of a transfer of personal data to the USA.
                """)
                .font(.poppins(weight: .regular, size: 16))
                .foregroundColor(.white)
                .padding(.horizontal, 15)
            }
        }
        .background(Color.COLOR_141_D_2_A)
        .navigationBarBackButtonHidden()
    }
    
    //MARK: - Functions
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
