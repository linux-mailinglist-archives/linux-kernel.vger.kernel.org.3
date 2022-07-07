Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2558A56AE08
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236728AbiGGV6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236233AbiGGV6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:58:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB7F5A47D;
        Thu,  7 Jul 2022 14:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657231101; x=1688767101;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5/T7qOJPEL0MkmUxuGXLljoqiSl5+J7fMt/QUylbKvY=;
  b=fjckSr78XiFRo5QSjL6t3Ht8AK+LAwQ1kViul7l5bWfBHOhVtVwfSFAR
   fpAxInOt3p8kHWkCRaBZ4wVLIhCxLrXsR0A4rqefScUUKaAxDFJajhaUQ
   iXttc8vHOKOmR4KVwR/Xic+4Tjxi7B9gsVvxumraYE6p/CpiGmfnV55bY
   o/biSeRrELs8cpw8qe+XrkIgQK+bX+A1Kblt6Vr8e/CMXkZTc8FfI7OCd
   KV0qOQgOa7YE2kVCwE6eBW0HZv0Tq+7KmpLNy80jerh3fgQnwpcO4woVh
   EpadxnhzJkYUV+9AiiRUtbXVPlZgjps2mbJl2tvrT/j/KSpb6fRHYsbnG
   A==;
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="103554639"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jul 2022 14:58:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Jul 2022 14:58:19 -0700
Received: from ryan-Precision-5560.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 7 Jul 2022 14:58:19 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH v3] ARM: dts: at91: sama5d2: Fix typo in i2s1 node
Date:   Thu, 7 Jul 2022 14:58:12 -0700
Message-ID: <20220707215812.193008-1-Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Typo in i2s1 causing errors in dt binding validation.
Changed assigned-parens to assigned-clock-parents and
to match i2s0 node formatting.

Fixes: 1ca81883c557 ("ARM: dts: at91: sama5d2: add nodes for I2S controllers")

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
changes in v2:
-corrected subject and tags
changes in v1:
-corrected formatting issues

 arch/arm/boot/dts/sama5d2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 89c71d419f82..659a17fc755c 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -1124,7 +1124,7 @@ AT91_XDMAC_DT_PERID(33))>,
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 55>, <&pmc PMC_TYPE_GCK 55>;
 				clock-names = "pclk", "gclk";
 				assigned-clocks = <&pmc PMC_TYPE_CORE PMC_I2S1_MUX>;
-				assigned-parrents = <&pmc PMC_TYPE_GCK 55>;
+				assigned-clock-parents = <&pmc PMC_TYPE_GCK 55>;
 				status = "disabled";
 			};
 
-- 
2.34.1

