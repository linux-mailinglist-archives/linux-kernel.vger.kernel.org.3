Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE2D4827BC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 15:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbiAAOTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 09:19:18 -0500
Received: from fallback21.m.smailru.net ([94.100.176.131]:52808 "EHLO
        fallback21.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiAAOTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 09:19:18 -0500
X-Greylist: delayed 964 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Jan 2022 09:19:17 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail3;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=AmHTn5QLkTRzbIDSpxm57IEHnMkwPINiZcUYWqC9F3o=;
        t=1641046758;x=1641652158; 
        b=cAu8iBlBEs8uG2U6qb5yw81EpkIWId8FPmZv/7Lu+icFA0fHHBuuoE4zXyr+iAM0bdoW4EurhrZgWs5ZaRb3tNqZdF98AmSmuV1wISXq5J//kP6vAdOKUriIY8qWD81jOcZcSmAwQwKsjQM8Kg4IR54TRLAQh2wkTHsl89da2lE=;
Received: from [10.161.55.49] (port=34606 helo=smtpng1.i.mail.ru)
        by fallback21.m.smailru.net with esmtp (envelope-from <gtk3@inbox.ru>)
        id 1n3eyW-00056L-4z; Sat, 01 Jan 2022 17:03:12 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=AmHTn5QLkTRzbIDSpxm57IEHnMkwPINiZcUYWqC9F3o=;
        t=1641045792;x=1641651192; 
        b=hoc9gFCqMNaSKqF/DYT+QKouwwUkcKnZvTVIAXKxacDXkNJ8cZDulzHd5Y+J0oSaUkO3Gy4if3qiVUFzcMrb1iTlU8mO6Ug+/AoW4ZLngbQFX9E9cTgD3EmvC7106ZBigaMcgk4h//CLdCqTlKdle26FFcuQ+r1lEJJyBAshBHjrrmykaCoM3buf6EOhKbZyPZS01kI3M3J2LjRXEQH+Wcp2LawAUee6K8kR5JKs95zQiPKpfXLj9uXbne4H/OTtmfRCSx6V3T2XqkvYhpxxfA/ZAk4W0TcZyW22QWwbGtWEc0L0OFzmAF1RWLGokmsMfzeCOlZqI6HOTxOVk12wpw==;
Received: by smtpng1.m.smailru.net with esmtpa (envelope-from <gtk3@inbox.ru>)
        id 1n3eyI-0008TK-Nr; Sat, 01 Jan 2022 17:02:59 +0300
From:   Maxim Kutnij <gtk3@inbox.ru>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Maxim Kutnij <gtk3@inbox.ru>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ARM: mediatek: dts: activate SMP for mt6582
Date:   Sat,  1 Jan 2022 19:01:37 +0500
Message-Id: <20220101140140.4119-2-gtk3@inbox.ru>
X-Mailer: git-send-email 2.33.1
In-Reply-To: dda186e0-38e0-4061-f60e-e297441d9fed@gmail.com
References: <20220101140140.4119-1-gtk3@inbox.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD94D5EF110843E6A67F048BDCF9374CE1A58D6149DC67AB94F182A05F538085040A0101759128AD6016C795D8B553528A6B2C0547B044728B1D1C0373C7B4A6AFA
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE72942E6CCEF3332DBEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637F5B2F26146BDF5648638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D86945DF9F1CC75BD729390D53FDA0BA316F9789CCF6C18C3F8528715B7D10C86859CC434672EE6371117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCF80095D1E57F4578A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352033AC447995A7AD18E5D25F19253116ADD2E47CDBA5A96583BA9C0B312567BB231DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B670D51CA322917D6D089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C414F749A5E30D975C357A67C6196E73BDD3E36531BF0317A2755C091D42AAEF6B9C2B6934AE262D3EE7EAB7254005DCED7532B743992DF240BDC6A1CF3F042BAD6DF99611D93F60EF15519F706774CB6A699F904B3F4130E343918A1A30D5E7FCCB5012B2E24CD356
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34753B45383CEFF204F7D5B8DDA22F309A27E28980963724510F8CA6FD09DE7ABF2DABF6287AB014B21D7E09C32AA3244CFE26EE6092C7DB4AB7DFCB2F60B05D203A76366E8A9DE7CADCA3B3C10BC03908
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojzdjxcBf1eR43lqoZyNF+Jw==
X-Mailru-Sender: 689FA8AB762F739339CABD9B3CA9A7D6DF5652CB75E442D31F19869E8BDFAE4B8F8182784CE3FA142B2697F7A04D759B04FC54F637BA925032C609A2DC06202998FD9B05CC386A12349DB15C680E247222B820C1B2086D890DA7A0AF5A3A8387
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B458EAA7E4B0EE0F09E17E9F3906B11922EE4D70694A97BD7A68F3CF0E9FE49B6998B3DD7178ECBFFC4311E5F8A58FA08064D8D59A3DED970705BBB30D1A6DDB5A
X-7FA49CB5: 0D63561A33F958A58A0A78F8386648435650FA35E274B94C48C8EDEFB6AE55BFCACD7DF95DA8FC8BD5E8D9A59859A8B62AF6E036D66B0843CC7F00164DA146DAFE8445B8C89999728AA50765F7900637436E42DEDF9DC02F9FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C3D6B3BA020039D4E8CC7F00164DA146DA6F5DAA56C3B73B23C77107234E2CFBA522CA9DD8327EE493EFA58DFCB7B0AE11A3CCBC2573AEBDE1C4224003CC83647689D4C264860C145E
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C414F749A5E30D975C357A67C6196E73BDA49BCCBEFCDE228D0A44D5006CF16A9D9C2B6934AE262D3EE7EAB7254005DCED8DA55E71E02F9FC08E8E86DC7131B365E7726E8460B7C23C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojzdjxcBf1eR6Q34UmZgxR2A==
X-Mailru-MI: 800
X-Mras: Ok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds nodes mt6589-smp, pmu and arm,armv7-timer.

Signed-off-by: Maxim Kutnij <gtk3@inbox.ru>
---
 arch/arm/boot/dts/mt6582.dtsi | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/mt6582.dtsi b/arch/arm/boot/dts/mt6582.dtsi
index 426337178..2d5cb3bdd 100644
--- a/arch/arm/boot/dts/mt6582.dtsi
+++ b/arch/arm/boot/dts/mt6582.dtsi
@@ -15,29 +15,39 @@ / {
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "mediatek,mt6589-smp";
 
-		cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x0>;
 		};
-		cpu@1 {
+		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x1>;
 		};
-		cpu@2 {
+		cpu2: cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x2>;
 		};
-		cpu@3 {
+		cpu3: cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x3>;
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
@@ -56,7 +66,18 @@ uart_clk: dummy26m {
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
2.33.1

