Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57164CDC2F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241630AbiCDSTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241617AbiCDSTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:19:19 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D328BF76;
        Fri,  4 Mar 2022 10:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646417910; x=1677953910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d7RvkwzUCTXssUmowUaeZmws8DArQwpm8XmcW0dwX5g=;
  b=P02CTBWsV8Ad/DKVIQqwxvJ/XAM7YlRd9mUCQ3gQHQKBfoRkO3LbgUV/
   h1bVeIhvafmsdx8UTDJNx6r3qgX9dTXYTmbzpZy7+8JeY944HGF7W9xvW
   UHHOB3ra6MpsYSSgvD5BAU91zeiGST4WfG8jyUbaZgYoHjQdNFw2uO3+n
   7Ehed3KAPYxCzV8gOV84FJwYxj0mxY2Lf9W6/9D1EvaYLBdOBWH9fD8aW
   LpHOcLEq1U/zcvaurQIB8H6RDeuKROOgFZjmgyf3zfo6p9Zoxve/RDKqc
   8pduLtFkY5yPe83E/GvpWqcl40fbgc0BeXINf9QbdRcQRFJNtMLd9/bkv
   w==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="155759082"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 11:18:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 11:18:29 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 4 Mar 2022 11:18:26 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lars@metafoo.de>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH 4/6] ARM: dts: at91: sama7g5: add nodes for PDMC
Date:   Fri, 4 Mar 2022 20:17:54 +0200
Message-ID: <20220304181756.1894561-5-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304181756.1894561-1-codrin.ciubotariu@microchip.com>
References: <20220304181756.1894561-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microchip's SAMA7G5 embeds two PDMCs. The PDMCs can be used to connect 2x4
PDM microphones.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 arch/arm/boot/dts/sama7g5.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index eddcfbf4d223..85a22c3a8e57 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -275,6 +275,30 @@ pwm: pwm@e1604000 {
 			status = "disabled";
 		};
 
+		pdmc0: pdmc@e1608000 {
+			compatible = "microchip,sama7g5-pdmc";
+			reg = <0xe1608000 0x1000>;
+			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+			#sound-dai-cells = <0>;
+			dmas = <&dma0 AT91_XDMAC_DT_PERID(37)>;
+			dma-names = "rx";
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 68>, <&pmc PMC_TYPE_GCK 68>;
+			clock-names = "pclk", "gclk";
+			status = "disabled";
+		};
+
+		pdmc1: pdmc@e160c000 {
+			compatible = "microchip,sama7g5-pdmc";
+			reg = <0xe160c000 0x1000>;
+			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+			#sound-dai-cells = <0>;
+			dmas = <&dma0 AT91_XDMAC_DT_PERID(38)>;
+			dma-names = "rx";
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 69>, <&pmc PMC_TYPE_GCK 69>;
+			clock-names = "pclk", "gclk";
+			status = "disabled";
+		};
+
 		spdifrx: spdifrx@e1614000 {
 			#sound-dai-cells = <0>;
 			compatible = "microchip,sama7g5-spdifrx";
-- 
2.32.0

