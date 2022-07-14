Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CAD574E4C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239666AbiGNMqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239253AbiGNMoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:44:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41854255AC;
        Thu, 14 Jul 2022 05:44:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A29A461F9F;
        Thu, 14 Jul 2022 12:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E59C341E7;
        Thu, 14 Jul 2022 12:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657802644;
        bh=tBb3TBcfg9s+9Nc73d6Io6kUB8boSCIbXgoJx8j5hJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NY9+/TnIkUpxV+x8FQaV+/zdNwONZuqc+Ggv4HhrsDh7QTXvH+34ZrJLBv1gro5S6
         C/oaNEGd1WU5Ih12JGjcE19PrOK5PoLEdLAoNiTEDeKpL58NNnJGFM88SdCP0+wN3q
         wsACciJSBOd7zAqJiAKkMd3YUH5k4Xri29qZdeK+5itJifGqbxahD9jLpc2+bqVJ/l
         VZsR8/bAtfATRLtpwsjYGNOu4EgizYrXNfAUK1wQTDliD3Cwm4mdXvdtqQXgUpsXFo
         ZT44ro08Qu0MyToBojo6xPud3V9Tlfq70EBJfqpdB44Smcr2mCRu1DVzCxpyjpzf+p
         gacoLusart4Gg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oByCP-0007DY-MC; Thu, 14 Jul 2022 14:44:09 +0200
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
Subject: [PATCH v3 11/30] dt-bindings: phy: qcom,msm8996-qmp-pcie: deprecate reset names
Date:   Thu, 14 Jul 2022 14:43:14 +0200
Message-Id: <20220714124333.27643-12-johan+linaro@kernel.org>
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

Deprecate the PHY node 'reset-names' property which specified that the
reset name should have an unnecessary "lane" suffix.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
index b7b115e021d4..4e710ef75523 100644
--- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
@@ -78,9 +78,10 @@ patternProperties:
 
       resets:
         items:
-          - description: PHY (lane) reset
+          - description: PHY reset
 
       reset-names:
+        deprecated: true
         items:
           - enum:
               - lane0
@@ -100,7 +101,6 @@ patternProperties:
       - reg
       - clocks
       - resets
-      - reset-names
       - "#clock-cells"
       - clock-output-names
       - "#phy-cells"
@@ -152,7 +152,6 @@ examples:
 
             clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
             resets = <&gcc GCC_PCIE_0_PHY_BCR>;
-            reset-names = "lane0";
 
             #clock-cells = <0>;
             clock-output-names = "pcie_0_pipe_clk_src";
@@ -167,7 +166,6 @@ examples:
 
             clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
             resets = <&gcc GCC_PCIE_1_PHY_BCR>;
-            reset-names = "lane1";
 
             #clock-cells = <0>;
             clock-output-names = "pcie_1_pipe_clk_src";
@@ -182,7 +180,6 @@ examples:
 
             clocks = <&gcc GCC_PCIE_2_PIPE_CLK>;
             resets = <&gcc GCC_PCIE_2_PHY_BCR>;
-            reset-names = "lane2";
 
             #clock-cells = <0>;
             clock-output-names = "pcie_2_pipe_clk_src";
-- 
2.35.1

