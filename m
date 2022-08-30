Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592435A61F5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiH3Lbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiH3LaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:30:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8371F21822;
        Tue, 30 Aug 2022 04:30:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3524B61555;
        Tue, 30 Aug 2022 11:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C0FC4FEE4;
        Tue, 30 Aug 2022 11:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661859000;
        bh=tBb3TBcfg9s+9Nc73d6Io6kUB8boSCIbXgoJx8j5hJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mYUW4WJ6oFhclkHRIZrHdHo1qTYxxrhLkh1VytqN3E4nMGHyAasRFvO+oOizqPFPT
         qjilFBWQEu4x6DYUiv3zqKU9eEYfnUB16cc3ANmihGySYToCXg0KpT8GbxQGG9wXgS
         kNYCDE6nvTlKBWhyg1F7RLeJ+4OWNBYHOKV5A3YvNUjLO8fVREzzpwcHdXMlA70Uvm
         SMVEtnUD+GJiUeVB9ndFeQSVQH7a64dQI7x4RLh6fYrkqWbiB9MpnbeMp/VuydVYrt
         c6Z/5VuvknMN5xrMZDgiJgjTx45vc09Xfe3EKkC0I/4qiFJfcL/9anLWz5y4+DkBfr
         BW0nlJ3FWamww==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oSzRN-00010I-P0; Tue, 30 Aug 2022 13:29:57 +0200
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
Subject: [PATCH v4 11/30] dt-bindings: phy: qcom,msm8996-qmp-pcie: deprecate reset names
Date:   Tue, 30 Aug 2022 13:29:04 +0200
Message-Id: <20220830112923.3725-12-johan+linaro@kernel.org>
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

