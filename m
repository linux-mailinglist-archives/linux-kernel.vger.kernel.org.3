Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1565515D7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241065AbiFTK2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239136AbiFTK2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:28:20 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7056349;
        Mon, 20 Jun 2022 03:28:19 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25KAS6M8044752;
        Mon, 20 Jun 2022 05:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655720886;
        bh=ImcBo4lsvcEZdixqDw7FCKVpHcPOYUoXNMbNGRzE718=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gzGGGRtDJuLpxf+/g/PaKAZyY201sXksFCn3aGrzk9ZczMJT1TcM7FHf6/PjRlwld
         T6GUkDr5V8IaHtYEONVUpm3xW7F2PRxpJubvARIOoZvcezSNYVXjN5xDbSzyQJJlhs
         WZdAH9sWZX5/NyoZE2OfDFJvgGHEJ3f+QskHJelg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25KAS65J095264
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jun 2022 05:28:06 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Jun 2022 05:28:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Jun 2022 05:28:06 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25KAS5Aa018394;
        Mon, 20 Jun 2022 05:28:06 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v4 1/2] arm64: dts: ti: k3-am62-main: Add McASP nodes
Date:   Mon, 20 Jun 2022 15:57:48 +0530
Message-ID: <20220620102750.32718-2-j-luthra@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220620102750.32718-1-j-luthra@ti.com>
References: <20220620102750.32718-1-j-luthra@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jayesh Choudhary <j-choudhary@ti.com>

Add the nodes for McASP 0-2.

Use the audio-friendly 96MHz main_1_hsdivout6_clk as clock parent
instead of the default 100Mhz main_2_hsdivout8_clk source.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 57 ++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index d08abad0bcf4..726f31a880ad 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -571,4 +571,61 @@
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
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
+		assigned-clocks = <&k3_clks 190 0>;
+		assigned-clock-parents = <&k3_clks 190 2>;
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
+		assigned-clocks = <&k3_clks 191 0>;
+		assigned-clock-parents = <&k3_clks 191 2>;
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
+		assigned-clocks = <&k3_clks 192 0>;
+		assigned-clock-parents = <&k3_clks 192 2>;
+		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
+	};
 };
-- 
2.17.1

