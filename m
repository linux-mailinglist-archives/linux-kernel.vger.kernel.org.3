Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8712156B881
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbiGHL2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237853AbiGHL2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:28:12 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D04E904E4;
        Fri,  8 Jul 2022 04:28:10 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 268BRxcj068525;
        Fri, 8 Jul 2022 06:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657279679;
        bh=+cjIkzcAUeJCDXeJLK7xoOIL/3yaylxgHyw3XoY/wLc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WVJGkWvCQJ08+etbIb0l8fFpCpwaZVCTTmi7k3HwV5T3wvf3YOOfyZ+uEBi37/Qxg
         LRjOu8AC44ZQNr2hvtFuGf6BxkP2tDVYqnMivgko0hM1MXNztOCmS8k36FsNXb6mRB
         OCHKDEPm9vvyXrNd1IhU1zSwsT+NLYoW9jO1V9y8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 268BRxvG029618
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jul 2022 06:27:59 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 8
 Jul 2022 06:27:59 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 8 Jul 2022 06:27:59 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 268BRw71091358;
        Fri, 8 Jul 2022 06:27:59 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <devicetree@vger.kernel.org>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <j-choudhary@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am64-main: Enable crypto accelerator
Date:   Fri, 8 Jul 2022 16:57:55 +0530
Message-ID: <20220708112755.105642-3-j-choudhary@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220708112755.105642-1-j-choudhary@ti.com>
References: <20220708112755.105642-1-j-choudhary@ti.com>
MIME-Version: 1.0
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

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

Add the node for SA2UL.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
[s-anna@ti.com: drop label, minor cleanups]
Signed-off-by: Suman Anna <s-anna@ti.com>
[j-choudhary@ti.com: drop rng-node, change flag to shared]
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index ada00575f0f2..dd2848cd0740 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1308,4 +1308,16 @@
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
 	};
+
+	crypto: crypto@40900000 {
+		compatible = "ti,am64-sa2ul";
+		reg = <0x00 0x40900000 0x00 0x1200>;
+		power-domains = <&k3_pds 133 TI_SCI_PD_SHARED>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x40900000 0x00 0x40900000 0x00 0x30000>;
+		dmas = <&main_pktdma 0xc001 0>, <&main_pktdma 0x4002 0>,
+		       <&main_pktdma 0x4003 0>;
+		dma-names = "tx", "rx1", "rx2";
+	};
 };
-- 
2.17.1

