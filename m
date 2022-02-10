Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD0C4B121D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 16:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243828AbiBJPzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 10:55:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243824AbiBJPzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 10:55:02 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7EFC2C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 07:55:02 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id w11so10398903wra.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 07:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gQDU3n0e11Xg2+7UZznvauAxifO/32EZJQ/CMSCp/cs=;
        b=V844y5pKhCA2MbojDtVXu5FIu2uj/NkVHCvk21W67ci8RQSvzBPLQibKTq8ndC8xEp
         /6lFy/eeOsQImxXKw4UhBgi94Da2VYfKMRMvMIZ3LbEswFXqmKr/89BLMVY3DQf0C5gn
         jpfdPnfo81LkkCtqF4O41kjXgdEKa7EWh4gFe41x8mDCZXNaSwgZl0KWmf91aq5+EiTZ
         8jbdSqsAlpfeNlnfTGi/5j0ArHAyRI4+OkzmSliRQFfl8zads48mqhkMnYeQjU6zS2SO
         8zOwtJErL/EkrgGGUmDvSVce79Grxx7W0OsCqqfyl/XcYmpkzqxDvKefc2UDZu0VCLEE
         N+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gQDU3n0e11Xg2+7UZznvauAxifO/32EZJQ/CMSCp/cs=;
        b=N8a8PE5PdahHs3ir1j9q1Gdsfx7uhMjhKCNirduelARZC9Ztpxpn/Fajtz1/XPp0G/
         JcVihe6Lk3pXbUa8BzXIhxz4qFonoW5NoAKkzAK2TACGwBFV9pYfmtFsnpC2OwhyjHeo
         bpiWLDC8ID43NR+g766ixoaT1GhQGBfXOC5KhWc8/wfhA2tqX0Y/FFEHY3znKtYpt50D
         1Uc72nL2KuG4LhoaVunrMblgRO2R+qbpZRP7jbdjEj8aw2Es2goOe9JD535dEsjGwoGA
         fGsSCx7g6rjOd5M+tBbt3E8c1kQtbjoAyfqWxJ6gszm2efpWLV4ZUN+9FkROUkA/zTCS
         KoIw==
X-Gm-Message-State: AOAM532nYUBffXunS5vX15szVFj4yZOPcawr5WrYzX2moIBuSeaYUBlw
        tz+J1bkfiveFnjcd81vx/kcS3PmA3R6axg==
X-Google-Smtp-Source: ABdhPJw1iWrj+ENDvwHvi8dSh+4uDNTmnt8/bAdZlwC5WT33CxX/cREDi31wWF2rlbjKTt+awhJr4w==
X-Received: by 2002:adf:f990:: with SMTP id f16mr6761115wrr.27.1644508500767;
        Thu, 10 Feb 2022 07:55:00 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id d4sm21917972wri.39.2022.02.10.07.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 07:55:00 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     krzysztof.kozlowski@canonical.com, linux@roeck-us.net,
        robh+dt@kernel.org, wim@linux-watchdog.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3] dt-bindings: watchdog: convert faraday,ftwdt010 to yaml
Date:   Thu, 10 Feb 2022 15:54:50 +0000
Message-Id: <20220210155450.2939129-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts watchdog/faraday,ftwdt010.txt to yaml.
This permits to detect missing properties like clocks and resets or
compatible like moxa,moxart-watchdog.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
Changes since v1:
- Added myself as maintainer as requested by Linus
- Added $ref to watchdog.yaml
- Removed useless quotes
- Added blank lines between properties
- Removed timeout-sec as already provided by watchdog.yaml

Change since v2:
- rewrite compatible section

 .../bindings/watchdog/faraday,ftwdt010.txt    | 22 -------
 .../bindings/watchdog/faraday,ftwdt010.yaml   | 66 +++++++++++++++++++
 2 files changed, 66 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.txt b/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.txt
deleted file mode 100644
index 9ecdb502e605..000000000000
--- a/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Faraday Technology FTWDT010 watchdog
-
-This is an IP part from Faraday Technology found in the Gemini
-SoCs and others.
-
-Required properties:
-- compatible : must be one of
-  "faraday,ftwdt010"
-  "cortina,gemini-watchdog", "faraday,ftwdt010"
-- reg : shall contain base register location and length
-- interrupts : shall contain the interrupt for the watchdog
-
-Optional properties:
-- timeout-sec : the default watchdog timeout in seconds.
-
-Example:
-
-watchdog@41000000 {
-	compatible = "faraday,ftwdt010";
-	reg = <0x41000000 0x1000>;
-	interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
-};
diff --git a/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml b/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml
new file mode 100644
index 000000000000..e7b90ba41093
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/faraday,ftwdt010.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Faraday Technology FTWDT010 watchdog
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+  - Corentin Labbe <clabbe@baylibre.com>
+
+description: |
+  This is an IP part from Faraday Technology found in the Gemini
+  SoCs and others.
+
+allOf:
+  - $ref: "watchdog.yaml#"
+
+properties:
+  compatible:
+    oneOf:
+      - const: faraday,ftwdt010
+      - items:
+        - enum:
+          - cortina,gemini-watchdog
+          - moxa,moxart-watchdog
+        - const: faraday,ftwdt010
+
+  reg:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: PCLK
+
+  interrupts:
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+    watchdog@41000000 {
+      compatible = "faraday,ftwdt010";
+      reg = <0x41000000 0x1000>;
+      interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+    };
+  - |
+    watchdog: watchdog@98500000 {
+      compatible = "moxa,moxart-watchdog", "faraday,ftwdt010";
+      reg = <0x98500000 0x10>;
+      clocks = <&clk_apb>;
+      clock-names = "PCLK";
+    };
+...
-- 
2.34.1

