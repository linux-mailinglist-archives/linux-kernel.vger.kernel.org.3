Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A940347887F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbhLQKNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbhLQKM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:12:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EE1C061574;
        Fri, 17 Dec 2021 02:12:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0076562070;
        Fri, 17 Dec 2021 10:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0BDC36AE9;
        Fri, 17 Dec 2021 10:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639735975;
        bh=OMKIhVLZUPKdh2b5spfQ1xeI04TQ3VcvJwTnPxVdAGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kZDwwESCTE5e1d2oB/a7RrnwmLOC6/S9BgtKCla+pvVOGAd8z+TCBuzNMh+O5zc2u
         nXkpKjfKzR2YEPymyVyreeR1X7d0vnRVHFHF0xh3pks/1pMn5mKj9VGO5UbhE+NHEa
         1ig3ZglSd8yQgC4FiUj6G8N16KVHtuODC9ETDH0nWEhGWmv0o7HhFp2vdgwHQzawwz
         acXWxP0QQ1gGCQO4/K/bB0F0CXAMF4m23f3p0kFRjqUTDNpRWEvwUPA3EJ0LuPO3A3
         N3Rzld0ZbJ6xuihJrW/HrwzAI9luzWlJwaUMq8T7klK5dCRX+oHjaNCCifkf8z0KBU
         by0Ed0ghpvyyA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1myAEP-000g6E-8X; Fri, 17 Dec 2021 11:12:53 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v2 3/7] dt-bindings: usb: hisilicon,hi3670-dwc3: add binding for Kirin970
Date:   Fri, 17 Dec 2021 11:12:47 +0100
Message-Id: <03023825dafd0c9ae3f99e650e14137f290bb377.1639735742.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639735742.git.mchehab@kernel.org>
References: <cover.1639735742.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Add documentation for the DWC3 USB3 controller found on Kirin970
CPUs.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH v2 0/7] at: https://lore.kernel.org/all/cover.1639735742.git.mchehab@kernel.org/

 .../bindings/usb/hisilicon,hi3670-dwc3.yaml   | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/hisilicon,hi3670-dwc3.yaml

diff --git a/Documentation/devicetree/bindings/usb/hisilicon,hi3670-dwc3.yaml b/Documentation/devicetree/bindings/usb/hisilicon,hi3670-dwc3.yaml
new file mode 100644
index 000000000000..b38f3bfd9107
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/hisilicon,hi3670-dwc3.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
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
+      - const: abb
+      - const: hclk
+      - const: ref
+      - const: aclk
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
+      usb3: dwc3 {
+        compatible = "hisilicon,hi3670-dwc3";
+        #address-cells = <2>;
+        #size-cells = <2>;
+        ranges;
+
+        clocks = <&crg_ctrl HI3670_CLK_GATE_ABB_USB>,
+                 <&crg_ctrl HI3670_HCLK_GATE_USB3OTG>,
+                 <&crg_ctrl HI3670_CLK_GATE_USB3OTG_REF>,
+                 <&crg_ctrl HI3670_ACLK_GATE_USB3DVFS>;
+        clock-names = "abb",
+                      "hclk",
+                      "ref",
+                      "aclk";
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

