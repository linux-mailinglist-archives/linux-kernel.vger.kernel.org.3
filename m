Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6077530BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbiEWIuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiEWIuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:50:13 -0400
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FDF6472
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:50:10 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.109.143.120])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 8F21E10347F4B;
        Mon, 23 May 2022 10:50:08 +0200 (CEST)
Received: from localhost.localdomain (88.161.25.233) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9; Mon, 23 May
 2022 10:50:08 +0200
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
CC:     <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] dt-bindings: leds: Add bindings for the TLC5925 controller
Date:   Mon, 23 May 2022 10:49:55 +0200
Message-ID: <20220523084958.2723943-2-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523084958.2723943-1-jjhiblot@traphandler.com>
References: <20220523084958.2723943-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG8EX2.emp2.local (172.16.2.82) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 5386305156936645083
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrjedtgddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgtghisehtkeertdertddtnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpedttdffveeljeetleeijefhffevtdffleejheejiefgjeeludefvdevjedutdejhfenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppedtrddtrddtrddtpdekkedrudeiuddrvdehrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings documentation for the TLC5925 LED controller.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
devicetree@vger.kernel.org
 .../bindings/leds/leds-tlc5925.yaml           | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-tlc5925.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-tlc5925.yaml b/Documentation/devicetree/bindings/leds/leds-tlc5925.yaml
new file mode 100644
index 000000000000..156db599d5a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-tlc5925.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/leds-tlc5925.yaml#
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
+properties:
+  compatible:
+    const: ti,tlc5925
+
+  shift_register_length:
+    maxItems: 1
+    description: |
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
+    description: |
+      GPIO pins to enable/disable the parallel output. They describe the GPIOs
+      connected to the OE/ pin of the TLC5925s.
+
+patternProperties:
+  "@[a-f0-9]+$":
+    type: object
+
+    $ref: common.yaml#
+
+    properties:
+      reg:
+        items:
+        description: |
+          LED pin number (must be lower than shift_register_length).
+          The furthest LED down the chain has the pin number 0.
+
+    required:
+      - reg
+
+required:
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - shift_register_length
+
+examples:
+  - |
+    &spi0 {
+        leds@2 {
+                compatible = "ti,tlc5925";
+                reg = <0x02>;
+                spi-max-frequency = <30000000>;
+                shift_register_length = <32>;
+                output-enable-b-gpios = <&gpio0b 9 GPIO_ACTIVE_HIGH>, <&gpio0b 7 GPIO_ACTIVE_HIGH>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led-satus@0 {
+                        reg = <0>;
+                        function = LED_FUNCTION_STATUS;
+                        color = <LED_COLOR_ID_GREEN>;
+                };
+
+                led-satus@4 {
+                        reg = <4>;
+                        function = LED_FUNCTION_STATUS;
+                        color = <LED_COLOR_ID_RED>;
+                };
+
+                led-alive@24 {
+                        reg = <24>;
+                        label = "green:alive"
+                };
+
+                led-panic@31 {
+                        reg = <31>;
+                        label = "red:panic"
+                };
+        };
+    };
-- 
2.25.1

