Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135034754B2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241045AbhLOIyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240966AbhLOIyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:54:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554D8C06173E;
        Wed, 15 Dec 2021 00:54:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07090B81EB8;
        Wed, 15 Dec 2021 08:54:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E48CC3460C;
        Wed, 15 Dec 2021 08:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639558480;
        bh=PoC5ZVjDhgG+YAzEZfocuwaKNBirq7z6kOR1u+gLvQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YePux2nWWEdMVdbTtnQXLzFKQZcq2+GNVe3xjYrv1ZNgU7+/TB37oat2xQaxvFf0j
         058YjFyrNlecEAkpA+/ZVEa6Vqb2+MfEDrdfugmYjhwOYFXA7J/fm7AOx4NmPt/i5/
         m8xPL+odMv4GhqAZ3GZ89GIQlDNJze5LtoYsHDvO3INObhA7rWz2WbxYdRiH35nRwS
         A2KCndMpzVsF81+ppQMIJuITt073s/v80S1mbjPs9U0IPFjcPjZbx49Y/aW7YhIYV0
         d+ZCM8xUykUuxzM6H7Tm3hBiDk77cT8g2Pv2ZFn1TsxCu1CrLgc+T/jfxC9+7y3W4U
         XWD9L1tumcGMA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mxQ3Z-0054Hy-Mw; Wed, 15 Dec 2021 09:54:37 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH RESEND 3/7] dt-bindings: usb: hisilicon,hi3670-dwc3: add binding for Kirin970
Date:   Wed, 15 Dec 2021 09:54:29 +0100
Message-Id: <0ccdbe3e1e2ed03c58b4d8b17295dbb11f4598eb.1639558366.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639558366.git.mchehab+huawei@kernel.org>
References: <cover.1639558366.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the DWC3 USB3 controller found on Kirin970
CPUs.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH RESEND 0/7] at: https://lore.kernel.org/all/cover.1639558366.git.mchehab+huawei@kernel.org/

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

