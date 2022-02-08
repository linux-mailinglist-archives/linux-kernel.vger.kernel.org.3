Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB904ADF4B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383764AbiBHRT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383494AbiBHRTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:19:17 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07651C061578
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:19:16 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CEF7D3F33A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 17:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644340754;
        bh=lAYCF0oFl9nGAtjZLrRDfxUB8PgsnopuWgeZlWJgjg4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Ek+iYDMzT8ce/HbDOjD5ibzDNR3F7CFtm30L6O55yePTHRKywz3yn2e3XUU4E9isl
         9Y5+E4yQ0ClpTn6u/X0XOSgXAUciWNm8Zm4fyiVntl5ipx3wR24gblQFxfUyHV5bNX
         L5KaeKG96siruNrrx0FvMrubJhxwyKRh4DSviRLk5pOXMxGq3QURAuujKi8UApjYNI
         Y5AjthOjFYKLhpiTzLjjLaPfi0xO13Sr64Afc+fKBXeskyLxss+b5m5S4eVAuCuH0q
         5fsavOLMi3AL9xSRjgU66jbZYGoAwdH7aSe2dFCIGNE492Ifw0uz9/+3lb4JdxhWll
         atmCqyq0t+JqA==
Received: by mail-ed1-f70.google.com with SMTP id f6-20020a0564021e8600b0040f662b99ffso4112258edf.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 09:19:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lAYCF0oFl9nGAtjZLrRDfxUB8PgsnopuWgeZlWJgjg4=;
        b=bzJa3XQAOvyI3lQBl1nQvTOWFTGg739QN1X0wuisv5aq0NFpEU4vIW5zV3cxAqxy1D
         Aj0tPqsJyZFEogM0K27sqGNsAfxzLbdQCfeskzOxBgTvkr6c2HjYDna5oULeyG5ADXk5
         SzGXH3Z1NBWGg+hOo2J8p22YpRl6bht8B7vhnXieagb19IzAT+GqFYTTVvCp1Kz9mkbP
         RlYNGLhb18Qz932GlxapR7TFAnjNGmYPZkPDRF63Dib6Bd+P+XXqu94nGm9Cqx0FON4c
         ENQZmAjDjjZmeEvr0grcqNqVXhEUtB4YRsfNbXDIJLAMSiyBDg2deruB6js9mzIEZBb1
         jG/w==
X-Gm-Message-State: AOAM531tXemvf1mLakcDMKFZPtUMkLQr6dBbiHqGo0SJG0JmYm6p1j1a
        QPRllujAzE8ORyWu9k89203u5uTL/huccFxZVA2WJ7AF2gQn99EC5GdPMhunr2G6sbm23md/PGW
        NLekPYAYiNkjDmIu6XNXV0MSK9Ypg9yBHwQ/62CTUNw==
X-Received: by 2002:a05:6402:26c8:: with SMTP id x8mr5675183edd.80.1644340754544;
        Tue, 08 Feb 2022 09:19:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyGbFLwRrBY5BwHpSgBbXGOoRElSE/B0TmO0zX/pZeqJzCVowi5xXNxxbrl6PdvIGlV9Er9gw==
X-Received: by 2002:a05:6402:26c8:: with SMTP id x8mr5675152edd.80.1644340754363;
        Tue, 08 Feb 2022 09:19:14 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id r10sm5125550ejy.148.2022.02.08.09.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 09:19:13 -0800 (PST)
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
Subject: [PATCH 03/10] dt-bindings: phy: samsung,exynos-hdmi-phy: convert to dtschema
Date:   Tue,  8 Feb 2022 18:18:16 +0100
Message-Id: <20220208171823.226211-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220208171823.226211-1-krzysztof.kozlowski@canonical.com>
References: <20220208171823.226211-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Exynos HDMI PHY bindings to DT schema format and put them
next to other PHYs.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../display/exynos/exynos_hdmiphy.txt         | 15 -------
 .../bindings/phy/samsung,exynos-hdmi-phy.yaml | 44 +++++++++++++++++++
 2 files changed, 44 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/exynos/exynos_hdmiphy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,exynos-hdmi-phy.yaml

diff --git a/Documentation/devicetree/bindings/display/exynos/exynos_hdmiphy.txt b/Documentation/devicetree/bindings/display/exynos/exynos_hdmiphy.txt
deleted file mode 100644
index 162f641f7639..000000000000
--- a/Documentation/devicetree/bindings/display/exynos/exynos_hdmiphy.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-Device-Tree bindings for hdmiphy driver
-
-Required properties:
-- compatible: value should be one of the following:
-	1) "samsung,exynos5-hdmiphy" <DEPRECATED>
-	2) "samsung,exynos4210-hdmiphy".
-	3) "samsung,exynos4212-hdmiphy".
-- reg: I2C address of the hdmiphy device.
-
-Example:
-
-	hdmiphy {
-		compatible = "samsung,exynos4210-hdmiphy";
-		reg = <0x38>;
-	};
diff --git a/Documentation/devicetree/bindings/phy/samsung,exynos-hdmi-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,exynos-hdmi-phy.yaml
new file mode 100644
index 000000000000..c61574e10b2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/samsung,exynos-hdmi-phy.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/samsung,exynos-hdmi-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos SoC HDMI PHY
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
+      - enum:
+          - samsung,exynos4210-hdmiphy
+          - samsung,exynos4212-hdmiphy
+      - const: samsung,exynos5-hdmiphy
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
+        hdmi-phy@38 {
+            compatible = "samsung,exynos4210-hdmiphy";
+            reg = <0x38>;
+        };
+    };
-- 
2.32.0

