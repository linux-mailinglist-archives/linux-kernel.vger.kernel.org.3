Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F7D48890F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 12:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbiAILx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 06:53:58 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:32957 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235374AbiAILxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 06:53:54 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 41C3B58036F;
        Sun,  9 Jan 2022 06:53:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 09 Jan 2022 06:53:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm3; bh=
        ogqpXTTRIytQdTC0K2kwz73G1qDnNrXafwRfEMjPnDc=; b=Oa8fijUljMkdYTuo
        xhRkIuovTDaARQ7upp1IWuE9c7eCzw0zZz4ZniwaduTSpG5sJcKM2Jsiz9JuB1VX
        3FG7ej0g5UQWLuhqoYj/sC9eVycKgCeyT4l7j/dFsBjfTNEHxt1llIloyx0GrcH8
        1NSNU9JC1QdPDMpSkmEtklgCDCsV7gUCuR43j0dYQCDw3eoBN3TtuK2AquL8V69h
        e6fnZ4JZHlsj8+Doce3kU5eSUg2v5Y83tRWUkNaEYFlv5zskNB7FVk5rdzie0uJf
        y21ZhVnarwVoFzX5f2pcIWXWBgTDHOQjVg/oEsrVT4cxK3/8SlSciHlYXiSOIpx1
        g4MCpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=ogqpXTTRIytQdTC0K2kwz73G1qDnNrXafwRfEMjPn
        Dc=; b=E9CW/iGFec4xzgAr5iRhzLc/L4dhfRsG1XeFwaeoKUsrY1/bZg7uRTml6
        TBWGHZ7LYyicoXf6Xha7mP8yC9hr/1XtSqRi/EX3x8w6npHmVI3SHPMZf5Qtkvi9
        KztfXZMHFdubvvemRc3RpaNX/JpazF5gENacT+kl/ozlGWUNRuWKJAJBwIlKEMt5
        zD5i/KyiQsJx58kBrzMT2/T+aq2lb/4NrE8Z70e5Hm7YicnC8AOXI76rKw3G92ol
        yncV7mSOqcsfMG3dtXebnz3RVyQa5DlsLcG4UxumqG1uIHFb1Hsl9udXBNfaOWzL
        3OxPWUQdvRHCsrjl8M54dqyoHfc9w==
X-ME-Sender: <xms:0szaYcsqh9VlwLyWXj1e7mRSJ8R_vHlbKYmCA2PYeIrqoGSMml9T4g>
    <xme:0szaYZe2GSCI4WoZNfxt79jZNPyfEHHlaeIG0tG3mwDDtaeaFn3d6qAI2jTJ2aN0B
    MEYpVmf7GM8mVNk58w>
X-ME-Received: <xmr:0szaYXzAkgE84t-IXnAG4QqMciEO42_jbvUSbauB_eDWYNeSxrCbkSYapIWZRyCRIfAWGVZvKfemQia2QAj7SQ4xm_QYx8M-ISo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegkedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheptehlihhs
    thgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmh
    gvqeenucggtffrrghtthgvrhhnpeefudehhfevgfffleeiffehuddvgedtueeujeeifefh
    jeejvdeivddugfehfeehjeenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhs
    thgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:0szaYfPInsOqP_7eZ5CvLK42bOjUDdhqzeEoQuJotFvX5EUJ9tgPrQ>
    <xmx:0szaYc-lbSm1WFPgDiVsDJn50mLyWWLqtLnAOYtxW18UkEgTuPHW9w>
    <xmx:0szaYXUvYgR3tyKPPEhuiIAAnlnop0mbCZ41TTohk51pXdOWuehuaA>
    <xmx:0szaYd1JVbJ25oN4FCG7ly_7E28LYpybGZUueKFmFUhCoc-R4e_e-Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Jan 2022 06:53:49 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dmitry.torokhov@gmail.com, rydberg@bitmath.org,
        andreas@kemnade.info, linus.walleij@linaro.org,
        alistair23@gmail.com, robh+dt@kernel.org,
        =?UTF-8?q?Myl=C3=A8ne=20Josserand?= 
        <mylene.josserand@free-electrons.com>,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v5 2/4] dt-bindings: input: Add Cypress TT2100 touchscreen controller
Date:   Sun,  9 Jan 2022 21:53:29 +1000
Message-Id: <20220109115331.388633-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220109115331.388633-1-alistair@alistair23.me>
References: <20220109115331.388633-1-alistair@alistair23.me>
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
index 000000000000..acd2d9389f8c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
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

