Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5AA5A9273
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiIAIzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbiIAIz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:55:27 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF098A832F;
        Thu,  1 Sep 2022 01:55:26 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2818tGpY065578;
        Thu, 1 Sep 2022 03:55:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662022516;
        bh=H0Tc6ojNuZk5yS4jUr0Qno91wdPGn6mpSzhNMcz8rXw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vpUK+4vqHD1N271+Wpr9wxXhxfMFhn1PewP+MOv9FvS1qzFQNSrrwmr2wNdQrWFTb
         8B6Gb2id4gDDQuUjysSuS5UyS3ys/Mg4DJpQt6J/m3qOTU9VuA1qGdbI/Urourszea
         obUjB7oPEa9lGLc1xGdfzOlf7JzGFqZDF2RGtPxg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2818tGUe118526
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Sep 2022 03:55:16 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 1 Sep
 2022 03:55:15 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 1 Sep 2022 03:55:16 -0500
Received: from uda0492258.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2818t7Tb061466;
        Thu, 1 Sep 2022 03:55:12 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>,
        <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>,
        <grygorii.strashko@ti.com>, <rogerq@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <s-vadapalli@ti.com>
Subject: [PATCH v4 1/2] dt-bindings: phy: ti: phy-gmii-sel: Add bindings for J7200
Date:   Thu, 1 Sep 2022 14:25:05 +0530
Message-ID: <20220901085506.138633-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220901085506.138633-1-s-vadapalli@ti.com>
References: <20220901085506.138633-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
 .../mfd/ti,j721e-system-controller.yaml       |  6 ++++
 .../bindings/phy/ti,phy-gmii-sel.yaml         | 30 ++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
index 1aeac43cad92..802374e7645f 100644
--- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
@@ -54,6 +54,12 @@ patternProperties:
     description:
       Clock provider for TI EHRPWM nodes.
 
+  "phy@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/phy/phy-provider.yaml
+    description:
+      This is the register to set phy mode through phy-gmii-sel driver.
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
index ff8a6d9eb153..0ffb97f1a77c 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
@@ -53,12 +53,24 @@ properties:
       - ti,am43xx-phy-gmii-sel
       - ti,dm814-phy-gmii-sel
       - ti,am654-phy-gmii-sel
+      - ti,j7200-cpsw5g-phy-gmii-sel
 
   reg:
     maxItems: 1
 
   '#phy-cells': true
 
+  ti,qsgmii-main-ports:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Required only for QSGMII mode. Array to select the port for
+      QSGMII main mode. Rest of the ports are selected as QSGMII_SUB
+      ports automatically. Any one of the 4 CPSW5G ports can act as the
+      main port with the rest of them being the QSGMII_SUB ports.
+    items:
+      minimum: 1
+      maximum: 4
+
 allOf:
   - if:
       properties:
@@ -73,6 +85,22 @@ allOf:
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
+        ti,qsgmii-main-ports:
+          maxItems: 1
+    else:
+      properties:
+        ti,qsgmii-main-ports: false
   - if:
       properties:
         compatible:
@@ -97,7 +125,7 @@ additionalProperties: false
 
 examples:
   - |
-    phy_gmii_sel: phy-gmii-sel@650 {
+    phy_gmii_sel: phy@650 {
         compatible = "ti,am3352-phy-gmii-sel";
         reg = <0x650 0x4>;
         #phy-cells = <2>;
-- 
2.25.1

