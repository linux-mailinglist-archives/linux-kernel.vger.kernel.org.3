Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687DA4A4D55
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 18:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381099AbiAaReB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 12:34:01 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:36022 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381027AbiAaRdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:33:43 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20VHXY9S043181;
        Mon, 31 Jan 2022 11:33:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643650414;
        bh=4SwLAH88JnJT5PZJ5YWyDguLyFBhuOkYKFjfGfwc2B8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iPRWr7V0miu35F593GdQpIKq9KLVAbr9/tOIJOt59LMoULQVZUPG9pnI0Ql7qoeq1
         Pfi1QSwc4+0/modXxhcLZmVdS1aSQ68i91MO9bhgBy8Q7KcWwrwWao6nvRQpM3URVv
         6GliiC3oKJj0xxsXtXwIML0Ri8arJlD5pj8xEKQo=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20VHXYmE032374
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jan 2022 11:33:34 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 31
 Jan 2022 11:33:33 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 31 Jan 2022 11:33:33 -0600
Received: from pratyush-4F-325.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20VHXFph034468;
        Mon, 31 Jan 2022 11:33:30 -0600
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
Subject: [PATCH v9 4/4] phy: dt-bindings: Add Cadence D-PHY Rx bindings
Date:   Mon, 31 Jan 2022 23:03:14 +0530
Message-ID: <20220131173314.2073641-5-p.yadav@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220131173314.2073641-1-p.yadav@ti.com>
References: <20220131173314.2073641-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rx mode DPHY is different from Tx mode DPHY. Add a separate binding
for it.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Rob Herring <robh@kernel.org>

---

(no changes since v8)

Changes in v8:
- Add Rob and Laurent's R-by.

Changes in v6:
- Add a new binding for DPHY Rx.

 .../devicetree/bindings/phy/cdns,dphy-rx.yaml | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml

diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml
new file mode 100644
index 000000000000..07be031d82e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/cdns,dphy-rx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence DPHY Rx Device Tree Bindings
+
+maintainers:
+  - Pratyush Yadav <p.yadav@ti.com>
+
+properties:
+  compatible:
+    items:
+      - const: cdns,dphy-rx
+
+  reg:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+
+    dphy0: phy@4580000 {
+        compatible = "cdns,dphy-rx";
+        reg = <0x4580000 0x1100>;
+        #phy-cells = <0>;
+        power-domains = <&k3_pds 147 TI_SCI_PD_EXCLUSIVE>;
+    };
-- 
2.34.1

