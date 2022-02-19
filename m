Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FE34BC921
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 16:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242567AbiBSP3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 10:29:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242557AbiBSP3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 10:29:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C594C5D647;
        Sat, 19 Feb 2022 07:28:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60C4E60B20;
        Sat, 19 Feb 2022 15:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A50C004E1;
        Sat, 19 Feb 2022 15:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645284517;
        bh=F6pcZPFpnI6hLMIYVmpuXloWiEvqSEfMam/xjyvdLDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dMOKL2ugYw+WQBj3ZZQVOq9CBHushdo1zYvAtdjLBBulSXfJCxtB2RB70mxRdh3Uh
         ZYRcyq4pgoZE0hi21EZUgZLGUBEdHYbpQ7+AqPMYjT8aeaE7RLgMOO/smC1jXlvwjm
         Q/sdx9DDPtm5A9x8tDuFkGuh39ujbcS2YQQRGELvoICo8W3of08RrEAW+MtNrqSFD3
         8GbHqHZbW4letP1dhAsqbX0W5Qffp8DgxfIFidm5jpNEosdiO2Gb4jjxV7PB1KCauD
         9owowxo0EQU1Br+wL0r+wc1ipLOZrV/Wp9QP+XmQyyg5mhhEMyi5yteqShfU6+mVXA
         +rJYplsFU8AQg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v9 6/6] arm64: dts: marvell: armada-37xx: add device node for UART clock and use it
Date:   Sat, 19 Feb 2022 16:28:18 +0100
Message-Id: <20220219152818.4319-7-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220219152818.4319-1-kabel@kernel.org>
References: <20220219152818.4319-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Define DT node for UART clock "marvell,armada-3700-uart-clock" and use
this UART clock as a base clock for all UART devices.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 673f4906eef9..da2f6b5c4b20 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -132,10 +132,20 @@ avs: avs@11500 {
 				reg = <0x11500 0x40>;
 			};
 
+			uartclk: clock-controller@12010 {
+				compatible = "marvell,armada-3700-uart-clock";
+				reg = <0x12010 0x4>, <0x12210 0x4>;
+				clocks = <&tbg 0>, <&tbg 1>, <&tbg 2>,
+					 <&tbg 3>, <&xtalclk>;
+				clock-names = "TBG-A-P", "TBG-B-P", "TBG-A-S",
+					      "TBG-B-S", "xtal";
+				#clock-cells = <1>;
+			};
+
 			uart0: serial@12000 {
 				compatible = "marvell,armada-3700-uart";
 				reg = <0x12000 0x18>;
-				clocks = <&xtalclk>;
+				clocks = <&uartclk 0>;
 				interrupts =
 				<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
@@ -147,7 +157,7 @@ uart0: serial@12000 {
 			uart1: serial@12200 {
 				compatible = "marvell,armada-3700-uart-ext";
 				reg = <0x12200 0x30>;
-				clocks = <&xtalclk>;
+				clocks = <&uartclk 1>;
 				interrupts =
 				<GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
 				<GIC_SPI 31 IRQ_TYPE_EDGE_RISING>;
-- 
2.34.1

