Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B4D5A6732
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiH3PWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiH3PVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:21:55 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5E5B6D7D;
        Tue, 30 Aug 2022 08:21:53 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27UFLcrj048470;
        Tue, 30 Aug 2022 10:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661872898;
        bh=ywjR1AnDdkkNqmVfBDldnoaMFPQ3GiyLfYVjXZp2PeM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wN04J8FpukUo3AzNw9tTWRViaxC2MAMXflvUj74HWszkF7PHj7F0/26suujN1BqRd
         fX0G9ME/4D8GL1GQcW0eu8k4A+GUogso/p/QM5OXRV8Mb7o2Dj1IqZovAU4xgg8xOe
         u4nA3WLLpoD+OYeu9yOddsFyLFvI52uKPusnc4G4=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27UFLcMR022131
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Aug 2022 10:21:38 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 30
 Aug 2022 10:21:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 30 Aug 2022 10:21:38 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27UFLciI061988;
        Tue, 30 Aug 2022 10:21:38 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/4] arm64: dts: ti: am65*: Define aliases in board files
Date:   Tue, 30 Aug 2022 10:21:29 -0500
Message-ID: <20220830152132.23916-2-nm@ti.com>
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

Define aliases in board files, instead of in the SoC dts file.

Note: the IoT family of boards have their own aliases already defined,
we need to carry the definitions forward to ensure things aren't
broken.

Reported-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi     | 12 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am65.dtsi             | 17 -----------------
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts  | 17 +++++++++++++++++
 3 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 32b797237581..8499754f45bb 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -14,6 +14,18 @@
 
 / {
 	aliases {
+		serial0 = &wkup_uart0;
+		serial1 = &mcu_uart0;
+		serial2 = &main_uart0;
+		serial3 = &main_uart1;
+		serial4 = &main_uart2;
+		i2c0 = &wkup_i2c0;
+		i2c1 = &mcu_i2c0;
+		i2c2 = &main_i2c0;
+		i2c3 = &main_i2c1;
+		i2c4 = &main_i2c2;
+		i2c5 = &main_i2c3;
+		ethernet0 = &cpsw_port1;
 		spi0 = &mcu_spi0;
 		mmc0 = &sdhci1;
 		mmc1 = &sdhci0;
diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
index c538a0bf3cdd..166d4e02c7e1 100644
--- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
@@ -18,23 +18,6 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	aliases {
-		serial0 = &wkup_uart0;
-		serial1 = &mcu_uart0;
-		serial2 = &main_uart0;
-		serial3 = &main_uart1;
-		serial4 = &main_uart2;
-		i2c0 = &wkup_i2c0;
-		i2c1 = &mcu_i2c0;
-		i2c2 = &main_i2c0;
-		i2c3 = &main_i2c1;
-		i2c4 = &main_i2c2;
-		i2c5 = &main_i2c3;
-		ethernet0 = &cpsw_port1;
-		mmc0 = &sdhci0;
-		mmc1 = &sdhci1;
-	};
-
 	chosen { };
 
 	firmware {
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 5850582dd4ed..aee866fb55b9 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -13,6 +13,23 @@ / {
 	compatible = "ti,am654-evm", "ti,am654";
 	model = "Texas Instruments AM654 Base Board";
 
+	aliases {
+		serial0 = &wkup_uart0;
+		serial1 = &mcu_uart0;
+		serial2 = &main_uart0;
+		serial3 = &main_uart1;
+		serial4 = &main_uart2;
+		i2c0 = &wkup_i2c0;
+		i2c1 = &mcu_i2c0;
+		i2c2 = &main_i2c0;
+		i2c3 = &main_i2c1;
+		i2c4 = &main_i2c2;
+		i2c5 = &main_i2c3;
+		ethernet0 = &cpsw_port1;
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 		bootargs = "earlycon=ns16550a,mmio32,0x02800000";
-- 
2.31.1

