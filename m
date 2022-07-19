Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60DB57A722
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbiGSTTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239095AbiGSTS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:18:56 -0400
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4993A550BD;
        Tue, 19 Jul 2022 12:18:55 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.108.1.33])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id B3616119C4175;
        Tue, 19 Jul 2022 21:18:37 +0200 (CEST)
Received: from localhost.localdomain (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9; Tue, 19 Jul
 2022 21:18:37 +0200
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <sven.schwermer@disruptive-technologies.com>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <johan+linaro@kernel.org>, <marijn.suijten@somainline.org>,
        <bjorn.andersson@linaro.org>, <andy.shevchenko@gmail.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Subject: [PATCH v2 3/4] dt-bindings: leds: Add binding for a multicolor group of LEDs
Date:   Tue, 19 Jul 2022 21:18:00 +0200
Message-ID: <20220719191801.345773-4-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719191801.345773-1-jjhiblot@traphandler.com>
References: <20220719191801.345773-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG2EX1.emp2.local (172.16.2.11) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 255860755238107611
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudeltddgudefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgjfhgggfgtihesthekredtredttdenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnheptddtffevleejteelieejhfffvedtffeljeehjeeigfejledufedvveejuddtjefhnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfkpheptddrtddrtddrtddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehvdek
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to group multiple monochromatic LEDs into a multicolor
LED, e.g. RGB LEDs.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 .../bindings/leds/leds-group-multicolor.yaml  | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
new file mode 100644
index 000000000000..79e5882a08e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/leds-group-multicolor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Multi-color LED built with monochromatic LEDs
+
+maintainers:
+  - Jean-Jacques Hiblot <jjhiblot@traphandler.com>
+
+description: |
+  This driver combines several monochromatic LEDs into one multi-color
+  LED using the multicolor LED class.
+
+properties:
+  compatible:
+    const: leds-group-multicolor
+
+  leds:
+    description:
+      An aray of monochromatic leds
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
+required:
+  - leds
+
+allOf:
+  - $ref: leds-class-multicolor.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/leds/common.h>
+
+    monochromatic-leds {
+        compatible = "gpio-leds";
+
+        led0: led-0 {
+            gpios = <&mcu_pio 0 GPIO_ACTIVE_LOW>;
+        };
+
+        led1: led-1 {
+            gpios = <&mcu_pio 1 GPIO_ACTIVE_HIGH>;
+        };
+
+        led2: led-2 {
+            gpios = <&mcu_pio 1 GPIO_ACTIVE_HIGH>;
+        };
+    };
+
+    multi-led {
+        compatible = "leds-group-multicolor";
+        color = <LED_COLOR_ID_RGB>;
+        function = LED_FUNCTION_INDICATOR;
+        leds = <&led0>, <&led1>, <&led2>;
+    };
+
+...
-- 
2.25.1

