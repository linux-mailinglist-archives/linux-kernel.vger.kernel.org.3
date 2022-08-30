Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59A55A67DF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiH3QFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiH3QFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:05:21 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2F3786C2;
        Tue, 30 Aug 2022 09:05:19 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27UG59nQ050775;
        Tue, 30 Aug 2022 11:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661875509;
        bh=1G4ZEtaZd/IgJ3Gszv4C0SPbop3rpeLAcLzhdcf66ec=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=O3mFdGqip+9A8sPjRUDZos++QJSEm/NnZXAiN774dslL65cMsP641cjgsru9KPQEW
         NT10s/7efrH9YdjHTEwzv79Lth8uNKD25npkccLOoEykieL4vwraXIzcZWYx+yEHBJ
         872qERw2xbfgfg++7ZRc8J5ON2Rro+Mpnm86TCn8=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27UG59Vs041634
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Aug 2022 11:05:09 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 30
 Aug 2022 11:05:08 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 30 Aug 2022 11:05:08 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27UG58Gm026907;
        Tue, 30 Aug 2022 11:05:08 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dt-bindings: arm: ti: k3: Sort the SoC definitions alphabetically
Date:   Tue, 30 Aug 2022 11:05:07 -0500
Message-ID: <20220830160507.7726-3-nm@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220830160507.7726-1-nm@ti.com>
References: <20220830160507.7726-1-nm@ti.com>
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

Use alphabetical sort to organize the SoCs

Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../devicetree/bindings/arm/ti/k3.yaml        | 42 +++++++++----------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 7e93e87dcdf4..aeef800eb6ec 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -19,6 +19,19 @@ properties:
   compatible:
     oneOf:
 
+      - description: K3 AM625 SoC
+        items:
+          - enum:
+              - ti,am625-sk
+          - const: ti,am625
+
+      - description: K3 AM642 SoC
+        items:
+          - enum:
+              - ti,am642-evm
+              - ti,am642-sk
+          - const: ti,am642
+
       - description: K3 AM654 SoC
         items:
           - enum:
@@ -29,15 +42,6 @@ properties:
               - ti,am654-evm
           - const: ti,am654
 
-      - description: K3 J721E SoC
-        oneOf:
-          - const: ti,j721e
-          - items:
-              - enum:
-                  - ti,j721e-evm
-                  - ti,j721e-sk
-              - const: ti,j721e
-
       - description: K3 J7200 SoC
         oneOf:
           - const: ti,j7200
@@ -46,18 +50,14 @@ properties:
                   - ti,j7200-evm
               - const: ti,j7200
 
-      - description: K3 AM625 SoC
-        items:
-          - enum:
-              - ti,am625-sk
-          - const: ti,am625
-
-      - description: K3 AM642 SoC
-        items:
-          - enum:
-              - ti,am642-evm
-              - ti,am642-sk
-          - const: ti,am642
+      - description: K3 J721E SoC
+        oneOf:
+          - const: ti,j721e
+          - items:
+              - enum:
+                  - ti,j721e-evm
+                  - ti,j721e-sk
+              - const: ti,j721e
 
       - description: K3 J721s2 SoC
         items:
-- 
2.31.1

