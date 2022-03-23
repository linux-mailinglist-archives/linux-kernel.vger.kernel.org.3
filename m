Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BA94E51C2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 13:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244055AbiCWMCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 08:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244044AbiCWMCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:02:17 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612857A9A5;
        Wed, 23 Mar 2022 05:00:43 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 14D743201FCD;
        Wed, 23 Mar 2022 08:00:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 23 Mar 2022 08:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=l1C3ccDGgcE7nR
        aC9V8NEemh9Ww1O1X8v8EZwzGnGZM=; b=OmRVNn2q44YDbguUD6dB7kL5IL5+Fq
        WRSal3peEY8VbgBU8Q5OIvbf1h5qAKNnzB8D0fxOwt/f60T/q7oorHGADpiJJrgl
        NyZVJRiAgnlOLk5DoH1Enjfs+iM+Qnz7fF2Vq+/VRh5X7WJCn/ZhdqU/xdrH45mx
        Vvkai8R6H51WqRVcsEc8pWgKosrUowY2vbtqd/9P/NZN2ABCW/Tmd7N5HPHbGcHn
        rEsT9ksD5DednZw9P1tJMcnt25ObEDk7+btadY8cOXWHdq/SM4KSOSYCmXacthSe
        q6ajzePbx+fOAk3YBMgfXEnZwUFWpeAN3LOlBQiw8eTmLEzbVr7IyuDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=l1C3cc
        DGgcE7nRaC9V8NEemh9Ww1O1X8v8EZwzGnGZM=; b=i0KAvIBfnOar1VNwUMCtN6
        CgDIFYLd2OymuUQvlILJHexzR7nyv+JH7CciYfFLjnIS4jhnNh1SNjwI0Fq5qhPd
        Ot4+Co4fs8KioWrqlO8KS0B4yusk9pfksz2bxxljGXs2REJAKtrVIGqrNS1opada
        0ITWEFYMOdajAwDGJlb2RwUVnUUjTenag/WLgqtzMZfqGWy3NlAMkoIOejpQZ5cX
        765XT5h3WLpCunM9j7iqEPqaCqwM1q1n6hrI9LjE60Sz2lyHNJ+Qq5eZLQANi8Zo
        KMa/Cug/JX+muXG1YhtqzsMGbJloo2+WR5bbVqJoaqIZckWVSFkqgXdn1epIJPZA
        ==
X-ME-Sender: <xms:6Qs7Yn72oo_uZ11W3070_G4KZiDMM1AQ21jte4zpvX9DOBzUrxGzVQ>
    <xme:6Qs7Ys5D9lnW6aicflRV88UZg55fvTs9BBpyQpep8AC6ChaEu88-IXHBHlT6vXXJ1
    JgksVdmDM4fi4HpsV4>
X-ME-Received: <xmr:6Qs7YudKDqzpj7y9HvRv0vwRAE7uVtuls8BTSNmKUIa0hca20V07QIEWyazdWjTrPdgrHQ0G7K0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegjedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpefftdfhgfeggf
    elgfekjefhkeeigfelleefhfethfehfeetleeggeeggfefffdvtdenucffohhmrghinhep
    uggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:6Qs7YoLaOL3nvCco8WvvJeexXsteGwuxOvrq_28awOnn9M7uPv_7Eg>
    <xmx:6Qs7YrKZoQ2oyvNHk7z5cvAIj5oAoITu3gnx5GyqSDGiON0GRQaL-w>
    <xmx:6Qs7Yhz54opRbgQ4PnXkor3RLWnkIKOETamDopB-VEYENzu76sc92g>
    <xmx:6Qs7YsWfIV2uj0kYoPIA5nt7_KOSvWt8yETJ_h_NxDX49DvbHwnhtQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Mar 2022 08:00:37 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     alistair23@gmail.com, rydberg@bitmath.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, andreas@kemnade.info,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v7 2/4] dt-bindings: input: Add Cypress TT2100 touchscreen controller
Date:   Wed, 23 Mar 2022 22:00:19 +1000
Message-Id: <20220323120021.361137-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323120021.361137-1-alistair@alistair23.me>
References: <20220323120021.361137-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
2.35.1

