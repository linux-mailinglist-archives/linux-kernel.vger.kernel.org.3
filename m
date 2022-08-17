Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662BB596AC9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbiHQIDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbiHQIDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:03:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1572721;
        Wed, 17 Aug 2022 01:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660723395; x=1692259395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O8uhz61dtWlrbycaCD8YirLLMtkR4Pp1tikfdlsPbqU=;
  b=FSx6/oFNlo9Ts4VYO2o8lYPVwJBbFnLv6+UG+49fKI8wtOdlBnz7pUac
   chZ7v0LhrxDQHukbfb52jM9jNbzUECTUaNPAb6yuouCwpkiIkxkOVlt9p
   p20fQj6+04O2WMwdXlBd866kRtigxnFR6pvD9pd6/ykjv+YrxvrRfF5/S
   nqAmNbawN2YVqoyestDA8yGNdiju/YpJCFp1xpXYS8KUu/oC2ygUZO9S3
   cgthtNu7d8arD5YWYYcrjvb/8u7iABB3AoQNHk/UdhnlcUPev4SlrjodJ
   R0nZeXd8GUouL2byF1iGjUYFlw7xv4mZinrQSY/PCYYMFcgO3KkEnbs3w
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="109399553"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Aug 2022 01:03:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 17 Aug 2022 01:03:08 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 17 Aug 2022 01:03:03 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <admin@hifiphile.com>, <kavyasree.kotagiri@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH 1/5] dt-bindings: mfd: atmel,sama5d2-flexcom: Add SPI child node ref binding
Date:   Wed, 17 Aug 2022 10:55:14 +0300
Message-ID: <20220817075517.49575-2-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220817075517.49575-1-sergiu.moga@microchip.com>
References: <20220817075517.49575-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another functionality of FLEXCOM is that of SPI. In order for
the proper validation of the SPI children nodes through the binding
to occur, the proper binding for SPI must be referenced.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---
 .../devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml       | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
index 568da7cb630c..e158af47c326 100644
--- a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
+++ b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
@@ -78,10 +78,9 @@ patternProperties:
       of USART bindings.
 
   "^spi@[0-9a-f]+$":
-    type: object
+    $ref: ../spi/atmel,at91rm9200-spi.yaml
     description:
-      Child node describing SPI. See ../spi/spi_atmel.txt for details
-      of SPI bindings.
+      Child node describing SPI.
 
   "^i2c@[0-9a-f]+$":
     $ref: ../i2c/atmel,at91sam-i2c.yaml
-- 
2.25.1

