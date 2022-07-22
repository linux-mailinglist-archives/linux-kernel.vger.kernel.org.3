Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01AC57DBFA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbiGVIMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbiGVIL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:11:59 -0400
Received: from smtpout1.mo3004.mail-out.ovh.net (smtpout1.mo3004.mail-out.ovh.net [79.137.123.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF8A9D51D;
        Fri, 22 Jul 2022 01:11:55 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.108.1.79])
        by mo3004.mail-out.ovh.net (Postfix) with ESMTPS id 2159E2454EA;
        Fri, 22 Jul 2022 08:11:54 +0000 (UTC)
Received: from localhost.localdomain (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9; Fri, 22 Jul
 2022 10:11:53 +0200
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <andy.shevchenko@gmail.com>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH v6 1/3] dt-bindings: leds: Add bindings for the TLC5925 controller
Date:   Fri, 22 Jul 2022 10:11:44 +0200
Message-ID: <20220722081146.47262-2-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722081146.47262-1-jjhiblot@traphandler.com>
References: <20220722081146.47262-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG4EX2.emp2.local (172.16.2.32) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 6614099006183717329
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrvddtvddgtdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfgtihesthekredtredttdenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnheptddtffevleejteelieejhfffvedtffeljeehjeeigfejledufedvveejuddtjefhnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfkpheptddrtddrtddrtddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhofedttdeg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings documentation for the TLC5925 LED controller.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/leds/ti,tlc5925.yaml  | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/ti,tlc5925.yaml

diff --git a/Documentation/devicetree/bindings/leds/ti,tlc5925.yaml b/Documentation/devicetree/bindings/leds/ti,tlc5925.yaml
new file mode 100644
index 000000000000..ce376917b423
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/ti,tlc5925.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/ti,tlc5925.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LEDs connected to TI TLC5925 controller
+
+maintainers:
+  - Jean-Jacques Hiblot <jjhiblot@traphandler.com>
+
+description: |
+  The TLC5925 is a low-power 16-channel constant-current LED sink driver.
+  It is controlled through a SPI interface.
+  It is built around a shift register and latches which convert serial
+  input data into a parallel output. Several TLC5925 can be chained to
+  control more than 16 LEDs with a single chip-select.
+  The brightness level cannot be controlled, each LED is either on or off.
+
+  Each LED is represented as a sub-node of the ti,tlc5925 device.
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: ti,tlc5925
+
+  ti,shift-register-length:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 8
+    multipleOf: 8
+    description:
+      The length of the shift register. If several TLC5925 are chained,
+      shift_register_length should be set to 16 times the number of TLC5925.
+      The value must be a multiple of 8.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  output-enable-b-gpios:
+    description:
+      Optional GPIO pins to enable/disable the parallel output. They describe
+      the GPIOs connected to the OE/ pin of the TLC5925s.
+
+patternProperties:
+  "@[0-9a-f]+$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+    properties:
+      reg:
+        description:
+          LED pin number (must be lower than ti,shift-register-length).
+          The furthest LED down the chain has the pin number 0.
+
+    required:
+      - reg
+
+required:
+  - "#address-cells"
+  - "#size-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/leds/common.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        leds@2 {
+            compatible = "ti,tlc5925";
+            reg = <0x02>;
+            spi-max-frequency = <30000000>;
+            ti,shift-register-length = <32>;
+            output-enable-b-gpios = <&gpio0b 9 GPIO_ACTIVE_HIGH>, <&gpio0b 7 GPIO_ACTIVE_HIGH>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            led@0 {
+                reg = <0>;
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_GREEN>;
+            };
+
+            led@4 {
+                reg = <4>;
+                function = LED_FUNCTION_STATUS;
+                color = <LED_COLOR_ID_RED>;
+            };
+
+            led@1f {
+                reg = <31>;
+                function = LED_FUNCTION_PANIC;
+                color = <LED_COLOR_ID_RED>;
+            };
+        };
+
+    };
-- 
2.25.1

