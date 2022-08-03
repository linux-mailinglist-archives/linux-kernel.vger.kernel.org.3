Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10128588A80
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbiHCK3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237817AbiHCK2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:28:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80A35A3D3;
        Wed,  3 Aug 2022 03:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659522450; x=1691058450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LEsflcyVfhw7OuN1kmNKDveU6IFbC/8KIJgDXAVZUU0=;
  b=i4BUOuSo9EXi6X9fKh6NhcZ+aE3DEeBbuhQb0WViSw0CKsrVMffT7Xu4
   Poi3+ZTCE1BBeT4rWcZYrdbQax0vmXf5LRAK+Si4QbZzZ7rk8FCT4baB0
   5g3fihrO1orPfkCuJIpu6BaFZLpuCVVoPeJftDwiGnaGsfZfYeHD/70bi
   i4BxnNIQu4MYEXNsjJAAN+OlVk8VpyfgDcCC0lYlmrdutZqyKoLmzjmy0
   ryE6NsCrTqHoW/OZrcwv5jb4Z0j8CpBgRwSmNRfO1QEQqTTxGv765/3GB
   GUD9TfAtCuYd1Qv4Jfsvz/A1PTWnrULAF8lM6O/XET0l6bVb4C8ZVa/7S
   w==;
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="170757353"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Aug 2022 03:27:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 03:27:29 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 03:27:26 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 16/19] dt-bindings: iio: adc: at91-sama5d2_adc: add id for temperature channel
Date:   Wed, 3 Aug 2022 13:28:52 +0300
Message-ID: <20220803102855.2191070-17-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220803102855.2191070-1-claudiu.beznea@microchip.com>
References: <20220803102855.2191070-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ID for temperature channel of AT91 SAMA5D2 ADC.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/iio/adc/at91-sama5d2_adc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/iio/adc/at91-sama5d2_adc.h b/include/dt-bindings/iio/adc/at91-sama5d2_adc.h
index 70f99dbdbb42..866d36530583 100644
--- a/include/dt-bindings/iio/adc/at91-sama5d2_adc.h
+++ b/include/dt-bindings/iio/adc/at91-sama5d2_adc.h
@@ -13,4 +13,7 @@
 /* pressure channel index */
 #define AT91_SAMA5D2_ADC_P_CHANNEL		26
 
+/* SAMA7G5 Temperature sensor channel index. */
+#define AT91_SAMA7G5_ADC_TEMP_CHANNEL		31
+
 #endif
-- 
2.34.1

