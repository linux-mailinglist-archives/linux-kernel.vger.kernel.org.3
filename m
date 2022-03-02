Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299984C9A75
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 02:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbiCBBef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 20:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbiCBBed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 20:34:33 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAE553B55;
        Tue,  1 Mar 2022 17:33:51 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id g6-20020a9d6486000000b005acf9a0b644so349052otl.12;
        Tue, 01 Mar 2022 17:33:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=88xxT5vkW1FD5Lw+DjeY3rRe+OzWsSvDd95LTbfCqfw=;
        b=GjkUATrPtGUZpS4Udxx35n4OZ1hV9rIMyYEycNTYpFPxMVOfFTi2eGWqJ5t60816+V
         IzsVO+tjwx6GUSz4n2LPNt8JPF3kY+R6LO/vZke+m2RrUBb+p7VtKZY6Gw9Bybc5r6Zt
         gdodx98ffw0ffbxKiUqLJvHU8IzSdsPTb1fvn7ywJ6qcpDZBsanBqRXpkIW/A+5hfOLt
         MAfWqVVBRAc8Xx0lHSuxBKZ74Lb/cY6aqQsITrohe/df5X9HesW7L54tYFc3p3Vk11zj
         ON/8+bKRQWhUa4f0fcrMRBIMV6nQn2M+cwdyxQtoHXjSGF0XrpFG3fZ/huFKh2oC4IGX
         0PRw==
X-Gm-Message-State: AOAM533rh9Wr3D1v0iftYq0oWXZT9hc6wM4A/M1fHhTWVIMm2xTxHGeo
        SWiVza3t0+LDGWzJr6l9JlUysfT3IA==
X-Google-Smtp-Source: ABdhPJxASzbqazLlVVSxOPjbvb6XUCjCoxGN0p8dOSbmV+NwTcHACaJNkJhLJK3Hut69Fx1CHhKRIQ==
X-Received: by 2002:a05:6830:1b6f:b0:5af:d2f:eed9 with SMTP id d15-20020a0568301b6f00b005af0d2feed9mr14324518ote.331.1646184830209;
        Tue, 01 Mar 2022 17:33:50 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id hq12-20020a0568709b0c00b000d3d5d4def7sm6627504oab.29.2022.03.01.17.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 17:33:49 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64/arm: dts: qcom: Drop bogus interrupt flags cell on MDSS nodes
Date:   Tue,  1 Mar 2022 19:33:39 -0600
Message-Id: <20220302013339.2354076-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MDSS interrupt provider is a single cell, so specifying interrupt flags
on the consumers is incorrect.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Add a bunch of missed cases
---
 arch/arm/boot/dts/qcom-msm8974.dtsi   | 4 ++--
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 6 +++---
 arch/arm64/boot/dts/qcom/sdm630.dtsi  | 5 ++---
 arch/arm64/boot/dts/qcom/sdm660.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi  | 6 +++---
 arch/arm64/boot/dts/qcom/sm8250.dtsi  | 6 +++---
 6 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 412d94736c35..3b9af5e24907 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -1495,7 +1495,7 @@ mdp: mdp@fd900000 {
 				reg-names = "mdp_phys";
 
 				interrupt-parent = <&mdss>;
-				interrupts = <0 0>;
+				interrupts = <0>;
 
 				clocks = <&mmcc MDSS_AHB_CLK>,
 					 <&mmcc MDSS_AXI_CLK>,
@@ -1530,7 +1530,7 @@ dsi0: dsi@fd922800 {
 				reg-names = "dsi_ctrl";
 
 				interrupt-parent = <&mdss>;
-				interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <4>;
 
 				assigned-clocks = <&mmcc BYTE0_CLK_SRC>,
 				                  <&mmcc PCLK0_CLK_SRC>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index f0f81c23c16f..0597d865a4a6 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -788,7 +788,7 @@ mdp: mdp@901000 {
 				reg-names = "mdp_phys";
 
 				interrupt-parent = <&mdss>;
-				interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <0>;
 
 				clocks = <&mmcc MDSS_AHB_CLK>,
 					 <&mmcc MDSS_AXI_CLK>,
@@ -834,7 +834,7 @@ dsi0: dsi@994000 {
 				reg-names = "dsi_ctrl";
 
 				interrupt-parent = <&mdss>;
-				interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <4>;
 
 				clocks = <&mmcc MDSS_MDP_CLK>,
 					 <&mmcc MDSS_BYTE0_CLK>,
@@ -904,7 +904,7 @@ hdmi: hdmi-tx@9a0000 {
 					    "hdcp_physical";
 
 				interrupt-parent = <&mdss>;
-				interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <8>;
 
 				clocks = <&mmcc MDSS_MDP_CLK>,
 					 <&mmcc MDSS_AHB_CLK>,
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 240293592ef9..f646fb80924f 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1453,7 +1453,7 @@ mdp: mdp@c901000 {
 				reg-names = "mdp_phys";
 
 				interrupt-parent = <&mdss>;
-				interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <0>;
 
 				assigned-clocks = <&mmcc MDSS_MDP_CLK>,
 						  <&mmcc MDSS_VSYNC_CLK>;
@@ -1530,7 +1530,7 @@ dsi0: dsi@c994000 {
 				power-domains = <&rpmpd SDM660_VDDCX>;
 
 				interrupt-parent = <&mdss>;
-				interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <4>;
 
 				assigned-clocks = <&mmcc BYTE0_CLK_SRC>,
 						  <&mmcc PCLK0_CLK_SRC>;
@@ -2487,4 +2487,3 @@ timer {
 				 <GIC_PPI 0 0xf08>;
 	};
 };
-
diff --git a/arch/arm64/boot/dts/qcom/sdm660.dtsi b/arch/arm64/boot/dts/qcom/sdm660.dtsi
index eccf6fde16b4..1d748c5305f4 100644
--- a/arch/arm64/boot/dts/qcom/sdm660.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm660.dtsi
@@ -163,7 +163,7 @@ dsi1: dsi@c996000 {
 		power-domains = <&rpmpd SDM660_VDDCX>;
 
 		interrupt-parent = <&mdss>;
-		interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <5>;
 
 		assigned-clocks = <&mmcc BYTE1_CLK_SRC>,
 					<&mmcc PCLK1_CLK_SRC>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 41f4e46e1f85..95e6a97c2170 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4281,7 +4281,7 @@ mdss_mdp: mdp@ae01000 {
 				power-domains = <&rpmhpd SDM845_CX>;
 
 				interrupt-parent = <&mdss>;
-				interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <0>;
 
 				ports {
 					#address-cells = <1>;
@@ -4333,7 +4333,7 @@ dsi0: dsi@ae94000 {
 				reg-names = "dsi_ctrl";
 
 				interrupt-parent = <&mdss>;
-				interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <4>;
 
 				clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK>,
 					 <&dispcc DISP_CC_MDSS_BYTE0_INTF_CLK>,
@@ -4405,7 +4405,7 @@ dsi1: dsi@ae96000 {
 				reg-names = "dsi_ctrl";
 
 				interrupt-parent = <&mdss>;
-				interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <5>;
 
 				clocks = <&dispcc DISP_CC_MDSS_BYTE1_CLK>,
 					 <&dispcc DISP_CC_MDSS_BYTE1_INTF_CLK>,
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index fdaf303ba047..956848068871 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -3200,7 +3200,7 @@ mdss_mdp: mdp@ae01000 {
 				power-domains = <&rpmhpd SM8250_MMCX>;
 
 				interrupt-parent = <&mdss>;
-				interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <0>;
 
 				ports {
 					#address-cells = <1>;
@@ -3252,7 +3252,7 @@ dsi0: dsi@ae94000 {
 				reg-names = "dsi_ctrl";
 
 				interrupt-parent = <&mdss>;
-				interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <4>;
 
 				clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK>,
 					 <&dispcc DISP_CC_MDSS_BYTE0_INTF_CLK>,
@@ -3325,7 +3325,7 @@ dsi1: dsi@ae96000 {
 				reg-names = "dsi_ctrl";
 
 				interrupt-parent = <&mdss>;
-				interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <5>;
 
 				clocks = <&dispcc DISP_CC_MDSS_BYTE1_CLK>,
 					 <&dispcc DISP_CC_MDSS_BYTE1_INTF_CLK>,
-- 
2.32.0

