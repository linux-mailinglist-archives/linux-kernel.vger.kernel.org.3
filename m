Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F144481C39
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 13:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239416AbhL3MwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 07:52:17 -0500
Received: from fallback25.m.smailru.net ([94.100.189.1]:55964 "EHLO
        fallback25.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239380AbhL3MwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 07:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail3;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=AI7M4IM+OIQfNp7Vwkgow1e5z6visorja0WbeRGp4Us=;
        t=1640868735;x=1641474135; 
        b=It1kYSgvaYY81zbH2Z3XhgwY1yvv7mWUMsC+5B9KrCQSH+Enmru8sPOkm5K0ReDbLO14GbrlhpClR/TM2XRW1B3HTi1kNNw9ohkxwV0JpTDrhsuYEHhVlJkJ25hdYtutu/wHhCFLvv7zpj7k7qIHeWTm6PuICDwGvYdFE2sqeSM=;
Received: from [10.161.100.15] (port=36022 helo=smtpng3.i.mail.ru)
        by fallback25.m.smailru.net with esmtp (envelope-from <gtk3@inbox.ru>)
        id 1n2uuj-0000lH-CB; Thu, 30 Dec 2021 15:52:13 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=AI7M4IM+OIQfNp7Vwkgow1e5z6visorja0WbeRGp4Us=;
        t=1640868733;x=1641474133; 
        b=Ouc4Zac7XLlEnI82AtHsm5jvkcFFUeYtzKUKSzo4UqRhfFv89YSh/dxx2MapfnIFgjKGA6wEAsBPAnOpUmwn/r5Yquht4Kvoy4nA2iSIoMYftVQjk1HXqACfi3L3uwKZHZ6pk4VnjZBrOSAotbG7D5lRjlZLIhOun/K4ivw9T8twt/UZe/vZbo6eOxODVpAXD3IzVCTVZ2T/05Gl6h6o92NQL7aZhy4uvDtMgJO6WhDxvxZLcA3PR6PPhU5OtOzuD8zos1kAgPEi7LMQa0xtfAwafqq5xfDt1bDAxCl61HVN7v7s56VEAGgk19oQsZ2AiK2dDLOk4Bi+lHZwR9Iccw==;
Received: by smtpng3.m.smailru.net with esmtpa (envelope-from <gtk3@inbox.ru>)
        id 1n2uuU-0001Tn-SJ; Thu, 30 Dec 2021 15:51:59 +0300
From:   Maxim Kutnij <gtk3@inbox.ru>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Maxim Kutnij <gtk3@inbox.ru>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: mediatek: dts: activate SMP for mt6582
Date:   Thu, 30 Dec 2021 20:51:51 +0500
Message-Id: <20211230155152.48715-2-gtk3@inbox.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230155152.48715-1-gtk3@inbox.ru>
References: <20211230155152.48715-1-gtk3@inbox.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD94D5EF110843E6A67C325213A5E2C0E449CAC477A2A6F0E15182A05F538085040450BCF773D3DF88160F72509ADBA016566A5ED421034FAE65B4B2153517ED7C4
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE766DCF8604E9C5C06EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063702DFA59B3C994360EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BEBC5CAB6D411FFA69254326C01B69220E1AA0239E909E00020879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C084ED00A64A654CBE8941B15DA834481FA18204E546F3947C21E93C0F2A571C7BF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063793270F7220657A0A389733CBF5DBD5E9B5C8C57E37DE458B9E9CE733340B9D5F3BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE493B89ED3C7A628178125A4AB119743A3B3C4224003CC83647689D4C264860C145E
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C414F749A5E30D975C98DCDA00E0158592738A57C1586C77681A742A5B678BDD7F9C2B6934AE262D3EE7EAB7254005DCED7532B743992DF240BDC6A1CF3F042BAD6DF99611D93F60EF15519F706774CB6A699F904B3F4130E343918A1A30D5E7FCCB5012B2E24CD356
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34E318F287A436F24C999557752B3EF12E5B4E0FE4061C08EA6AF60B13CC337B9A8D73C3FBA8DABA541D7E09C32AA3244CA30F42E3C18344009E7B19D8CBDC2F27B4DF56057A86259FDCA3B3C10BC03908
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj1qmHCAeuKqPnSxAz7wEH1g==
X-Mailru-Sender: 689FA8AB762F739339CABD9B3CA9A7D642AD7DBB5C5DF4F89F393FC02AAF00E88F8182784CE3FA142B2697F7A04D759B04FC54F637BA925032C609A2DC06202998FD9B05CC386A12349DB15C680E247222B820C1B2086D890DA7A0AF5A3A8387
X-Mras: Ok
X-7564579A: 78E4E2B564C1792B
X-77F55803: 6242723A09DB00B458EAA7E4B0EE0F09DF6515A376223A25B0677477102AB39668F3CF0E9FE49B69F7F4223F437ECD80C3E6194ADB03F046AA02DB1958FF3E28A0753487BC874588
X-7FA49CB5: 0D63561A33F958A566F275E0886E016FD9BCCF36858B8D3C16ED296B5FE6A35FCACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F79006371E900BC921822949389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8FE0D02E6309259D2F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE70740AD75FEDF3C08731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C414F749A5E30D975C98DCDA00E0158592AB1DA771A99C60C14777FCF87EEE51509C2B6934AE262D3EE7EAB7254005DCED8DA55E71E02F9FC08E8E86DC7131B365E7726E8460B7C23C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj1qmHCAeuKqPVkPjlTypI+A==
X-Mailru-MI: 800
X-Mras: Ok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds nodes mt6589-smp, pmu and arm,armv7-timer.

Signed-off-by: Maxim Kutnij <gtk3@inbox.ru>
---
 arch/arm/boot/dts/mt6582.dtsi | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/mt6582.dtsi b/arch/arm/boot/dts/mt6582.dtsi
index 4263371784c..5efcbf43325 100644
--- a/arch/arm/boot/dts/mt6582.dtsi
+++ b/arch/arm/boot/dts/mt6582.dtsi
@@ -15,29 +15,43 @@ / {
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "mediatek,mt6589-smp";
 
-		cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x0>;
+			clock-frequency = <1300000000>;
 		};
-		cpu@1 {
+		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x1>;
+			clock-frequency = <1300000000>;
 		};
-		cpu@2 {
+		cpu2: cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x2>;
+			clock-frequency = <1300000000>;
 		};
-		cpu@3 {
+		cpu3: cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x3>;
+			clock-frequency = <1300000000>;
 		};
 	};
 
+	pmu {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 5 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 6 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 7 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+	};
+
 	system_clk: dummy13m {
 		compatible = "fixed-clock";
 		clock-frequency = <13000000>;
@@ -56,7 +70,18 @@ uart_clk: dummy26m {
 		#clock-cells = <0>;
 	};
 
-	timer: timer@11008000 {
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		clock-frequency = <13000000>;
+		arm,cpu-registers-not-fw-configured;
+	};
+
+	timer: timer@10008000 {
 		compatible = "mediatek,mt6577-timer";
 		reg = <0x10008000 0x80>;
 		interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_LOW>;
-- 
2.34.1

