Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0845649EC05
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240473AbiA0UDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344042AbiA0UDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:03:19 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC6DC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:03:19 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c2so2733411wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dnjZ8liPA7/h3/BthPRXMHnMC8m+sC0gjHgL+cd4U/I=;
        b=31Il6k2wbhFteM2EahuPKQvm/lr9RvdgDCD6s5QLGsl0LmNRIE6h5kcrTp7O0AfYNF
         C9ltMr2PWZmeJ6i2zzhfwKrcFiUjKRhshqt/Z+8D5bNHMaGpvZA6T9tr6OB9EEIHS+60
         /eG6IodF90L95zkJ3sJDfyI1flgCXQAehkPNbnTQ0WSr6E24FiDRtjGVQ6DnS5gndVLd
         alPMfVm+NbqF3rCQKcrQrk3gOu6QjMIh/KNtMkgWyQTl9kzXO72F68YaJSLpFWf8LzWF
         Q+mWdcKxfIDKCab0wNy1Cwvhru/oKi76xXPJ0UMKlilm16suruJ1LVBW4PCZ/4rY5Cw2
         N5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dnjZ8liPA7/h3/BthPRXMHnMC8m+sC0gjHgL+cd4U/I=;
        b=tzperiBghM0aTB5r/HN2he1rIatKU4w9aGxWJ9AZl99Qe7AVw0GKb5JXjbyblgbu6N
         qLaKRrL8gU5znjzZkkltidsQKQqG4nalQoiy1WklVPOPEl2sDhOsjxNHXGDozs6FZ5ws
         XaDBlVl9F3CYJp+CfCSEd0Ri8qiICYf+FoTpHSCzpx5j2UoHryCnqF5qQxYFA/j02Koe
         gqQvtL7kegkgsryzRVzRHRYmmJ4+JrU/qPM2wjz5i+Vv3nNDI33uyxUfrsfdhJU/OkR1
         19FgXwZrIz0Hjl+iMfAUmSGhbYMSK6PYzvJKZs4LkVNMyRlbQgnqSar4mCWrcdqPo0bD
         0M/Q==
X-Gm-Message-State: AOAM531cDNBwW7zd3ttC6tN/wWO3PK58qEn7GeulaUPJ9wmeytwG13Uz
        PrccD8pZfXRAJloDpyYzJMDyIQ==
X-Google-Smtp-Source: ABdhPJxIUkgCivPsX6P4xZCeLOZ1heJIgNFK8ZctU0b8awNySJplRGbBoHfb06LcKnNkxi1FdrJdtw==
X-Received: by 2002:a7b:cbce:: with SMTP id n14mr13053351wmi.90.1643313798177;
        Thu, 27 Jan 2022 12:03:18 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x6sm3328301wrn.18.2022.01.27.12.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 12:03:17 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     linus.walleij@linaro.org, miquel.raynal@bootlin.com,
        richard@nod.at, robh+dt@kernel.org, vigneshr@ti.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] dt-bindings: mtd: drop mtd/cortina,gemini-flash.txt
Date:   Thu, 27 Jan 2022 20:03:10 +0000
Message-Id: <20220127200310.4150981-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop mtd/cortina,gemini-flash.txt since it is nearly already handled by
Documentation/devicetree/bindings/mtd/mtd-physmap.yaml.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../bindings/mtd/cortina,gemini-flash.txt     | 24 -------------------
 .../devicetree/bindings/mtd/mtd-physmap.yaml  | 18 +++++++++++++-
 2 files changed, 17 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/cortina,gemini-flash.txt

diff --git a/Documentation/devicetree/bindings/mtd/cortina,gemini-flash.txt b/Documentation/devicetree/bindings/mtd/cortina,gemini-flash.txt
deleted file mode 100644
index efa5b2aba829..000000000000
--- a/Documentation/devicetree/bindings/mtd/cortina,gemini-flash.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Flash device on Cortina Systems Gemini SoC
-
-This flash is regular CFI compatible (Intel or AMD extended) flash chips with
-some special bits that can be controlled by the machine's system controller.
-
-Required properties:
-- compatible : must be "cortina,gemini-flash", "cfi-flash";
-- reg : memory address for the flash chip
-- syscon : must be a phandle to the system controller
-- bank-width : width in bytes of flash interface, should be <2>
-
-For the rest of the properties, see mtd-physmap.yaml.
-
-The device tree may optionally contain sub-nodes describing partitions of the
-address space. See partition.txt for more detail.
-
-Example:
-
-flash@30000000 {
-	compatible = "cortina,gemini-flash", "cfi-flash";
-	reg = <0x30000000 0x01000000>;
-	syscon = <&syscon>;
-	bank-width = <2>;
-};
diff --git a/Documentation/devicetree/bindings/mtd/mtd-physmap.yaml b/Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
index f827984936f6..5b4440e005bc 100644
--- a/Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
+++ b/Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
@@ -44,7 +44,9 @@ properties:
               - numonyx,js28f128
               - sst,sst39vf320
               - xlnx,xps-mch-emc-2.00.a
-          - const: cfi-flash
+          - enum:
+              - cfi-flash
+              - jedec-flash
       - items:
           - enum:
               - cypress,cy7c1019dv33-10zsxi
@@ -127,6 +129,20 @@ required:
   - compatible
   - reg
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: cortina,gemini-flash
+then:
+  properties:
+    syscon:
+      $ref: /schemas/types.yaml#/definitions/phandle
+      description:
+        Phandle to the syscom controller
+  required:
+    - syscon
+
 # FIXME: A parent bus may define timing properties
 additionalProperties: true
 
-- 
2.34.1

