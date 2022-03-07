Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7350D4D090E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbiCGU43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245542AbiCGUzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:55:47 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A7D41FBA;
        Mon,  7 Mar 2022 12:54:05 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id z3so6645868plg.8;
        Mon, 07 Mar 2022 12:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tPjj1K6lZBTX8hEOK8gCg4IqEXUDCbxzugfTcpB9YN8=;
        b=OMzmZsWF6JgoOaoX1/pDF/nRhTOuDAHER8czjOyjiq7yKS2qN3j6nwTCBJ4hqAg+JX
         H40Ap/u9AwWk7P0tpF39dkkVO77Ry/kbySKy1LAKUbVlElWMHw8fNy7wsjHeegjTUEHF
         a414YLXxuGUVjhdD9fMv1JHkt7NC4vuBe5r/7pZoCw1ZBoHREUITBtN4ftvmsojLmBWK
         f8173M9fdBd7MOa0wDAPOKniWI1FfbLPPncT0ACvW98AbOCqx1hW7SRJO91rHZ3ausHv
         wLUlH6hpsyEn4fShDc1ohT4ol4Os5j22tOEugnlYS6wGhWVHCi57x/Vxhy3r4P4YBw2X
         q/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tPjj1K6lZBTX8hEOK8gCg4IqEXUDCbxzugfTcpB9YN8=;
        b=zuqlfoum/VhiL+nWQxybuxjAPrDx+LMe/lIjs+qTWfTSMX6M5JMSR2R/AC2PmqWZH3
         h9CenTxgQRxDwQa6tDjsNUKB0H327NViKDhrZiaaYZlguPF2EQMSAWhZtU4IZ2jtzTJj
         eZvrzBsSOqdEcpeOiHk31HFnlnTY9z7+5vew5jU93ekOOAElYyIDMwKXhwyl9bNTPdgm
         GZpIEXB7ENR6DHxwyjvT2bmWyUriS3oQk6jX2EzWCl8bICboTZr8WcUzw1vQDf+++F3q
         xdx+xbJ9Zet5bM7bkd/9wnPjZadtaR98PPT1NQdWASukLcxKew4rLjCiVl/9j3ywJVtx
         fjew==
X-Gm-Message-State: AOAM533h1i9if4KshMjbG7Y6N5WpE5gVN8CgVaGs3JYyL4RkMRnvhn7O
        AgOh/OEBiCIhIsqhslukFSY=
X-Google-Smtp-Source: ABdhPJzrRr056Aj27ekDLcE8flrt5RD2c10LT3iVJtMosvKrNjN+CHHRAgST3EWxdmM+dNbEwafBOQ==
X-Received: by 2002:a17:902:cf12:b0:14f:e0c2:1515 with SMTP id i18-20020a170902cf1200b0014fe0c21515mr14094770plg.4.1646686444633;
        Mon, 07 Mar 2022 12:54:04 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id a12-20020a056a000c8c00b004e1a76f0a8asm17676794pfv.51.2022.03.07.12.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 12:54:04 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/2] arm: dts: realview/versatile/ste: Update spi clock name
Date:   Tue,  8 Mar 2022 02:23:56 +0530
Message-Id: <20220307205357.66322-2-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307205357.66322-1-singh.kuldeep87k@gmail.com>
References: <20220307205357.66322-1-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI clock for pl022 is "sspclk" and meanwhile few platforms such as
realview, versatile etc. specify "SSPCLK" as clock name. Even though
bindings checks don't differentiate between the two names still keep
same convention throughout i.e sspclk to align with other platforms.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 arch/arm/boot/dts/arm-realview-eb.dtsi    |  2 +-
 arch/arm/boot/dts/arm-realview-pb1176.dts |  2 +-
 arch/arm/boot/dts/arm-realview-pb11mp.dts |  2 +-
 arch/arm/boot/dts/arm-realview-pbx.dtsi   |  2 +-
 arch/arm/boot/dts/ste-dbx5x0.dtsi         | 12 ++++++------
 arch/arm/boot/dts/versatile-ab.dts        |  2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/arm-realview-eb.dtsi b/arch/arm/boot/dts/arm-realview-eb.dtsi
index 2dfb32bf9d48..fbb2258b451f 100644
--- a/arch/arm/boot/dts/arm-realview-eb.dtsi
+++ b/arch/arm/boot/dts/arm-realview-eb.dtsi
@@ -399,7 +399,7 @@ ssp: spi@1000d000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x1000d000 0x1000>;
 			clocks = <&sspclk>, <&pclk>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 		};
 
 		wdog: watchdog@10010000 {
diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index 06b8723b09eb..efed325af88d 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -410,7 +410,7 @@ pb1176_ssp: spi@1010b000 {
 			interrupt-parent = <&intc_dc1176>;
 			interrupts = <0 17 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&sspclk>, <&pclk>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 		};
 
 		pb1176_serial0: serial@1010c000 {
diff --git a/arch/arm/boot/dts/arm-realview-pb11mp.dts b/arch/arm/boot/dts/arm-realview-pb11mp.dts
index 295aef448123..89103d54ecc1 100644
--- a/arch/arm/boot/dts/arm-realview-pb11mp.dts
+++ b/arch/arm/boot/dts/arm-realview-pb11mp.dts
@@ -555,7 +555,7 @@ spi@1000d000 {
 			interrupt-parent = <&intc_pb11mp>;
 			interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&sspclk>, <&pclk>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 		};
 
 		watchdog@1000f000 {
diff --git a/arch/arm/boot/dts/arm-realview-pbx.dtsi b/arch/arm/boot/dts/arm-realview-pbx.dtsi
index 6f61f968d689..ec1507c5147c 100644
--- a/arch/arm/boot/dts/arm-realview-pbx.dtsi
+++ b/arch/arm/boot/dts/arm-realview-pbx.dtsi
@@ -390,7 +390,7 @@ ssp: spi@1000d000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x1000d000 0x1000>;
 			clocks = <&sspclk>, <&pclk>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 		};
 
 		wdog0: watchdog@1000f000 {
diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index dc0bcc7020f1..c28b32640254 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -755,7 +755,7 @@ ssp0: spi@80002000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&prcc_kclk 3 1>, <&prcc_pclk 3 1>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 			dmas = <&dma 8 0 0x2>, /* Logical - DevToMem */
 			       <&dma 8 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
@@ -772,7 +772,7 @@ ssp1: spi@80003000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&prcc_kclk 3 2>, <&prcc_pclk 3 2>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 			dmas = <&dma 9 0 0x2>, /* Logical - DevToMem */
 			       <&dma 9 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
@@ -790,7 +790,7 @@ spi0: spi@8011a000 {
 			#size-cells = <0>;
 			/* Same clock wired to kernel and pclk */
 			clocks = <&prcc_pclk 2 8>, <&prcc_pclk 2 8>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 			dmas = <&dma 0 0 0x2>, /* Logical - DevToMem */
 			       <&dma 0 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
@@ -807,7 +807,7 @@ spi1: spi@80112000 {
 			#size-cells = <0>;
 			/* Same clock wired to kernel and pclk */
 			clocks = <&prcc_pclk 2 2>, <&prcc_pclk 2 2>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 			dmas = <&dma 35 0 0x2>, /* Logical - DevToMem */
 			       <&dma 35 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
@@ -824,7 +824,7 @@ spi2: spi@80111000 {
 			#size-cells = <0>;
 			/* Same clock wired to kernel and pclk */
 			clocks = <&prcc_pclk 2 1>, <&prcc_pclk 2 1>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 			dmas = <&dma 33 0 0x2>, /* Logical - DevToMem */
 			       <&dma 33 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
@@ -841,7 +841,7 @@ spi3: spi@80129000 {
 			#size-cells = <0>;
 			/* Same clock wired to kernel and pclk */
 			clocks = <&prcc_pclk 1 7>, <&prcc_pclk 1 7>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 			dmas = <&dma 40 0 0x2>, /* Logical - DevToMem */
 			       <&dma 40 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
index 79f7cc241282..a520615f4d8d 100644
--- a/arch/arm/boot/dts/versatile-ab.dts
+++ b/arch/arm/boot/dts/versatile-ab.dts
@@ -391,7 +391,7 @@ spi@101f4000 {
 			reg = <0x101f4000 0x1000>;
 			interrupts = <11>;
 			clocks = <&xtal24mhz>, <&pclk>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 		};
 
 		fpga {
-- 
2.25.1

