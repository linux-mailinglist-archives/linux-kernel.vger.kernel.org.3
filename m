Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14A2495CF9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349095AbiAUJjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 04:39:20 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54936 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349623AbiAUJjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:39:18 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20L9d5t8008719;
        Fri, 21 Jan 2022 03:39:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1642757945;
        bh=g1t5ZkmS5sFmGdv/w4eHt//216aXDZLa8/FNmCyDPbw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vGLnzqMHwEZ908/u49odC3XfFKPkpK0GuhnNXPfqt1EQt23kx9xAun+LrQ2Zf88RC
         EL5f1pyeXlIqOYD1lIZWm5TuH0QzorEpkxmBB+T03sSSYYBVvqiXOBseGnHyrCrYRK
         pE7QfSpZXR5Ggz5ev2i5/rnIlnBRQbJwLeEer77k=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20L9d5Ar043556
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Jan 2022 03:39:05 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 21
 Jan 2022 03:39:04 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 21 Jan 2022 03:39:04 -0600
Received: from pratyush-4F-325.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20L9cndP048554;
        Fri, 21 Jan 2022 03:39:01 -0600
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
Subject: [PATCH v8 3/4] phy: dt-bindings: cdns,dphy: add power-domains property
Date:   Fri, 21 Jan 2022 15:08:48 +0530
Message-ID: <20220121093849.3218092-4-p.yadav@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121093849.3218092-1-p.yadav@ti.com>
References: <20220121093849.3218092-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property is needed on TI platforms to enable the PD of the DPHY
before it can be used.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Rob Herring <robh@kernel.org>

---

(no changes since v3)

Changes in v3:
- Add Rob's Ack.

Changes in v2:
- Add power-domain to the example.
- Add Laurent's R-by.
- Re-order subject prefixes.

 Documentation/devicetree/bindings/phy/cdns,dphy.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
index b90a58773bf2..c50629bd1b51 100644
--- a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
+++ b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
@@ -30,6 +30,9 @@ properties:
   "#phy-cells":
     const: 0
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -41,11 +44,13 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
 
     dphy0: phy@fd0e0000{
         compatible = "cdns,dphy";
         reg = <0xfd0e0000 0x1000>;
         clocks = <&psm_clk>, <&pll_ref_clk>;
         clock-names = "psm", "pll_ref";
+        power-domains = <&k3_pds 147 TI_SCI_PD_EXCLUSIVE>;
         #phy-cells = <0>;
     };
-- 
2.25.1

