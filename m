Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8155669F7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiGELlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiGELlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:41:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170A316587;
        Tue,  5 Jul 2022 04:40:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE7FF61640;
        Tue,  5 Jul 2022 11:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D35C341F0;
        Tue,  5 Jul 2022 11:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657021256;
        bh=lbRbz+C9ylQQqmM6yIHghVjXaGtf5c6lGhSwwRAWYZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ABtMGAFeUvcUCyEkm0iHmWa3FCGjPXPx42Ci7n6f54bMGVgSpfMxNBIhwH2Vb/sVE
         iYcg/mmIU4zEGIisxxzaznu6egrleODGBj4luSqJwr33y+VEvocDNWCLzO6FH/nrxg
         Tmn4LiUnCqmwDKU2qu3+ZjVM1sx4wRCwJEmxrLOn9+9n1fqtZjvAm65MmjoZpQSYZE
         FHeMEJ950XNcRdjiaWk4MCdBK/JEhXPP1bz5SxGAgZ0xtHiZzkyNA1HuRHpQ/F6yAp
         eoHnQ2ge+Ucu6hcLu+WoSvHLZwyTvx/t7jUB7JuTqYobx/fj9U3gosVJXOq+y6wm53
         5U9WosDy8DtHw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8gvK-0005y1-79; Tue, 05 Jul 2022 13:40:58 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 13/14] arm64: dts: qcom: msm8996: use non-empty ranges for PCIe PHYs
Date:   Tue,  5 Jul 2022 13:40:31 +0200
Message-Id: <20220705114032.22787-14-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220705114032.22787-1-johan+linaro@kernel.org>
References: <20220705114032.22787-1-johan+linaro@kernel.org>
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

Clean up the PCIe PHY nodes by using a non-empty ranges property.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index b670d0412760..16869bb7d625 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -590,7 +590,7 @@ pcie_phy: phy@34000 {
 			reg = <0x00034000 0x488>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges;
+			ranges = <0x0 0x00034000 0x4000>;
 
 			clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
 				<&gcc GCC_PCIE_PHY_CFG_AHB_CLK>,
@@ -603,10 +603,10 @@ pcie_phy: phy@34000 {
 			reset-names = "phy", "common", "cfg";
 			status = "disabled";
 
-			pciephy_0: phy@35000 {
-				reg = <0x00035000 0x130>,
-				      <0x00035200 0x200>,
-				      <0x00035400 0x1dc>;
+			pciephy_0: phy@1000 {
+				reg = <0x1000 0x130>,
+				      <0x1200 0x200>,
+				      <0x1400 0x1dc>;
 				#phy-cells = <0>;
 
 				#clock-cells = <0>;
@@ -617,10 +617,10 @@ pciephy_0: phy@35000 {
 				reset-names = "lane0";
 			};
 
-			pciephy_1: phy@36000 {
-				reg = <0x00036000 0x130>,
-				      <0x00036200 0x200>,
-				      <0x00036400 0x1dc>;
+			pciephy_1: phy@2000 {
+				reg = <0x2000 0x130>,
+				      <0x2200 0x200>,
+				      <0x2400 0x1dc>;
 				#phy-cells = <0>;
 
 				#clock-cells = <0>;
@@ -631,10 +631,10 @@ pciephy_1: phy@36000 {
 				reset-names = "lane1";
 			};
 
-			pciephy_2: phy@37000 {
-				reg = <0x00037000 0x130>,
-				      <0x00037200 0x200>,
-				      <0x00037400 0x1dc>;
+			pciephy_2: phy@3000 {
+				reg = <0x3000 0x130>,
+				      <0x3200 0x200>,
+				      <0x3400 0x1dc>;
 				#phy-cells = <0>;
 
 				#clock-cells = <0>;
-- 
2.35.1

