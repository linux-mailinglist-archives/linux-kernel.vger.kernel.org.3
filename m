Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF2E4CA9C4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237309AbiCBQDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiCBQDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:03:31 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD8B24BC3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646236967; x=1677772967;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=npHMTjUnOkZYuNlkeHcg6+79O+0BJRy+nrEnrknYqJE=;
  b=Oir6b8KEheK1eRxew7XYEQZ8tdb5ulBChExZc+OS9wmBsaxKdZu1AUaZ
   DHJiFRfd6DAKnBtdaLAEoJBGnvXE/lGiEXun2s5DiDSMOv4DB/0rctRdH
   tEBHZW8ViTCdQbo/gj+qTa0RL4oqCo0SHE2W8CbcnfHzrmEgokUFzlwY+
   KYajRO+QzQui+9mQb5MB8nhtOrNaDriEaVVaj2csIjVDP7DKKJZwtWvgw
   rkJF6SPBX2Q4CeWDijspCCSWfBC/UJXj5qNwZdltVLeumR1yyckgJrsmt
   K0iiyWvAW6MzV9wAEn9CwnahdrU+jQgwPbGTGNkhMh7bqgvP062ES3MKQ
   g==;
X-IronPort-AV: E=Sophos;i="5.90,149,1643698800"; 
   d="scan'208";a="155439111"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2022 09:02:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 2 Mar 2022 09:02:44 -0700
Received: from ness.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 2 Mar 2022 09:02:43 -0700
From:   <nicolas.ferre@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH] ARM: dts: at91: sam9x60ek: modify vdd_1v5 regulator to vdd_1v15
Date:   Wed, 2 Mar 2022 17:02:35 +0100
Message-ID: <20220302160235.28336-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
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

From: Mihai Sain <mihai.sain@microchip.com>

This regulator is powering the vddcore pins from MPU.
Its real value on the board and in the MPU datasheet is 1.15V.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/boot/dts/at91-sam9x60ek.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
index b1068cca4228..7719ea3d4933 100644
--- a/arch/arm/boot/dts/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
@@ -48,11 +48,11 @@ vdd_1v8: fixed-regulator-vdd_1v8@0 {
 			status = "okay";
 		};
 
-		vdd_1v5: fixed-regulator-vdd_1v5@1 {
+		vdd_1v15: fixed-regulator-vdd_1v15@1 {
 			compatible = "regulator-fixed";
-			regulator-name = "VDD_1V5";
-			regulator-min-microvolt = <1500000>;
-			regulator-max-microvolt = <1500000>;
+			regulator-name = "VDD_1V15";
+			regulator-min-microvolt = <1150000>;
+			regulator-max-microvolt = <1150000>;
 			regulator-always-on;
 			status = "okay";
 		};
-- 
2.32.0

