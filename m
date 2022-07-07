Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C477F569A7A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbiGGGZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbiGGGZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:25:21 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C055914095;
        Wed,  6 Jul 2022 23:25:20 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2676PFD6079973;
        Thu, 7 Jul 2022 01:25:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657175115;
        bh=AYEf6gwAH8Cx8+7cbizE4cA7eC7HZ8FPs5Eo6CFAG1E=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=dbnm2geERQQJ/gR/5p1R5q6Qp8qGs2hu5RDdXIVsZkg9cO2pnqQOriFheV2Skq1Gf
         RBWbxFoTiULOFpEcz71Wly646u2cv2LKR1otKvovsDBl/y8MTMgCCdMmGF+QVn87av
         Vy/loSsSPsx6NaRE+Am5Ax4n+c9vEccN40JaRjYk=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2676PFWO119125
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jul 2022 01:25:15 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 7
 Jul 2022 01:25:15 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 7 Jul 2022 01:25:15 -0500
Received: from ubuntu.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2676P51U106842;
        Thu, 7 Jul 2022 01:25:13 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH RESEND 3/6] arm64: dts: ti: k3-j721s2-mcu-wakeup: Add support of OSPI
Date:   Wed, 6 Jul 2022 23:25:00 -0700
Message-ID: <20220707062503.295663-4-mranostay@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707062503.295663-1-mranostay@ti.com>
References: <20220707062503.295663-1-mranostay@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aswath Govindraju <a-govindraju@ti.com>

Add support for two instance of OSPI in J721S2 SoC.

Acked-by: Matt Ranostay <mranostay@ti.com>
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 4d1bfabd1313..7bc268f27030 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -299,4 +299,44 @@ cpts@3d000 {
 			ti,cpts-periodic-outputs = <2>;
 		};
 	};
+
+	fss: syscon@47000000 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0x0 0x47000000 0x0 0x100>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ospi0: spi@47040000 {
+			compatible = "ti,am654-ospi", "cdns,qspi-nor";
+			reg = <0x00 0x47040000 0x00 0x100>,
+			      <0x5 0x0000000 0x1 0x0000000>;
+			interrupts = <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>;
+			cdns,fifo-depth = <256>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x0>;
+			clocks = <&k3_clks 109 5>;
+			assigned-clocks = <&k3_clks 109 5>;
+			assigned-clock-parents = <&k3_clks 109 7>;
+			assigned-clock-rates = <166666666>;
+			power-domains = <&k3_pds 109 TI_SCI_PD_EXCLUSIVE>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		ospi1: spi@47050000 {
+			compatible = "ti,am654-ospi", "cdns,qspi-nor";
+			reg = <0x00 0x47050000 0x00 0x100>,
+			      <0x7 0x0000000 0x1 0x0000000>;
+			interrupts = <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>;
+			cdns,fifo-depth = <256>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x0>;
+			clocks = <&k3_clks 110 5>;
+			power-domains = <&k3_pds 110 TI_SCI_PD_EXCLUSIVE>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+	};
 };
-- 
2.36.1

