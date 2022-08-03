Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E04E5891DD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237776AbiHCR4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbiHCR4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:56:06 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D6D7667
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 10:56:04 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 17so1610485plj.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 10:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc;
        bh=5QZwPNnGGdxSU1kFb7YD7c0jxkYvvSPHJerGOHj69wg=;
        b=TpVuodO16urETNV6tSiK8erUV8Y+4JKvfNEKUPn3E0YP1a8msyj9fo1Epn9AzPw08x
         HxSU1brTd2BNTsmTgkM4/SVkar0AB0UGWOPB/hPgKS+EcFwSrqd0U/q2O8YsXQnBAJZE
         tK8Glk3zQNFRU2e9TTiGA3oJbyAA8qJDc4FPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=5QZwPNnGGdxSU1kFb7YD7c0jxkYvvSPHJerGOHj69wg=;
        b=NjEO+Tm3lo5qloC+KRhuHCt6jE14KQyWCPG9hKkgiG8QFtR0WCK2WK0p0FO1yXhpPb
         WsZNcvgQmDwW8CZzAbVR6ETDi+Gxnf7ZDYonAcJLmgpOqejS7ZStwq3Zqoc3Sk75xhTm
         PLTia/jnZNKldF0oCUg7lK5Hf+JeR8sBO3QDSniIfldgKIb4mE19cGhC4zE9l9Xdu9f3
         4AYXxwj9VTzqDGrD5pl07WykOP1Ajxr9ZKwb7gvEXdIoogOuZapnopV7ZAY/iiPQR/oS
         FIGCmrGhjvqIfgmlm5p8F5vmu50Qcm0TAkgfr3TysqVgWNiRWgV8VnkJDW4BgBYE35Bx
         lf2Q==
X-Gm-Message-State: ACgBeo0pxNkX25s5R+ck+Xnq+7yZ8HUuqNrHE3wAiaJPh3x1rVxHGI8Z
        XEo+6A2BFIcQH69V1BFAJ0YbUA==
X-Google-Smtp-Source: AA6agR4pp+Jyiwoyk+HX78k+R9TzRWTbAZe7MMRVhp//C5T8j78WK3SfSl0T/xN6uljGKUqs4qTDbA==
X-Received: by 2002:a17:903:2054:b0:16e:c85d:d86c with SMTP id q20-20020a170903205400b0016ec85dd86cmr23045045pla.39.1659549363742;
        Wed, 03 Aug 2022 10:56:03 -0700 (PDT)
Received: from ubuntu-22.localdomain ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id iw4-20020a170903044400b0016d150c6c6dsm2238639plb.45.2022.08.03.10.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 10:56:00 -0700 (PDT)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        f.fainelli@gmail.com, krzysztof.kozlowski@linaro.org,
        rafal@milecki.pl, William Zhang <william.zhang@broadcom.com>,
        Rob Herring <robh@kernel.org>,
        Anand Gore <anand.gore@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/9] dt-bindings: arm64: bcmbca: Merge BCM4908 into BCMBCA
Date:   Wed,  3 Aug 2022 10:54:47 -0700
Message-Id: <20220803175455.47638-2-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220803175455.47638-1-william.zhang@broadcom.com>
References: <20220803175455.47638-1-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000559fbd05e559f27d"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000559fbd05e559f27d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BCM4908 is one of the Broadcom Broadband origin WLAN Router/Access
Pointer SoCs. It was originally added by Rafał before Broadcom
started to upstream the support for broadband SoCs. Now that Broadcom
Broadband SoC is supported under arch ARCH_BCMBCA, this patch moves
BCM4908 SoC device tree descriptions into BCMBCA binding.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Acked-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes in v3:
- Add Reviewed-by tag

Changes in v2:
- Add Acked-by tag
- Improve commit message with more details

 .../bindings/arm/bcm/brcm,bcm4908.yaml        | 42 -------------------
 .../bindings/arm/bcm/brcm,bcmbca.yaml         | 21 ++++++++++
 2 files changed, 21 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm4908.yaml

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4908.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4908.yaml
deleted file mode 100644
index 9b745531ff04..000000000000
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4908.yaml
+++ /dev/null
@@ -1,42 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/arm/bcm/brcm,bcm4908.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Broadcom BCM4908 device tree bindings
-
-description:
-  Broadcom BCM4906 / BCM4908 / BCM49408 Wi-Fi/network SoCs with Brahma CPUs.
-
-maintainers:
-  - Rafał Miłecki <rafal@milecki.pl>
-
-properties:
-  $nodename:
-    const: '/'
-  compatible:
-    oneOf:
-      - description: BCM4906 based boards
-        items:
-          - enum:
-              - netgear,r8000p
-              - tplink,archer-c2300-v1
-          - const: brcm,bcm4906
-          - const: brcm,bcm4908
-
-      - description: BCM4908 based boards
-        items:
-          - enum:
-              - asus,gt-ac5300
-              - netgear,raxe500
-          - const: brcm,bcm4908
-
-      - description: BCM49408 based boards
-        items:
-          - const: brcm,bcm49408
-          - const: brcm,bcm4908
-
-additionalProperties: true
-
-...
diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
index 324e59104360..6a64afa95918 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
@@ -15,6 +15,7 @@ maintainers:
   - William Zhang <william.zhang@broadcom.com>
   - Anand Gore <anand.gore@broadcom.com>
   - Kursad Oney <kursad.oney@broadcom.com>
+  - Rafał Miłecki <rafal@milecki.pl>
 
 properties:
   $nodename:
@@ -28,6 +29,26 @@ properties:
           - const: brcm,bcm47622
           - const: brcm,bcmbca
 
+      - description: BCM4906 based boards
+        items:
+          - enum:
+              - netgear,r8000p
+              - tplink,archer-c2300-v1
+          - const: brcm,bcm4906
+          - const: brcm,bcm4908
+
+      - description: BCM4908 based boards
+        items:
+          - enum:
+              - asus,gt-ac5300
+              - netgear,raxe500
+          - const: brcm,bcm4908
+
+      - description: BCM49408 based boards
+        items:
+          - const: brcm,bcm49408
+          - const: brcm,bcm4908
+
       - description: BCM4912 based boards
         items:
           - enum:
-- 
2.34.1


--000000000000559fbd05e559f27d
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
SIMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIF3ByWS0cTxtVtcGnYB3dzPbxs1Y
gMBDWXvHFA5ZR3zwMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIy
MDgwMzE3NTYwNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQB4hbit0KpD7Qh2a19+U3qtgPqqJ9ksf9VPVRUIPgWzN5G9
OJDc0tvlL9ygcPPbE7hQhI/O3KIOO/YhJuUG3oxYlBa/w0OnRzL5KQH/OGLvxpfTbgf42SF7gemN
IfvS/RZ1xdwQjMoLbDdWGZQla3YIuL4hEKMnIuxFVDYcuHZa/bbY7sigHU17oc+oKoR5JvyKtZ2o
kUGEukh9OO9PdZpYRn0vwZQ4BVAYM1x8h5bVyp34L4TPataRPJOCdkDytQydcisU8dnAmmF0Yz7Q
mb4a6YRi0aJ/37NcvCecb/FQ0eSkgpeaXensySFNtj9yNpB41/iJCsGyu7AC/Y6r6dE0
--000000000000559fbd05e559f27d--
