Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D542C545B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 07:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243752AbiFJFKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 01:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243681AbiFJFKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 01:10:02 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Jun 2022 22:09:59 PDT
Received: from enterprise02.smtp.diehl.com (enterprise02.smtp.diehl.com [193.201.238.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6253B63A9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 22:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=diehl.com; i=@diehl.com; q=dns/txt; s=default;
  t=1654837800; x=1686373800;
  h=from:to:cc:subject:message-id:mime-version:date;
  bh=PszikEndB8MNvl4TkZ46e+JlAuqon/0m4UQsfRATA3I=;
  b=LzNo410Qai/ba79PBWOzu8y2yuIcT56igTF+oKpMiNQsN9aianffM36S
   448da1ywbM7BXsQDWF094+ey0v+qn+Patq80JgrWAwWYBFCayckuWHxaO
   azhxlqd/Pm/IecViFjVRyP8Y8xvquO4XVeS8ZoP4qUuga9Pi2DQM/r2dS
   Tgq8VGr5oC40i4dmoJVkYlpJJdVPwZW4WvGjyK9HU1d/DTobSasXgOrVG
   qllq5epQIoyX9/IaU5WGmBlKemYloYXlb2LhOy0ol+070hxJ9TGSpMS4y
   n5CucJVI5h4wEkGriKuMPxsFap41ChPtU3qo7Cp8eMCrf+gSVKxdx0Pve
   g==;
IronPort-Data: A9a23:7nKybKOfZ7VSD1TvrR2El8FynXyQoLVcMsEvi/8bNHDolHp+jmZWi
 jtAB3bOJ7/RMSHyZpovP9PnsQ9E7KZh/KYgFVsx+Dd1EGkiRaHtDozAdxf+MS/MJZCeFR04t
 p1AN4iYd5lpEXKM9kf8brG6oyEjivjWT+uiBbLOanErGwY/En8s2UMywOA13YdjiLBVb+/jV
 fba+qUzb3f+imYkWo5t14qDtA937rO1uz4JpRoyZP1LuBnVkHxSB4gbYr2yanvPRM9fBOriL
 9ovt4pVjV41hT9oUZX9+ovTclEWWuyVeguDm2EQV6mvghwErSs3la0hML0AagJXvDPPlMp1k
 IgO9MTYdetSBUG/pQhne1wDVXkWAIVG5KPfcz/4rtOMiUHHfnvohf5pCQYuPoxfoo5L7Rp1G
 Y8lxEolK0vF34qL/Y+GpslQauULIpm0NY1A53g6kzzVXKh5Gc2fTqnBvI4Bg29gjZtFEK2CP
 ppIYjdRNxmROBcn1nX7qn4dtLry2iOvI2UwRHa9//dfD737lVQpuFTVGIOJPITMH625p27Az
 o781z2R7ioyaZrOkFJpzlr23rWVxX2iANpLfFGF3qUCbGO7lzV75CI+BQPTTcmR0iZSjPoGd
 iT4UgJ3xUQD3BTDouvVBnVUk1bd1vIoYOe8JsVhgO27Jgg41C7CboQMZmYphNXLL6baTxRyv
 rOCt4uB6TCCLNR54J9Sn1uZhWraBMQbEYMNTQA/TS4f4ofSnKs20C7+UPxZL4uXjNKgTFkcw
 xjSxMQ/r7kWn8UEyP3hu1vAmSrqqpnETgpz7QLSNo6nxlohIt7/IdX4rwGAt56sL67AJrWFl
 GAehdPLtb1VBMHXmnPVFekAGrCyofGeLDDGhVdpE7Et9jmt/zioeoU4DDRWfx81aZpeKGWBj
 En7vw1g5bpuDWGRUIR4O4SrFOgm9qm4PIGwPhzTRp8UCnRrTyeO+i10ZF/WxGDgjkMsnKc8P
 r+fcMCxHTAbD7hqyHy9QOJ1+aci2C067X7YWtbw3XyP1buYeW7QSrofNlaKRv424bnCowjP9
 dtbccyQxH13VOz4fzmS9YMfNngUInUhQ5P7scpacqiEOAUOJY06I/PU07guZNQ/2ahUm+fMu
 Hq6QFcwJEfDuEAr4D6iMhhLAI4Dl74mxZ7nFUTA5WqV5kU=
IronPort-HdrOrdr: A9a23:iixTFKwPFE5g9mBfS3nnKrPwvL1zdoMgy1knxilNYDRJd4ijm8
 ey2Msa3XbP+VAscVk8nNibIqmJRlfV9ZswxYUNNfOFVxPhvWe0IMVDwOLZsl7dMgXi8+ZGz6
 dpdIx3CNi1KVRmhYLG+wG+Cd4r3dmA9+SJqI7lr0uFLDsaE52Iij0SNu/1KCBLrWV9aabRUa
 DshPavxADQAEj/DP7bOpBfZZmlmzSjrvuPXfdFPW9D1ODkt12VAdDBfCSw71M8UyhGhZgj9m
 bIiBXj5qK/2svLriM0h1W506hr
X-IronPort-AV: E=Sophos;i="5.91,288,1647298800"; 
   d="p7s'?scan'208";a="30434292"
From:   Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>
Subject: RE: [PATCH v1 1/1] leds: core: Refactor led_update_brightness() to
 use standard pattern
Message-ID: <84e53330631549a68aa27ac61ea1da18@RCDC-Mail15.corp.diehl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----BEE73F19A85F1353C6A40F13761BFBE7"
Date:   Fri, 10 Jun 2022 07:08:48 +0200 (CEST)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an S/MIME signed message

------BEE73F19A85F1353C6A40F13761BFBE7
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

LGTM

Acked-by: Denis Osterland-Heim <denis.osterland@diehl.com>

-----Original Message-----
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com> 
Sent: Thursday, June 9, 2022 6:23 PM
To: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>; Andy Shevchenko
<andriy.shevchenko@linux.intel.com>; linux-leds@vger.kernel.org;
linux-kernel@vger.kernel.org
Cc: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v1 1/1] leds: core: Refactor led_update_brightness() to use
standard pattern

The standard conditional pattern is to check for errors first and
bail out if any. Refactor led_update_brightness() accordingly.

While at it, drop unneeded assignment and return 0 unconditionally
on success.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/led-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index 4a97cb745788..96a2817712e5 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -304,17 +304,17 @@ EXPORT_SYMBOL_GPL(led_set_brightness_sync);
 
 int led_update_brightness(struct led_classdev *led_cdev)
 {
-	int ret = 0;
+	int ret;
 
 	if (led_cdev->brightness_get) {
 		ret = led_cdev->brightness_get(led_cdev);
-		if (ret >= 0) {
-			led_cdev->brightness = ret;
-			return 0;
-		}
+		if (ret < 0)
+			return ret;
+
+		led_cdev->brightness = ret;
 	}
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(led_update_brightness);
 
-- 
2.35.1

------BEE73F19A85F1353C6A40F13761BFBE7
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIPQAYJKoZIhvcNAQcCoIIPMTCCDy0CAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgggxWMIIGUTCCBDmgAwIBAgICMAAwDQYJKoZIhvcNAQELBQAwgaMx
ITAfBgNVBAMMGERpZWhsIEdyb3VwIE1haWwgUm9vdCBDQTELMAkGA1UEBhMCREUx
EjAQBgNVBAcMCU51ZXJuYmVyZzEUMBIGA1UECgwLRGllaGwgR3JvdXAxFDASBgNV
BAsMC0RpZWhsIEdyb3VwMQ8wDQYDVQQIDAZCYXllcm4xIDAeBgkqhkiG9w0BCQEW
EXg1MDktY2FAZGllaGwuY29tMB4XDTE4MDUyOTEyMzIzNVoXDTI4MDUyNjEyMzIz
NVowgZQxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCYXllcm4xFDASBgNVBAoMC0Rp
ZWhsIEdyb3VwMRswGQYDVQQLDBJEaWVobCBNZXRlcmluZyBUS0gxHzAdBgNVBAMM
FkRpZWhsIE1ldGVyaW5nIE1haWwgQ0ExIDAeBgkqhkiG9w0BCQEWEXg1MDktY2FA
ZGllaGwuY29tMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAtISPrKPL
Zjjh//2n9b+GXgrhijJV2knQVC0+/FS3zGl4p2fboB+Vr4YHz1uilEvhsS1oG4FV
f1u0dqdmLVxDHBPMO2K1NKKOJN/6LDDfyiZGNqDOJke6FzrmDyPXXTDtgzWZfdnD
esx63XSxprre30oJ3BxDFS+/8UpuI628SPc1N4125rHeUXG4scKFSjqRPcIOAQ2X
veGXU2dYHzq7B02NA8tssmtJNwXjyvMjOw6HGZ8SB87TrFQm6drEtM7QhI/mfpGe
nTZ4nc84n0yKuMveav8IOspYbkOXzi4JapiOUpmccNLZdIiMg5WJQ0Xt9NSp5yD5
CYKideGrWgX2wNEBpalgjZoPPQDImcWEJx88/yYZ4FwtRD3VueFqpBr4z/bxwVDr
N2a/sEqnocY9Tm2EQyHFHDCJ9JyYEXB8W0LTFcUAx+uHijwPk/oIB5EeH8UygXlX
qUqII+BUZ+q5m5sIc4eXQ10UpUEjG/ptIyO1Ee/E0kPOWzHp07pPgXCZohZb3y41
Ha2pO6rXOsOmPBK2r2++fLWz3NFyfEJCmn6FcBNi003HUEVCup1D9/9yaPHPSieN
27sjQcQ96GbOitC99p3xMnSlg4N11lGeuTXCZjIGXdZL5/dThQaxneVA+hr2X+i1
KmqnesMaSBEuBEBDmbDbakEgJFVWtVeXuk8CAwEAAaOBmzCBmDASBgNVHRMBAf8E
CDAGAQH/AgEAMAsGA1UdDwQEAwIBBjAdBgNVHQ4EFgQUn8t6NGPzWsF+oZYXxmfn
p4Ok7rIwHwYDVR0jBBgwFoAUZrrYQMMD50v/OCDMgDN7y/GT2P8wNQYDVR0fBC4w
LDAqoCigJoYkaHR0cDovL2tleXMuZGllaGwuY29tL2NybC90ay1oX24uY3JsMA0G
CSqGSIb3DQEBCwUAA4ICAQAl6hO6b6+GseZi3EAU+zPVhxNZP5Y+YsBnjf13jCGw
nUVvPz6giwXiCd9KIC4eCqqrJLTHwZe8c/9hSk5CCd6A5XAd3YudrPDvmIwms5Ex
OREMQkygZO6/qxfXO6IhfUO4HvYQtQexzHOLuxG/KdycVwWapA4acFzBurxFQ3aG
jvPRgvWxe2Mt3K9wLrEhvGrDmS8yg4bYNyBZGgax6LRhfW4/ShInVUa0koG2Sj+H
hKpppvqDK4FNgR2dKeCPoo28P9a+K9N3wkLKx4zxaxHegij0DsJOBAVbhk+vDWDO
gedjtT09c9bsykaXFzykyQeQz7cwrTQ1gDacdcDgywMDQzZKim9O3JpyzvXnD7mb
CvclM3xp9w6jIJbeaQE7HDlA9YIL/bSRIQq8mJcXArUevLK2MX/Mb+5m3UMU+zXc
ZqmaneeZeR4bOWrmmhK6bMuce6H+i2YB1vG3BAcSfKQUzZ1m6aKSW1FvjI3SZXQD
FzRzBwC5ql7i2ugtfOLNYjOO/fvAxNppIZb3IyWN1KBAI7YgS4nx0us/NIlWpTMW
91WeUtNBCp2sgi3VTi/TUel3RZ9x3tggMUhrksGkFXz2NUL85AdPV6BqJXXXHggd
121rnduE9ocMt0MFLuDPkMaHqKNzBAcKTcmFM8KYMJ5Z7NBqGtTAgHNVmEnU8gu3
czCCBf0wggPloAMCAQICAgb0MA0GCSqGSIb3DQEBCwUAMIGUMQswCQYDVQQGEwJE
RTEPMA0GA1UECAwGQmF5ZXJuMRQwEgYDVQQKDAtEaWVobCBHcm91cDEbMBkGA1UE
CwwSRGllaGwgTWV0ZXJpbmcgVEtIMR8wHQYDVQQDDBZEaWVobCBNZXRlcmluZyBN
YWlsIENBMSAwHgYJKoZIhvcNAQkBFhF4NTA5LWNhQGRpZWhsLmNvbTAeFw0yMjAx
MTYwODIyMjNaFw0yNDAxMTcwODIyMjNaMIG8MSIwIAYDVQQDDBlkZW5pcy5vc3Rl
cmxhbmRAZGllaGwuY29tMSgwJgYJKoZIhvcNAQkBFhlkZW5pcy5vc3RlcmxhbmRA
ZGllaGwuY29tMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMRwwGgYDVQQK
DBNEaWVobCBNZXRlcmluZyBUSy1IMRwwGgYDVQQLDBNEaWVobCBNZXRlcmluZyBU
Sy1IMRIwEAYDVQQHDAlOdWVybmJlcmcwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQCtiK2ROwKpXoaZxHvDoCkAqTh/L+Ymvg8sEV1mk//iOLWtENFkQfFp
3e1scofcCyYWMoJ9QEjKvKAdcFSvjqeczDmKnD8li4vqEukqGJmrNe5p2cQFJxpD
Gy/Pb9CoPtuE7GNMiBgQfX12qHj9sdopLv9nijEtSfCtXiIc+ees3kd9DBPhiiAv
S9t89DUy307W0izYMsUaqcfOWEFT2nLRhXweoPTE0VrSg485uYMdgdTj8OvEs/oB
1cM95QdiqjrWhuhc/JRJk/iyztrXA8gjdsGrk2SlCB2Pcv0tNAbplKw95z00rNRi
pwV+WFkpNRyruO2gkFKYvSy9J1gdXsarAgMBAAGjggEtMIIBKTAfBgNVHSMEGDAW
gBSfy3o0Y/NawX6hlhfGZ+eng6TusjAJBgNVHRIEAjAAMCQGA1UdEQQdMBuBGWRl
bmlzLm9zdGVybGFuZEBkaWVobC5jb20wNQYDVR0fBC4wLDAqoCigJoYkaHR0cDov
L2tleXMuZGllaGwuY29tL2NybC90ay1oX24uY3JsMDUGCCsGAQUFBwEBBCkwJzAl
BggrBgEFBQcwAoYZaHR0cDovL3d3dy5kaWVobC5jb20vcGtpLzAJBgNVHRMEAjAA
MB0GA1UdDgQWBBSjWBEDN4lSGcPnP9UrMtXUFmejNTALBgNVHQ8EBAMCBaAwHQYD
VR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBEGCWCGSAGG+EIBAQQEAwIFoDAN
BgkqhkiG9w0BAQsFAAOCAgEAgsI+DkMhcC9r5Eit3DLpMRVZzZAYMYpMvwsGPeWF
TF1fTt7DW5QoBhntXHet27YcU10qERLHO9cgXD0QhK5FroUTML3jT1r+Q+YZu0gb
ujpDlKWPJyXkrexgjUOHg+odKJDa50Vr6xwLzE+rgT4wpsUatKay3hwcTGuRQrD8
zJoxfLJ7bhznM8YrUD0fFpoz/8QcvoP2S3Y9wHn/r+gmKF3+6Nbgz7CYUlndENG7
Ul1tUrGMOWvPr+dXYEsqYPRk5eApuuYn/P8ax+GW+RlYm6wHDN3PRUDN/NoGzpuJ
FHTZVLNMPSrFTHdW+H2OPwyQTW6cZ2q+u69jm2Vc6ARXrEjzN5SRmjHodWpt7fUu
B3i6l0b36PFEAS42AO32U+FGsdi2T84KqZJOoohtJQKrTqKYn7aUQn7e3rQbQyLt
BxBO/rbPVjYwi7mUamOcggvIRx0oru3uIpsV59IFM/40lCv5s7mS5RmUudGtVZul
fnHj8b/R4j8S1IQEAzplBjmXX9tSPLy+8TKtT8NBnLWN/LGEoW+/O9NCdGuuRT4h
cgHEWf/AQSZ580/3AUcd/oC35b0E7qnfAZobqqipLqQkO4bYlgzSpazmXddoGcqm
YtVcPwt5SXQ3upyseicvLMLz11WqUmlUI9PKY8Ki+9oFc7SaiplvopQGwIxSQTLl
bQMxggKuMIICqgIBATCBmzCBlDELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJheWVy
bjEUMBIGA1UECgwLRGllaGwgR3JvdXAxGzAZBgNVBAsMEkRpZWhsIE1ldGVyaW5n
IFRLSDEfMB0GA1UEAwwWRGllaGwgTWV0ZXJpbmcgTWFpbCBDQTEgMB4GCSqGSIb3
DQEJARYReDUwOS1jYUBkaWVobC5jb20CAgb0MA0GCWCGSAFlAwQCAQUAoIHkMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDYxMDA1
MDg0OFowLwYJKoZIhvcNAQkEMSIEILCKll9vI2RXkKsOEYfZ4IIspdg16mAH9GtC
uHOWFlseMHkGCSqGSIb3DQEJDzFsMGowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQB
FjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMA0GCSqGSIb3DQEBAQUA
BIIBAFiSaUaZDelrbngAfBwkm9i5+gNvURSomqwbU+jVsprFZzdD56V+IgEoGOSF
2lgu/x6tLm6b5Xn2asrtwIDE+WTLdsh6p51okcHonn+t5DvvF9u8rlgNAHTTwsAa
s2nDe7cVqHTYLHigxu7wXN+g0V8DB8Qi5PK6q/Dw/SH6oVQQZH9ZRglVBtzpjpg3
bDwVpDpRRk9yutT8cJHaQUL71rcmrb1YO2x7H2Z8K2RolnFngU/F8eLrw9O9zwpB
rlYiqS3PtLgmkNwfQzNzm9eAB4jwKsWHzmFDB17V4dxmzUA8j0+JNshnCyF94P8P
jcPudBbOLIHA/6Sl6ao5X9Wder0=

------BEE73F19A85F1353C6A40F13761BFBE7--

