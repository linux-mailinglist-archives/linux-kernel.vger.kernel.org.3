Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32198466320
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357696AbhLBMLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:11:42 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:53477 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357656AbhLBMLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:11:38 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7FF6558030B;
        Thu,  2 Dec 2021 07:08:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 02 Dec 2021 07:08:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=dIamJe71dG+Zo
        x+zSJ91KvmhrQ+mqndeaCChM+4h6+0=; b=zW41Y/YnE9CIHwf01atEo654jDB34
        NuuZBBwVgAt03eRGXwVLexK+ADFmazHAtmskpWeyDjfk7KwjgCsaLEaN7MV4Q5Ms
        Q/BUbsHsqlzkixGPgRVp6wpryzYkN5YWgK4fNWYePYQlo/zs0TtyEros5fsBb4Bh
        bpj0QrWMqR4xFDZoe2L5Eqd9CTYMgUGnBx6ZDCPngc6J4JcXADVzYPgkJM6IWIau
        wBnNDurS+US7aaaPz0gG34B1LFTgj8fw2GALmBk/ealKOHQ0KmN4W7NM85jIVL7J
        Ya54h8P5QVo/7qj+kBq3Q7jgfdojPq0Lr8/KBubpnxXVy7YzaadSClfQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=dIamJe71dG+Zox+zSJ91KvmhrQ+mqndeaCChM+4h6+0=; b=gnbWBAkA
        cYmf4yw0oPWQpsZeRyuTpgH4tpxfwK6X7/LwCslhj4aq6O5tdXw4NlYn3cTurfrL
        y/xUG8UM2F4+TKakQTKVja2vhtBAcroJKxru5yZgOaRl2eUYAa/Iug0yVVzXjCVi
        NN5tjXrojXKRNq+QgmYhEIbGKfxW6ow1VlW79QA9Mg/uFxdnOJAJmPSNoMgZBQZd
        rfIirUCoojI7GCRzEElXxS5JpjUwkj0i0w24XUOF8Ugswgebtz2iLvuK/60CaFUD
        cF5Ckq9dLhje4OsFUz0ZcOhCWc5n9WOfcJILR7wtwupmniE+DqUr8XGUAGYFDMOq
        eVOkiG4agXw5UA==
X-ME-Sender: <xms:L7eoYXKhKK2AMwflzX_eN_Jn6QKGh8TsqYXZc71Kho1wgx0ulM2LYQ>
    <xme:L7eoYbJFZzRIr-4XMLXoknWSCSh6MAZvFnuqUgx6tbQ9Z-U-hOyLsuPM6kbrN3Q1w
    oSTW5y3JwoUiQmpBO8>
X-ME-Received: <xmr:L7eoYfvwDqzQc-4h-lY6VJpYbtsp0Zrk3BuB4kA4ec4ClAxLXZfwbzqsySFMVCHPte_n5WnddmLhOHQICKPdJYNgFNNdZ_huRbd7S6d8E8rC0Kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieehgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihhsthgr
    ihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqe
    enucggtffrrghtthgvrhhnpefftdfhgfeggfelgfekjefhkeeigfelleefhfethfehfeet
    leeggeeggfefffdvtdenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:L7eoYQaJJcV6Q3a40PfoFxQA3lwVhkMPPEgqM36yyi85ud1q9yXyeQ>
    <xmx:L7eoYeZ_4muyOnC_clumvYeWSyi7ggGg14RcXSBeBalPIqzgr_N7DA>
    <xmx:L7eoYUC1R0uz-gTLo_iskr7xd3HI3HIF22mUWnxf3VlbaUgIrU-Z5w>
    <xmx:L7eoYQuTe55ceW2ftK64EsdhnIz2NX0H9KiWlW2aoPjYbsTLLApk0A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 07:08:08 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     kernel@pengutronix.de, robh+dt@kernel.org, lee.jones@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, andreas@kemnade.info,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, amitk@kernel.org, shawnguo@kernel.org,
        Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v16 1/8] dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
Date:   Thu,  2 Dec 2021 22:07:51 +1000
Message-Id: <20211202120758.41478-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202120758.41478-1-alistair@alistair23.me>
References: <20211202120758.41478-1-alistair@alistair23.me>
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

