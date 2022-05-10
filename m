Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD14521146
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbiEJJsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238439AbiEJJsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:48:18 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBDD29B814
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:44:18 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7C6BA2C0230;
        Tue, 10 May 2022 09:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1652175855;
        bh=CV+nnOcVdQpKcQgRV0xaZ1gbK67yRvqbHUPMIFx963c=;
        h=From:To:Cc:Subject:Date:From;
        b=JoFE27gO/Ez8LMOL1AkLzWX4Qkfe7EEJNX2E3ihIR9mvzEzvN1tx8Ox6kSlfMZs8r
         T9kCoK2rxlnd2y9BHaC1dgVHC2PgjR0lwd102U1UswBkGgDz1FY8Qlnw+xg7ZTs6zR
         zKQEZxKbKy+lcgE+qfDsCWPR6hJe/f0kkdIKyVFzUqDYNXQpvH5HdW+vwrcxXUjAyD
         FiBf5gw0egfG6y185RpHzNNWsxb/1n6B4NeXjqDP8QGHHzAYAFfOz+FxEOeobuyTna
         vslC3W3GM0ypTLfOzEWYigsljbGZFWxcicUK3Lw52Zpz8T888PfK18XdPOQglch3jF
         hLpONa6On0Bgg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B627a33ee0000>; Tue, 10 May 2022 21:44:14 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 6F1CC13ECEC;
        Tue, 10 May 2022 21:44:14 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 69B952A00D3; Tue, 10 May 2022 21:44:14 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] dt-bindings: gpio: gpio-mvebu: convert txt binding to YAML
Date:   Tue, 10 May 2022 21:44:04 +1200
Message-Id: <20220510094404.1020307-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=C7GXNjH+ c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=oZkIemNP1mAA:10 a=gEfo2CItAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=voM4FWlXAAAA:8 a=yZ6uvJJHfemicqfEXc0A:9 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22 a=IC2XNlieTeVoXbcui8wp:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the existing device tree binding to YAML format.

The old binding listed the interrupt-controller and related properties
as required but there are sufficiently many existing usages without it
that the YAML binding does not make the interrupt properties required.

The offset and marvell,pwm-offset properties weren't in the old binding
and are added to the YAML binding. The offset property is required when
the marvell,armada-8k-gpio compatible is used.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 .../devicetree/bindings/gpio/gpio-mvebu.txt   |  93 -----------
 .../devicetree/bindings/gpio/gpio-mvebu.yaml  | 147 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 3 files changed, 148 insertions(+), 94 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-mvebu.yam=
l

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt b/Docu=
mentation/devicetree/bindings/gpio/gpio-mvebu.txt
deleted file mode 100644
index 0fc6700ed800..000000000000
--- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
+++ /dev/null
@@ -1,93 +0,0 @@
-* Marvell EBU GPIO controller
-
-Required properties:
-
-- compatible : Should be "marvell,orion-gpio", "marvell,mv78200-gpio",
-  "marvell,armadaxp-gpio" or "marvell,armada-8k-gpio".
-
-    "marvell,orion-gpio" should be used for Orion, Kirkwood, Dove,
-    Discovery (except MV78200) and Armada 370. "marvell,mv78200-gpio"
-    should be used for the Discovery MV78200.
-
-    "marvel,armadaxp-gpio" should be used for all Armada XP SoCs
-    (MV78230, MV78260, MV78460).
-
-    "marvell,armada-8k-gpio" should be used for the Armada 7K and 8K
-    SoCs (either from AP or CP), see
-    Documentation/devicetree/bindings/arm/marvell/ap80x-system-controlle=
r.txt
-    for specific details about the offset property.
-
-- reg: Address and length of the register set for the device. Only one
-  entry is expected, except for the "marvell,armadaxp-gpio" variant
-  for which two entries are expected: one for the general registers,
-  one for the per-cpu registers. Not used for marvell,armada-8k-gpio.
-
-- interrupts: The list of interrupts that are used for all the pins
-  managed by this GPIO bank. There can be more than one interrupt
-  (example: 1 interrupt per 8 pins on Armada XP, which means 4
-  interrupts per bank of 32 GPIOs).
-
-- interrupt-controller: identifies the node as an interrupt controller
-
-- #interrupt-cells: specifies the number of cells needed to encode an
-  interrupt source. Should be two.
-  The first cell is the GPIO number.
-  The second cell is used to specify flags:
-    bits[3:0] trigger type and level flags:
-      1 =3D low-to-high edge triggered.
-      2 =3D high-to-low edge triggered.
-      4 =3D active high level-sensitive.
-      8 =3D active low level-sensitive.
-
-- gpio-controller: marks the device node as a gpio controller
-
-- ngpios: number of GPIOs this controller has
-
-- #gpio-cells: Should be two. The first cell is the pin number. The
-  second cell is reserved for flags, unused at the moment.
-
-Optional properties:
-
-In order to use the GPIO lines in PWM mode, some additional optional
-properties are required.
-
-- compatible: Must contain "marvell,armada-370-gpio"
-
-- reg: an additional register set is needed, for the GPIO Blink
-  Counter on/off registers.
-
-- reg-names: Must contain an entry "pwm" corresponding to the
-  additional register range needed for PWM operation.
-
-- #pwm-cells: Should be two. The first cell is the GPIO line number. The
-  second cell is the period in nanoseconds.
-
-- clocks: Must be a phandle to the clock for the GPIO controller.
-
-Example:
-
-		gpio0: gpio@d0018100 {
-			compatible =3D "marvell,armadaxp-gpio";
-			reg =3D <0xd0018100 0x40>,
-			    <0xd0018800 0x30>;
-			ngpios =3D <32>;
-			gpio-controller;
-			#gpio-cells =3D <2>;
-			interrupt-controller;
-			#interrupt-cells =3D <2>;
-			interrupts =3D <16>, <17>, <18>, <19>;
-		};
-
-		gpio1: gpio@18140 {
-			compatible =3D "marvell,armada-370-gpio";
-			reg =3D <0x18140 0x40>, <0x181c8 0x08>;
-			reg-names =3D "gpio", "pwm";
-			ngpios =3D <17>;
-			gpio-controller;
-			#gpio-cells =3D <2>;
-			#pwm-cells =3D <2>;
-			interrupt-controller;
-			#interrupt-cells =3D <2>;
-			interrupts =3D <87>, <88>, <89>;
-			clocks =3D <&coreclk 0>;
-		};
diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml b/Doc=
umentation/devicetree/bindings/gpio/gpio-mvebu.yaml
new file mode 100644
index 000000000000..84b72e506526
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
@@ -0,0 +1,147 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/gpio-mvebu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell EBU GPIO controller
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Lee Jones <lee.jones@linaro.org>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - marvell,orion-gpio
+          - marvell,mv78200-gpio
+          - marvell,armada-370-gpio
+          - marvell,armadaxp-gpio
+          - marvell,armada-8k-gpio
+      - items:
+          - const: marvell,armada-370-gpio
+          - const: marvell,orion-gpio
+
+    description: |
+      "marvell,orion-gpio" should be used for Orion, Kirkwood, Dove, Dis=
covery
+      (except MV78200) and Armada 370. "marvell,mv78200-gpio" should be =
used
+      for the Discovery MV78200.
+
+      "marvel,armadaxp-gpio" should be used for all Armada XP SoCs (MV78=
230,
+      MV78260, MV78460).
+
+      "marvell,armada-8k-gpio" should be used for the Armada 7K and 8K S=
oCs
+      (either from AP or CP), see
+      Documentation/devicetree/bindings/arm/marvell/ap80x-system-control=
ler.txt
+      for specific details about the offset property.
+
+  reg:
+    description: |
+      Address and length of the register set for the device. Only one en=
try
+      is expected, except for the "marvell,armadaxp-gpio" variant for wh=
ich
+      two entries are expected: one for the general registers, one for t=
he
+      per-cpu registers. Not used for marvell,armada-8k-gpio.
+
+      An additional register set is needed, for the GPIO Blink
+      Counter on/off registers.
+    minItems: 1
+    maxItems: 2
+
+  reg-names:
+    description:
+      Must contain an entry "pwm" corresponding to the
+      additional register range needed for PWM operation.
+    minItems: 1
+    maxItems: 2
+
+  offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Offset in the register map for the gpio registers (in b=
ytes)
+
+  interrupts:
+    description: |
+      The list of interrupts that are used for all the pins managed by t=
his
+      GPIO bank. There can be more than one interrupt (example: 1 interr=
upt
+      per 8 pins on Armada XP, which means 4 interrupts per bank of 32
+      GPIOs).
+    minItems: 1
+    maxItems: 4
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  gpio-controller: true
+
+  ngpios:
+    description:
+      number of GPIOs this controller has
+    minimum: 1
+    maximum: 32
+
+  "#gpio-cells":
+    const: 2
+
+  marvell,pwm-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Offset in the register map for the pwm registers (in by=
tes)
+
+  "#pwm-cells":
+    description:
+      The first cell is the GPIO line number. The second cell is the per=
iod
+      in nanoseconds.
+    const: 2
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+required:
+  - compatible
+  - gpio-controller
+  - ngpios
+  - "#gpio-cells"
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: marvell,armada-8k-gpio
+then:
+  required:
+    - offset
+else:
+  required:
+    - reg
+
+unevaluatedProperties: true
+
+examples:
+  - |
+      gpio@d0018100 {
+        compatible =3D "marvell,armadaxp-gpio";
+        reg =3D <0xd0018100 0x40>, <0xd0018800 0x30>;
+        ngpios =3D <32>;
+        gpio-controller;
+        #gpio-cells =3D <2>;
+        interrupt-controller;
+        #interrupt-cells =3D <2>;
+        interrupts =3D <16>, <17>, <18>, <19>;
+      };
+
+  - |
+      gpio@18140 {
+        compatible =3D "marvell,armada-370-gpio";
+        reg =3D <0x18140 0x40>, <0x181c8 0x08>;
+        reg-names =3D "gpio", "pwm";
+        ngpios =3D <17>;
+        gpio-controller;
+        #gpio-cells =3D <2>;
+        #pwm-cells =3D <2>;
+        interrupt-controller;
+        #interrupt-cells =3D <2>;
+        interrupts =3D <87>, <88>, <89>;
+        clocks =3D <&coreclk 0>;
+      };
diff --git a/MAINTAINERS b/MAINTAINERS
index e8c52d0192a6..6b1c80fd7611 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16019,7 +16019,7 @@ L:	linux-pwm@vger.kernel.org
 S:	Maintained
 Q:	https://patchwork.ozlabs.org/project/linux-pwm/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linu=
x-pwm.git
-F:	Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
+F:	Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
 F:	Documentation/devicetree/bindings/pwm/
 F:	Documentation/driver-api/pwm.rst
 F:	drivers/gpio/gpio-mvebu.c
--=20
2.36.0

