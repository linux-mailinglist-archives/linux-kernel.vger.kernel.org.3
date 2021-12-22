Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C075947D261
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240880AbhLVMq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:46:29 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:60609 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240913AbhLVMqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:46:23 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id D29615803CD;
        Wed, 22 Dec 2021 07:46:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 22 Dec 2021 07:46:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm2; bh=
        /0L1d4qF1zV4rH2U8KCiQalyzRKpjCVvJn5v0TcvaFw=; b=yH9C5y8hYPnB8x8R
        OzaTD89PFB8sxXUtsTiDEONlhX4nhRHZ7vTwDO408QhUA7JHl3S2puwNus9XGmuA
        YAGAEyxRwzEEB9wnSi8CWCkkuRg839qU3Puo8oMd88QlpyZDa2d/1SAddL9Zp90W
        iemFSEkmNUcHdcC6Wb+LaCCCXsfkx9BUANY0aF1Xmo7184c3zMicZYi63oW+374f
        wNZwtj/gNs/1lPtpS4bc5JWvaKkdyXswS7LLI7vteb0ycuVYkEywe/nIo/cu3fxu
        Bthg1MaAHaaQrJziTocjjUcYH+UuFTuUZ6qrNUUpS6Ue+F4eqXkvfvjsX6r0s+Qh
        9vuHzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=/0L1d4qF1zV4rH2U8KCiQalyzRKpjCVvJn5v0Tcva
        Fw=; b=Qh85zWWXAVq9Up6r+zRDCznQKY+cQC+FNBTYqTeVtAVZNz/2cJS71SxTa
        zjvM7xG6DfzySqiz8jRfrBNJuAaklw0ec7Rx6NTMHfqUpAuWwp99gaIlDo03c+hp
        hJRXidEs+6n8CJvYB4OyavJIZwBcFgXa+dwXnkNGZApTN4K8hQB4RPaHsUg3z2/B
        hjvseQXQptSSPS+joWgAd9xZdfsepKChNRa14aangJoTKz+OKva0XbxnYCS/BVuT
        UsQL43kiKKgaDCJirf0wZTOUk24fsyfBLb4GUmJgL0wpI8cZs34WrZyvoSr3mgWn
        rKFPXDl0Vubsl3+V20rD46XwbF4Zg==
X-ME-Sender: <xms:HR7DYXNkwC9JB3n9UCeT4vfeY3i3PNBhPST4JGY23yE-MV7HpGubIw>
    <xme:HR7DYR8zJMtylhWbWZzq1uojvcu23fJiFRVNj1XO_aVH-3cwBmyM4kCE0NuPsA7VN
    i-ZYEe8RDfkM0th8hI>
X-ME-Received: <xmr:HR7DYWT2S_71vFucVVdFX-yOWGYYHtbj-dtqkhtJwuR4SzsbvE44aXgc0K5OJVSJ-Smq2Jffbto>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddruddtiedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheptehlihhs
    thgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmh
    gvqeenucggtffrrghtthgvrhhnpeefudehhfevgfffleeiffehuddvgedtueeujeeifefh
    jeejvdeivddugfehfeehjeenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhs
    thgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:HR7DYbssyaZ8dcowr9Iqs0OUjwHYt0_4BMf3rSiVfcs6xLUWg0YM9w>
    <xmx:HR7DYffRf2QvV-yvbBQ1O3GVQtnDOQF1vHtwS-5SbSMR2ndNVzGQXg>
    <xmx:HR7DYX3squOTvR1keGsobV9BDIHb8K905Dp-sxNSxDN9rqyQAKyk6g>
    <xmx:Hh7DYQXQatijl7JhonKyUX_c_30YHWQqCFxHhRezPHdQEDhD7GdCMg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Dec 2021 07:46:16 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, alistair23@gmail.com,
        robh+dt@kernel.org, linus.walleij@linaro.org, rydberg@bitmath.org,
        andreas@kemnade.info,
        =?UTF-8?q?Myl=C3=A8ne=20Josserand?= 
        <mylene.josserand@free-electrons.com>,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 2/4] dt-bindings: input: Add Cypress TT2100 touchscreen controller
Date:   Wed, 22 Dec 2021 22:46:01 +1000
Message-Id: <20211222124603.326920-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211222124603.326920-1-alistair@alistair23.me>
References: <20211222124603.326920-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mylène Josserand <mylene.josserand@free-electrons.com>

Add the Cypress TrueTouch Generation 5 touchscreen device tree bindings
documentation. It can use I2C or SPI bus.
This touchscreen can handle some defined zone that are designed and
sent as button. To be able to customize the keycode sent, the
"linux,code" property in a "button" sub-node can be used.

Signed-off-by: Mylène Josserand <mylene.josserand@free-electrons.com>
Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 .../input/touchscreen/cypress,tt21000.yaml    | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
new file mode 100644
index 000000000000..5a721d789c87
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/cypress,tt21000.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cypress TT2100 touchscreen controller
+
+description: The Cypress TT2100 series (also known as "CYTTSP5" after
+  the marketing name Cypress TrueTouch Standard Product series 5).
+
+maintainers:
+  - Alistair Francis <alistair@alistair23.me>
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    const: cypress,tt21000
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator for voltage.
+
+  reset-gpios:
+    maxItems: 1
+
+  linux,code:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: EV_ABS specific event code generated by the axis.
+
+patternProperties:
+  "^button-[0-9]+$":
+    type: object
+    properties:
+      linux,code:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Keycode to emit
+
+    required:
+      - linux,code
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - vdd-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/input/linux-event-codes.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@24 {
+            compatible = "cypress,tt21000";
+            reg = <0x24>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&tp_reset_ds203>;
+            interrupt-parent = <&pio>;
+            interrupts = <1 5 IRQ_TYPE_LEVEL_LOW>;
+            reset-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>;
+            vdd-supply = <&reg_touch>;
+
+            button-0 {
+                linux,code = <KEY_HOMEPAGE>;
+            };
+
+            button-1 {
+                linux,code = <KEY_MENU>;
+            };
+
+            button-2 {
+                linux,code = <KEY_BACK>;
+            };
+        };
+    };
+...
-- 
2.31.1

