Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8BF474F84
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbhLOAs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238648AbhLOAqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:46:51 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C28C061574;
        Tue, 14 Dec 2021 16:46:50 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id e128so27356817iof.1;
        Tue, 14 Dec 2021 16:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0lrmLuZmbeWpcJjHLH2OoVtrLVKHq3sYzN1knYQa9CU=;
        b=AA5g89cXf4V+9gKDdbTTrlCEcOQIpbVtyZGaea9I5jSOHCaWNYqePdbTlAQ3f07qGJ
         BBXmTw8dP4VTnuJ8+YpyVbQ3keTctDQoe3jxmoqCiGTGTS2O9AsyqmyNV6P6u+fFhQMu
         iQj8tnxIyebrITHLKNfZtrboJYz7AY3N2YBzb8oXzPB2j0S3pG4U1U+pJBwf04rUO/HK
         zMJAvjgzOX31BTEhAO2M5QB6oiwxXaQKxPh4bx2oamomOKK89ZpBA6XOLYbThoy9atic
         uL6o8YmT5mvtRaguHcI2pLpGatwfUpdYSKH8WWOOFaBGPdgTzm35xFvTtMBphxKVWKPO
         CpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0lrmLuZmbeWpcJjHLH2OoVtrLVKHq3sYzN1knYQa9CU=;
        b=DuAI/6vM5oiI4k1qc23w1O3ApqCHm9/hGYWhXG9CqUBaieMQF8Ssr1OhIjf24P3GR9
         Uq/Vy/RXsq/kcpovSiMwj9uXOhijU9nDLlGkyMLg3tetu2Q8xkhZK929vGOkLz8oB83l
         c+f6p39WBPefVK/dQeycFJ0giftrxJzRPwPYbiulVCzsdrc41SI0Apye/Hx5XkShWBBC
         oVPeOca4fn5usAoe1JqWOgxcjUrjwpsjlm5N8eGejEIUB/n09dZTyxaAwknGTHBAJ9dC
         j0xIXWg2VWSw73uaLTy8ZVqfuu9t+LHY24VlaVkcLSVOOC1WH4IMQXiHFhfa17V4ilVf
         xpaA==
X-Gm-Message-State: AOAM531v7Ee5T93QKccEclB1EAPeM7e/PU3pMj0SEZMlPARg1Ba1+o6O
        8tNTHlg5kCzHs5CooeEpJ5Q=
X-Google-Smtp-Source: ABdhPJyz3I1lSY/GENeRqJbtGQ204PO6YAcI9ovd2EKIT90mEXR27YKMW53IP3/v/+CUFk8YwXwnCw==
X-Received: by 2002:a5e:c707:: with SMTP id f7mr5546230iop.188.1639529210104;
        Tue, 14 Dec 2021 16:46:50 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:8256:b93c:84fb:458b])
        by smtp.gmail.com with ESMTPSA id y8sm218857iox.32.2021.12.14.16.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 16:46:49 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     tharvey@gateworks.com, aford@beaconembedded.com,
        michael@amarulasolutions.com, jagan@amarulasolutions.com,
        Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 6/9] arm64: dts: imx8mn: add GPC node
Date:   Tue, 14 Dec 2021 18:46:23 -0600
Message-Id: <20211215004626.2241839-7-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211215004626.2241839-1-aford173@gmail.com>
References: <20211215004626.2241839-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT node for the GPC, including all the PGC power domains,
some of them are not fully functional yet, as they require interaction
with the blk-ctrls to properly power up/down the peripherals.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index b8d49d5f2668..52bf32be994f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -4,6 +4,8 @@
  */
 
 #include <dt-bindings/clock/imx8mn-clock.h>
+#include <dt-bindings/power/imx8mn-power.h>
+#include <dt-bindings/reset/imx8mq-reset.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -640,6 +642,53 @@ src: reset-controller@30390000 {
 				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 				#reset-cells = <1>;
 			};
+
+			gpc: gpc@303a0000 {
+				compatible = "fsl,imx8mn-gpc";
+				reg = <0x303a0000 0x10000>;
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+
+				pgc {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					pgc_hsiomix: power-domain@0 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MN_POWER_DOMAIN_HSIOMIX>;
+						clocks = <&clk IMX8MN_CLK_USB_BUS>;
+					};
+
+					pgc_otg1: power-domain@1 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MN_POWER_DOMAIN_OTG1>;
+						power-domains = <&pgc_hsiomix>;
+					};
+
+					pgc_gpumix: power-domain@2 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MN_POWER_DOMAIN_GPUMIX>;
+						clocks = <&clk IMX8MN_CLK_GPU_CORE_ROOT>,
+							 <&clk IMX8MN_CLK_GPU_SHADER>,
+							 <&clk IMX8MN_CLK_GPU_BUS_ROOT>,
+							 <&clk IMX8MN_CLK_GPU_AHB>;
+						resets = <&src IMX8MQ_RESET_GPU_RESET>;
+					};
+
+					pgc_dispmix: power-domain@3 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MN_POWER_DOMAIN_DISPMIX>;
+						clocks = <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
+							 <&clk IMX8MN_CLK_DISP_APB_ROOT>;
+					};
+
+					pgc_mipi: power-domain@4 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MN_POWER_DOMAIN_MIPI>;
+						power-domains = <&pgc_dispmix>;
+					};
+				};
+			};
 		};
 
 		aips2: bus@30400000 {
-- 
2.32.0

