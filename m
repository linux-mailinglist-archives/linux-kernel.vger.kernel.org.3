Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E555666F2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiGEJuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiGEJtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:49:08 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD3512AC9;
        Tue,  5 Jul 2022 02:49:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6B5E6CE1811;
        Tue,  5 Jul 2022 09:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D1DC341CF;
        Tue,  5 Jul 2022 09:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657014542;
        bh=7FwLRC+kaJKNAor2Em2HVLe0zohhBgTEt6rXgUIFLUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UaJguFOMq3Vfr33WlA8A3NoNXHyeszzqG1TbiJfnDbvPTkut1oe0aIE9LPQWog7G/
         xzsdtYoIPhhx2VaWBuX5iBg4Bm5KQZhDqH0Wkn4f03KS4+yDgfx4DX3LB962wSQzUp
         wMGX+0SbToYTJ6OcwWC5t+lPJMZ20Wgxg4uFDMReU4ZUG6xdfXWgNLC6v+1MMY1Xoi
         nRtrywYibb+ev2pcHjrmvlsXcb/wFZSBGpyjWfWunNhQUjnh0VdZNteuEPZYOAKXG5
         YvQKThVycIkocjR/yWTVP1OgISMGcdWMv8gZ2iOA0nM1Czq5QZT8c45QJH52wYd43x
         G91HZcKt6P0tw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8fB0-0004Wx-PT; Tue, 05 Jul 2022 11:49:02 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 03/43] dt-bindings: phy: qcom,qmp: clean up descriptions
Date:   Tue,  5 Jul 2022 11:41:59 +0200
Message-Id: <20220705094239.17174-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220705094239.17174-1-johan+linaro@kernel.org>
References: <20220705094239.17174-1-johan+linaro@kernel.org>
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

Clean up the descriptions somewhat by using uppercase "PHY" consistently
and spelling out "clock".

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml | 102 +++++++++---------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index 38e0ade01687..83f777b4636f 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Vinod Koul <vkoul@kernel.org>
 
 description:
-  QMP phy controller supports physical layer functionality for a number of
+  QMP PHY controller supports physical layer functionality for a number of
   controllers on Qualcomm chipsets, such as, PCIe, UFS, and USB.
 
 properties:
@@ -107,7 +107,7 @@ patternProperties:
   "^phy@[0-9a-f]+$":
     type: object
     description:
-      Each device node of QMP phy is required to have as many child nodes as
+      Each device node of QMP PHY is required to have as many child nodes as
       the number of lanes the PHY has.
 
 required:
@@ -134,10 +134,10 @@ allOf:
       properties:
         clocks:
           items:
-            - description: Phy aux clock.
-            - description: Phy config clock.
-            - description: 19.2 MHz ref clk.
-            - description: Phy common block aux clock.
+            - description: PHY aux clock.
+            - description: PHY config clock.
+            - description: 19.2 MHz ref clock.
+            - description: PHY common block aux clock.
         clock-names:
           items:
             - const: aux
@@ -146,8 +146,8 @@ allOf:
             - const: com_aux
         resets:
           items:
-            - description: reset of phy block.
-            - description: phy common block reset.
+            - description: Reset of PHY block.
+            - description: PHY common block reset.
         reset-names:
           items:
             - const: phy
@@ -166,9 +166,9 @@ allOf:
       properties:
         clocks:
           items:
-            - description: Phy aux clock.
-            - description: Phy config clock.
-            - description: 19.2 MHz ref clk.
+            - description: PHY aux clock.
+            - description: PHY config clock.
+            - description: 19.2 MHz ref clock.
         clock-names:
           items:
             - const: aux
@@ -176,8 +176,8 @@ allOf:
             - const: ref
         resets:
           items:
-            - description: reset of phy block.
-            - description: phy common block reset.
+            - description: Reset of PHY block.
+            - description: PHY common block reset.
         reset-names:
           items:
             - const: phy
@@ -195,9 +195,9 @@ allOf:
       properties:
         clocks:
           items:
-            - description: Phy aux clock.
-            - description: Phy config clock.
-            - description: 19.2 MHz ref clk.
+            - description: PHY aux clock.
+            - description: PHY config clock.
+            - description: 19.2 MHz ref clock.
         clock-names:
           items:
             - const: aux
@@ -205,9 +205,9 @@ allOf:
             - const: ref
         resets:
           items:
-            - description: reset of phy block.
-            - description: phy common block reset.
-            - description: phy's ahb cfg block reset.
+            - description: Reset of PHY block.
+            - description: PHY common block reset.
+            - description: PHY's ahb cfg block reset.
         reset-names:
           items:
             - const: phy
@@ -229,9 +229,9 @@ allOf:
       properties:
         clocks:
           items:
-            - description: Phy aux clock.
-            - description: Phy config clock.
-            - description: 19.2 MHz ref clk.
+            - description: PHY aux clock.
+            - description: PHY config clock.
+            - description: 19.2 MHz ref clock.
         clock-names:
           items:
             - const: aux
@@ -239,8 +239,8 @@ allOf:
             - const: ref
         resets:
           items:
-            - description: reset of phy block.
-            - description: phy common block reset.
+            - description: Reset of PHY block.
+            - description: PHY common block reset.
         reset-names:
           items:
             - const: phy
@@ -258,7 +258,7 @@ allOf:
       properties:
         clocks:
           items:
-            - description: 19.2 MHz ref clk.
+            - description: 19.2 MHz ref clock.
         clock-names:
           items:
             - const: ref
@@ -287,8 +287,8 @@ allOf:
       properties:
         clocks:
           items:
-            - description: 19.2 MHz ref clk.
-            - description: Phy reference aux clock.
+            - description: 19.2 MHz ref clock.
+            - description: PHY reference aux clock.
         clock-names:
           items:
             - const: ref
@@ -313,16 +313,16 @@ allOf:
       properties:
         clocks:
           items:
-            - description: Phy aux clock.
-            - description: Phy config clock.
+            - description: PHY aux clock.
+            - description: PHY config clock.
         clock-names:
           items:
             - const: aux
             - const: cfg_ahb
         resets:
           items:
-            - description: reset of phy block.
-            - description: phy common block reset.
+            - description: Reset of PHY block.
+            - description: PHY common block reset.
         reset-names:
           items:
             - const: phy
@@ -345,10 +345,10 @@ allOf:
       properties:
         clocks:
           items:
-            - description: Phy aux clock.
-            - description: Phy config clock.
-            - description: 19.2 MHz ref clk.
-            - description: Phy refgen clk.
+            - description: PHY aux clock.
+            - description: PHY config clock.
+            - description: 19.2 MHz ref clock.
+            - description: PHY refgen clock.
         clock-names:
           items:
             - const: aux
@@ -357,7 +357,7 @@ allOf:
             - const: refgen
         resets:
           items:
-            - description: reset of phy block.
+            - description: Reset of PHY block.
         reset-names:
           items:
             - const: phy
@@ -377,10 +377,10 @@ allOf:
       properties:
         clocks:
           items:
-            - description: Phy aux clock.
-            - description: 19.2 MHz ref clk source.
-            - description: 19.2 MHz ref clk.
-            - description: Phy common block aux clock.
+            - description: PHY aux clock.
+            - description: 19.2 MHz ref clock source.
+            - description: 19.2 MHz ref clock.
+            - description: PHY common block aux clock.
         clock-names:
           items:
             - const: aux
@@ -389,8 +389,8 @@ allOf:
             - const: com_aux
         resets:
           items:
-            - description: reset of phy block.
-            - description: phy common block reset.
+            - description: Reset of PHY block.
+            - description: PHY common block reset.
         reset-names:
           items:
             - const: phy
@@ -409,9 +409,9 @@ allOf:
       properties:
         clocks:
           items:
-            - description: Phy aux clock.
-            - description: 19.2 MHz ref clk.
-            - description: Phy common block aux clock.
+            - description: PHY aux clock.
+            - description: 19.2 MHz ref clock.
+            - description: PHY common block aux clock.
         clock-names:
           items:
             - const: aux
@@ -419,8 +419,8 @@ allOf:
             - const: com_aux
         resets:
           items:
-            - description: reset of phy block.
-            - description: phy common block reset.
+            - description: Reset of PHY block.
+            - description: PHY common block reset.
         reset-names:
           items:
             - const: phy
@@ -438,9 +438,9 @@ allOf:
       properties:
         clocks:
           items:
-            - description: Phy config clock.
-            - description: 19.2 MHz ref clk.
-            - description: Phy common block aux clock.
+            - description: PHY config clock.
+            - description: 19.2 MHz ref clock.
+            - description: PHY common block aux clock.
         clock-names:
           items:
             - const: cfg_ahb
@@ -449,7 +449,7 @@ allOf:
         resets:
           items:
             - description: phy_phy reset.
-            - description: reset of phy block.
+            - description: reset of PHY block.
         reset-names:
           items:
             - const: phy_phy
-- 
2.35.1

