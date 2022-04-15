Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6A4502923
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 13:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353006AbiDOMAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352837AbiDOL7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 07:59:41 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CDDA9958
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 04:57:04 -0700 (PDT)
Received: from localhost.localdomain (abxj52.neoplus.adsl.tpnet.pl [83.9.3.52])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id C3E5D3F612;
        Fri, 15 Apr 2022 13:57:01 +0200 (CEST)
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
Subject: [PATCH 14/23] ARM: dts: qcom-msm8974pro: Use &labels
Date:   Fri, 15 Apr 2022 13:56:24 +0200
Message-Id: <20220415115633.575010-15-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415115633.575010-1-konrad.dybcio@somainline.org>
References: <20220415115633.575010-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use &labels to align with the style used in new DTS and apply tiny
style fixes.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm/boot/dts/qcom-msm8974pro.dtsi | 31 +++++++++++---------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974pro.dtsi b/arch/arm/boot/dts/qcom-msm8974pro.dtsi
index b64c28036dd0..973bd1dafbfe 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974pro.dtsi
@@ -1,23 +1,18 @@
 #include "qcom-msm8974.dtsi"
 
-/ {
-	soc {
-		sdhci@f9824900 {
-			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
-				 <&gcc GCC_SDCC1_AHB_CLK>,
-				 <&xo_board>,
-				 <&gcc GCC_SDCC1_CDCCAL_FF_CLK>,
-				 <&gcc GCC_SDCC1_CDCCAL_SLEEP_CLK>;
-			clock-names = "core", "iface", "xo", "cal", "sleep";
-		};
+&gcc {
+	compatible = "qcom,gcc-msm8974pro";
+};
 
-		clock-controller@fc400000 {
-				compatible = "qcom,gcc-msm8974pro";
-		};
+&gpu {
+	compatible = "qcom,adreno-330.2", "qcom,adreno";
+};
 
-		adreno@fdb00000 {
-			compatible = "qcom,adreno-330.2",
-				     "qcom,adreno";
-		};
-	};
+&sdhc_1 {
+	clocks = <&gcc GCC_SDCC1_APPS_CLK>,
+		 <&gcc GCC_SDCC1_AHB_CLK>,
+		 <&xo_board>,
+		 <&gcc GCC_SDCC1_CDCCAL_FF_CLK>,
+		 <&gcc GCC_SDCC1_CDCCAL_SLEEP_CLK>;
+	clock-names = "core", "iface", "xo", "cal", "sleep";
 };
-- 
2.35.2

