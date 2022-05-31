Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB94538F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 13:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343702AbiEaLNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 07:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343691AbiEaLNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 07:13:10 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653546F4B3;
        Tue, 31 May 2022 04:13:09 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24VBD20H004194;
        Tue, 31 May 2022 06:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1653995582;
        bh=sk63Z4ufXimfVQy5b3IO3HJO0DUDoexen2snbThS2zg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xnSIQLnLrTGMgUr4ohI1l2c+g/Npx7zJ2oqsskvJ9RyT8s/HnKW9+AYaGBMR+/Aiz
         gbXSTsgp6pMC3LIKFOLhJmEKNOENObxoiPiAZ962+3eDSuFvt50sZweryNzrLvCiE5
         s1GF1FQ4iDPYkigmsySHca7Aywki32JAuQcLAknY=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24VBD217036632
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 31 May 2022 06:13:02 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 31
 May 2022 06:13:01 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 31 May 2022 06:13:02 -0500
Received: from ula0492258.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24VBCka8045977;
        Tue, 31 May 2022 06:12:58 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>,
        <grygorii.strashko@ti.com>, <rogerq@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: [PATCH 1/2] dt-bindings: phy: ti: phy-gmii-sel: Add bindings for J7200
Date:   Tue, 31 May 2022 16:42:20 +0530
Message-ID: <20220531111221.22963-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220531111221.22963-1-s-vadapalli@ti.com>
References: <20220531111221.22963-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI's J7200 SoC supports additional PHY modes like QSGMII and SGMII
that are not supported on earlier SoCs. Add a compatible for it.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 .../mfd/ti,j721e-system-controller.yaml       |  5 ++++
 .../bindings/phy/ti,phy-gmii-sel.yaml         | 24 ++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
index fa86691ebf16..e381ba62a513 100644
--- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
@@ -48,6 +48,11 @@ patternProperties:
     description:
       This is the SERDES lane control mux.
 
+  "phy@[0-9a-f]+$":
+    type: object
+    description:
+      This is the register to set phy mode through phy-gmii-sel driver.
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
index ff8a6d9eb153..7427758451e7 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
@@ -53,12 +53,21 @@ properties:
       - ti,am43xx-phy-gmii-sel
       - ti,dm814-phy-gmii-sel
       - ti,am654-phy-gmii-sel
+      - ti,j7200-cpsw5g-phy-gmii-sel
 
   reg:
     maxItems: 1
 
   '#phy-cells': true
 
+  ti,enet-ctrl-qsgmii:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Required only for QSGMII mode. Bitmask to select the port for
+      QSGMII main mode. Rest of the ports are selected as QSGMII_SUB
+      ports automatically. Any of the 4 CPSW5G ports can act as the
+      main port with the rest of them being the QSGMII_SUB ports.
+
 allOf:
   - if:
       properties:
@@ -73,6 +82,19 @@ allOf:
         '#phy-cells':
           const: 1
           description: CPSW port number (starting from 1)
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,j7200-cpsw5g-phy-gmii-sel
+    then:
+      properties:
+        '#phy-cells':
+          const: 1
+          description: CPSW port number (starting from 1)
+        ti,enet-ctrl-qsgmii:
+          enum: [1, 2, 4, 8]
   - if:
       properties:
         compatible:
@@ -97,7 +119,7 @@ additionalProperties: false
 
 examples:
   - |
-    phy_gmii_sel: phy-gmii-sel@650 {
+    phy_gmii_sel: phy@650 {
         compatible = "ti,am3352-phy-gmii-sel";
         reg = <0x650 0x4>;
         #phy-cells = <2>;
-- 
2.36.1

