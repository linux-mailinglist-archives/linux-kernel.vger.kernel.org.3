Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A85504F9F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbiDRMBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 08:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiDRMBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 08:01:11 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B28C1929E;
        Mon, 18 Apr 2022 04:58:31 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23IBwMjU049774;
        Mon, 18 Apr 2022 06:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650283102;
        bh=40Ngx4Pv4wSweCX1SRjdVfe8o99TDlani6CGjMT90cA=;
        h=From:To:CC:Subject:Date;
        b=r8o8itffMszj91f38GEwyKdNkYdx+LsdUL3NoPhwArFlMx4ChhfkgcNZHPTFDY6bk
         b5GNsBodMIV/VfWpWQdkF5tOZ08RskdqsymsR6hpwp3noXNL4Su9AMP61jW6I0Ie1Y
         TPn+myADnkWBpRDvGU8F72DJNlpQGK4RaMEQE4lo=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23IBwMqk020246
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Apr 2022 06:58:22 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 18
 Apr 2022 06:58:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 18 Apr 2022 06:58:22 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23IBwJEH110643;
        Mon, 18 Apr 2022 06:58:19 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: ti: k3-am62: Add support for MCAN
Date:   Mon, 18 Apr 2022 17:28:01 +0530
Message-ID: <20220418115802.5672-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM62 SoC has one instance of MCAN in main domain. However, its
corresponding CAN signals are not brought out through a transceiver, on the
SK board. Therefore, add the device tree node in the main dt file and set
the status to disabled in the SK board dts file.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---

Notes:
- This patch applies on top of,
  https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=632573

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 14 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts   |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 4b6ba98dd0a2..8bb42fe24d7c 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -530,4 +530,18 @@
 		ti,mbox-num-users = <4>;
 		ti,mbox-num-fifos = <16>;
 	};
+
+	main_mcan0: can@20701000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x20701000 0x00 0x200>,
+		      <0x00 0x20708000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 98 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 98 6>, <&k3_clks 98 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index a0ea2cc66b31..3d7166e17d05 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -475,3 +475,7 @@
 		};
 	};
 };
+
+&main_mcan0 {
+	status = "disabled";
+};
-- 
2.17.1

