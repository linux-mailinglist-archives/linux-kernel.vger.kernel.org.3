Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90354C5B1B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 13:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiB0Mlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 07:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiB0Mlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 07:41:36 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898636D382;
        Sun, 27 Feb 2022 04:40:58 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7E9DE580223;
        Sun, 27 Feb 2022 07:33:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 27 Feb 2022 07:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=TdjkeNItJHdTmy
        q+LFHIzBr44CzyamChCcNOe2cjE2M=; b=yLitF93uqMywQosHgFTae2D+lE+uDf
        xMPcSSM/ovXzZmD6W++IDHsdY57B6bsOCdhDtCwyBFsrb/Z2wYaGFht6F5XPmzIq
        LqNm8Fmmk9lqLQBF4e1yrpRVy0IT0BhGVWXTZUvAVJKUXTmcPMr3Fyix0oW9660x
        GZYy8JqepMq155hHILAZhlY6Nz804h2BBro4lnSsbCSlCF/caKqrAvgPnHaYkiSt
        JsgkKMrHMvkxMynlR6eIpNZVF6SIRZSrfuEqiq0RZpGQxtX0DYbPR+8ZlsKPGKJD
        ce/EyTn1g8ZFMjKAuZ50FQqPze3+5/zynCIFk7vh6weOwUkd1ZlCCgiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=TdjkeN
        ItJHdTmyq+LFHIzBr44CzyamChCcNOe2cjE2M=; b=UABfOWN1VOKhmIXQSG9am0
        T4Txvw90JxoG0Dmw++jNyFFgM13o2tBhppOsYXgb66Mp83LnHqfG5Da8l4OJ8tmj
        C2U/YS5ULKFWDw5fJHyJF79W4eioSTdD3t3SGvH9JYbeaIw/yAmPqLtYYmu3/140
        IJgd6Yz14Z4Y2bDLYDmVi5DXLBnzkbOOjjt0NMRJajaMlaROS48fQGCSPwE58KCE
        8CaDCqbkgxR48768zcs62mPpFYjxEjzVXM0wZ7afqAm+oKbSowJIPrNK+f6GmMhl
        qs9+DQx/NzpASvt1QJg1C6DTjo5IwYiTzg7WtIhl67bW9dYIunoxUwwmik4DAsdg
        ==
X-ME-Sender: <xms:n28bYsTSZ6NlVQtRWnRbWQu5Il2QFjvFEA_tE1mWqcGvoNMvisGfPw>
    <xme:n28bYpzxNmemSDoR57d57pugZRqAZJvIs_pQvhbgRW5ATQEZ8Dy9jCTWSt9usvYm4
    y0Sj5fdOEJ-rR_CGr4>
X-ME-Received: <xmr:n28bYp1fp0q_Ar_q2VT3XCiOHuL7G0mzl5FrpV9KpmlYiq6WvPPDZyieZQPw7nW_c4Xj1jOCpecbvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrleekgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepffdthffggefgle
    fgkeejhfekiefgleelfefhtefhheefteelgeeggefgfeffvddtnecuffhomhgrihhnpegu
    vghvihgtvghtrhgvvgdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:n28bYgAwyrgUdNdJtzLyxmQVv-xK0nH7ZNW_rJ_4taxvMst_zM3v6w>
    <xmx:n28bYlg0etFq59bWog7kE3i2721B7-LBsS0L-aAEpamuZ7zAB21dkQ>
    <xmx:n28bYsr1FQ4LzEAd6ZSYtYcPnR_ciRzfSYr3IfOEX8q0puIFDkfJSg>
    <xmx:n28bYsNQy1yyrSnMLi1ku5dU-PwXuIl2nUkILam6Lq3tAL7eH7KgaQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Feb 2022 07:33:31 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc:     robh+dt@kernel.org, linus.walleij@linaro.org, rydberg@bitmath.org,
        dmitry.torokhov@gmail.com, andreas@kemnade.info,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v6 2/4] dt-bindings: input: Add Cypress TT2100 touchscreen controller
Date:   Sun, 27 Feb 2022 22:33:16 +1000
Message-Id: <20220227123318.313009-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220227123318.313009-1-alistair@alistair23.me>
References: <20220227123318.313009-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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
 .../input/touchscreen/cypress,tt21000.yaml    | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
new file mode 100644
index 000000000000..12a9c13f7706
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
@@ -0,0 +1,98 @@
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
2.34.1

