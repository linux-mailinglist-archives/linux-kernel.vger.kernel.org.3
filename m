Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B223566702
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbiGEJuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiGEJtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:49:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451FF101EA;
        Tue,  5 Jul 2022 02:49:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9A48B81716;
        Tue,  5 Jul 2022 09:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCBFC341E4;
        Tue,  5 Jul 2022 09:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657014542;
        bh=VVg4jZIiDuyCLFuPo+TMMEfePD6ymiFC4L/Ctad/WPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dROh7zTIa22ghKI7OeYe/tQhjZzeHn8RhtWh+0xm2EqgxBAc53e6+tDXsCX5UIWuq
         brXYfB/UXBYThFwm2Sdlf1a+SsD8bqZ6kGh4bWFCgHU45G8bmNSaVYvUgm/e06SwNp
         964UVhYofNEO1IZqThhHOMHcefnDxh91DQtaB3VSciqfn24l7WbIXMP616MAzI6Rh0
         Thct2wGQM/OfZw6kvq9TDuUDheP3vu95S1Rg3CMWAeXmYp/eJX6yW3vRM41yJqHogR
         vaFkYD7dgMAno5wRI1H+0jaXAo9RFQNb/RMikF+1gd4d1UDNrPTCMinkoWgzvpr4hK
         gFx7Vu1xiDacQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8fB1-0004XF-Ac; Tue, 05 Jul 2022 11:49:03 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 09/43] dt-bindings: phy: qcom,msm8996-qmp-pcie: add example node
Date:   Tue,  5 Jul 2022 11:42:05 +0200
Message-Id: <20220705094239.17174-10-johan+linaro@kernel.org>
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

Add an example node based on a cleaned up version of msm8996.dtsi.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../phy/qcom,msm8996-qmp-pcie-phy.yaml        | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
index 8aadb25686b2..45f7bb7a632a 100644
--- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
@@ -130,3 +130,75 @@ required:
   - vdda-pll-supply
 
 additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-msm8996.h>
+    pcie_phy: phy-wrapper@34000 {
+        compatible = "qcom,msm8996-qmp-pcie-phy";
+        reg = <0x34000 0x488>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x34000 0x4000>;
+
+        clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
+                 <&gcc GCC_PCIE_PHY_CFG_AHB_CLK>,
+                 <&gcc GCC_PCIE_CLKREF_CLK>;
+        clock-names = "aux", "cfg_ahb", "ref";
+
+        resets = <&gcc GCC_PCIE_PHY_BCR>,
+                 <&gcc GCC_PCIE_PHY_COM_BCR>,
+                 <&gcc GCC_PCIE_PHY_COM_NOCSR_BCR>;
+        reset-names = "phy", "common", "cfg";
+
+        vdda-phy-supply = <&vreg_l28a_0p925>;
+        vdda-pll-supply = <&vreg_l12a_1p8>;
+
+        pciephy_0: phy@1000 {
+            reg = <0x1000 0x130>,
+                  <0x1200 0x200>,
+                  <0x1400 0x1dc>;
+
+            clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
+            clock-names = "pipe0";
+            resets = <&gcc GCC_PCIE_0_PHY_BCR>;
+            reset-names = "lane0";
+
+            #clock-cells = <0>;
+            clock-output-names = "pcie_0_pipe_clk_src";
+
+            #phy-cells = <0>;
+        };
+
+        pciephy_1: phy@2000 {
+            reg = <0x2000 0x130>,
+                  <0x2200 0x200>,
+                  <0x2400 0x1dc>;
+
+            clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
+            clock-names = "pipe1";
+            resets = <&gcc GCC_PCIE_1_PHY_BCR>;
+            reset-names = "lane1";
+
+            #clock-cells = <0>;
+            clock-output-names = "pcie_1_pipe_clk_src";
+
+            #phy-cells = <0>;
+        };
+
+        pciephy_2: phy@3000 {
+            reg = <0x3000 0x130>,
+                  <0x3200 0x200>,
+                  <0x3400 0x1dc>;
+
+            clocks = <&gcc GCC_PCIE_2_PIPE_CLK>;
+            clock-names = "pipe2";
+            resets = <&gcc GCC_PCIE_2_PHY_BCR>;
+            reset-names = "lane2";
+
+            #clock-cells = <0>;
+            clock-output-names = "pcie_2_pipe_clk_src";
+
+            #phy-cells = <0>;
+        };
+    };
-- 
2.35.1

