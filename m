Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752015ACEA7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 11:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbiIEJQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 05:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbiIEJQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 05:16:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7D93C175;
        Mon,  5 Sep 2022 02:16:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2654461192;
        Mon,  5 Sep 2022 09:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864D6C433D6;
        Mon,  5 Sep 2022 09:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662369380;
        bh=mSrbaGciGB3lq5EQyxvPqDDGd2vT1uxuRQ5lFDDPziY=;
        h=From:To:Cc:Subject:Date:From;
        b=IlW+VpylxcCrYsMgQ7z8b7B3isKSc1+l2SGurlQTfiNPkZJodDbxGLHtKTY1KzxcQ
         vbjOUstqxG8Z6YXwmFBWgmpCahRnjIVtpDuYCB+Ahys0uzCIk5Sn3lJOgG1qEb4xxC
         dP1J+gCxpZ51g4JkvAPunaW6/BiIJGn8Cg0pV1qObEwXRux+GL4gVQY3gRfEqk10p2
         GSZF/6q99JgC9VQ2uW6F6AzgottZftTfH8fRdQ7JV1p/z5SYPhLxoBc5RUMImO/HjP
         JsVGOzJ/Kc90LttoUYpIeCFy2jSbtN4JUaTfowOgbb3FhxEwyJJHLHOaESCxTaiAOp
         ZUBIpNGOs0/kg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oV8DO-0005Iw-CR; Mon, 05 Sep 2022 11:16:22 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] arm64: dts: qcom: fix syscon node names
Date:   Mon,  5 Sep 2022 11:16:02 +0200
Message-Id: <20220905091602.20364-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
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

Some recent changes that added new syscon nodes used misspelled node names.

Fixes: 86d7c9460e2c arm64: dts: qcom: sm8150: split TCSR halt regs out of mutex
Fixes: 0da603387225 arm64: dts: qcom: sdm630: split TCSR halt regs out of mutex
Fixes: 8a8531e69b2d arm64: dts: qcom: sdm845: split TCSR halt regs out of mutex
Fixes: d9a2214d6ba5 arm64: dts: qcom: sc7280: split TCSR halt regs out of mutex
Fixes: ce1ac53c7faa arm64: dts: qcom: sc7180: split TCSR halt regs out of mutex
Fixes: fc10cfa38580 arm64: dts: qcom: msm8998: split TCSR halt regs out of mutex
Fixes: 100ce2205924 arm64: dts: qcom: msm8996: split TCSR halt regs out of mutex
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/sdm630.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi  | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 9fa524079c1b..a67b181a6135 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -833,7 +833,7 @@ tcsr_mutex: hwlock@740000 {
 			#hwlock-cells = <1>;
 		};
 
-		tcsr_1: sycon@760000 {
+		tcsr_1: syscon@760000 {
 			compatible = "qcom,tcsr-msm8996", "syscon";
 			reg = <0x00760000 0x20000>;
 		};
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index d463a66715ea..1118134ff01e 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1047,7 +1047,7 @@ tcsr_mutex: hwlock@1f40000 {
 			#hwlock-cells = <1>;
 		};
 
-		tcsr_regs_1: sycon@1f60000 {
+		tcsr_regs_1: syscon@1f60000 {
 			compatible = "qcom,msm8998-tcsr", "syscon";
 			reg = <0x01f60000 0x20000>;
 		};
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index e8debb0da411..58976a1ba06b 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1462,7 +1462,7 @@ tcsr_mutex: hwlock@1f40000 {
 			#hwlock-cells = <1>;
 		};
 
-		tcsr_regs_1: sycon@1f60000 {
+		tcsr_regs_1: syscon@1f60000 {
 			compatible = "qcom,sc7180-tcsr", "syscon";
 			reg = <0 0x01f60000 0 0x20000>;
 		};
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 50c3d79abcc3..50bbc069c218 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2160,7 +2160,7 @@ tcsr_mutex: hwlock@1f40000 {
 			#hwlock-cells = <1>;
 		};
 
-		tcsr_1: sycon@1f60000 {
+		tcsr_1: syscon@1f60000 {
 			compatible = "qcom,sc7280-tcsr", "syscon";
 			reg = <0 0x01f60000 0 0x20000>;
 		};
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 9ae6610af93a..b51b85f583e5 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -703,7 +703,7 @@ tcsr_mutex: hwlock@1f40000 {
 			#hwlock-cells = <1>;
 		};
 
-		tcsr_regs_1: sycon@1f60000 {
+		tcsr_regs_1: syscon@1f60000 {
 			compatible = "qcom,sdm630-tcsr", "syscon";
 			reg = <0x01f60000 0x20000>;
 		};
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 347c3abc117b..d761da47220d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2625,7 +2625,7 @@ tcsr_mutex: hwlock@1f40000 {
 			#hwlock-cells = <1>;
 		};
 
-		tcsr_regs_1: sycon@1f60000 {
+		tcsr_regs_1: syscon@1f60000 {
 			compatible = "qcom,sdm845-tcsr", "syscon";
 			reg = <0 0x01f60000 0 0x20000>;
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 008f2e8c171c..cef8c4f4f0ff 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -2054,7 +2054,7 @@ tcsr_mutex: hwlock@1f40000 {
 			#hwlock-cells = <1>;
 		};
 
-		tcsr_regs_1: sycon@1f60000 {
+		tcsr_regs_1: syscon@1f60000 {
 			compatible = "qcom,sm8150-tcsr", "syscon";
 			reg = <0x0 0x01f60000 0x0 0x20000>;
 		};
-- 
2.35.1

