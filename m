Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036035354C7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242698AbiEZUmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349041AbiEZUme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:42:34 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD17210E6
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:42:25 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g20so3144614edj.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xexrzx/Z2+41mJlgQJa+6IcDgOBEQTDb07VL3nibIDo=;
        b=JHhCapECCfHlCBe7dnsAx2XuFNgSDEABxduC/sRHRvTwCZbdnesm2WNTSDTe7DuCKE
         C7KCuAbP6mPoxC7ua/1B0RtCzSHPXBX9N1MUmAj5DXIzyVfuRbphF88IapZHG4HJN83L
         U96nuxWO9ua0FKJxS1H67oQav1Uib0fVHZ3275eHodU5oHrgOPVvPCLrxfzNFQhOp7/b
         FUmjbWyjzuj5pE9DHW0SgO27rM+YNIIQAAYzqGyfmviAwcBnrFbr+1rmSbdv5nPxZfpf
         /jN5LKys3z8Ge43o+hbdOo3eyQd+7Ibn116UNiOx4vm/4/gph73uakXplO9zolo/6UF4
         ubcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xexrzx/Z2+41mJlgQJa+6IcDgOBEQTDb07VL3nibIDo=;
        b=O12YUUr4lz3mSUhxmjugsYCNFWdOsH6KGb9lPdpJwxlK1uU7CWVuptbfGwL3sb175H
         fXHfDg1UTfM+nTmq4+GBs87xdwKnW5HXZRJFRRcVZgQxrEilAVPkJnHRL3t8TbljR6Q/
         pl8B+hZYlkHYZqg0ECLcUEvvlg2AUf3YTurGpv0w1cGXqYQhAQRwBMRFIRUKDzQeOgnZ
         mZ9vSjRTj01k0Gfx/HMEdR92WedwmmQIaWsK/0ToZ61/vf/47FDvvovmnPHCMMpMeFQn
         EkTxrBUDyIgfS1xHxkufdst5d7rwRPmQhhKSW+SrKSn4kwux/WwRQn35O4cxxPodbRaf
         WfRw==
X-Gm-Message-State: AOAM533oajW1BLaqxGZbU+qnwQWMvlLE2Xz60YjauqgjaJL8l3DMozZQ
        deW7HJYg1/WPJigB2xx5qd6OjQ==
X-Google-Smtp-Source: ABdhPJyIxK6IQef/XZ8gpZxTuo79xjWunylkaMWeKFo+JpDp1RKm3dK/AsYcM8hal7BYOj7ybERxjw==
X-Received: by 2002:a05:6402:84c:b0:428:4cc4:8212 with SMTP id b12-20020a056402084c00b004284cc48212mr42427200edz.171.1653597744008;
        Thu, 26 May 2022 13:42:24 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id r17-20020a50d691000000b0042617ba6389sm1239732edi.19.2022.05.26.13.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:42:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] arm64: dts: rockchip: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:42:16 +0200
Message-Id: <20220526204218.832029-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
 arch/arm64/boot/dts/rockchip/px30.dtsi                     | 2 +-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi                   | 6 +++---
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts                | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts        | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi      | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 56dfbb2e2fa6..214f94fea3dc 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -528,7 +528,7 @@ uart5: serial@ff178000 {
 	i2c0: i2c@ff180000 {
 		compatible = "rockchip,px30-i2c", "rockchip,rk3399-i2c";
 		reg = <0x0 0xff180000 0x0 0x1000>;
-		clocks =  <&cru SCLK_I2C0>, <&cru PCLK_I2C0>;
+		clocks = <&cru SCLK_I2C0>, <&cru PCLK_I2C0>;
 		clock-names = "i2c", "pclk";
 		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 		pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 4f0b5feaa5e6..a4c5aaf1f457 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -1084,7 +1084,7 @@ emmc_bus8: emmc-bus8 {
 
 		gmac {
 			rgmii_pins: rgmii-pins {
-				rockchip,pins =	<3 RK_PC6 1 &pcfg_pull_none>,
+				rockchip,pins = <3 RK_PC6 1 &pcfg_pull_none>,
 						<3 RK_PD0 1 &pcfg_pull_none>,
 						<3 RK_PC3 1 &pcfg_pull_none>,
 						<3 RK_PB0 1 &pcfg_pull_none_12ma>,
@@ -1102,7 +1102,7 @@ rgmii_pins: rgmii-pins {
 			};
 
 			rmii_pins: rmii-pins {
-				rockchip,pins =	<3 RK_PC6 1 &pcfg_pull_none>,
+				rockchip,pins = <3 RK_PC6 1 &pcfg_pull_none>,
 						<3 RK_PD0 1 &pcfg_pull_none>,
 						<3 RK_PC3 1 &pcfg_pull_none>,
 						<3 RK_PB0 1 &pcfg_pull_none_12ma>,
@@ -1257,7 +1257,7 @@ sdmmc_bus4: sdmmc-bus4 {
 
 		spdif {
 			spdif_tx: spdif-tx {
-				rockchip,pins =	<2 RK_PC7 1 &pcfg_pull_none>;
+				rockchip,pins = <2 RK_PC7 1 &pcfg_pull_none>;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
index 7b717ebec8ff..3d1e126b553f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
@@ -55,7 +55,7 @@ backlight: backlight {
 	};
 
 	edp_panel: edp-panel {
-		compatible ="lg,lp079qx1-sp0v";
+		compatible = "lg,lp079qx1-sp0v";
 		backlight = <&backlight>;
 		enable-gpios = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
 		power-supply = <&vcc3v3_s0>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
index 3ae5d727e367..04c752f49be9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
@@ -49,7 +49,7 @@ simple-audio-card,cpu {
 	sgtl5000_clk: sgtl5000-oscillator  {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-frequency  = <24576000>;
+			clock-frequency = <24576000>;
 	};
 
 	dc_12v: dc-12v {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts b/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
index f6b2199a42bd..13927e7d0724 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
@@ -88,7 +88,7 @@ backlight: backlight {
 	};
 
 	edp_panel: edp-panel {
-		compatible ="lg,lp079qx1-sp0v";
+		compatible = "lg,lp079qx1-sp0v";
 		backlight = <&backlight>;
 		enable-gpios = <&gpio4 RK_PC6 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
index 01d1a75c8b4d..935b8c68a71d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
@@ -347,7 +347,7 @@ hym8563_int: hym8563-int {
 
 	pcie {
 		pcie_pwr: pcie-pwr {
-			rockchip,pins =	<4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_up>;
+			rockchip,pins = <4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
 
-- 
2.34.1

