Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F33A583EBE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238341AbiG1MYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbiG1MYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:24:48 -0400
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1A76BD61;
        Thu, 28 Jul 2022 05:24:45 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id XLB00042;
        Thu, 28 Jul 2022 20:24:42 +0800
Received: from Jtjnmail201613.home.langchao.com (10.100.2.13) by
 Jtjnmail201615.home.langchao.com (10.100.2.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Thu, 28 Jul 2022 20:24:41 +0800
Received: from Jtjnmail201613.home.langchao.com ([fe80::b8bf:393:bebe:1197])
 by Jtjnmail201613.home.langchao.com ([fe80::b8bf:393:bebe:1197%12]) with mapi
 id 15.01.2507.009; Thu, 28 Jul 2022 20:24:41 +0800
From:   =?utf-8?B?QW5keSBHdW8gKOmDreWNq+aWjCk=?= <guoweibin@inspur.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "b-liu@ti.com" <b-liu@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?UkU6IOetlOWkjTogW3ZnZXIua2VybmVsLm9yZ+S7o+WPkV1SZTogW1BBVENI?=
 =?utf-8?B?IHYyXSB1c2I6IG11c2I6IEZpeCBtdXNiX2dhZGdldC5jIHJ4c3RhdGUgbWF5?=
 =?utf-8?Q?_cause_request->buf_overflow_problems?=
Thread-Topic: =?utf-8?B?562U5aSNOiBbdmdlci5rZXJuZWwub3Jn5Luj5Y+RXVJlOiBbUEFUQ0ggdjJd?=
 =?utf-8?B?IHVzYjogbXVzYjogRml4IG11c2JfZ2FkZ2V0LmMgcnhzdGF0ZSBtYXkgY2F1?=
 =?utf-8?Q?se_request->buf_overflow_problems?=
Thread-Index: AdihlK58/c/eW9hwTTW0SyWnHPS6Pf//hjMA//94hRCAAfBDgP//HpSA
Date:   Thu, 28 Jul 2022 12:24:41 +0000
Message-ID: <7ab29bb9ed094ee593ebcf2e351665dd@inspur.com>
References: <28d16ec3ed25603cdda2c5fb3fbf1470@sslemail.net>
 <YuEElC563HN5ldMu@kroah.com> <2c234d13d7274763b0102b83ce65b8ff@inspur.com>
 <YuIzOeJZ7YKe4KDZ@kroah.com>
In-Reply-To: <YuIzOeJZ7YKe4KDZ@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.180.162.69]
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
        micalg=SHA1; boundary="----=_NextPart_000_0203_01D8A2C0.10078B20"
MIME-Version: 1.0
tUid:   20227282024422d4ffad0d3e43ad8f4512b35f066eb3e
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_000_0203_01D8A2C0.10078B20
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I'm sorroy,
I use Enterprise mailbox doesn't work very well.
I will send this patch through another mailbox.

Thanks

guoweibin

-----Original Message-----
From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>=20
Sent: Thursday, July 28, 2022 2:57 PM
To: Andy Guo (=E9=83=AD=E5=8D=AB=E6=96=8C) <guoweibin@inspur.com>
Cc: b-liu@ti.com; linux-usb@vger.kernel.org; =
linux-kernel@vger.kernel.org
Subject: Re: =E7=AD=94=E5=A4=8D: [vger.kernel.org=E4=BB=A3=E5=8F=91]Re: =
[PATCH v2] usb: musb: Fix musb_gadget.c rxstate may cause request->buf =
overflow problems

On Thu, Jul 28, 2022 at 01:14:17AM +0000, Andy Guo =
(=E9=83=AD=E5=8D=AB=E6=96=8C) wrote:

As can be seen in the archives:
	=
https://lore.kernel.org/all/2c234d13d7274763b0102b83ce65b8ff@inspur.com/
this message could not be decoded, sorry.

Please resend in plain text format.

thanks,

greg k-h


------=_NextPart_000_0203_01D8A2C0.10078B20
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIHYjCCB14w
ggZGoAMCAQICE34AAR03Lnlt8vAH3sgAAAABHTcwDQYJKoZIhvcNAQELBQAwWTETMBEGCgmSJomT
8ixkARkWA2NvbTEYMBYGCgmSJomT8ixkARkWCGxhbmdjaGFvMRQwEgYKCZImiZPyLGQBGRYEaG9t
ZTESMBAGA1UEAxMJSU5TUFVSLUNBMB4XDTIxMDkyODAyMzcyNVoXDTI2MDkyNzAyMzcyNVowgbYx
EzARBgoJkiaJk/IsZAEZFgNjb20xGDAWBgoJkiaJk/IsZAEZFghsYW5nY2hhbzEUMBIGCgmSJomT
8ixkARkWBGhvbWUxNjA0BgNVBAsMLeWxseS4nOa1qua9ruS6uuW3peaZuuiDveeglOeptumZouac
iemZkOWFrOWPuDESMBAGA1UEAwwJ6YOt5Y2r5paMMSMwIQYJKoZIhvcNAQkBFhRndW93ZWliaW5A
aW5zcHVyLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKN1kpWcEFprxAKE8FNL
+AJNR9+ooGd0WOUsK7Mp02bTN0uSAs7HzvQPbXzLylGDj2EyI/g1hhustIl7qQQ9RJeEIcwQyHVZ
Fh+KUoEuMX3duzsrLhIp89b+yCP6T5+g7m4Pp+/Mw+3ClBY7cAF0Ps3SeWFCv+h4aA2VeN8jsMpq
G/p9/Le/+cO2v3q9AiLhc5lnG/drzDSfqU6rtaoBtoZaIJg+L+AQ4yCqFvWqUnGEGdJbNj+r8Hzb
mx59kZlEnwooocutyEcZbwkC4x4/0ejHcvpaFmvxKld13vzXGw0ux2J9dqJkJF57423QoGOOD571
LTYKGMs3jI28NZdwm7ECAwEAAaOCA78wggO7MD0GCSsGAQQBgjcVBwQwMC4GJisGAQQBgjcVCILy
qR+Egdd6hqmRPYaA9xWD2I9cgUr9iyaBlKdNAgFkAgFhMCkGA1UdJQQiMCAGCCsGAQUFBwMCBggr
BgEFBQcDBAYKKwYBBAGCNwoDBDALBgNVHQ8EBAMCBaAwNQYJKwYBBAGCNxUKBCgwJjAKBggrBgEF
BQcDAjAKBggrBgEFBQcDBDAMBgorBgEEAYI3CgMEMEQGCSqGSIb3DQEJDwQ3MDUwDgYIKoZIhvcN
AwICAgCAMA4GCCqGSIb3DQMEAgIAgDAHBgUrDgMCBzAKBggqhkiG9w0DBzAdBgNVHQ4EFgQUxCys
sH6w+RFelyTb976/cxtlJVIwHwYDVR0jBBgwFoAUXlkDprRMWGCRTvYetaU5pjLBNWowggEPBgNV
HR8EggEGMIIBAjCB/6CB/KCB+YaBumxkYXA6Ly8vQ049SU5TUFVSLUNBLENOPUpUQ0EyMDEyLENO
PUNEUCxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0
aW9uLERDPWhvbWUsREM9bGFuZ2NoYW8sREM9Y29tP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3Q/
YmFzZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRpb25Qb2ludIY6aHR0cDovL0pUQ0EyMDEyLmhv
bWUubGFuZ2NoYW8uY29tL0NlcnRFbnJvbGwvSU5TUFVSLUNBLmNybDCCASkGCCsGAQUFBwEBBIIB
GzCCARcwgbEGCCsGAQUFBzAChoGkbGRhcDovLy9DTj1JTlNQVVItQ0EsQ049QUlBLENOPVB1Ymxp
YyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9aG9tZSxE
Qz1sYW5nY2hhbyxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVjdENsYXNzPWNlcnRpZmlj
YXRpb25BdXRob3JpdHkwYQYIKwYBBQUHMAKGVWh0dHA6Ly9KVENBMjAxMi5ob21lLmxhbmdjaGFv
LmNvbS9DZXJ0RW5yb2xsL0pUQ0EyMDEyLmhvbWUubGFuZ2NoYW8uY29tX0lOU1BVUi1DQS5jcnQw
RQYDVR0RBD4wPKAkBgorBgEEAYI3FAIDoBYMFGd1b3dlaWJpbkBpbnNwdXIuY29tgRRndW93ZWli
aW5AaW5zcHVyLmNvbTANBgkqhkiG9w0BAQsFAAOCAQEAcbsy8EKbqOnyvky62q4tgbiQXLrWAfqc
J8ct2AWBJ09cxv5Id95DxyFzbyJMl2e9LHuoSyqIPSIK7Kt2h1s0E0dq0bHOt5avwL1TeKfjpl/a
RAqdkkGs4o1g9aWD2Mz0av9luhQAWJAEw3Von8L/EreNRD4HwlW69whXp47pSe+vCXdRczoJ4/qi
8/nMNmF2NHilHpSBE0fP/3dpo5AYP9PvrJSJQEFlgJrhSH3GY+hUuYFTG5E1zgr5C+nCuNUIyF4J
6kSWRnCb+rPxLJro/mwZqD7qt+HhFJhc37vgjZmBSqMGBoswrhnbgOQHhpAFHsYAG2u3yaJrsxBb
DpWD+jGCA5MwggOPAgEBMHAwWTETMBEGCgmSJomT8ixkARkWA2NvbTEYMBYGCgmSJomT8ixkARkW
CGxhbmdjaGFvMRQwEgYKCZImiZPyLGQBGRYEaG9tZTESMBAGA1UEAxMJSU5TUFVSLUNBAhN+AAEd
Ny55bfLwB97IAAAAAR03MAkGBSsOAwIaBQCgggH4MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTIyMDcyODEyMjQzOVowIwYJKoZIhvcNAQkEMRYEFJzDPCBndwv0nGQO
If67To9UkXhZMH8GCSsGAQQBgjcQBDFyMHAwWTETMBEGCgmSJomT8ixkARkWA2NvbTEYMBYGCgmS
JomT8ixkARkWCGxhbmdjaGFvMRQwEgYKCZImiZPyLGQBGRYEaG9tZTESMBAGA1UEAxMJSU5TUFVS
LUNBAhN+AAEdNy55bfLwB97IAAAAAR03MIGBBgsqhkiG9w0BCRACCzFyoHAwWTETMBEGCgmSJomT
8ixkARkWA2NvbTEYMBYGCgmSJomT8ixkARkWCGxhbmdjaGFvMRQwEgYKCZImiZPyLGQBGRYEaG9t
ZTESMBAGA1UEAxMJSU5TUFVSLUNBAhN+AAEdNy55bfLwB97IAAAAAR03MIGTBgkqhkiG9w0BCQ8x
gYUwgYIwCgYIKoZIhvcNAwcwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIw
DgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIaMAsGCWCGSAFlAwQCAzALBglg
hkgBZQMEAgIwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAF6+XPhx+xzKGT5LWETr0wKi
YtDMJ9J7cIxKmkfQy9pq70cd6Q1h5N2pViEvWGjmvTCzlGc6PJNKrGSIfbj3PaZSywJSppfp2T3G
mowqKyGcjCm792xOKJci2Mb/N4pASL6YZGmtzdxAh8BOp7H1XA1OYd9c5QIym61hnGikKSnbXTD2
H8T9AyKnOoAfjbpzw4dA0E3gfSmdj7mhBNOAtAxS1nKze1LcEVnkiRHFLkp88IQ6VsmYWrVBWRqW
OUJ44RJ0EZ7sW+h9KgyfmgiYMIiQ+s5fEmN1DFdvdHVRQsc+pgRf+wJNeMXSCuhqH8hK519l7kLo
qBq0dqQp1Q069YEAAAAAAAA=

------=_NextPart_000_0203_01D8A2C0.10078B20--
