Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5834B47FC08
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 11:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbhL0K4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 05:56:19 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42136 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236235AbhL0K4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 05:56:14 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BRAtvmp005348;
        Mon, 27 Dec 2021 04:55:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640602557;
        bh=kkyCiX36YX76v5RgfDpt9CFK+de87qepIlO83uIqZ1w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kHUqNCA+y5kH2zaSE+tZZK9ooevAVrn9O62lK2U4ndzPweSuuLPRFZNbVSmMoHXCa
         0PwBdK4uNicbVpC5LGBc6UT+bulxS/no1xYUMNe1dg+km4rDZ5SrebN8/O3DIvh3q2
         2aU4J0u8ff0yPfSX4eCOcGoiLj5k8A7TBUZOh6HE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BRAtvQW066575
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Dec 2021 04:55:57 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 27
 Dec 2021 04:55:57 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 27 Dec 2021 04:55:57 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BRAtkVN029188;
        Mon, 27 Dec 2021 04:55:54 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: [PATCH v7 2/4] phy: dt-bindings: Convert Cadence DPHY binding to YAML
Date:   Mon, 27 Dec 2021 16:25:43 +0530
Message-ID: <20211227105545.4852-3-p.yadav@ti.com>
X-Mailer: git-send-email 2.33.1.835.ge9e5ba39a7
In-Reply-To: <20211227105545.4852-1-p.yadav@ti.com>
References: <20211227105545.4852-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Cadence DPHY binding to YAML.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Rob Herring <robh@kernel.org>

---

(no changes since v3)

Changes in v3:
- Add Rob's R-by.

Changes in v2:
- Drop reg description.
- Add a description for each DPHY clock.
- Rename dphy@... to phy@... in example.
- Add Laurent's R-by.
- Re-order subject prefixes.

 .../devicetree/bindings/phy/cdns,dphy.txt     | 20 --------
 .../devicetree/bindings/phy/cdns,dphy.yaml    | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.yaml

diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.txt b/Documentation/devicetree/bindings/phy/cdns,dphy.txt
deleted file mode 100644
index 1095bc4e72d9..000000000000
--- a/Documentation/devicetree/bindings/phy/cdns,dphy.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Cadence DPHY
-============
-
-Cadence DPHY block.
-
-Required properties:
-- compatible: should be set to "cdns,dphy".
-- reg: physical base address and length of the DPHY registers.
-- clocks: DPHY reference clocks.
-- clock-names: must contain "psm" and "pll_ref".
-- #phy-cells: must be set to 0.
-
-Example:
-	dphy0: dphy@fd0e0000{
-		compatible = "cdns,dphy";
-		reg = <0x0 0xfd0e0000 0x0 0x1000>;
-		clocks = <&psm_clk>, <&pll_ref_clk>;
-		clock-names = "psm", "pll_ref";
-		#phy-cells = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
new file mode 100644
index 000000000000..b90a58773bf2
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/cdns,dphy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence DPHY Device Tree Bindings
+
+maintainers:
+  - Pratyush Yadav <p.yadav@ti.com>
+
+properties:
+  compatible:
+    items:
+      - const: cdns,dphy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: PMA state machine clock
+      - description: PLL reference clock
+
+  clock-names:
+    items:
+      - const: psm
+      - const: pll_ref
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+
+    dphy0: phy@fd0e0000{
+        compatible = "cdns,dphy";
+        reg = <0xfd0e0000 0x1000>;
+        clocks = <&psm_clk>, <&pll_ref_clk>;
+        clock-names = "psm", "pll_ref";
+        #phy-cells = <0>;
+    };
-- 
2.33.1.835.ge9e5ba39a7

