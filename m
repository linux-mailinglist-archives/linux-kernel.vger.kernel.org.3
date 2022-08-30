Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBAC5A672C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiH3PWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiH3PVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:21:55 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB01B728D;
        Tue, 30 Aug 2022 08:21:53 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27UFLcf6048474;
        Tue, 30 Aug 2022 10:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661872898;
        bh=secVNftM85ekE/jpsmMFiAgn/cbSg5ncZ9m6WYwQ3NM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=V4aiv4Jh40ZUNx7p3k3jtu0akJbkFGWt+ZJTAiILaYJQPEccCUUKr9wkqeKCn4vXa
         oMMq13PMHz/SkRkv0tK0W6oRQ6696ycO2Hyay3tgAufsWJI/J2Sw+o6ZVYPZFxTOkr
         6Qd6MWYJBSeDBZWHUKigvGhzNvts7qYWLcyarDUI=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27UFLcSK018000
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Aug 2022 10:21:38 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 30
 Aug 2022 10:21:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 30 Aug 2022 10:21:38 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27UFLcf5022771;
        Tue, 30 Aug 2022 10:21:38 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 4/4] arm64: dts: ti: am64*: Define aliases in board files
Date:   Tue, 30 Aug 2022 10:21:32 -0500
Message-ID: <20220830152132.23916-5-nm@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220830152132.23916-1-nm@ti.com>
References: <20220830152132.23916-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define aliases in board files, instead of in the SoC dtsi file.

Reported-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64.dtsi     | 16 ----------------
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 16 ++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts  | 16 ++++++++++++++++
 3 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64.dtsi b/arch/arm64/boot/dts/ti/k3-am64.dtsi
index 016dd8511ca6..ffe7578e553b 100644
--- a/arch/arm64/boot/dts/ti/k3-am64.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64.dtsi
@@ -18,22 +18,6 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	aliases {
-		serial0 = &mcu_uart0;
-		serial1 = &mcu_uart1;
-		serial2 = &main_uart0;
-		serial3 = &main_uart1;
-		serial4 = &main_uart2;
-		serial5 = &main_uart3;
-		serial6 = &main_uart4;
-		serial7 = &main_uart5;
-		serial8 = &main_uart6;
-		ethernet0 = &cpsw_port1;
-		ethernet1 = &cpsw_port2;
-		mmc0 = &sdhci0;
-		mmc1 = &sdhci1;
-	};
-
 	chosen { };
 
 	firmware {
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index ad150c704623..076e21e3d261 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -16,6 +16,22 @@ / {
 	compatible = "ti,am642-evm", "ti,am642";
 	model = "Texas Instruments AM642 EVM";
 
+	aliases {
+		serial0 = &mcu_uart0;
+		serial1 = &mcu_uart1;
+		serial2 = &main_uart0;
+		serial3 = &main_uart1;
+		serial4 = &main_uart2;
+		serial5 = &main_uart3;
+		serial6 = &main_uart4;
+		serial7 = &main_uart5;
+		serial8 = &main_uart6;
+		ethernet0 = &cpsw_port1;
+		ethernet1 = &cpsw_port2;
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 2620469a7517..70432a9ac485 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -15,6 +15,22 @@ / {
 	compatible = "ti,am642-sk", "ti,am642";
 	model = "Texas Instruments AM642 SK";
 
+	aliases {
+		serial0 = &mcu_uart0;
+		serial1 = &mcu_uart1;
+		serial2 = &main_uart0;
+		serial3 = &main_uart1;
+		serial4 = &main_uart2;
+		serial5 = &main_uart3;
+		serial6 = &main_uart4;
+		serial7 = &main_uart5;
+		serial8 = &main_uart6;
+		ethernet0 = &cpsw_port1;
+		ethernet1 = &cpsw_port2;
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
-- 
2.31.1

