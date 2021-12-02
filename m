Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B295C466387
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346778AbhLBMYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:24:33 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:42423 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357983AbhLBMYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:24:01 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id D77CD58030B;
        Thu,  2 Dec 2021 07:20:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 02 Dec 2021 07:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm2; bh=
        qETIBq3rrsCGZV81LeNKeQG+vGesMCgkTVk/diulH/w=; b=NpCGHLdFgtc7JGQU
        uzbEy0Fs/C6ZoULGHpL8ZhsaH0rasZSmFCdBBXaW6MFyMm8J9ww4UnRKuAOUEXKN
        dJsZA/fKuOvoju0lAAuUo2F0RbGItFzu1yHzguDFuo9k4PcBkZMuGukcoDaq7BZc
        huw0xcHABuD+6QaQR28TecbRQ6RkGWHlIuz0ONgb4ffvRvsf6NQW6a5uCIuzpcJl
        Wm11iQrbxt/Lqm4ududko5EBfbNMCx590AG9TjmALM3RS4Ui2qb3YQUweH4LUwIP
        nmdTpPNSOzI7Jtgz5w0WJ0O1Gah9V6JFKMxMsLXytUhD+9fbnfA8VdROuwzpdk0O
        kLMZ7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=qETIBq3rrsCGZV81LeNKeQG+vGesMCgkTVk/diulH
        /w=; b=X5a4AXkeDDrzNtKcelWsUsyDq6nEb1T0fYojpMAJXjbGFvbrElbu1Ls1/
        pGBLb+PJ4M9n/S7Qhd0k2oZf5IQe93G4URs5IknxRL/VKQRl25zCDE/9kNMaWlAC
        XhmTGwvuqDI+YGjtsMMdttmMq8fviHnHukGUS6n8NCbJN+9GAymTeIJ5FhJgnYvR
        FJHkLEA/oBOBo5ziDQZgF6WVzaHBQvO98OJ4U8O66jjuycMlEDe2sUGIyOXVx228
        ZfXo2qKLYYe/XI1DHYbg/fSuGN+Q2hzTxcd83ysWgsMvdMrowdQuo78WfRe4dqbV
        YCk3MQWMYjWhmUvWQxr7zt/yO9K1Q==
X-ME-Sender: <xms:FrqoYeGRF7moKut5-YfKcYuYOOqCd_I1C618TdIsiaIC7CwocQejHA>
    <xme:FrqoYfVee93HD-1jOLWvBktVRtRZJr6ng6WhNhOWA3tAAfdfB2IVdfYDICxHdGlQN
    2emk7GZrs65eF3sNNY>
X-ME-Received: <xmr:FrqoYYLkExz6zZD8xabFegkjVKie8oW47m3OsJ4k9xSCbpHxW-xeGWw4v9VoXOhSm3ARIojrS1QcjzyaT3ykM61Bu-Huar6XoMa1wHKqyl5Fo6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieehgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeetlhhishht
    rghirhcuhfhrrghntghishcuoegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
    eqnecuggftrfgrthhtvghrnhepfeduhefhvefgffelieffheduvdegtdeuueejieefhfej
    jedviedvudfgheefheejnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishht
    rghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:FrqoYYGDgHz--Aoln71xePTIKHVYwknJdhUri5kplh7uuOF_0xYGVw>
    <xmx:FrqoYUWoDc6v1i_nh3g9q3aQqWBSp4bjjm7bQ2by-bY54gL2akxrjQ>
    <xmx:FrqoYbM_gXfvJGE1i7wKoeMGAp5f5qMK1blJLvPdl1pkezGSGWBk3Q>
    <xmx:FrqoYdPVchxI0nRHOlCufpydNj4DvcBQP7wMQX4ZxhiIp6wrLJ1_og>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 07:20:33 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, andreas@kemnade.info, alistair23@gmail.com,
        dmitry.torokhov@gmail.com, linus.walleij@linaro.org,
        rydberg@bitmath.org,
        =?UTF-8?q?Myl=C3=A8ne=20Josserand?= 
        <mylene.josserand@free-electrons.com>,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3 2/4] Documentation: DT: bindings: input: Add documentation for cyttsp5
Date:   Thu,  2 Dec 2021 22:20:19 +1000
Message-Id: <20211202122021.43124-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202122021.43124-1-alistair@alistair23.me>
References: <20211202122021.43124-1-alistair@alistair23.me>
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
Message-Id: <20170529144538.29187-3-mylene.josserand@free-electrons.com>
Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 .../input/touchscreen/cypress,tt21000.yaml    | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
new file mode 100644
index 000000000000..f3f353192917
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
+            compatible = "cypress,tt2100";
+            reg = <0x24>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&tp_reset_ds203>;
+            interrupt-parent = <&pio>;
+            interrupts = <1 5 IRQ_TYPE_LEVEL_LOW>;
+            reset-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>;
+            vdd-supply = <&reg_touch>;
+
+            button@0 {
+                linux,code = <KEY_HOMEPAGE>;
+            };
+
+            button@1 {
+                linux,code = <KEY_MENU>;
+            };
+
+            button@2 {
+                linux,code = <KEY_BACK>;
+            };
+        };
+    };
+...
-- 
2.31.1

