Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBC1535487
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245656AbiEZUgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242070AbiEZUgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:36:52 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893A712091
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:36:50 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t26so3185344edt.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=//MRnXNtSeLfQ5bWtX3v1G4dcnE5lQDmM/+h837nasQ=;
        b=WXRFeFKzDOkC71nxNRIQXgIyMNK8hNrAszVEILj5pQ9eP8XexBdh7hYcu6D95VAgk0
         YLCG/VOiQUEEUYjjCx7DV51+E2yG8ouHfOkcsRKwTsIQFrnpyWt0vxj1yxFEcWBnx1Pn
         UUkqfKaGckf1q8PjCQ+WelSOEYjXVKlYVVPfqcFjqaUXy4zeWACL9VnMrwZS9LXHEwQ9
         UXkipkCSWyTK/qQWMsXDpkJOcGnWMh1YZcxrLgincIR7gzy7rRJhCN41Hw7GqszuQuYL
         46h8UZdBa23f4eZNWsPb8ITwPw0WYpwgpxcv1vQahZsqqYl2JuhdABsohrmVQWR7vaj9
         fZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=//MRnXNtSeLfQ5bWtX3v1G4dcnE5lQDmM/+h837nasQ=;
        b=5b27vLR/BkuKUtfbGP8cCR3oai3Dwj+d1tvpfD+Yww5FOmisdVPpidSyDCdONmqQcw
         WxdCOhopwoNBq9+ozIYBOsr9uXUMyJdGIceZlGniQLy0sYtaljblf5rqFeuLvxU7R+tg
         kiMTCjo/Saa3+wK6fSAZJUJbRoY6ZhEQNKSZrgkz5Xx2wV6vn3lxHAZM/j5A6kYwyFp1
         78gKLSGZ3+HUY/cspZfiq9Yxah5DqWkkwO77qlYN6F/Gv2yMMmbSNQo2m4bJ005R+IVY
         pkVL6fXo4LnUkxVFa6FL4GRhI+dJxSnlwrb/1kVglofdgD1los9rzto5ugKgJDxs4RSd
         PPmQ==
X-Gm-Message-State: AOAM530E9+RgP5OI/PwNvkkrDHUoQ2X4ptbLbm81TCrG4HgEYX5fhA5A
        A2Y1ZqaUfgC7DmzcnqgYXt8dNA==
X-Google-Smtp-Source: ABdhPJxFj38q8x1olmylRRI/if3+8v0VRPgSaKL24LzFdG1RJYtYbE3AN/UWzXPXbVCCko3K67Ok6Q==
X-Received: by 2002:a05:6402:50d2:b0:42b:2bf0:4dbe with SMTP id h18-20020a05640250d200b0042b2bf04dbemr34617129edb.309.1653597409093;
        Thu, 26 May 2022 13:36:49 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u28-20020a50c05c000000b0042ac43be19dsm1211304edd.3.2022.05.26.13.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:36:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: dts: sti: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:36:31 +0200
Message-Id: <20220526203632.831039-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix whitespace coding style: use single space instead of tabs or
multiple spaces around '=' sign in property assignment.  No functional
changes (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Output compared with dtx_diff and fdtdump.
---
 arch/arm/boot/dts/stih407-family.dtsi | 174 +++++++++++++-------------
 arch/arm/boot/dts/stih407.dtsi        |   4 +-
 arch/arm/boot/dts/stih410.dtsi        |   4 +-
 arch/arm/boot/dts/stihxxx-b2120.dtsi  |   8 +-
 4 files changed, 95 insertions(+), 95 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 1713f7878117..33cf54cb46cc 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -137,8 +137,8 @@ picophyreset: picophyreset-controller {
 	};
 
 	irq-syscfg {
-		compatible    = "st,stih407-irq-syscfg";
-		st,syscfg     = <&syscfg_core>;
+		compatible = "st,stih407-irq-syscfg";
+		st,syscfg = <&syscfg_core>;
 		st,irq-device = <ST_IRQ_SYSCFG_PMU_0>,
 				<ST_IRQ_SYSCFG_PMU_1>;
 		st,fiq-device = <ST_IRQ_SYSCFG_DISABLED>,
@@ -157,8 +157,8 @@ usb2_picophy0: phy1 {
 	miphy28lp_phy: miphy28lp {
 		compatible = "st,miphy28lp-phy";
 		st,syscfg = <&syscfg_core>;
-		#address-cells	= <1>;
-		#size-cells	= <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
 		ranges;
 
 		phy_port0: port@9b22000 {
@@ -208,26 +208,26 @@ phy_port2: port@8f95000 {
 	};
 
 	st231_gp0: st231-gp0 {
-		compatible	= "st,st231-rproc";
-		memory-region	= <&gp0_reserved>;
-		resets		= <&softreset STIH407_ST231_GP0_SOFTRESET>;
-		reset-names	= "sw_reset";
-		clocks		= <&clk_s_c0_flexgen CLK_ST231_GP_0>;
-		clock-frequency	= <600000000>;
-		st,syscfg	= <&syscfg_core 0x22c>;
+		compatible = "st,st231-rproc";
+		memory-region = <&gp0_reserved>;
+		resets = <&softreset STIH407_ST231_GP0_SOFTRESET>;
+		reset-names = "sw_reset";
+		clocks = <&clk_s_c0_flexgen CLK_ST231_GP_0>;
+		clock-frequency = <600000000>;
+		st,syscfg = <&syscfg_core 0x22c>;
 		#mbox-cells = <1>;
 		mbox-names = "vq0_rx", "vq0_tx", "vq1_rx", "vq1_tx";
 		mboxes = <&mailbox0 0 2>, <&mailbox2 0 1>, <&mailbox0 0 3>, <&mailbox2 0 0>;
 	};
 
 	st231_delta: st231-delta {
-		compatible	= "st,st231-rproc";
-		memory-region	= <&delta_reserved>;
-		resets		= <&softreset STIH407_ST231_DMU_SOFTRESET>;
-		reset-names	= "sw_reset";
-		clocks		= <&clk_s_c0_flexgen CLK_ST231_DMU>;
-		clock-frequency	= <600000000>;
-		st,syscfg	= <&syscfg_core 0x224>;
+		compatible = "st,st231-rproc";
+		memory-region = <&delta_reserved>;
+		resets = <&softreset STIH407_ST231_DMU_SOFTRESET>;
+		reset-names = "sw_reset";
+		clocks = <&clk_s_c0_flexgen CLK_ST231_DMU>;
+		clock-frequency = <600000000>;
+		st,syscfg = <&syscfg_core 0x224>;
 		#mbox-cells = <1>;
 		mbox-names = "vq0_rx", "vq0_tx", "vq1_rx", "vq1_tx";
 		mboxes = <&mailbox0 0 0>, <&mailbox3 0 1>, <&mailbox0 0 1>, <&mailbox3 0 0>;
@@ -710,78 +710,78 @@ sata1: sata@9b28000 {
 
 
 		st_dwc3: dwc3@8f94000 {
-			compatible	= "st,stih407-dwc3";
-			reg		= <0x08f94000 0x1000>, <0x110 0x4>;
-			reg-names	= "reg-glue", "syscfg-reg";
-			st,syscfg	= <&syscfg_core>;
-			resets		= <&powerdown STIH407_USB3_POWERDOWN>,
-					  <&softreset STIH407_MIPHY2_SOFTRESET>;
-			reset-names	= "powerdown", "softreset";
-			#address-cells	= <1>;
-			#size-cells	= <1>;
-			pinctrl-names	= "default";
-			pinctrl-0	= <&pinctrl_usb3>;
+			compatible = "st,stih407-dwc3";
+			reg = <0x08f94000 0x1000>, <0x110 0x4>;
+			reg-names = "reg-glue", "syscfg-reg";
+			st,syscfg = <&syscfg_core>;
+			resets = <&powerdown STIH407_USB3_POWERDOWN>,
+				 <&softreset STIH407_MIPHY2_SOFTRESET>;
+			reset-names = "powerdown", "softreset";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usb3>;
 			ranges;
 
 			status = "disabled";
 
 			dwc3: dwc3@9900000 {
-				compatible	= "snps,dwc3";
-				reg		= <0x09900000 0x100000>;
-				interrupts	= <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
-				dr_mode		= "host";
-				phy-names	= "usb2-phy", "usb3-phy";
-				phys		= <&usb2_picophy0>,
-						  <&phy_port2 PHY_TYPE_USB3>;
+				compatible = "snps,dwc3";
+				reg = <0x09900000 0x100000>;
+				interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+				dr_mode = "host";
+				phy-names = "usb2-phy", "usb3-phy";
+				phys = <&usb2_picophy0>,
+				       <&phy_port2 PHY_TYPE_USB3>;
 				snps,dis_u3_susphy_quirk;
 			};
 		};
 
 		/* COMMS PWM Module */
 		pwm0: pwm@9810000 {
-			compatible	= "st,sti-pwm";
-			#pwm-cells	= <2>;
-			reg		= <0x9810000 0x68>;
-			interrupts      = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
-			pinctrl-names	= "default";
-			pinctrl-0	= <&pinctrl_pwm0_chan0_default>;
-			clock-names	= "pwm";
-			clocks		= <&clk_sysin>;
+			compatible = "st,sti-pwm";
+			#pwm-cells = <2>;
+			reg = <0x9810000 0x68>;
+			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_pwm0_chan0_default>;
+			clock-names = "pwm";
+			clocks = <&clk_sysin>;
 			st,pwm-num-chan = <1>;
 
-			status		= "disabled";
+			status = "disabled";
 		};
 
 		/* SBC PWM Module */
 		pwm1: pwm@9510000 {
-			compatible	= "st,sti-pwm";
-			#pwm-cells	= <2>;
-			reg		= <0x9510000 0x68>;
-			interrupts      = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
-			pinctrl-names	= "default";
-			pinctrl-0	= <&pinctrl_pwm1_chan0_default
-					&pinctrl_pwm1_chan1_default
-					&pinctrl_pwm1_chan2_default
-					&pinctrl_pwm1_chan3_default>;
-			clock-names	= "pwm";
-			clocks		= <&clk_sysin>;
+			compatible = "st,sti-pwm";
+			#pwm-cells = <2>;
+			reg = <0x9510000 0x68>;
+			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_pwm1_chan0_default
+				     &pinctrl_pwm1_chan1_default
+				     &pinctrl_pwm1_chan2_default
+				     &pinctrl_pwm1_chan3_default>;
+			clock-names = "pwm";
+			clocks = <&clk_sysin>;
 			st,pwm-num-chan = <4>;
 
-			status		= "disabled";
+			status = "disabled";
 		};
 
 		rng10: rng@8a89000 {
-			compatible      = "st,rng";
-			reg		= <0x08a89000 0x1000>;
-			clocks          = <&clk_sysin>;
-			status		= "okay";
+			compatible = "st,rng";
+			reg = <0x08a89000 0x1000>;
+			clocks = <&clk_sysin>;
+			status = "okay";
 		};
 
 		rng11: rng@8a8a000 {
-			compatible      = "st,rng";
-			reg		= <0x08a8a000 0x1000>;
-			clocks          = <&clk_sysin>;
-			status		= "okay";
+			compatible = "st,rng";
+			reg = <0x08a8a000 0x1000>;
+			clocks = <&clk_sysin>;
+			status = "okay";
 		};
 
 		ethernet0: dwmac@9630000 {
@@ -812,36 +812,36 @@ ethernet0: dwmac@9630000 {
 		};
 
 		mailbox0: mailbox@8f00000  {
-			compatible	= "st,stih407-mailbox";
-			reg		= <0x8f00000 0x1000>;
-			interrupts	= <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
-			#mbox-cells	= <2>;
-			mbox-name	= "a9";
-			status		= "okay";
+			compatible = "st,stih407-mailbox";
+			reg = <0x8f00000 0x1000>;
+			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+			mbox-name = "a9";
+			status = "okay";
 		};
 
 		mailbox1: mailbox@8f01000 {
-			compatible	= "st,stih407-mailbox";
-			reg		= <0x8f01000 0x1000>;
-			#mbox-cells	= <2>;
-			mbox-name	= "st231_gp_1";
-			status		= "okay";
+			compatible = "st,stih407-mailbox";
+			reg = <0x8f01000 0x1000>;
+			#mbox-cells = <2>;
+			mbox-name = "st231_gp_1";
+			status = "okay";
 		};
 
 		mailbox2: mailbox@8f02000 {
-			compatible	= "st,stih407-mailbox";
-			reg		= <0x8f02000 0x1000>;
-			#mbox-cells	= <2>;
-			mbox-name	= "st231_gp_0";
-			status		= "okay";
+			compatible = "st,stih407-mailbox";
+			reg = <0x8f02000 0x1000>;
+			#mbox-cells = <2>;
+			mbox-name = "st231_gp_0";
+			status = "okay";
 		};
 
 		mailbox3: mailbox@8f03000 {
-			compatible	= "st,stih407-mailbox";
-			reg		= <0x8f03000 0x1000>;
-			#mbox-cells	= <2>;
-			mbox-name	= "st231_audio_video";
-			status		= "okay";
+			compatible = "st,stih407-mailbox";
+			reg = <0x8f03000 0x1000>;
+			#mbox-cells = <2>;
+			mbox-name = "st231_audio_video";
+			status = "okay";
 		};
 
 		/* fdma audio */
@@ -913,7 +913,7 @@ sti_uni_player0: sti-uni-player@8d80000 {
 			dmas = <&fdma0 2 0 1>;
 			dma-names = "tx";
 
-			status		= "disabled";
+			status = "disabled";
 		};
 
 		sti_uni_player1: sti-uni-player@8d81000 {
diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
index 9e212b0af89d..aca43d2bdaad 100644
--- a/arch/arm/boot/dts/stih407.dtsi
+++ b/arch/arm/boot/dts/stih407.dtsi
@@ -13,7 +13,7 @@ sti-display-subsystem@0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			reg = <0 0>;
-			assigned-clocks	= <&clk_s_d2_quadfs 0>,
+			assigned-clocks = <&clk_s_d2_quadfs 0>,
 					  <&clk_s_d2_quadfs 1>,
 					  <&clk_s_c0_pll1 0>,
 					  <&clk_s_c0_flexgen CLK_COMPO_DVP>,
@@ -106,7 +106,7 @@ sti_hdmi: sti-hdmi@8d04000 {
 				reg-names = "hdmi-reg";
 				#sound-dai-cells = <0>;
 				interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names	= "irq";
+				interrupt-names = "irq";
 				clock-names = "pix",
 					      "tmds",
 					      "phy",
diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
index ce2f62cf129b..a39dd5f7bcae 100644
--- a/arch/arm/boot/dts/stih410.dtsi
+++ b/arch/arm/boot/dts/stih410.dtsi
@@ -105,7 +105,7 @@ sti-display-subsystem@0 {
 			#size-cells = <1>;
 
 			reg = <0 0>;
-			assigned-clocks	= <&clk_s_d2_quadfs 0>,
+			assigned-clocks = <&clk_s_d2_quadfs 0>,
 					  <&clk_s_d2_quadfs 1>,
 					  <&clk_s_c0_pll1 0>,
 					  <&clk_s_c0_flexgen CLK_COMPO_DVP>,
@@ -198,7 +198,7 @@ sti_hdmi: sti-hdmi@8d04000 {
 				reg-names = "hdmi-reg";
 				#sound-dai-cells = <0>;
 				interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names	= "irq";
+				interrupt-names = "irq";
 				clock-names = "pix",
 					      "tmds",
 					      "phy",
diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
index 4c72dedcd1be..2aa94605d3d4 100644
--- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
@@ -175,11 +175,11 @@ demux@8a20000 {
 
 			/* tsin0 is TSA on NIMA */
 			tsin0: port {
-				tsin-num	= <0>;
+				tsin-num = <0>;
 				serial-not-parallel;
-				i2c-bus		= <&ssc2>;
-				reset-gpios	= <&pio15 4 GPIO_ACTIVE_HIGH>;
-				dvb-card	= <STV0367_TDA18212_NIMA_1>;
+				i2c-bus = <&ssc2>;
+				reset-gpios = <&pio15 4 GPIO_ACTIVE_HIGH>;
+				dvb-card = <STV0367_TDA18212_NIMA_1>;
 			};
 		};
 
-- 
2.34.1

