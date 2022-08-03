Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CAC5891E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbiHCR4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237615AbiHCR4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:56:43 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5BD4B0FA
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 10:56:42 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id pm17so11672944pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 10:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc;
        bh=J3a1rtuyFGhkdAmSw9Hxj2Dgzjd88ctSGo4P01I1e5I=;
        b=Up0X4vEV+q2CpvD/RK4G39bbUHWipijHKFJVQVY/hvoauG7G09JnKQmxcWw+ei2NmQ
         EX52mKoofWgRzVBXl17KjuuCdROHpfTrcNsQv0B8t9AJDu/rxS/vaKh4B8zobEpG34tr
         e3y66LQN8z+Jakv4xksVHmIodJXM9UVHqFsMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=J3a1rtuyFGhkdAmSw9Hxj2Dgzjd88ctSGo4P01I1e5I=;
        b=zB08v3qyTkBh21nZ8mRgPInGqjdGq0MprryfxR7w0yaZ+dviWcSqWD6nNqxngVPGpU
         WTggSQWgsNdCgocGsAm9XF9KSQJU477IoxCWN40LNopitBXtad8yemg/empsvjdeXcjz
         i7ZZmvT0yleqfk37lzSHq1J5xdv9irXe2jPBgxoIyPFysjlL0rn5Zqkb2WwmgmkBJO+5
         1sV8i5O3nw7LKDi3Lv+Tg8CjJ24zIIEF108g2RZLrBTsVxdJSjBMBZkFxJ0GDaykkmFr
         9EMcTuNAlsgCDruu17tWzWiVXmMIVhbB+lVFQnUi3L1op9dQY8CV8SuXo8Xxaobjh30x
         7cFA==
X-Gm-Message-State: ACgBeo3LCTrj/y8tnVb9qPAXrIfOyMQRDYYKOAlz3Kas6g9APteZuMnb
        NHx7u7zRSA7bh27NWFcIauZuWw==
X-Google-Smtp-Source: AA6agR7tL8u2UCuuUUN1grDUOuDR5fUKUE3JGofHB+dbaqrFr/jWWlYbqzeLGQMDC8z1W0gRJpvsVw==
X-Received: by 2002:a17:902:d4d1:b0:16e:ec0b:75d0 with SMTP id o17-20020a170902d4d100b0016eec0b75d0mr15411247plg.123.1659549401837;
        Wed, 03 Aug 2022 10:56:41 -0700 (PDT)
Received: from ubuntu-22.localdomain ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id iw4-20020a170903044400b0016d150c6c6dsm2238639plb.45.2022.08.03.10.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 10:56:36 -0700 (PDT)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        f.fainelli@gmail.com, krzysztof.kozlowski@linaro.org,
        rafal@milecki.pl, William Zhang <william.zhang@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/9] arm64: dts: Move BCM4908 dts to bcmbca folder
Date:   Wed,  3 Aug 2022 10:54:50 -0700
Message-Id: <20220803175455.47638-5-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220803175455.47638-1-william.zhang@broadcom.com>
References: <20220803175455.47638-1-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000009aa38a05e559f4db"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000009aa38a05e559f4db
Content-Transfer-Encoding: 8bit

As part of ARCH_BCM4908 to ARCH_BCMBCA migration, move the BCM4908 dts
files to bcmbca folder and use CONFIG_ARCH_BCMBCA to build all the
BCM4908 board dts. Delete bcm4908 folder and its makefile as well.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
---

(no changes since v1)

 arch/arm64/boot/dts/broadcom/Makefile                        | 1 -
 arch/arm64/boot/dts/broadcom/bcm4908/Makefile                | 5 -----
 arch/arm64/boot/dts/broadcom/bcmbca/Makefile                 | 4 ++++
 .../broadcom/{bcm4908 => bcmbca}/bcm4906-netgear-r8000p.dts  | 0
 .../{bcm4908 => bcmbca}/bcm4906-tplink-archer-c2300-v1.dts   | 0
 .../arm64/boot/dts/broadcom/{bcm4908 => bcmbca}/bcm4906.dtsi | 0
 .../broadcom/{bcm4908 => bcmbca}/bcm4908-asus-gt-ac5300.dts  | 0
 .../broadcom/{bcm4908 => bcmbca}/bcm4908-netgear-raxe500.dts | 0
 .../arm64/boot/dts/broadcom/{bcm4908 => bcmbca}/bcm4908.dtsi | 0
 9 files changed, 4 insertions(+), 6 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/broadcom/bcm4908/Makefile
 rename arch/arm64/boot/dts/broadcom/{bcm4908 => bcmbca}/bcm4906-netgear-r8000p.dts (100%)
 rename arch/arm64/boot/dts/broadcom/{bcm4908 => bcmbca}/bcm4906-tplink-archer-c2300-v1.dts (100%)
 rename arch/arm64/boot/dts/broadcom/{bcm4908 => bcmbca}/bcm4906.dtsi (100%)
 rename arch/arm64/boot/dts/broadcom/{bcm4908 => bcmbca}/bcm4908-asus-gt-ac5300.dts (100%)
 rename arch/arm64/boot/dts/broadcom/{bcm4908 => bcmbca}/bcm4908-netgear-raxe500.dts (100%)
 rename arch/arm64/boot/dts/broadcom/{bcm4908 => bcmbca}/bcm4908.dtsi (100%)

diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index e8584d3b698f..05d8c5ecf3b0 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -8,7 +8,6 @@ dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-400.dtb \
 			      bcm2837-rpi-cm3-io3.dtb \
 			      bcm2837-rpi-zero-2-w.dtb
 
-subdir-y	+= bcm4908
 subdir-y	+= bcmbca
 subdir-y	+= northstar2
 subdir-y	+= stingray
diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/Makefile b/arch/arm64/boot/dts/broadcom/bcm4908/Makefile
deleted file mode 100644
index 6e364e304d4f..000000000000
--- a/arch/arm64/boot/dts/broadcom/bcm4908/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_ARCH_BCM4908) += bcm4906-netgear-r8000p.dtb
-dtb-$(CONFIG_ARCH_BCM4908) += bcm4906-tplink-archer-c2300-v1.dtb
-dtb-$(CONFIG_ARCH_BCM4908) += bcm4908-asus-gt-ac5300.dtb
-dtb-$(CONFIG_ARCH_BCM4908) += bcm4908-netgear-raxe500.dtb
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/Makefile b/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
index 38f14307184b..d30fa75f0611 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
@@ -1,5 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_BCMBCA) += \
+				bcm4906-netgear-r8000p.dtb \
+				bcm4906-tplink-archer-c2300-v1.dtb \
+				bcm4908-asus-gt-ac5300.dtb \
+				bcm4908-netgear-raxe500.dtb \
 				bcm4912-asus-gt-ax6000.dtb \
 				bcm94912.dtb \
 				bcm963158.dtb \
diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-netgear-r8000p.dts
similarity index 100%
rename from arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts
rename to arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-netgear-r8000p.dts
diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-tplink-archer-c2300-v1.dts
similarity index 100%
rename from arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts
rename to arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-tplink-archer-c2300-v1.dts
diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906.dtsi
similarity index 100%
rename from arch/arm64/boot/dts/broadcom/bcm4908/bcm4906.dtsi
rename to arch/arm64/boot/dts/broadcom/bcmbca/bcm4906.dtsi
diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts
similarity index 100%
rename from arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts
rename to arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts
diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-netgear-raxe500.dts
similarity index 100%
rename from arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts
rename to arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-netgear-raxe500.dts
diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
similarity index 100%
rename from arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi
rename to arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
-- 
2.34.1


--0000000000009aa38a05e559f4db
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
TltlrAeBKRJ1M9O/DY5v7L1Yrs//7XIRg/d2ZPAOSGBQzFYjYTFWwNBiR1s1zP0m2y56DPbS5gwj
fqAN/I4PJHIvTh3zUgHXNKadYoYRiPHXfaTWO9UhzysOpQIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRp3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUohM5GmNlGWe5wpzDxzIy
+EgzbRswDQYJKoZIhvcNAQELBQADggEBACKu9JSQAYTlmC+JTniO/C/UcXGonATI/muBjWTxtkHc
abZtz0uwzzrRrpV+mbHLGVFFeRbXSLvcEzqHp8VomXifEZlfsE9LajSehzaqhd+np+tmUPz1RlI/
ibZ7vW+1VF18lfoL+wHs2H0fsG6JfoqZldEWYXASXnUrs0iTLgXxvwaQj69cSMuzfFm1X5kWqWCP
W0KkR8025J0L5L4yXfkSO6psD/k4VcTsMJHLN4RfMuaXIT6EM0cNO6h3GypyTuPf1N1X+F6WQPKb
1u+rvdML63P9fX7e7mwwGt5klRnf8aK2VU7mIdYCcrFHaKDTW3fkG6kIgrE1wWSgiZYL400xggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgw28eX6TfvsbNfu
SIMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMIgEUZ3ztlUQeXCeaUNEO2yeyVf
QhjVx4Y4jU32G6tZMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIy
MDgwMzE3NTY0MlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAYHXIrEb+IokNbP2722g15m8wfTjyRV67TqXD5qPL+xzfj
ZP75XRYXDM/F+yZkmteHwVt2HAScOWgUhryI0mML8q4w0iYDEN4nGWm2tQENtvVgxcwBuVM/2cUE
aKK7Tw1+kzs1ZLrR2v2tLIRem2mqQjIcLLw+TE9Lf7BxOKbn2tjBx4SjTKJBjPfncck4GJNqDbca
dicXZzo53C5ko6/h3QJT7rPwcrSaEgnSB39knJT2uAT5OY5cFq+fxCVNn53m6SUVHpOObbWTGRqW
YuqDOaI4JHHidIwX1ryWIpVJiE64v+VG9Hi4qBYzSZu+PYbfItdH41Qj6FshOTupbOLB
--0000000000009aa38a05e559f4db--
