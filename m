Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0B3574E47
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238423AbiGNMpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239493AbiGNMoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:44:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D20474F8;
        Thu, 14 Jul 2022 05:44:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE8A2B824F8;
        Thu, 14 Jul 2022 12:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1FBC34115;
        Thu, 14 Jul 2022 12:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657802644;
        bh=qmg0PoPSNW26UsXhfD2Q9qsF4W171kv+wv6j1LGVsok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d7O0iR/9/G8jl6QptcfX/t3fv2u0snanine1fiNEASXOp8MmiWsb84rJZm7KTWNE7
         mPhGaz0vjWotqNSg9nn5H/UgO2XOQ7z3kXr5pIgVaU06U6/gOWBXz7G4aObAvLziSS
         2k7FBLi4UvA1j6Ovx9ma7TuTOepPX/GjAmWHEd2C7NrdQzCznI8JWUJcjdpmemuhsi
         SbWDYGTceefle588OxpdZnw9MJytb3/nhlOoqJs1nr2kGaTywMZvIZjKCqSBiLY1l9
         ijUw6lR3JWVbnc8G923znFF1x+yDzfM2J7ZrAYSgknUaVdMzecfj47z8BRtKK+1YYy
         +ka70YBl79s+Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oByCO-0007DB-W7; Thu, 14 Jul 2022 14:44:09 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 03/30] dt-bindings: phy: qcom,qmp: drop redundant descriptions
Date:   Thu, 14 Jul 2022 14:43:06 +0200
Message-Id: <20220714124333.27643-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220714124333.27643-1-johan+linaro@kernel.org>
References: <20220714124333.27643-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml | 108 ++++--------------
 1 file changed, 25 insertions(+), 83 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index ec4ddaef2ba9..0359f06bc37d 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -91,17 +91,11 @@ properties:
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
@@ -134,11 +128,7 @@ allOf:
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
@@ -146,9 +136,7 @@ allOf:
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
@@ -166,19 +154,14 @@ allOf:
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
@@ -195,20 +178,14 @@ allOf:
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
@@ -229,19 +206,14 @@ allOf:
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
@@ -258,14 +230,12 @@ allOf:
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
@@ -287,16 +257,13 @@ allOf:
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
@@ -314,17 +281,13 @@ allOf:
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
@@ -346,11 +309,7 @@ allOf:
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
@@ -358,8 +317,7 @@ allOf:
             - const: ref
             - const: refgen
         resets:
-          items:
-            - description: reset of phy block.
+          maxItems: 1
         reset-names:
           items:
             - const: phy
@@ -378,11 +336,7 @@ allOf:
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
@@ -390,9 +344,7 @@ allOf:
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
@@ -410,19 +362,14 @@ allOf:
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
@@ -439,19 +386,14 @@ allOf:
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

