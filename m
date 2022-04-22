Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82D850AFE0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbiDVGEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbiDVGEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:04:04 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74414F473;
        Thu, 21 Apr 2022 23:01:12 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23M617gb121375;
        Fri, 22 Apr 2022 01:01:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650607267;
        bh=b5SLYsYvigmTzUt32J57S1xBqu4+IQmeZP2d1WqYmuU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gcM/EpRISDo5IRg/Nh0tADJ0Mf35ceXT5KF+tQM3R84eoKGh3udX+9cJ6fR5WjJFa
         3+Tek9XBP5Gopt8+s99Zu/Nz/f2OMzLsS0QjU/Zo2UnHNt+ipGv7x4DnCLJo5vamDn
         rwZuYz4pVl3AAa9hBZRDipmee1RSz9pVeZP+/rE8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23M617W6024265
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Apr 2022 01:01:07 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 22
 Apr 2022 01:01:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 22 Apr 2022 01:01:07 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23M616W0008841;
        Fri, 22 Apr 2022 01:01:07 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-am62-main: Add McASP nodes
Date:   Fri, 22 Apr 2022 11:30:51 +0530
Message-ID: <20220422060052.8548-2-j-luthra@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220422060052.8548-1-j-luthra@ti.com>
References: <20220422060052.8548-1-j-luthra@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jayesh Choudhary <j-choudhary@ti.com>

Add the nodes for McASP 0-2.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 51 ++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 4b6ba98dd0a2..2014c0ca599c 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -530,4 +530,55 @@
 		ti,mbox-num-users = <4>;
 		ti,mbox-num-fifos = <16>;
 	};
+
+	mcasp0: mcasp@2b00000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x00 0x02b00000 0x00 0x2000>,
+		      <0x00 0x02b08000 0x00 0x400>;
+		reg-names = "mpu","dat";
+		interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+
+		dmas = <&main_bcdma 0 0xc500 0>, <&main_bcdma 0 0x4500 0>;
+		dma-names = "tx", "rx";
+
+		clocks = <&k3_clks 190 0>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 190 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	mcasp1: mcasp@2b10000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x00 0x02b10000 0x00 0x2000>,
+		      <0x00 0x02b18000 0x00 0x400>;
+		reg-names = "mpu","dat";
+		interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+
+		dmas = <&main_bcdma 0 0xc501 0>, <&main_bcdma 0 0x4501 0>;
+		dma-names = "tx", "rx";
+
+		clocks = <&k3_clks 191 0>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 191 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	mcasp2: mcasp@2b20000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x00 0x02b20000 0x00 0x2000>,
+		      <0x00 0x02b28000 0x00 0x400>;
+		reg-names = "mpu","dat";
+		interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+
+		dmas = <&main_bcdma 0 0xc502 0>, <&main_bcdma 0 0x4502 0>;
+		dma-names = "tx", "rx";
+
+		clocks = <&k3_clks 192 0>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
+	};
 };
-- 
2.17.1

