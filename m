Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2958587CC7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbiHBM7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbiHBM7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:59:15 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE90312616;
        Tue,  2 Aug 2022 05:58:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 0D35B320076F;
        Tue,  2 Aug 2022 08:58:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 02 Aug 2022 08:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1659445131; x=
        1659531531; bh=xFLZr6ZusKlMWRwea6+YGJF8blEZjaPxGsnunVYfyOE=; b=t
        jt9OJLZOxEmGkVMXYX1dYLNb+7owi642kyLQ/uiEjxXqWwD4t14nzbapa3FuWftp
        4zuas4AS6IA9DtqTfNBpb0OYxtd7gLh8NR1NL/QHDiJ/W9WfRPgvlCXA9udbvvKZ
        E0oGZ9sfcEzh/hqL8KHs3T5CZ8z13qS3VX8ZPcxzvMsEezkjjKDys60EC+YXjysj
        4yTTyy4R5q5aXr+XdXtniACmL7F+NRxIXh1KKpZewEmxJhBCD2+/HzPpnz+AovTG
        Kxy/rqLpvVZhHx4bFQprHtMfz6lb5jab1JzqoOOp9Ip5mCHDxgJNiEh1Wc+ZYIXr
        JXHDIVaFQcSjDlXWyTaYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659445131; x=1659531531; bh=xFLZr6ZusKlMW
        Rwea6+YGJF8blEZjaPxGsnunVYfyOE=; b=zLygn3FP7DKbc3qvmFmLB/WpUVZ3d
        5/Tm3U9LXhbOkgG4Pj/Nv/iOMFikO/P6wYd6iNzwoHYS9U2ljRPweezzXio+QSOU
        ioEDS0VwtfUmcafd2fczGt8vtt/q2l4akwGIWxlkdCePj6xYZRkyM2AB1vhx8Jnz
        vXqfCM9Kc8PNGn5nPLEzT9aPjaX+2U/lKAHhz4OZFncuu5oFuBzKVNwcYYuxJVX0
        FavVZ0RKunBWi2P8caY8prVag+Nvkq01KsWhbDCnLX/X+YLnYOBPE+/rN5f5B2K3
        juriD3l6BXzQm/X+xlShbBZZUQxeb7iyUX4yKYzzsTfgcCSW7Ghh56YKw==
X-ME-Sender: <xms:ix_pYmjcPAqY7wqmHWcSe62TkAqpnDxfVtsrVjFFxvbowpsC3Uc-Ig>
    <xme:ix_pYnBkxbFcY3OuLsb-uRk--0Bv_5AEXO910uHPBEnJM4zNeiMARE3q32JgYXmRE
    LB2HpioLd2ulOO_smY>
X-ME-Received: <xmr:ix_pYuG76LeqTVKOZbE4bRJ-HQR_Q2milGgnOof48to-67WgPCdzvFCHvEBzvP8EpQA6O-dJjuyX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvhedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjughrpefhvfevufffkffojghfggfg
    sedtkeertdertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlh
    hishhtrghirhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnheplefg
    ffeuheevvdekgefghfegueeuteetueekteevgedtffejvefguedujeeljeevnecuffhomh
    grihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrd
    hmvg
X-ME-Proxy: <xmx:ix_pYvSQM_2JUTR_0iuenKE30RtS3iOwIuG-64My4A_Z8tjdtYzLVw>
    <xmx:ix_pYjy0Y5jiVaqxNmdxKJOXngrM3lrcfzgwrDWhUKPeZ2W8_CnbTQ>
    <xmx:ix_pYt5BmCZ67gZj_FKl3HFn6Hxc7rVNI-6sjxRcRUaj3P7BcnyVOQ>
    <xmx:ix_pYrjgw1OEYm7JQNQ4-Q4z_dCSD7-AV8KAfp8lz1-56x3I92yifg>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Aug 2022 08:58:46 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     shawnguo@kernel.org, alistair23@gmail.com, robh+dt@kernel.org,
        linus.walleij@linaro.org, s.hauer@pengutronix.de,
        andreas@kemnade.info, krzysztof.kozlowski+dt@linaro.org,
        rydberg@bitmath.org, dmitry.torokhov@gmail.com,
        Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v8 2/4] dt-bindings: input: Add Cypress TT2100 touchscreen controller
Date:   Tue,  2 Aug 2022 22:58:25 +1000
Message-Id: <20220802125827.34509-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220802125827.34509-1-alistair@alistair23.me>
References: <20220802125827.34509-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Cypress TrueTouch Generation 5 touchscreen device tree bindings
documentation. It can use I2C or SPI bus.
This touchscreen can handle some defined zone that are designed and
sent as button. To be able to customize the keycode sent, the
"linux,code" property in a "button" sub-node can be used.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../input/touchscreen/cypress,tt21000.yaml    | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
new file mode 100644
index 000000000000..3fc4b7011040
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
@@ -0,0 +1,101 @@
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
+  linux,keycodes:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: EV_ABS specific event code generated by the axis.
+
+patternProperties:
+  "^button@[0-9]+$":
+    type: object
+    properties:
+      reg:
+        maxItems: 1
+      linux,keycodes:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Keycode to emit
+
+    required:
+      - reg
+      - linux,keycodes
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
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            compatible = "cypress,tt21000";
+            reg = <0x24>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&tp_reset_ds203>;
+            interrupt-parent = <&pio>;
+            interrupts = <1 5 IRQ_TYPE_LEVEL_LOW>;
+            reset-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>;
+            vdd-supply = <&reg_touch>;
+
+            button@0 {
+                reg = <0>;
+                linux,keycodes = <KEY_HOMEPAGE>;
+            };
+
+            button@1 {
+                reg = <1>;
+                linux,keycodes = <KEY_MENU>;
+            };
+
+            button@2 {
+                reg = <2>;
+                linux,keycodes = <KEY_BACK>;
+            };
+        };
+    };
+...
-- 
2.37.1

