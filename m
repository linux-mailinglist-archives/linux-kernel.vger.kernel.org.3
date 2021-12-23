Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E573F47E316
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348192AbhLWMRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:17:34 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36608 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348175AbhLWMRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:17:32 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BNCHSq4018204;
        Thu, 23 Dec 2021 06:17:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640261848;
        bh=upyrxwQro1G6ZhI6ZlGGuSAAgV5rehB5dzXndpwD6J4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CjgqFEr/ehBkiYN+sIxZqaOyxMyz7NAMLYPO0/C01LgmpxSjkmGadM1rLdet8QFWA
         rQKYzMJLP7F2ClzQqLHMsxfW7fvjOyAiFEj5mgaORn0jVnt8+pbPXgIrQaRqsyG4/C
         NcTtbZx5x8AB+3lELaxt50cd0IdHiCiN8pfS2KOc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BNCHSJ5076062
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Dec 2021 06:17:28 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 23
 Dec 2021 06:17:28 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 23 Dec 2021 06:17:28 -0600
Received: from uda0132425.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BNCHN6C047704;
        Thu, 23 Dec 2021 06:17:26 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH-next 1/2] arm64: dts: ti: k3-j721s2: Move aliases to board dts
Date:   Thu, 23 Dec 2021 17:46:49 +0530
Message-ID: <20211223121650.26868-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211223121650.26868-1-vigneshr@ti.com>
References: <20211223121650.26868-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aswath Govindraju <a-govindraju@ti.com>

Aliases are board specific and should be in board dts files.
So, move aliases to board dts and trim the list to interfaces that are
actually enabled.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../dts/ti/k3-j721s2-common-proc-board.dts    | 10 +++++++++
 arch/arm64/boot/dts/ti/k3-j721s2.dtsi         | 22 -------------------
 2 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index a5a24f9f46c5..708c14338eb7 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -19,6 +19,16 @@ chosen {
 		bootargs = "console=ttyS10,115200n8 earlycon=ns16550a,mmio32,2880000";
 	};
 
+	aliases {
+		serial1 = &mcu_uart0;
+		serial10 = &main_uart8;
+		mmc0 = &main_sdhci0;
+		mmc1 = &main_sdhci1;
+		can0 = &main_mcan16;
+		can1 = &mcu_mcan0;
+		can2 = &mcu_mcan1;
+	};
+
 	evm_12v0: fixedregulator-evm12v0 {
 		/* main supply */
 		compatible = "regulator-fixed";
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2.dtsi
index 80d3cae03e88..fe5234c40f6c 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2.dtsi
@@ -21,28 +21,6 @@ / {
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
-		mmc0 = &main_sdhci0;
-		mmc1 = &main_sdhci1;
-		can0 = &main_mcan16;
-		can1 = &mcu_mcan0;
-		can2 = &mcu_mcan1;
-		can3 = &main_mcan3;
-		can4 = &main_mcan5;
-	};
-
 	chosen { };
 
 	cpus {
-- 
2.34.1

