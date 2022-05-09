Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D696E51FFD5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbiEIObf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237088AbiEIObL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:31:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2486D1D500A;
        Mon,  9 May 2022 07:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652106437; x=1683642437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3ojOsUB0BmRtwo5gMeoeGrNl3U9+C7e6Z5b5OxtO0A8=;
  b=YMNsIjAsIzcwmyjD6vw0WO6/IuANKAru9fAmr9QLJUe9EHqRQxaRyoF2
   JIqxW8TcY/XiqaiIk7jOhzpq3h3t6txGcAykxCjVJ5u8XhLWufUUh7NOD
   ckrKIEYnIAOtA6y9oalDbwGNXAldu/2dSkJtF+tfUVRh8OTbKIkLMHilW
   29VEtr/RX0y7fgPpyCabMu8zDrADYb46MwrOght0CUrpizhzYZmLkG5Qy
   8Km3T5y0VNOuqhBT1StGF5vubdjQLHq7dFaVYMgwJbf63Z4J3I4XncNfh
   6NZV9A5whl8rWzQtCojCGbicCQp2FqG0EQSyoN48STOlv3hmGFDKyQoRO
   g==;
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="163251770"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 May 2022 07:27:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 9 May 2022 07:27:16 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 9 May 2022 07:27:14 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Cyril Jean <Cyril.Jean@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v5 10/10] riscv: dts: icicle: sort nodes alphabetically
Date:   Mon, 9 May 2022 15:26:11 +0100
Message-ID: <20220509142610.128590-11-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220509142610.128590-1-conor.dooley@microchip.com>
References: <20220509142610.128590-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The icicle device tree is in a "random" order, so clean it up and sort
its elements alphabetically to match the newly added PolarBerry dts.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../boot/dts/microchip/mpfs-icicle-kit.dts    | 104 +++++++++---------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
index 9cd1a30edf2c..044982a11df5 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
@@ -43,23 +43,57 @@ ddrc_cache_hi: memory@1000000000 {
 	};
 };
 
-&refclk {
-	clock-frequency = <125000000>;
+&core_pwm0 {
+	status = "okay";
 };
 
-&mmuart1 {
+&gpio2 {
+	interrupts = <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>;
 	status = "okay";
 };
 
-&mmuart2 {
+&i2c0 {
 	status = "okay";
 };
 
-&mmuart3 {
+&i2c1 {
 	status = "okay";
 };
 
-&mmuart4 {
+&i2c2 {
+	status = "okay";
+};
+
+&mac0 {
+	phy-mode = "sgmii";
+	phy-handle = <&phy0>;
+	status = "okay";
+};
+
+&mac1 {
+	phy-mode = "sgmii";
+	phy-handle = <&phy1>;
+	status = "okay";
+
+	phy1: ethernet-phy@9 {
+		reg = <9>;
+		ti,fifo-depth = <0x1>;
+	};
+
+	phy0: ethernet-phy@8 {
+		reg = <8>;
+		ti,fifo-depth = <0x1>;
+	};
+};
+
+&mbox {
 	status = "okay";
 };
 
@@ -78,74 +112,43 @@ &mmc {
 	status = "okay";
 };
 
-&spi0 {
-	status = "okay";
-};
-
-&spi1 {
-	status = "okay";
-};
-
-&qspi {
+&mmuart1 {
 	status = "okay";
 };
 
-&i2c0 {
+&mmuart2 {
 	status = "okay";
 };
 
-&i2c1 {
+&mmuart3 {
 	status = "okay";
 };
 
-&i2c2 {
+&mmuart4 {
 	status = "okay";
 };
 
-&mac0 {
-	phy-mode = "sgmii";
-	phy-handle = <&phy0>;
+&pcie {
 	status = "okay";
 };
 
-&mac1 {
-	phy-mode = "sgmii";
-	phy-handle = <&phy1>;
+&qspi {
 	status = "okay";
-
-	phy1: ethernet-phy@9 {
-		reg = <9>;
-		ti,fifo-depth = <0x1>;
-	};
-
-	phy0: ethernet-phy@8 {
-		reg = <8>;
-		ti,fifo-depth = <0x1>;
-	};
 };
 
-&gpio2 {
-	interrupts = <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>;
-	status = "okay";
+&refclk {
+	clock-frequency = <125000000>;
 };
 
 &rtc {
 	status = "okay";
 };
 
-&usb {
+&spi0 {
 	status = "okay";
-	dr_mode = "host";
 };
 
-&mbox {
+&spi1 {
 	status = "okay";
 };
 
@@ -153,10 +156,7 @@ &syscontroller {
 	status = "okay";
 };
 
-&pcie {
-	status = "okay";
-};
-
-&core_pwm0 {
+&usb {
 	status = "okay";
+	dr_mode = "host";
 };
-- 
2.35.2

