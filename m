Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC0A4AED32
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242536AbiBIIx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:53:29 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242266AbiBIIxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:53:16 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60157E02461C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 00:53:12 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id s18so2752944wrv.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 00:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UboVgMauCJoly95Wb/OTDqKyHdAc/NeskvhhaT+/Rg0=;
        b=uqcPsSQpMZsUmJwetH1iRGtQXHsjvo0kngcHtAHyU46IWm9IELIoZLhspGc9AiYTRX
         URazFP79C22I7+VCkI0XgMFUs92d233fWLwWS5li5R3hshaFr+owSxjCnghv0MNwOUJx
         ttQ17l7U4l/RA6DA1BLm4t0ScMcZJmJdXqdEWjOOrkZtBc41n7E4AelE9D1pU2vI2UHM
         LjJCzGbEnE4e/95RYTpa2uYi0FfKHxXENtuYat+z71JA0bMpritVV6m7FVKxukk/3SHV
         is90yUg8y5LNnsB8MOKN5X7UhZdSWxoUcdmx20ZpyI+x3XcvaWFVXkXZSftfF3XXEkNs
         JyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UboVgMauCJoly95Wb/OTDqKyHdAc/NeskvhhaT+/Rg0=;
        b=tIsjgBqrNqt2MFinfQiDItUldE4nHfKlbfJFEwa6oFfXG+v+zrbtMQszyMu7153RmL
         5j6FCPyuF0iSc7/W+kXz6md4fJaja6Af6UDkijCbNVHkseDFm6f6QyxBPfM4xtgHioni
         fO0at7fY/2hrr6wjmP3n5dPLyOEcYYaIo4pn0vkWqygyEP60kUZptDRsSq9p9JiolKNz
         qNZ6OYFnWfRQikT9gl35DXfSUAjyye20Hwd9/my3bwJoC58PYUXpMsGWuuQ059cyfwK/
         Ti9rSwzr97Ad6TOZma/17anA+ufCEoHPfw1et7n+MYgdN7iao/adTBex3WHuvIEFjdFQ
         iNdw==
X-Gm-Message-State: AOAM531u0n/0NdKrC6AYU5Jb0J0W++570sW1UgHPmQeVkaIsvRHKoVNt
        0GZjjC/q9D52ZlpxRGcep68cUg==
X-Google-Smtp-Source: ABdhPJxth6XdzcknVlyeQ2/HkUu556+xHLbAZXHlKuDBo5RR2zRlufFE/1JxBdBGA9eWz5MgPZCbkg==
X-Received: by 2002:a5d:47c9:: with SMTP id o9mr1238727wrc.546.1644396787210;
        Wed, 09 Feb 2022 00:53:07 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 1sm16943718wry.52.2022.02.09.00.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 00:53:06 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     brgl@bgdev.pl, krzysztof.kozlowski@canonical.com,
        linus.walleij@linaro.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2] dt-bindings: gpio: convert faraday,ftgpio01 to yaml
Date:   Wed,  9 Feb 2022 08:52:58 +0000
Message-Id: <20220209085258.1468649-1-clabbe@baylibre.com>
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

Converts gpio/faraday,ftgpio010.txt to yaml.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
Change since v1:
- added reviewed-by
- put blank lines between DT property
- removed useless quotes

This commit will cause arch/arm/boot/dts/moxart-uc7112lx.dts to fail DT validation,
but the GPIO driver need an interrupt so the current moxart DT is incomplete and the error is appropriate.
 .../bindings/gpio/faraday,ftgpio010.txt       | 27 --------
 .../bindings/gpio/faraday,ftgpio010.yaml      | 65 +++++++++++++++++++
 2 files changed, 65 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/faraday,ftgpio010.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/faraday,ftgpio010.yaml

diff --git a/Documentation/devicetree/bindings/gpio/faraday,ftgpio010.txt b/Documentation/devicetree/bindings/gpio/faraday,ftgpio010.txt
deleted file mode 100644
index d04236558619..000000000000
--- a/Documentation/devicetree/bindings/gpio/faraday,ftgpio010.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-Faraday Technology FTGPIO010 GPIO Controller
-
-Required properties:
-
-- compatible : Should be one of
-  "cortina,gemini-gpio", "faraday,ftgpio010"
-  "moxa,moxart-gpio", "faraday,ftgpio010"
-  "faraday,ftgpio010"
-- reg : Should contain registers location and length
-- interrupts : Should contain the interrupt line for the GPIO block
-- gpio-controller : marks this as a GPIO controller
-- #gpio-cells : Should be 2, see gpio/gpio.txt
-- interrupt-controller : marks this as an interrupt controller
-- #interrupt-cells : a standard two-cell interrupt flag, see
-  interrupt-controller/interrupts.txt
-
-Example:
-
-gpio@4d000000 {
-	compatible = "cortina,gemini-gpio", "faraday,ftgpio010";
-	reg = <0x4d000000 0x100>;
-	interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
-	gpio-controller;
-	#gpio-cells = <2>;
-	interrupt-controller;
-	#interrupt-cells = <2>;
-};
diff --git a/Documentation/devicetree/bindings/gpio/faraday,ftgpio010.yaml b/Documentation/devicetree/bindings/gpio/faraday,ftgpio010.yaml
new file mode 100644
index 000000000000..640da5b9b0cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/faraday,ftgpio010.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/faraday,ftgpio010.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Faraday Technology FTGPIO010 GPIO Controller
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: cortina,gemini-gpio
+          - const: faraday,ftgpio010
+      - items:
+          - const: moxa,moxart-gpio
+          - const: faraday,ftgpio010
+      - const: faraday,ftgpio010
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
+  interrupts:
+    maxItems: 1
+    description: Should contain the interrupt line for the GPIO block
+
+  gpio-controller: true
+  "#gpio-cells":
+    const: 2
+
+  interrupt-controller: true
+  "#interrupt-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#gpio-cells"
+  - interrupt-controller
+  - "#interrupt-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    gpio@4d000000 {
+      compatible = "cortina,gemini-gpio", "faraday,ftgpio010";
+      reg = <0x4d000000 0x100>;
+      interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
+      gpio-controller;
+      #gpio-cells = <2>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+    };
-- 
2.34.1

