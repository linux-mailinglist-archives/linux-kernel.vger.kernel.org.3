Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C145A6734
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiH3PWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiH3PV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:21:56 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4BEB81ED;
        Tue, 30 Aug 2022 08:21:54 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27UFLcaC054559;
        Tue, 30 Aug 2022 10:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661872898;
        bh=cntUskqzohyadfhsaNuLHuq4bZpbdu4uxpaIy+vZh9k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=i0igwv4EKTxz/IYDVFouW43t1NzlEJFThe+VrGwTYZfm3CCWLayP8L5Dgx/lFcjFW
         QptfBFWHiUwmQmieK5dTOCMQIDrg/kaS147Ak6edG6H4OWJsWtw1SgnWsGcxGqTjic
         4ZArl9QjKPSXhVbCLtbCS/kNubMj102LnImrPvt8=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27UFLc1p022134
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Aug 2022 10:21:38 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 30
 Aug 2022 10:21:37 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 30 Aug 2022 10:21:38 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27UFLcjI091927;
        Tue, 30 Aug 2022 10:21:38 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/4] arm64: dts: ti: j721e*: Define aliases in board files
Date:   Tue, 30 Aug 2022 10:21:30 -0500
Message-ID: <20220830152132.23916-3-nm@ti.com>
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
 .../dts/ti/k3-j721e-common-proc-board.dts     | 19 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 19 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          | 19 -------------------
 3 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index b1691ac3442d..7355144bdc19 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -15,6 +15,25 @@ / {
 	compatible = "ti,j721e-evm", "ti,j721e";
 	model = "Texas Instruments J721e EVM";
 
+	aliases {
+		serial0 = &wkup_uart0;
+		serial1 = &mcu_uart0;
+		serial2 = &main_uart0;
+		serial3 = &main_uart1;
+		serial4 = &main_uart2;
+		serial5 = &main_uart3;
+		serial6 = &main_uart4;
+		serial7 = &main_uart5;
+		serial8 = &main_uart6;
+		serial9 = &main_uart7;
+		serial10 = &main_uart8;
+		serial11 = &main_uart9;
+		ethernet0 = &cpsw_port1;
+		mmc0 = &main_sdhci0;
+		mmc1 = &main_sdhci1;
+		mmc2 = &main_sdhci2;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 80358cba6954..f5e6ab2ef35c 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -16,6 +16,25 @@ / {
 	compatible = "ti,j721e-sk", "ti,j721e";
 	model = "Texas Instruments J721E SK";
 
+	aliases {
+		serial0 = &wkup_uart0;
+		serial1 = &mcu_uart0;
+		serial2 = &main_uart0;
+		serial3 = &main_uart1;
+		serial4 = &main_uart2;
+		serial5 = &main_uart3;
+		serial6 = &main_uart4;
+		serial7 = &main_uart5;
+		serial8 = &main_uart6;
+		serial9 = &main_uart7;
+		serial10 = &main_uart8;
+		serial11 = &main_uart9;
+		ethernet0 = &cpsw_port1;
+		mmc0 = &main_sdhci0;
+		mmc1 = &main_sdhci1;
+		mmc2 = &main_sdhci2;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
index 0e23886c9fd1..e8e93d075dc4 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
@@ -17,25 +17,6 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	aliases {
-		serial0 = &wkup_uart0;
-		serial1 = &mcu_uart0;
-		serial2 = &main_uart0;
-		serial3 = &main_uart1;
-		serial4 = &main_uart2;
-		serial5 = &main_uart3;
-		serial6 = &main_uart4;
-		serial7 = &main_uart5;
-		serial8 = &main_uart6;
-		serial9 = &main_uart7;
-		serial10 = &main_uart8;
-		serial11 = &main_uart9;
-		ethernet0 = &cpsw_port1;
-		mmc0 = &main_sdhci0;
-		mmc1 = &main_sdhci1;
-		mmc2 = &main_sdhci2;
-	};
-
 	chosen { };
 
 	cpus {
-- 
2.31.1

