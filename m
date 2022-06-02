Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B1553B534
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 10:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiFBIdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 04:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiFBIc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:32:59 -0400
Received: from mx1.uni-rostock.de (mx1.uni-rostock.de [139.30.22.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6430913AF00
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 01:32:56 -0700 (PDT)
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1654158774; bh=XBBnpgFMtcUOaA+6+v61C8ED5BLwisu5IEPMNRcdngU=; h=
 "Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id"; 
 a=ed25519-sha256; b=
 5rC/5ZrVFdh4NoAn9x2kHPruhI8XsYNPCKRkDVAaTK7aU+2pQxDQrIBfhOwmHnccTQadq+4IG1mbuhL8ep7/Dg==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1654158774; bh=XBBnpgFMtcUOaA+6+v61C8ED5BLwisu5IEPMNRcdngU=; h=
 "Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id"; 
 a=rsa-sha256; b=
 cw2lUVxVNI9HwowSiFTOmV/kcqeyTuqQ4SG2HaxUO0jH/wg23E17Vu/mnoux26NN+D/tgsGJjZjpjPfPbCyJDMFOMhkQVnrMDOalTO6zH8av+Ux+BF2z1cwulX6nM1sSGEZ77/P7i6tQ3sdyPS1d5ou89uP+dGd7CizlEeBqVSI=
Received: from 139.30.22.81 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Thu, 02 Jun 2022 08:32:53 GMT
Received: from [192.168.0.222] (91.59.50.121) by email1.uni-rostock.de
 (139.30.22.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Thu, 2 Jun 2022
 10:32:53 +0200
Message-ID: <679ce219-d6f8-88a3-2aef-9de506b624ad@uni-rostock.de>
Date:   Thu, 2 Jun 2022 10:32:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Subject: Re: [PATCH] um: read multiple msg from virtio slave request fd
To:     Johannes Berg <johannes@sipsolutions.net>, <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
CC:     <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220601153722.181427-1-benjamin.beichler@uni-rostock.de>
 <360edf352f888f4607e0411df8a994aa087e9db4.camel@sipsolutions.net>
Content-Language: de-DE
Organization: =?UTF-8?Q?Universit=c3=a4t_Rostock?=
In-Reply-To: <360edf352f888f4607e0411df8a994aa087e9db4.camel@sipsolutions.net>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
        micalg=sha-256; boundary="------------ms080608090402030207000403"
X-Originating-IP: [91.59.50.121]
X-ClientProxiedBy: EMAIL2.uni-rostock.de (139.30.22.82) To
 email1.uni-rostock.de (139.30.22.81)
X-TM-SNTS-SMTP: 37E14481D2145061BB0578EBD0E9FF9D3CD5DDE7E74230D869DB2F95FC695A772002:8
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------ms080608090402030207000403
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

Am 01.06.2022 um 19:13 schrieb Johannes Berg:
> On Wed, 2022-06-01 at 15:37 +0000, Benjamin Beichler wrote:
>
> Hmm. How did you run into this=3F Why would a device send many messages
> and not wait for ACK, but the kernel side actually waits for ACK=3F What
> would the use case for that be=3F Seems a bit odd, if both wait for ACK
> there shouldn't be an issue=3F
>
> Anyway, I guess I don't mind fixing this regardless of whether I see a
> use case where it could happen :-)

Here is my (admittedly maybe odd) case:

I want to use hwsim over virtio with UML but without time travel (as a 
precursor for a later version with TT)

I modified wmediumd to strip out the scheduler dependency and wrote a 
very simple simulation, which simply forwards all frames to all radios. 
Furthermore, I use the usfstl "loop" as main driver to poll all fds 
without time travel. This leads to the situation, that when a msg is put 
on the RX-ring of an uml instance, which also sent concurrently a kick 
(e.g., also trying to send a frame), this creates a deadlock. In the 
original wmediumd this was handled by kind of a hack, calling the loop 
implementation to answer the kick, before sending out a call msg. I need 
to rip out this workaround, because without the usfstl scheduler, it 
created a deep recursion of the loop implementation with additional 
problems.

Nonetheless, even if this would be kind of an optimization: it is 
feasible to wait for the ACK asynchronously, as long as it arrives in 
the same point of simulation time (or as you called it calender). For 
many uml-instances, which could easily run in parallel, this allows an 
easier implementation (at least in my planning :-) ). Of course, it 
would be hard to distinguish, which call-request was acked, but at the 
end wmediumd (and I also plan to do so) simply aborts when the ack is 
negative, so the actual corresponding call is not that important to know.

>
> This code changed a bit, you should rebase onto the uml tree's for-next
> branch.
My bad, I was not expecting someone to change something it that corner 
of the kernel, I only used the latest master and not the next. I will 
redo the patch with ease.
>
>> +=09while (1) {
>> +=09=09if (vhost=5Fuser=5Frecv=5Freq(vu=5Fdev, &msg.msg,
>> +=09=09=09=09=09sizeof(msg.msg.payload)
>> +=09=09=09=09=09+ sizeof(msg.extra=5Fpayload)))
> prefer to keep the + on the previous line.
>
It slightly hits the 80 column restriction, but I would also prefer not 
to break. :-D
> That said, my attempt at rebasing this made it all fail completely,
> maybe you have better luck :)
>
> johannes
>
kind regards

Benjamin

-- 
M.Sc. Benjamin Beichler

Universit=C3=A4t Rostock, Fakult=C3=A4t f=C3=BCr Informatik und Elektrotechnik
Institut f=C3=BCr Angewandte Mikroelektronik und Datentechnik

University of Rostock, Department of CS and EE
Institute of Applied Microelectronics and CE

Richard-Wagner-Stra=C3=9Fe 31
18119 Rostock
Deutschland/Germany

phone: +49 (0) 381 498 - 7278
email:Benjamin.Beichler@uni-rostock.de
www:http://www.imd.uni-rostock.de/

--------------ms080608090402030207000403
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EKcwggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWsMIIElKADAgECAgcbY7rQHiw9MA0GCSqGSIb3DQEBCwUAMIGVMQswCQYD
VQQGEwJERTFFMEMGA1UEChM8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRzY2hl
biBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLEwdERk4tUEtJMS0wKwYDVQQDEyRE
Rk4tVmVyZWluIENlcnRpZmljYXRpb24gQXV0aG9yaXR5IDIwHhcNMTYwNTI0MTEzODQwWhcN
MzEwMjIyMjM1OTU5WjCBjTELMAkGA1UEBhMCREUxRTBDBgNVBAoMPFZlcmVpbiB6dXIgRm9l
cmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5nc25ldHplcyBlLiBWLjEQMA4GA1UE
CwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9iYWwgSXNzdWluZyBDQTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJ07eRxH3h+Gy8Zp1xCeOdfZojDbchwFfylf
S2jxrRnWTOFrG7ELf6Gr4HuLi9gtzm6IOhDuV+UefwRRNuu6cG1joL6WLkDh0YNMZj0cZGnl
m6Stcq5oOVGHecwX064vXWNxSzl660Knl5BpBb+Q/6RAcL0D57+eGIgfn5mITQ5HjUhfZZkQ
0tkqSe3BuS0dnxLLFdM/fx5ULzquk1enfnjK1UriGuXtQX1TX8izKvWKMKztFwUkP7agCwf9
TRqaA1KgNpzeJIdl5Of6x5ZzJBTN0OgbaJ4YWa52fvfRCng8h0uwN89Tyjo4EPPLR22MZD08
WkVKusqAfLjz56dMTM0CAwEAAaOCAgUwggIBMBIGA1UdEwEB/wQIMAYBAf8CAQEwDgYDVR0P
AQH/BAQDAgEGMCkGA1UdIAQiMCAwDQYLKwYBBAGBrSGCLB4wDwYNKwYBBAGBrSGCLAEBBDAd
BgNVHQ4EFgQUazqYi/nyU4na4K2yMh4JH+iqO3QwHwYDVR0jBBgwFoAUk+PYMiba1fFKpZFK
4OpL4qIMz+EwgY8GA1UdHwSBhzCBhDBAoD6gPIY6aHR0cDovL2NkcDEucGNhLmRmbi5kZS9n
bG9iYWwtcm9vdC1nMi1jYS9wdWIvY3JsL2NhY3JsLmNybDBAoD6gPIY6aHR0cDovL2NkcDIu
cGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1jYS9wdWIvY3JsL2NhY3JsLmNybDCB3QYIKwYB
BQUHAQEEgdAwgc0wMwYIKwYBBQUHMAGGJ2h0dHA6Ly9vY3NwLnBjYS5kZm4uZGUvT0NTUC1T
ZXJ2ZXIvT0NTUDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDEucGNhLmRmbi5kZS9nbG9iYWwt
cm9vdC1nMi1jYS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwSgYIKwYBBQUHMAKGPmh0dHA6Ly9j
ZHAyLnBjYS5kZm4uZGUvZ2xvYmFsLXJvb3QtZzItY2EvcHViL2NhY2VydC9jYWNlcnQuY3J0
MA0GCSqGSIb3DQEBCwUAA4IBAQCBeEWkTqR/DlXwCbFqPnjMaDWpHPOVnj/z+N9rOHeJLI21
rT7H8pTNoAauusyosa0zCLYkhmI2THhuUPDVbmCNT1IxQ5dGdfBi5G5mUcFCMWdQ5UnnOR7L
n8qGSN4IFP8VSytmm6A4nwDO/afr0X9XLchMX9wQEZc+lgQCXISoKTlslPwQkgZ7nu7YRrQb
tQMMONncsKk/cQYLsgMHM8KNSGMlJTx6e1du94oFOO+4oK4v9NsH1VuEGMGpuEvObJAaguS5
Pfp38dIfMwK/U+d2+dwmJUFvL6Yb+qQTkPp8ftkLYF3sv8pBoGH7EUkp2KgtdRXYShjqFu9V
NCIaE40GMIIF3TCCBMWgAwIBAgIMJLUFOr7DT1PAbUHrMA0GCSqGSIb3DQEBCwUAMIGNMQsw
CQYDVQQGEwJERTFFMEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRz
Y2hlbiBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUwIwYDVQQD
DBxERk4tVmVyZWluIEdsb2JhbCBJc3N1aW5nIENBMB4XDTIxMDUwNzE4MzIxMloXDTI0MDUw
NjE4MzIxMlowbjELMAkGA1UEBhMCREUxHTAbBgNVBAoMFFVuaXZlcnNpdGFldCBSb3N0b2Nr
MREwDwYDVQQEDAhCZWljaGxlcjERMA8GA1UEKgwIQmVuamFtaW4xGjAYBgNVBAMMEUJlbmph
bWluIEJlaWNobGVyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2b8u90iXRBjH
yBjGxC1OB7LXQfzdDYQ7JSdKvmpmyJKFuljDEIy5yYzjRHee0+Kf5DhrSgshWuvYAD1sIqQF
WlM38YTJRtwq9NF6yCdZQgxwaR8qUplUw72d/PCqD+KjFyj8scb32EOclVXY9UpEYeGp1BnG
66o9Oewbk4rdHqeYDt/9VDPZOmi5YYtXUfwITZ/A6LpgGYf+NDQHRWcmG5thbvcXVYvSOwrm
vZnf8ZW4GbMsTorXWKFqx3gntf5VmY/xZ7XH4mE1V9gtNAo5XaTpj9g3ncJel1jEMtii1DeH
/tnP5ICo6GabZhyUfRo0vYGQhBGYqRm5vMowdqJ38wIDAQABo4ICWTCCAlUwPgYDVR0gBDcw
NTAPBg0rBgEEAYGtIYIsAQEEMBAGDisGAQQBga0hgiwBAQQIMBAGDisGAQQBga0hgiwCAQQI
MAkGA1UdEwQCMAAwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDAdBgNVHQ4EFgQUVUQ/tNKbRqzbUgK5NMo8iU5mwfswHwYDVR0jBBgwFoAUazqYi/ny
U4na4K2yMh4JH+iqO3QwKwYDVR0RBCQwIoEgQmVuamFtaW4uQmVpY2hsZXJAdW5pLXJvc3Rv
Y2suZGUwgY0GA1UdHwSBhTCBgjA/oD2gO4Y5aHR0cDovL2NkcDEucGNhLmRmbi5kZS9kZm4t
Y2EtZ2xvYmFsLWcyL3B1Yi9jcmwvY2FjcmwuY3JsMD+gPaA7hjlodHRwOi8vY2RwMi5wY2Eu
ZGZuLmRlL2Rmbi1jYS1nbG9iYWwtZzIvcHViL2NybC9jYWNybC5jcmwwgdsGCCsGAQUFBwEB
BIHOMIHLMDMGCCsGAQUFBzABhidodHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVy
L09DU1AwSQYIKwYBBQUHMAKGPWh0dHA6Ly9jZHAxLnBjYS5kZm4uZGUvZGZuLWNhLWdsb2Jh
bC1nMi9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwSQYIKwYBBQUHMAKGPWh0dHA6Ly9jZHAyLnBj
YS5kZm4uZGUvZGZuLWNhLWdsb2JhbC1nMi9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZI
hvcNAQELBQADggEBACOufP2NVgvUwvjvP2WPeIHDEVtJ/+s/Mj0LWp5soBW7NigeBcLIuEk0
2SCxCrfhn2KP9UtQbVecIbJ1swZDyLvhth/fFarUy0oVjkljW3C9v5Ahsl+XGt0vuykJjyz5
KDlioNEAG3aMrfeWA/wAMJLDZ62xGHJZR94PgiFtyMpuxfMHy0INKPaxLjS6xDESL8ecqHTq
Q53DDAPudkZg7aUllBEufBk4aS3mBO1Gl2kOXR/1om14+7fKMxiQCbpaPiJH9VA0txBJfnfk
KeFTOAf9OdtZ77WWZTEA9JLLrcG9l44WJt7DM5Ui38NC/ZBprX4IVDhOdoIgv5uWUVTHVIwx
ggQLMIIEBwIBATCBnjCBjTELMAkGA1UEBhMCREUxRTBDBgNVBAoMPFZlcmVpbiB6dXIgRm9l
cmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5nc25ldHplcyBlLiBWLjEQMA4GA1UE
CwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9iYWwgSXNzdWluZyBDQQIMJLUF
Or7DT1PAbUHrMA0GCWCGSAFlAwQCAQUAoIICPTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA2MDIwODMyNThaMC8GCSqGSIb3DQEJBDEiBCCfB90s2qMc
7YMO2NM4fzGg3ljRd40c8wNne8e7hvPsnjBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQB
KjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMC
AgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGvBgkrBgEEAYI3EAQxgaEwgZ4wgY0xCzAJ
BgNVBAYTAkRFMUUwQwYDVQQKDDxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNj
aGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsMB0RGTi1QS0kxJTAjBgNVBAMM
HERGTi1WZXJlaW4gR2xvYmFsIElzc3VpbmcgQ0ECDCS1BTq+w09TwG1B6zCBsQYLKoZIhvcN
AQkQAgsxgaGggZ4wgY0xCzAJBgNVBAYTAkRFMUUwQwYDVQQKDDxWZXJlaW4genVyIEZvZXJk
ZXJ1bmcgZWluZXMgRGV1dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsM
B0RGTi1QS0kxJTAjBgNVBAMMHERGTi1WZXJlaW4gR2xvYmFsIElzc3VpbmcgQ0ECDCS1BTq+
w09TwG1B6zANBgkqhkiG9w0BAQEFAASCAQBt3Pip45uVG6DzqwgqBxdn9aRDx8EowmnpbWqb
rKJCseYK3ae1UZgjBpfBMphVcUVvke9yI1REw7dMr2oxjWS0tvZlikBKjrGwo/dWD+0P/Nh5
pzj6nXYSlq+YrawdQS95fRmREav19mVCdXZoB+pzy/3uwW2rzzcqqdIIK+s9hFtpActKPhRG
bqBYLXG2SHe55/Mz0q/X9ZO04zMZld1u3tq5Q6Sp6FIgZ/yxQJXvrj/ljPqvzdSJGviO87c/
Pvq3++jRyQcxQ+PcrmWK11msySKkpgp+aMB3/J+0NPgpNgzAW6FdRYnbVhtjYstM4dYidml/
SBuDtdz7DXLYjSzaAAAAAAAA
--------------ms080608090402030207000403--

