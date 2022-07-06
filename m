Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67EB568EFD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbiGFQWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbiGFQV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:21:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A9827FDF;
        Wed,  6 Jul 2022 09:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657124515; x=1688660515;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9dxRKMclWJPU8zdojzP6bZuaqj6umfAl3NNcbfX/f80=;
  b=un67AWPXt33Pe3Twi/GYjkiOSolk+yewPI0rIoBK9ae8n6YrW1Fzn7RA
   rjMQyDHAxfdHRleAmDzAijUIQKeXJpCcagV0eYjuU9oVL5bm+B3nLrYuO
   E1zPvljdofNgXwj087v+8Ja1If6j3PHJ//XJ3jFHgu57Ry0SWt7MRdL1t
   mW6nY6KqFu6exdBv9wk6ep1uVzMTZbRsCsylSIDwsr+gLKYuiCEEcDmBo
   FVUpfwTlulX/duAlCFqQLMWoGnt0eBk1IcwNXP5o8FZlhGbWjFdLZF+eG
   9cwuhnSO3Hw5IW6Ne6+TG9tJizUIYAL9Fc7WcHeXq0CgXwN58CAhA28b+
   w==;
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="171302345"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jul 2022 09:21:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 6 Jul 2022 09:21:53 -0700
Received: from ryan-Precision-5560.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 6 Jul 2022 09:21:53 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.berna@microchip.com>, <robh+dt@kernel.org>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH v2] Fixes: 1ca81883c557 ("ARM: dts: at91: sama5d2: add nodes for I2S controllers")
Date:   Wed, 6 Jul 2022 09:21:44 -0700
Message-ID: <20220706162144.66831-1-Ryan.Wanner@microchip.com>
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

Fixed typo in i2s1 node

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
Changes since v1:
1. Corrected commit 
---
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

