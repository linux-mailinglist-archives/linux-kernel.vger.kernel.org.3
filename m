Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01D64AACCD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 22:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380751AbiBEV7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 16:59:50 -0500
Received: from mailserv1.kapsi.fi ([91.232.154.157]:52990 "EHLO
        mailserv1.kapsi.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351002AbiBEV7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 16:59:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=ext.kapsi.fi; s=20161220; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6Z08zw8GPYqaS2TD7Ieq2MqRlSnLB18cTeBXjvmX1cE=; b=DbGUbspCHFW47QvBKZEmj/Zaeq
        UjgDxbo6xF3Ii6w00HSM47B/QBiI4132+3Dlg2bagsqY9OGdfZAa7u8z7GIJSMoJC+sM0h8VBe8n3
        PvSlm5H6r76UQMzXfNFQS8B+H9f2RLFii6KyRARNUpLEZ+1NsS5m96ZEJGjsehsnQEUvL9rvLAYQL
        UWqDhCQOrcglw1mF2CTb8iB2DOwQzDRU5th66OdRE2yCUenFEge4g7dY55uJxtx8zV6AT4T89XmBX
        DtZkRaGzkB4ld2Hu9oaX5vNT43dadKFDPuIzOy9dGRRKq3ZuSXtn6uDnIZBHNB/WMvAbjynEeBuGk
        0YatFeeg==;
Received: from 246-30-196-88.dyn.estpak.ee ([88.196.30.246]:49929 helo=localhost)
        by mailserv1.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <maukka@ext.kapsi.fi>)
        id 1nGT5p-0006cQ-9m; Sat, 05 Feb 2022 23:59:42 +0200
Received: by localhost (sSMTP sendmail emulation); Sat, 05 Feb 2022 23:59:40 +0200
From:   Mauri Sandberg <maukka@ext.kapsi.fi>
To:     bgolaszewski@baylibre.com, brgl@bgdev.pl
Cc:     andy.shevchenko@gmail.com, geert+renesas@glider.be,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, drew@beagleboard.org,
        Mauri Sandberg <maukka@ext.kapsi.fi>,
        Rob Herring <robh@kernel.org>
Date:   Sat,  5 Feb 2022 23:59:17 +0200
Message-Id: <20220205215918.8924-2-maukka@ext.kapsi.fi>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220205215918.8924-1-maukka@ext.kapsi.fi>
References: <20210325122832.119147-1-sandberg@mailfence.com>
 <20220205215918.8924-1-maukka@ext.kapsi.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 88.196.30.246
X-SA-Exim-Mail-From: maukka@ext.kapsi.fi
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mailserv1.kapsi.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [RESEND v8 1/2] dt-bindings: gpio-cascade: add documentation
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mailserv1.kapsi.fi)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for a general GPIO cascade. It allows building
one-to-many cascades of GPIO lines using multiplexer to choose
the cascaded line.

Signed-off-by: Mauri Sandberg <maukka@ext.kapsi.fi>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
v7 -> v8:
 - added Reviewed-by tag by Linus
v6 -> v7:
 - no changes
v5 -> v6:
 - added Reviewed-by tag by Rob
v4 -> v5:
 - renamed gpio-mux-input -> gpio-cascade
 - changed vague term 'pin' to 'upstream line'
 - added more verbose description for the module
 - added missing 'mux-controls' entry
 - dropped Tested-by and Reviewed-by due to changes in bindings
v3 -> v4:
 - Changed author email
 - Included Tested-by and Reviewed-by from Drew
v2 -> v3: added a complete example on dual 4-way multiplexer
v1 -> v2: added a little bit more text in the binding documenation
---
 .../bindings/gpio/gpio-cascade.yaml           | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-cascade.yaml

diff --git a/Documentation/devicetree/bindings/gpio/gpio-cascade.yaml b/Documentation/devicetree/bindings/gpio/gpio-cascade.yaml
new file mode 100644
index 000000000000..46248f8e2ba5
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-cascade.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/gpio-cascade.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic GPIO cascade
+
+maintainers:
+  - Mauri Sandberg <maukka@ext.kapsi.fi>
+
+description: |
+  A generic GPIO cascade
+
+  This hardware construction cascades (multiplexes) several GPIO lines from
+  one-to-many using a software controlled multiplexer. The most common use
+  case is probably reading several inputs by switching the multiplexer over
+  several input lines, which in practice works well since input lines has
+  high impedance.
+
+  Constructions with multiplexed outputs are also possible using open drain
+  electronics.
+
+  The number of cascaded GPIO lines is limited by the technology used to
+  switch over the cascaded lines. There are readily available dual/triple
+  4-to-1 multiplexers, for example, and others.
+
+  Illustration (pins used to drive the multiplexer are omitted for clarity)
+
+                 /|---- Cascaded GPIO line 0
+  Upstream      | |---- Cascaded GPIO line 1
+  GPIO line ----+ | .
+                | | .
+                 \|---- Cascaded GPIO line n
+
+properties:
+  compatible:
+    enum:
+      - gpio-cascade
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  mux-controls:
+    minItems: 1
+    maxItems: 1
+    description: |
+      The mux controller that will be driving the GPIO cascade.
+
+  upstream-gpios:
+    description: |
+      The GPIO line used as the upstream line will convey the status to/from
+      cascaded GPIO lines. In an input mode, by using this line, it is
+      possible to read the status from selected cascaded GPIO line.
+
+      In an output mode the status of the upstream GPIO will be conveyed to
+      the selected cascaded GPIO line.
+
+required:
+  - compatible
+  - gpio-controller
+  - "#gpio-cells"
+  - mux-controls
+  - upstream-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    mux: mux-controller {
+        compatible = "gpio-mux";
+        #mux-control-cells = <0>;
+
+        mux-gpios = <&gpio 9 GPIO_ACTIVE_HIGH>,
+                    <&gpio 11 GPIO_ACTIVE_HIGH>;
+    };
+
+    gpio2: key-mux1 {
+        compatible = "gpio-cascade";
+        mux-controls = <&mux>;
+
+        gpio-controller;
+        #gpio-cells = <2>;
+
+        // GPIOs used by this node, upstream pin
+        upstream-gpios = <&gpio 12 GPIO_ACTIVE_HIGH>;
+    };
+
+    gpio3: key-mux2 {
+        compatible = "gpio-cascade";
+        mux-controls = <&mux>;
+
+        gpio-controller;
+        #gpio-cells = <2>;
+
+        // GPIOs used by this node, upstream pin
+        upstream-gpios = <&gpio 14 GPIO_ACTIVE_HIGH>;
+    };
+
+...
-- 
2.25.1

