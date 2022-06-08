Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C2054297C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiFHIcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiFHIbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:31:04 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAC11D0BF8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1654671921; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=CBvX57e4YlSIDQpfnjPuKmjuLD3PVw7IH00/pg5gB/ZIRzj9lzL/Yh87wFG9Y3885B2jk9hJ3N7t+1YZZyuifB76fgxLHW4Q1p153ffvl+yN6dvvZvQulAI17HvxMlK/KI1+Zy7mnnjlSpZk2f1esIpdOyBFYCBXsadfH2qkBZU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1654671921; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=fAPXMZVtetQtonlC7+xF0w9Gl7sJR8Jiaxw+KPYWZCs=; 
        b=WVgdwcBKeVWAjZiDVgz+ePUSizrKtrgToLHPeoCGVDtjerJN7Xq4K3mFLtGB7ukyiBU2OwhlGt799bfRmaCYrlxEdI3TJztZCy36ncErtKWKozq0S41u1kVrGNoJU4qAND7zrPTsUvDHDzPgRQzTht6OcQUCZpSlNACWgiCLroY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1654671921;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=fAPXMZVtetQtonlC7+xF0w9Gl7sJR8Jiaxw+KPYWZCs=;
        b=cVmwm18fXkrsNvg4P/LMGAD9oFvgNao9WPetXbyJ3wdp4m4l3+rdt3ygNa7lD5qZ
        gj5DTSVqSbk27ltdNJeRujVREMHc9RTtPfsx5ntM3PYmbZ+u/JldYAZWbQNfSbHeH5+
        TVr55F2ktLUb4swqXr1ubfaB9EejqXCYKImHNjMo=
Received: from edelgard.icenowy.me (59.41.163.66 [59.41.163.66]) by mx.zohomail.com
        with SMTPS id 1654671919691727.7602971052912; Wed, 8 Jun 2022 00:05:19 -0700 (PDT)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bin Liu <b-liu@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-usb@vger.kernel.org,
        Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 2/7] dt-bindings: phy: add binding document for Allwinner F1C100s USB PHY
Date:   Wed,  8 Jun 2022 15:04:47 +0800
Message-Id: <20220608070452.338006-3-uwu@icenowy.me>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220608070452.338006-1-uwu@icenowy.me>
References: <20220608070452.338006-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner F1C100s has the most simple USB PHY among all Allwinner SoCs,
because it has only one OTG USB controller, no host-only OHCI/EHCI
controllers.

Add a binding document for it.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 .../phy/allwinner,suniv-f1c100s-usb-phy.yaml  | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/allwinner,suniv-f1c100s-usb-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/allwinner,suniv-f1c100s-usb-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,suniv-f1c100s-usb-phy.yaml
new file mode 100644
index 000000000000..180fa8840bf7
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/allwinner,suniv-f1c100s-usb-phy.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/allwinner,suniv-f1c100s-usb-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner F1C100s USB PHY Device Tree Bindings
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <mripard@kernel.org>
+
+properties:
+  "#phy-cells":
+    const: 1
+
+  compatible:
+    const: allwinner,suniv-f1c100s-usb-phy
+
+  reg:
+    maxItems: 1
+    description: PHY Control registers
+
+  reg-names:
+    const: phy_ctrl
+
+  clocks:
+    maxItems: 1
+    description: USB OTG PHY bus clock
+
+  clock-names:
+    const: usb0_phy
+
+  resets:
+    maxItems: 1
+    description: USB OTG reset
+
+  reset-names:
+    const: usb0_reset
+
+  usb0_id_det-gpios:
+    maxItems: 1
+    description: GPIO to the USB OTG ID pin
+
+  usb0_vbus_det-gpios:
+    maxItems: 1
+    description: GPIO to the USB OTG VBUS detect pin
+
+  usb0_vbus_power-supply:
+    description: Power supply to detect the USB OTG VBUS
+
+  usb0_vbus-supply:
+    description: Regulator controlling USB OTG VBUS
+
+required:
+  - "#phy-cells"
+  - compatible
+  - clocks
+  - clock-names
+  - reg
+  - reg-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/clock/suniv-f1c100s-ccu.h>
+    #include <dt-bindings/reset/suniv-f1c100s-ccu.h>
+
+    phy@1c13400 {
+        compatible = "allwinner,suniv-f1c100s-usb-phy";
+        reg = <0x01c13400 0x10>;
+        reg-names = "phy_ctrl";
+        clocks = <&ccu CLK_USB_PHY0>;
+        clock-names = "usb0_phy";
+        resets = <&ccu RST_USB_PHY0>;
+        reset-names = "usb0_reset";
+        #phy-cells = <1>;
+        usb0_id_det-gpios = <&pio 4 2 GPIO_ACTIVE_HIGH>;
+    };
-- 
2.36.0

