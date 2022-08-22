Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C01C59CC81
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 01:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238858AbiHVXuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 19:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238813AbiHVXuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:50:16 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B3E4E850;
        Mon, 22 Aug 2022 16:50:15 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27MNo7Ox077649;
        Mon, 22 Aug 2022 18:50:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661212207;
        bh=fbVO4NP2sIrSso7zoeE9WQzLJAcQcbsiy+0DRhSvl4E=;
        h=From:To:CC:Subject:Date;
        b=uSPPtHmr1WaMl24NuJjzgDilCFWXM94kVVgWiGsd8WUFws42HyPt+1kYv6cfM2Bme
         LhF5fsuJXMa+eONAJS23TwN2heMo5OsHiiAHtB7j79Bhr4VrTJm2fvG+QVbwQ6lZLv
         +s2/M9bKzEUItWFgHEEikyZ6wrdTdqp3LTNQpMWk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27MNo7ks033293
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Aug 2022 18:50:07 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 22
 Aug 2022 18:50:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 22 Aug 2022 18:50:06 -0500
Received: from ula0226330.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27MNo6Bk008115;
        Mon, 22 Aug 2022 18:50:06 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j7200-main: Add main domain watchdog entries
Date:   Mon, 22 Aug 2022 18:50:06 -0500
Message-ID: <20220822235006.7081-1-afd@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gowtham Tammana <g-tammana@ti.com>

Add DT entries for main domain watchdog instances.

Signed-off-by: Gowtham Tammana <g-tammana@ti.com>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 16684a2f054d..cf657ac0bd6a 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -739,6 +739,24 @@ main_gpio6: gpio@630000 {
 		clock-names = "gpio";
 	};
 
+	watchdog0: watchdog@2200000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x0 0x2200000 0x0 0x100>;
+		clocks = <&k3_clks 252 1>;
+		power-domains = <&k3_pds 252 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 252 1>;
+		assigned-clock-parents = <&k3_clks 252 5>;
+	};
+
+	watchdog1: watchdog@2210000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x0 0x2210000 0x0 0x100>;
+		clocks = <&k3_clks 253 1>;
+		power-domains = <&k3_pds 253 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 253 1>;
+		assigned-clock-parents = <&k3_clks 253 5>;
+	};
+
 	main_r5fss0: r5fss@5c00000 {
 		compatible = "ti,j7200-r5fss";
 		ti,cluster-mode = <1>;
-- 
2.36.1

