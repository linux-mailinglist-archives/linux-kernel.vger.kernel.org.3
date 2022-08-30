Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A875A61F4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiH3Lbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiH3LaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:30:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8217A17072;
        Tue, 30 Aug 2022 04:30:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 25327CE1AA4;
        Tue, 30 Aug 2022 11:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1ECDC433D7;
        Tue, 30 Aug 2022 11:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661859000;
        bh=YXEO7TnIknDOjep8rYgIZiNPpS/HJKSGiIdHgQZk324=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rylHwQlZG/b4yn90lJCctDXJE4uvye6FnTwrMNeEZNmagerqm1rHpYJx6G1fdm1UD
         2PP4NR1pAk8kPuZZba272ADvur1YiJfiRnEGJZzxkdD7d6MWvNng/jKQXn/J+RBO2i
         Wy/4djdagi6A98V8/nTfaTMDkx0RQnQcmxjpHf8PqQuyrndUYcV6EBxXbFJetM5tj1
         2M89evbCM+mdgCtZflmhM2cW4Et2Hdl6vM+W9nJ45AOOPAAe0cXxfgUbiA5Xtwt4et
         nlwMhCvDOc3YXUbtNNCevxDXIZ4x7l+iLXlI2qYhnlpyj11hsjDFOJpWt8q/UL8BqJ
         QhPKaeXJwsXZA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oSzRN-0000zt-3w; Tue, 30 Aug 2022 13:29:57 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 03/30] dt-bindings: phy: qcom,qmp: drop redundant descriptions
Date:   Tue, 30 Aug 2022 13:28:56 +0200
Message-Id: <20220830112923.3725-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220830112923.3725-1-johan+linaro@kernel.org>
References: <20220830112923.3725-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index f3976b1585b5..da38764f845b 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -92,17 +92,11 @@ properties:
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
@@ -135,11 +129,7 @@ allOf:
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
@@ -147,9 +137,7 @@ allOf:
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
@@ -167,19 +155,14 @@ allOf:
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
@@ -196,20 +179,14 @@ allOf:
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
@@ -230,19 +207,14 @@ allOf:
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
@@ -259,14 +231,12 @@ allOf:
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
@@ -288,16 +258,13 @@ allOf:
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
@@ -315,17 +282,13 @@ allOf:
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
@@ -347,11 +310,7 @@ allOf:
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
@@ -359,8 +318,7 @@ allOf:
             - const: ref
             - const: refgen
         resets:
-          items:
-            - description: reset of phy block.
+          maxItems: 1
         reset-names:
           items:
             - const: phy
@@ -380,11 +338,7 @@ allOf:
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
@@ -392,9 +346,7 @@ allOf:
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
@@ -412,19 +364,14 @@ allOf:
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
@@ -441,19 +388,14 @@ allOf:
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

