Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0C1502929
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 13:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352973AbiDOMAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352752AbiDOL7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 07:59:16 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00708A8ED6;
        Fri, 15 Apr 2022 04:56:48 -0700 (PDT)
Received: from localhost.localdomain (abxj52.neoplus.adsl.tpnet.pl [83.9.3.52])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 8DAF43F697;
        Fri, 15 Apr 2022 13:56:46 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/23] ARM: dts: qcom-msm8974: Fix up mdss nodes
Date:   Fri, 15 Apr 2022 13:56:15 +0200
Message-Id: <20220415115633.575010-6-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415115633.575010-1-konrad.dybcio@somainline.org>
References: <20220415115633.575010-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up formatting, move status=disabled to the end where it belongs,
rename DSI PHY label to match newer DTs, use tabs where possible,
unwrap lines where wrapping is not necessary and don't disable mdp,
as MDSS is useless without it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 77 +++++++++++++----------------
 1 file changed, 34 insertions(+), 43 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index a74563c6f068..71fc24e34092 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -1459,35 +1459,29 @@ opp-27000000 {
 		};
 
 		mdss: mdss@fd900000 {
-			status = "disabled";
-
 			compatible = "qcom,mdss";
-			reg = <0xfd900000 0x100>,
-			      <0xfd924000 0x1000>;
-			reg-names = "mdss_phys",
-			            "vbif_phys";
+			reg = <0xfd900000 0x100>, <0xfd924000 0x1000>;
+			reg-names = "mdss_phys", "vbif_phys";
 
 			power-domains = <&mmcc MDSS_GDSC>;
 
 			clocks = <&mmcc MDSS_AHB_CLK>,
-			         <&mmcc MDSS_AXI_CLK>,
-			         <&mmcc MDSS_VSYNC_CLK>;
-			clock-names = "iface",
-			              "bus",
-			              "vsync";
+				 <&mmcc MDSS_AXI_CLK>,
+				 <&mmcc MDSS_VSYNC_CLK>;
+			clock-names = "iface", "bus", "vsync";
 
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 
 			interrupt-controller;
 			#interrupt-cells = <1>;
 
+			status = "disabled";
+
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
 
 			mdp: mdp@fd900000 {
-				status = "disabled";
-
 				compatible = "qcom,mdp5";
 				reg = <0xfd900100 0x22000>;
 				reg-names = "mdp_phys";
@@ -1499,10 +1493,7 @@ mdp: mdp@fd900000 {
 					 <&mmcc MDSS_AXI_CLK>,
 					 <&mmcc MDSS_MDP_CLK>,
 					 <&mmcc MDSS_VSYNC_CLK>;
-				clock-names = "iface",
-				              "bus",
-				              "core",
-				              "vsync";
+				clock-names = "iface", "bus", "core", "vsync";
 
 				interconnects = <&mmssnoc MNOC_MAS_MDP_PORT0 &bimc BIMC_SLV_EBI_CH0>;
 				interconnect-names = "mdp0-mem";
@@ -1521,8 +1512,6 @@ mdp5_intf1_out: endpoint {
 			};
 
 			dsi0: dsi@fd922800 {
-				status = "disabled";
-
 				compatible = "qcom,mdss-dsi-ctrl";
 				reg = <0xfd922800 0x1f8>;
 				reg-names = "dsi_ctrl";
@@ -1530,29 +1519,32 @@ dsi0: dsi@fd922800 {
 				interrupt-parent = <&mdss>;
 				interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
 
-				assigned-clocks = <&mmcc BYTE0_CLK_SRC>,
-				                  <&mmcc PCLK0_CLK_SRC>;
-				assigned-clock-parents = <&dsi_phy0 0>,
-				                         <&dsi_phy0 1>;
+				assigned-clocks = <&mmcc BYTE0_CLK_SRC>, <&mmcc PCLK0_CLK_SRC>;
+				assigned-clock-parents = <&dsi0_phy 0>, <&dsi0_phy 1>;
 
 				clocks = <&mmcc MDSS_MDP_CLK>,
-				         <&mmcc MDSS_AHB_CLK>,
-				         <&mmcc MDSS_AXI_CLK>,
-				         <&mmcc MDSS_BYTE0_CLK>,
-				         <&mmcc MDSS_PCLK0_CLK>,
-				         <&mmcc MDSS_ESC0_CLK>,
-				         <&mmcc MMSS_MISC_AHB_CLK>;
+					 <&mmcc MDSS_AHB_CLK>,
+					 <&mmcc MDSS_AXI_CLK>,
+					 <&mmcc MDSS_BYTE0_CLK>,
+					 <&mmcc MDSS_PCLK0_CLK>,
+					 <&mmcc MDSS_ESC0_CLK>,
+					 <&mmcc MMSS_MISC_AHB_CLK>;
 				clock-names = "mdp_core",
-				              "iface",
-				              "bus",
-				              "byte",
-				              "pixel",
-				              "core",
-				              "core_mmss";
-
-				phys = <&dsi_phy0>;
+					      "iface",
+					      "bus",
+					      "byte",
+					      "pixel",
+					      "core",
+					      "core_mmss";
+
+				phys = <&dsi0_phy>;
 				phy-names = "dsi-phy";
 
+				status = "disabled";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
@@ -1572,23 +1564,22 @@ dsi0_out: endpoint {
 				};
 			};
 
-			dsi_phy0: dsi-phy@fd922a00 {
-				status = "disabled";
-
+			dsi0_phy: dsi-phy@fd922a00 {
 				compatible = "qcom,dsi-phy-28nm-hpm";
 				reg = <0xfd922a00 0xd4>,
 				      <0xfd922b00 0x280>,
 				      <0xfd922d80 0x30>;
 				reg-names = "dsi_pll",
-				            "dsi_phy",
-				            "dsi_phy_regulator";
+					    "dsi_phy",
+					    "dsi_phy_regulator";
 
 				#clock-cells = <1>;
 				#phy-cells = <0>;
-				qcom,dsi-phy-index = <0>;
 
 				clocks = <&mmcc MDSS_AHB_CLK>, <&xo_board>;
 				clock-names = "iface", "ref";
+
+				status = "disabled";
 			};
 		};
 
-- 
2.35.2

