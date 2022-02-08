Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8394ADF50
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383959AbiBHRTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383635AbiBHRTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:19:23 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C720C0612C3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:19:20 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 02B5540052
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 17:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644340759;
        bh=wsWLsYLohqc24CY+DvCwQmjmrJB1cZZyKqkEteo8zKw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=rFngePbBZXmlj75FzYYUkG45jxZ5ZBcJWogc5fjlmv+5+L5tuK3BwBgqnw9m6tFpr
         EG6IW+sKhOOfVQPxT2zIx7T3N/zBMo1LD0PN19bpwBI0I5JAh7I9eZTlMBnR05WmM5
         ctEq/E6kG0Hh8zUjCq5qsbyaZRnNNAkictGcd3z3qVOpJ1I+oH1VfwhB2TZIUni88A
         /+dd5QPy3GV14YuNO2KuFJ71nopqzc4/bHLHnH0Pv3C5dn9D6XRP8t/SAkp1Ds0xba
         cq2iyaMIBsP3VjGfh7jQ1LAW6Z/N6wjvpINjjJt2MhalasGf/2/6cd9+F9nmN2Mp+7
         d2iSfGRHSUkSA==
Received: by mail-ej1-f70.google.com with SMTP id o4-20020a170906768400b006a981625756so6061596ejm.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 09:19:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wsWLsYLohqc24CY+DvCwQmjmrJB1cZZyKqkEteo8zKw=;
        b=wez6ueg6Ym6ACGa1sTFMP2PMBb17C/XNdZuMIWG2SAvZ/NZWpLjFVSFogjPonIXsAJ
         ty8iQaN8tv0aClJOW4jFVyTHmP2i/Vq4FxCEJkH+VOaPmWnRM74NXUs6uVkInIvhKlww
         L4jZDe+jYOd0jyqPa/cXm/jPlbK5QCriEXBrZWTGBtCeclBrWmL6Bnh+IPJUerqV7e01
         KO2PhPi6HAO5zlIzSF3iSfVI5zwKh2ktnDWZ12TlezWYLTmpfo6vOC7iUzhCTSZDN5HK
         y/ghJEiIvv3r6xKXxS2PhVVQhXd1+uK7UTNQm4zRhuUplFURTiRLZZuAWduwFVjrH7nD
         qLkA==
X-Gm-Message-State: AOAM533XYfXASi/PiP7uUvIekZS8bjlRCbrAB45f2QGmeOupEeUen8cR
        fAy2KnYz1zzRU/QxI1MJ8ZvBglc0sD+R3o4hl0SkQNZNvwKb1LGVNgFvRkgfx91Iz1MHxRk7b52
        Q2nRYDljDkEPvUS9cTf8c5UBoyg+PYpNoV8ohGEUSSw==
X-Received: by 2002:a17:906:9b87:: with SMTP id dd7mr4512024ejc.552.1644340758534;
        Tue, 08 Feb 2022 09:19:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzY0F7r0kLyPgMZZGqkUbCU8KjDhU3RXIohWlNO6hLTLuOou/cnXcs5p5tX1Nu6bOpKpEpjlg==
X-Received: by 2002:a17:906:9b87:: with SMTP id dd7mr4511993ejc.552.1644340758311;
        Tue, 08 Feb 2022 09:19:18 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id r10sm5125550ejy.148.2022.02.08.09.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 09:19:17 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 06/10] dt-bindings: display: samsung,exynos-hdmi-ddc: convert to dtschema
Date:   Tue,  8 Feb 2022 18:18:19 +0100
Message-Id: <20220208171823.226211-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220208171823.226211-1-krzysztof.kozlowski@canonical.com>
References: <20220208171823.226211-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Exynos HDMI DDC bindings to DT schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../display/exynos/exynos_hdmiddc.txt         | 15 -------
 .../samsung/samsung,exynos-hdmi-ddc.yaml      | 42 +++++++++++++++++++
 2 files changed, 42 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/exynos/exynos_hdmiddc.txt
 create mode 100644 Documentation/devicetree/bindings/display/samsung/samsung,exynos-hdmi-ddc.yaml

diff --git a/Documentation/devicetree/bindings/display/exynos/exynos_hdmiddc.txt b/Documentation/devicetree/bindings/display/exynos/exynos_hdmiddc.txt
deleted file mode 100644
index 41eee971562b..000000000000
--- a/Documentation/devicetree/bindings/display/exynos/exynos_hdmiddc.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-Device-Tree bindings for hdmiddc driver
-
-Required properties:
-- compatible: value should be one of the following
-	1) "samsung,exynos5-hdmiddc" <DEPRECATED>
-	2) "samsung,exynos4210-hdmiddc"
-
-- reg: I2C address of the hdmiddc device.
-
-Example:
-
-	hdmiddc {
-		compatible = "samsung,exynos4210-hdmiddc";
-		reg = <0x50>;
-	};
diff --git a/Documentation/devicetree/bindings/display/samsung/samsung,exynos-hdmi-ddc.yaml b/Documentation/devicetree/bindings/display/samsung/samsung,exynos-hdmi-ddc.yaml
new file mode 100644
index 000000000000..f998a3a5b71f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/samsung/samsung,exynos-hdmi-ddc.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/samsung/samsung,exynos-hdmi-ddc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos SoC HDMI DDC
+
+maintainers:
+  - Inki Dae <inki.dae@samsung.com>
+  - Joonyoung Shim <jy0922.shim@samsung.com>
+  - Seung-Woo Kim <sw0312.kim@samsung.com>
+  - Kyungmin Park <kyungmin.park@samsung.com>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: samsung,exynos4210-hdmiddc
+      - const: samsung,exynos5-hdmiddc
+        deprecated: true
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ddc@50 {
+            compatible = "samsung,exynos4210-hdmiddc";
+            reg = <0x50>;
+        };
+    };
-- 
2.32.0

