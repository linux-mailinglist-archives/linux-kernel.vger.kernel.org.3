Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6B856A468
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbiGGNs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236100AbiGGNrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:47:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2B82CC9F;
        Thu,  7 Jul 2022 06:47:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16E0DB8221E;
        Thu,  7 Jul 2022 13:47:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD89C341DB;
        Thu,  7 Jul 2022 13:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657201659;
        bh=nsBGsr4XzACo0oOKuodhYrKEKO7HUqy+Yib6di9ICIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ozBSbjpp9k6O2ZKVvm498hDVDKmBjN7aaJ8EQOGjgMFv+hrwPMxPPd7x5Lt1n7gkO
         UB8vg73NioDO/abh8gYSVNiN9OItA+53YWW9RqxfZ1lRcV/uPlexkV5vCixEUXd8Jd
         najyUPpmJC9MGJDrEBcw52iAUueqRu0nLuIn2sBFO4ydJcZ1d8vSFdw1nG91qJ86qK
         RI16VWud2kXu6EugFXUilvx7VIaaZv8WUNyjfKX0QogrU/mR7nzPgXghMno8SMi9k4
         q/Cq7bmedXMIiPBMt+KMa3ErGht0GcfCOre1mPAFYcMEExUBbbCB93q7VK8tBAv7mt
         jhmKLtleiwBEw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o9Rr3-0000vu-Qu; Thu, 07 Jul 2022 15:47:41 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 03/30] dt-bindings: phy: qcom,qmp: drop redundant descriptions
Date:   Thu,  7 Jul 2022 15:46:58 +0200
Message-Id: <20220707134725.3512-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220707134725.3512-1-johan+linaro@kernel.org>
References: <20220707134725.3512-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the redundant supply and clock descriptions which did not add much
information beyond what can be inferred from the corresponding resource
names.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml | 108 ++++--------------
 1 file changed, 25 insertions(+), 83 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index 38e0ade01687..ea028bad961d 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -90,17 +90,11 @@ properties:
     minItems: 1
     maxItems: 3
 
-  vdda-phy-supply:
-    description:
-      Phandle to a regulator supply to PHY core block.
+  vdda-phy-supply: true
 
-  vdda-pll-supply:
-    description:
-      Phandle to 1.8V regulator supply to PHY refclk pll block.
+  vdda-pll-supply: true
 
-  vddp-ref-clk-supply:
-    description:
-      Phandle to a regulator supply to any specific refclk pll block.
+  vddp-ref-clk-supply: true
 
 #Required nodes:
 patternProperties:
@@ -133,11 +127,7 @@ allOf:
     then:
       properties:
         clocks:
-          items:
-            - description: Phy aux clock.
-            - description: Phy config clock.
-            - description: 19.2 MHz ref clk.
-            - description: Phy common block aux clock.
+          maxItems: 4
         clock-names:
           items:
             - const: aux
@@ -145,9 +135,7 @@ allOf:
             - const: ref
             - const: com_aux
         resets:
-          items:
-            - description: reset of phy block.
-            - description: phy common block reset.
+          maxItems: 2
         reset-names:
           items:
             - const: phy
@@ -165,19 +153,14 @@ allOf:
     then:
       properties:
         clocks:
-          items:
-            - description: Phy aux clock.
-            - description: Phy config clock.
-            - description: 19.2 MHz ref clk.
+          maxItems: 3
         clock-names:
           items:
             - const: aux
             - const: cfg_ahb
             - const: ref
         resets:
-          items:
-            - description: reset of phy block.
-            - description: phy common block reset.
+          maxItems: 2
         reset-names:
           items:
             - const: phy
@@ -194,20 +177,14 @@ allOf:
     then:
       properties:
         clocks:
-          items:
-            - description: Phy aux clock.
-            - description: Phy config clock.
-            - description: 19.2 MHz ref clk.
+          maxItems: 3
         clock-names:
           items:
             - const: aux
             - const: cfg_ahb
             - const: ref
         resets:
-          items:
-            - description: reset of phy block.
-            - description: phy common block reset.
-            - description: phy's ahb cfg block reset.
+          maxItems: 3
         reset-names:
           items:
             - const: phy
@@ -228,19 +205,14 @@ allOf:
     then:
       properties:
         clocks:
-          items:
-            - description: Phy aux clock.
-            - description: Phy config clock.
-            - description: 19.2 MHz ref clk.
+          maxItems: 3
         clock-names:
           items:
             - const: aux
             - const: cfg_ahb
             - const: ref
         resets:
-          items:
-            - description: reset of phy block.
-            - description: phy common block reset.
+          maxItems: 2
         reset-names:
           items:
             - const: phy
@@ -257,14 +229,12 @@ allOf:
     then:
       properties:
         clocks:
-          items:
-            - description: 19.2 MHz ref clk.
+          maxItems: 1
         clock-names:
           items:
             - const: ref
         resets:
-          items:
-            - description: PHY reset in the UFS controller.
+          maxItems: 1
         reset-names:
           items:
             - const: ufsphy
@@ -286,16 +256,13 @@ allOf:
     then:
       properties:
         clocks:
-          items:
-            - description: 19.2 MHz ref clk.
-            - description: Phy reference aux clock.
+          maxItems: 2
         clock-names:
           items:
             - const: ref
             - const: ref_aux
         resets:
-          items:
-            - description: PHY reset in the UFS controller.
+          maxItems: 1
         reset-names:
           items:
             - const: ufsphy
@@ -312,17 +279,13 @@ allOf:
     then:
       properties:
         clocks:
-          items:
-            - description: Phy aux clock.
-            - description: Phy config clock.
+          maxItems: 2
         clock-names:
           items:
             - const: aux
             - const: cfg_ahb
         resets:
-          items:
-            - description: reset of phy block.
-            - description: phy common block reset.
+          maxItems: 2
         reset-names:
           items:
             - const: phy
@@ -344,11 +307,7 @@ allOf:
     then:
       properties:
         clocks:
-          items:
-            - description: Phy aux clock.
-            - description: Phy config clock.
-            - description: 19.2 MHz ref clk.
-            - description: Phy refgen clk.
+          maxItems: 4
         clock-names:
           items:
             - const: aux
@@ -356,8 +315,7 @@ allOf:
             - const: ref
             - const: refgen
         resets:
-          items:
-            - description: reset of phy block.
+          maxItems: 1
         reset-names:
           items:
             - const: phy
@@ -376,11 +334,7 @@ allOf:
     then:
       properties:
         clocks:
-          items:
-            - description: Phy aux clock.
-            - description: 19.2 MHz ref clk source.
-            - description: 19.2 MHz ref clk.
-            - description: Phy common block aux clock.
+          maxItems: 4
         clock-names:
           items:
             - const: aux
@@ -388,9 +342,7 @@ allOf:
             - const: ref
             - const: com_aux
         resets:
-          items:
-            - description: reset of phy block.
-            - description: phy common block reset.
+          maxItems: 2
         reset-names:
           items:
             - const: phy
@@ -408,19 +360,14 @@ allOf:
     then:
       properties:
         clocks:
-          items:
-            - description: Phy aux clock.
-            - description: 19.2 MHz ref clk.
-            - description: Phy common block aux clock.
+          maxItems: 3
         clock-names:
           items:
             - const: aux
             - const: ref_clk_src
             - const: com_aux
         resets:
-          items:
-            - description: reset of phy block.
-            - description: phy common block reset.
+          maxItems: 2
         reset-names:
           items:
             - const: phy
@@ -437,19 +384,14 @@ allOf:
     then:
       properties:
         clocks:
-          items:
-            - description: Phy config clock.
-            - description: 19.2 MHz ref clk.
-            - description: Phy common block aux clock.
+          maxItems: 3
         clock-names:
           items:
             - const: cfg_ahb
             - const: ref
             - const: com_aux
         resets:
-          items:
-            - description: phy_phy reset.
-            - description: reset of phy block.
+          maxItems: 2
         reset-names:
           items:
             - const: phy_phy
-- 
2.35.1

