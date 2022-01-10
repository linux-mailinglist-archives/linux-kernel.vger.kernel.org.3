Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BD3489712
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244581AbiAJLLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244448AbiAJLKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:10:45 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A75C061759;
        Mon, 10 Jan 2022 03:10:45 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c66so8449450wma.5;
        Mon, 10 Jan 2022 03:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MQX3WExGOS3qStO9Hx8ccBSuVV1T9JyvQiyN4+V/nRc=;
        b=W9sfgjT024kLxdeX84tFdQSxjPk8+2wKADvt93f8M0RqdhtLksuA3brFAQYwlyPyjm
         5Lum1FR1HifCQEXnI1CFvFtVXHZlUfhtB5ziCMEn2sKxSa7qnKTxWaLMCAi0sou8c2wz
         dCcldt5+aYH2+ElT1betL3k31QGzTBKAMWL1wxFXNotmTsdzII+iywBwGNfdf8JEvIYy
         58bSe2UpawrkRFwN61IIz/B3eDmKWeLvEH1Gv9HNQg2tYQ031YTIKUCeRrs2eHYxpZcW
         +kkTYI18H9lx++DSAPFIPsYwn/d0vs1H98MPQGsbpN7TkSBnDdWJ2s811DQrpRXspM3e
         sutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MQX3WExGOS3qStO9Hx8ccBSuVV1T9JyvQiyN4+V/nRc=;
        b=jvZmp/e5Xb5xqgGriUTbAIPKz5HmfQXUtNl7RNlF8bDO/pAocwdpWx8wZYdSTZ6Pny
         C7zdXDrk0d3Q5KuJ4Z2iO/7qEJBIBGJoLVYrfeesUUNJqecs81PWhFqAapk4+2rWjawt
         Zn6hQrKB3vss0nibcMbcoRF7Mbz/Nv/QQ/5GaBK5o8h2YjzVvxeTVVv4SlX9CT3P+i+B
         4uEFE9BhrBeVtVNusvDdQGrelIAWP/pHxFB9PteefsmcxF+x/5xnWBEQGX8xKc8cMlLW
         8+EanpVeDjqlnaL1+HTKeSmuFkId/1BelA5C+KfUkha3hyZ90P4RkheHOASFfgMFbpe1
         0blA==
X-Gm-Message-State: AOAM530st4ADuK0Vz7ygvCTbsrHvBgAla3Y2txPvthHEWKaSKVybt6gG
        kp8gARBr245ViC7xLDdaQvOMcu68Tq2pPA==
X-Google-Smtp-Source: ABdhPJxWz6lmk65Y41f1HFC0x4Qxetqmb34AlsY3PYRbrECeKWXtiFsuOHwYK2hXaEx33/pFbHeMDw==
X-Received: by 2002:a05:600c:a0a:: with SMTP id z10mr21501618wmp.126.1641813043350;
        Mon, 10 Jan 2022 03:10:43 -0800 (PST)
Received: from localhost.localdomain (198.red-81-44-130.dynamicip.rima-tde.net. [81.44.130.198])
        by smtp.gmail.com with ESMTPSA id x8sm6256733wmj.44.2022.01.10.03.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 03:10:42 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     john@phrozen.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, neil@brown.name,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        sboyd@kernel.org
Subject: [PATCH v7 4/4] staging: mt7621-dts: align resets with binding documentation
Date:   Mon, 10 Jan 2022 12:10:36 +0100
Message-Id: <20220110111036.1380288-5-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220110111036.1380288-1-sergio.paracuellos@gmail.com>
References: <20220110111036.1380288-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binding documentation for compatible 'mediatek,mt7621-sysc' has been updated
to be used as a reset provider. Align reset related bits and system controller
node with binding documentation along the dtsi file.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/staging/mt7621-dts/mt7621.dtsi | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/mt7621-dts/mt7621.dtsi b/drivers/staging/mt7621-dts/mt7621.dtsi
index 644a65d1a6a1..d72673c91dc2 100644
--- a/drivers/staging/mt7621-dts/mt7621.dtsi
+++ b/drivers/staging/mt7621-dts/mt7621.dtsi
@@ -2,6 +2,7 @@
 #include <dt-bindings/interrupt-controller/mips-gic.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/mt7621-clk.h>
+#include <dt-bindings/reset/mt7621-reset.h>
 
 / {
 	#address-cells = <1>;
@@ -67,6 +68,7 @@ sysc: syscon@0 {
 			compatible = "mediatek,mt7621-sysc", "syscon";
 			reg = <0x0 0x100>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 			ralink,memctl = <&memc>;
 			clock-output-names = "xtal", "cpu", "bus",
 					     "50m", "125m", "150m",
@@ -96,7 +98,7 @@ i2c: i2c@900 {
 
 			clocks = <&sysc MT7621_CLK_I2C>;
 			clock-names = "i2c";
-			resets = <&rstctrl 16>;
+			resets = <&sysc MT7621_RST_I2C>;
 			reset-names = "i2c";
 
 			#address-cells = <1>;
@@ -137,7 +139,7 @@ spi0: spi@b00 {
 			clocks = <&sysc MT7621_CLK_SPI>;
 			clock-names = "spi";
 
-			resets = <&rstctrl 18>;
+			resets = <&sysc MT7621_RST_SPI>;
 			reset-names = "spi";
 
 			#address-cells = <1>;
@@ -234,11 +236,6 @@ pinmux {
 		};
 	};
 
-	rstctrl: rstctrl {
-		compatible = "ralink,rt2880-reset";
-		#reset-cells = <1>;
-	};
-
 	sdhci: sdhci@1e130000 {
 		status = "disabled";
 
@@ -317,7 +314,7 @@ ethernet: ethernet@1e100000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		resets = <&rstctrl 6 &rstctrl 23>;
+		resets = <&sysc MT7621_RST_FE &sysc MT7621_RST_ETH>;
 		reset-names = "fe", "eth";
 
 		interrupt-parent = <&gic>;
@@ -362,7 +359,7 @@ switch0: switch0@0 {
 				#size-cells = <0>;
 				reg = <0>;
 				mediatek,mcm;
-				resets = <&rstctrl 2>;
+				resets = <&sysc MT7621_RST_MCM>;
 				reset-names = "mcm";
 				interrupt-controller;
 				#interrupt-cells = <1>;
@@ -448,7 +445,7 @@ pcie@0,0 {
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0>;
 			interrupt-map = <0 0 0 0 &gic GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH>;
-			resets = <&rstctrl 24>;
+			resets = <&sysc MT7621_RST_PCIE0>;
 			clocks = <&sysc MT7621_CLK_PCIE0>;
 			phys = <&pcie0_phy 1>;
 			phy-names = "pcie-phy0";
@@ -463,7 +460,7 @@ pcie@1,0 {
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0>;
 			interrupt-map = <0 0 0 0 &gic GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>;
-			resets = <&rstctrl 25>;
+			resets = <&sysc MT7621_RST_PCIE1>;
 			clocks = <&sysc MT7621_CLK_PCIE1>;
 			phys = <&pcie0_phy 1>;
 			phy-names = "pcie-phy1";
@@ -478,7 +475,7 @@ pcie@2,0 {
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0>;
 			interrupt-map = <0 0 0 0 &gic GIC_SHARED 25 IRQ_TYPE_LEVEL_HIGH>;
-			resets = <&rstctrl 26>;
+			resets = <&sysc MT7621_RST_PCIE2>;
 			clocks = <&sysc MT7621_CLK_PCIE2>;
 			phys = <&pcie2_phy 0>;
 			phy-names = "pcie-phy2";
-- 
2.25.1

