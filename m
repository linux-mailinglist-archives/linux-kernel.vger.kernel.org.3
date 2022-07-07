Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C96B569A82
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbiGGGZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbiGGGZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:25:28 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655D610B0;
        Wed,  6 Jul 2022 23:25:25 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2676PMXr079999;
        Thu, 7 Jul 2022 01:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657175122;
        bh=qrw4XVHNrZye88ZfJWhQes3lr/b67tipTURWg7X+C7s=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=xLz609ID3ShAlW+cV/s8V8RfRl8dve2KDau5fwxE7SUhdpYtsSTbRtihJv5eQ2iEj
         Ee1Hvp/6ny20dOj5voCgOEOeXIX8pT1YbZZuZO8rw1SkUsNR0+f6ZT3eYvumtpCudN
         1LmcU65Mzldeyq9EplUvjANXWdQs4a/lykTqoEYs=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2676PH7N047414
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jul 2022 01:25:22 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 7
 Jul 2022 01:25:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 7 Jul 2022 01:25:17 -0500
Received: from ubuntu.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2676P51V106842;
        Thu, 7 Jul 2022 01:25:16 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH RESEND 4/6] arm64: dts: ti: k3-j721s2-common-proc-board: Enable SERDES0
Date:   Wed, 6 Jul 2022 23:25:01 -0700
Message-ID: <20220707062503.295663-5-mranostay@ti.com>
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

Configure first lane to PCIe, the second lane to USB and the last two lanes
to eDP. Also, add sub-nodes to SERDES0 DT node to represent SERDES0 is
connected to PCIe.

Acked-by: Matt Ranostay <mranostay@ti.com>
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 .../dts/ti/k3-j721s2-common-proc-board.dts    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index b210cc07c539..791f235bd95f 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -9,6 +9,9 @@
 
 #include "k3-j721s2-som-p0.dtsi"
 #include <dt-bindings/net/ti-dp83867.h>
+#include <dt-bindings/phy/phy-cadence.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/mux/ti-serdes.h>
 
 / {
 	compatible = "ti,j721s2-evm", "ti,j721s2";
@@ -350,6 +353,25 @@ &cpsw_port1 {
 	phy-handle = <&phy0>;
 };
 
+&serdes_ln_ctrl {
+	idle-states = <J721S2_SERDES0_LANE0_PCIE1_LANE0>, <J721S2_SERDES0_LANE1_USB>,
+		      <J721S2_SERDES0_LANE2_EDP_LANE2>, <J721S2_SERDES0_LANE3_EDP_LANE3>;
+};
+
+&serdes_refclk {
+	clock-frequency = <100000000>;
+};
+
+&serdes0 {
+	serdes0_pcie_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <1>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_PCIE>;
+		resets = <&serdes_wiz0 1>;
+	};
+};
+
 &mcu_mcan0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_mcan0_pins_default>;
-- 
2.36.1

