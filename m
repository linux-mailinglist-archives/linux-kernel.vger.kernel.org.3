Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1E54771A5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbhLPMZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:25:43 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:60713 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231969AbhLPMZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:25:43 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 90AD55805FA;
        Thu, 16 Dec 2021 07:25:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 16 Dec 2021 07:25:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=dIamJe71dG+Zo
        x+zSJ91KvmhrQ+mqndeaCChM+4h6+0=; b=IH/Xa6a9z8IuMsSVSFtfKSSjcE2g1
        fu0qGIIxWw0WuBwZQe+RkXz+D6kV8BhAOYwnkTW/dNjKV8HjzlF3//V6EreR1Xsk
        6Rf2QfEbmMx+2wSy7hPcm81xZ7Dc/9crSADkK+QzUj4GF96x+gEtfVX9vgRVthhY
        4LiRkSNYdrtxWJDAx8z0DHWC8mM5/Ze3j4kvA29e/4egn7sOol5QeNHWT2xKSVfb
        ftRaHYNjWZqD+xoTah0HCcrBsNnon91cJSq3UmS0qGJksaOiy4rDmEVj19WquEqp
        YsZoltTQQQy5TCkpF+n7Xeu89sVnlJppYAFC/ASBwGCgBnWjeWnOGBDjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=dIamJe71dG+Zox+zSJ91KvmhrQ+mqndeaCChM+4h6+0=; b=nRElCAnP
        JmWDUmZRcoUHMOPy9f5LA7tGM9ym2LyUTtapkMWkymB4KHuFqY4UovfptowO4LIO
        wg7dIvgYjkoxn2Vu8ULwxD1B+xEez+Cor9exEECo5ITeLQsuKoxvK3XuuUIyLheu
        d8JCQ/y/O4JCewblFVreV3H25Uju7oWs0+4nWlcUumkLE/NXn2QTG/GDvfvbiKAo
        uV9/+BH1Bu+LpgS20X1KHJoPsQwTdjW7lMvU8x8uHLryqqM2ZecTczpgbneeXGke
        wa5dgclorg1U1n9ATvEp/fyjzo5msxfYbPvYoOqeEsoPeat1zoF8UUe1ZlLzl5d3
        MGQab/RAPs6+jw==
X-ME-Sender: <xms:RjC7YbOP30DekGLTCn_y1DRTc81b05PckOKX8NnuQ6_HHfRW3H5s0A>
    <xme:RjC7YV8dRXWtTA7wrDHMb5XIC_wjnCHpPBl5UdCP_rT6_aE3yktq0w0_WWVlFBaV6
    nbkNWmz6lV1PJJmEhk>
X-ME-Received: <xmr:RjC7YaQzxXMZLMNM89ARXUbEXB5AXXysGZLsXOIp1Gn_nRUKIULPfOaPW8fgejd1-iRtk5GDGZuoRL7NHhuOSTxSborKtnMetPdzEdbPiODz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrleeggdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihhsthgr
    ihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqe
    enucggtffrrghtthgvrhhnpefftdfhgfeggfelgfekjefhkeeigfelleefhfethfehfeet
    leeggeeggfefffdvtdenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:RjC7YfvAb49t04iaY0uyCrsNbAaCei9_8-qh-z13wOPXCNSTINoBsg>
    <xmx:RjC7YTdxnkeP6wB-pPAwqhU1pM7b0WwpY15xjLlDmWpW1W3pPdzwcg>
    <xmx:RjC7Yb06yGncSy4HTtfdk3KIYLTY8sWEpd3hFIQ-0ZJn8ylXIOAdBA>
    <xmx:RjC7YeCDVglGNRqQEbJ3cJguLzaOz8DbHtqF2RkVl-7N7RSxc2kXBQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Dec 2021 07:25:36 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     kernel@pengutronix.de, lgirdwood@gmail.com, robh+dt@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org
Cc:     linux-imx@nxp.com, devicetree@vger.kernel.org,
        s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        andreas@kemnade.info, linux-hwmon@vger.kernel.org,
        alistair23@gmail.com, amitk@kernel.org, shawnguo@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v17 1/8] dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
Date:   Thu, 16 Dec 2021 22:25:18 +1000
Message-Id: <20211216122525.136139-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216122525.136139-1-alistair@alistair23.me>
References: <20211216122525.136139-1-alistair@alistair23.me>
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

