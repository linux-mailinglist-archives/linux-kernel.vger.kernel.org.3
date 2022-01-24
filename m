Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143BD497E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238243AbiAXMKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:10:38 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:37711 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238388AbiAXMK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:10:26 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5965B58035C;
        Mon, 24 Jan 2022 07:10:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 24 Jan 2022 07:10:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=dIamJe71dG+Zox
        +zSJ91KvmhrQ+mqndeaCChM+4h6+0=; b=WDYQKVYH+ZiKUwKq8iAnWtalF2X8JA
        1oHvo9ex0o/zEHl710TxdhfaPhj9zpQTNFDf6rnCSOxejGqKJs8yIt5mVwnSMiEX
        FgqG8k8/UjJIhXc5JwmV57gYBASt18F0FAMh8rPO0/AxM2rl6nwa0/uZVGV3a0sO
        9m6ax5igUoGBuBmK8sCGVCERiB5W03BT7dycn8dHdsBQELaYbsoDhVEHTTpvCQix
        X/6ZeWCQxYvszf6WfZ0N39SIZ6ZAz1GDsjlPGD4Uy9QUWVF3qTeYUqQItRm5zQSU
        rA/EcKDsAea3eTuSRHz/mWkelID9ycSgXke5Cq8tH4M9yR1DThpHm4Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=dIamJe
        71dG+Zox+zSJ91KvmhrQ+mqndeaCChM+4h6+0=; b=iCDmk0rcRelouNrStnu2YI
        U54JakfTuK/+vTEUVtRYWyO9c9PDNDW6k4mvr0RhzTgboFlKTmODFcVQxpiCjH2E
        fqAMPm0k2fDCoM7OCQZhCZRdinYqldw195wck8tew4Z4zWQiAnqKTDh7Wx7BJqO6
        zwR3zI5eQr1LnNvwcWhT/m0kp76dyCRLATvgQbnOS0PnNBGS3/OlUbOX7fwCYK3+
        ri8uga8asxncW/B8uWvWFOAG1dOn1BrnI47PYoKBhlSjWev3Va2ytwrW7sga9l6V
        pIOO4+/V9IHD7BunTz9ytdJRo7oCx5sK7htF9KrqIr4HWbQFnI6e7DpBZAaBEqVg
        ==
X-ME-Sender: <xms:MJfuYYWKz8C8-vXPGubV7BsdcB84Z5p6z9QY2UJRp--KgRgV4MY00A>
    <xme:MJfuYcmUY9_yE_HIc-Vt_UO5duKD5IutbowfVcW1t5M7KFc8yhkXGRsYzlnKDln3t
    k0Gy3dYrCSwLv525To>
X-ME-Received: <xmr:MJfuYcZHvwO05qOcnfvy4RqDtcGP5ZMnzrZYzklVVh-SEk_69AGLatgFMXPipcdbFu7-zCh2TNMj2XTeXgM6NHimpVjtBNVQJQ5w01jkkvFe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrvdeigdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihhsthgr
    ihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqe
    enucggtffrrghtthgvrhhnpefftdfhgfeggfelgfekjefhkeeigfelleefhfethfehfeet
    leeggeeggfefffdvtdenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:MJfuYXXfWJZZTWQZd7453F2cuKznxCI_Em7G6JaUOASusC4l39QJgw>
    <xmx:MJfuYSkHuo4ACseccLQzRtzScdlNa-YVq8Uk9BVObFiE_IX7jIBNzQ>
    <xmx:MJfuYcd-VpDOS6J0RDqYVvFAblNlp8I4NFC9KIJmwH64x-Bjs6h9KQ>
    <xmx:MJfuYRqazzV9THiGh7omcke-tRaplNs8umZdG9tZCs2T2GcvlDKaRQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jan 2022 07:10:18 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     broonie@kernel.org, robh+dt@kernel.org, kernel@pengutronix.de,
        lgirdwood@gmail.com, lee.jones@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-imx@nxp.com, rui.zhang@intel.com,
        alistair23@gmail.com, amitk@kernel.org,
        linux-arm-kernel@lists.infradead.org, andreas@kemnade.info,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v18 1/8] dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
Date:   Mon, 24 Jan 2022 22:10:02 +1000
Message-Id: <20220124121009.108649-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220124121009.108649-1-alistair@alistair23.me>
References: <20220124121009.108649-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial support for the Silergy SY7636A Power Management chip
and regulator.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 .../bindings/mfd/silergy,sy7636a.yaml         | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml

diff --git a/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
new file mode 100644
index 000000000000..6de74c701635
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/silergy,sy7636a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: silergy sy7636a PMIC
+
+maintainers:
+  - Alistair Francis <alistair@alistair23.me>
+
+properties:
+  compatible:
+    const: silergy,sy7636a
+
+  reg:
+    description:
+      I2C device address.
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  '#thermal-sensor-cells':
+    const: 0
+
+  epd-pwr-good-gpios:
+    description:
+      Specifying the power good GPIOs.
+    maxItems: 1
+
+  regulators:
+    type: object
+
+    properties:
+      compatible:
+        const: silergy,sy7636a-regulator
+
+      vcom:
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        description:
+          The regulator for the compenstation voltage. Enabling/disabling this
+          enables/disables the entire device.
+        properties:
+          regulator-name:
+            const: vcom
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - '#thermal-sensor-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pmic@62 {
+        compatible = "silergy,sy7636a";
+        reg = <0x62>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_epdpmic>;
+        #thermal-sensor-cells = <0>;
+
+        regulators {
+          reg_epdpmic: vcom {
+            regulator-name = "vcom";
+            regulator-boot-on;
+          };
+        };
+      };
+    };
+...
-- 
2.31.1

