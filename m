Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DA346BBF6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbhLGNBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236645AbhLGNBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:01:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D137FC061574;
        Tue,  7 Dec 2021 04:57:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 954B3B817A2;
        Tue,  7 Dec 2021 12:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B99DC341C3;
        Tue,  7 Dec 2021 12:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638881853;
        bh=Vsakwz4v3KTwZtfP7ooJ1vlV9GwLJQmR6q3SYZ0oB6g=;
        h=From:To:Cc:Subject:Date:From;
        b=A6YasNxTZVPG9rVx1R+x6jDLUObYgtxaK/sxcnTOKUhXS84A3C7Z7TepavtJOeLcv
         YKtEN13PCUFLALzqnpEqTHLb5We5PZBbmr7mB2mokQmek/dNrj3FXr4uQypXrjqohl
         rSFXd+ZNxhQ4IaOtmQJOZ38pFUgIx0lFImPxxTr9Y0rCqfbd6x9XIh6K02MAiQbPVT
         vK1FTF1F9Ml58IyrW+xK7h7b1elxAnxnaDp6nCN5/VSN4qAkf+pXSg34CSxBRtFBwc
         j9H/A23lJGz+2S4gaY9VvXbGirMnwt3BqLDy6EHB1D3HTumsHd9P52bqFGknqT+6wp
         f+B9kg3V4szcQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mua2F-00BYbD-0g; Tue, 07 Dec 2021 13:57:31 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Wei Xu" <xuwei5@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH] dt-bindings: usb: hisilicon,hi3670-dwc3: add binding for Kirin970
Date:   Tue,  7 Dec 2021 13:57:29 +0100
Message-Id: <fec9df1a99ad8639f23edc24cdcc3ec78ea31575.1638881845.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the DWC3 USB3 controller found on Kirin970
CPUs.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../bindings/usb/hisilicon,hi3670-dwc3.yaml   | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/hisilicon,hi3670-dwc3.yaml

diff --git a/Documentation/devicetree/bindings/usb/hisilicon,hi3670-dwc3.yaml b/Documentation/devicetree/bindings/usb/hisilicon,hi3670-dwc3.yaml
new file mode 100644
index 000000000000..309a876ea615
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/hisilicon,hi3670-dwc3.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/hisilicon,hi3670-dwc3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HiSilicon Kirin970 USB3 Controller
+
+maintainers:
+  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+
+description:
+  Bindings for the USB3 DWC3 controller present on Kirin970.
+
+properties:
+  compatible:
+    const: hisilicon,hi3670-dwc3
+
+  clocks:
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: clk_gate_abb_usb
+      - const: hclk_gate_usb3otg
+      - const: clk_gate_usb3otg_ref
+      - const: aclk_gate_usb3dvfs
+
+  ranges: true
+
+  assigned-clocks:
+    maxItems: 1
+
+  assigned-clock-rates:
+    maxItems: 1
+
+  resets:
+    maxItems: 4
+
+  '#address-cells':
+    const: 2
+
+  '#size-cells':
+    const: 2
+
+# Required child node:
+
+patternProperties:
+  "^usb@[0-9a-f]+$":
+    $ref: snps,dwc3.yaml#
+
+required:
+  - compatible
+  - ranges
+  - clocks
+  - clock-names
+  - assigned-clocks
+  - assigned-clock-rates
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/hi3670-clock.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      usb3: hisi_dwc3 {
+        compatible = "hisilicon,hi3670-dwc3";
+        #address-cells = <2>;
+        #size-cells = <2>;
+        ranges;
+
+        clocks = <&crg_ctrl HI3670_CLK_GATE_ABB_USB>,
+                 <&crg_ctrl HI3670_HCLK_GATE_USB3OTG>,
+                 <&crg_ctrl HI3670_CLK_GATE_USB3OTG_REF>,
+                 <&crg_ctrl HI3670_ACLK_GATE_USB3DVFS>;
+        clock-names = "clk_gate_abb_usb",
+                      "hclk_gate_usb3otg",
+                      "clk_gate_usb3otg_ref",
+                      "aclk_gate_usb3dvfs";
+
+        assigned-clocks = <&crg_ctrl HI3670_ACLK_GATE_USB3DVFS>;
+        assigned-clock-rates = <238000000>;
+        resets = <&crg_rst 0x90 6>,
+                 <&crg_rst 0x90 7>,
+                 <&usb31_misc_rst 0xA0 8>,
+                 <&usb31_misc_rst 0xA0 9>;
+
+        dwc3: usb@ff100000 {
+          compatible = "snps,dwc3";
+          reg = <0x0 0xff100000 0x0 0x100000>;
+
+          interrupts = <0 159 IRQ_TYPE_LEVEL_HIGH>,
+                       <0 161 IRQ_TYPE_LEVEL_HIGH>;
+
+          phys = <&usb_phy>;
+          phy-names = "usb3-phy";
+        };
+      };
+    };
-- 
2.33.1

