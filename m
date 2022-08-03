Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C34588A6A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237994AbiHCK1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235896AbiHCK1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:27:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC2333E18;
        Wed,  3 Aug 2022 03:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659522426; x=1691058426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OKZacX0kF35D93Q6lObfeb5ubx4Sti2ysVT4KqZ9r0k=;
  b=l/AFIWABEJxqa1MZeYxHEpAphqHzR99xMsivPjJ4ExUmWbdxuHvRbQSB
   +SXIyzKAHQJ7gXPz5/XbffyMJkvXwAcNIP/p25tAQ9Xl/Neq16WX1WPCI
   di7R7m5ZrcCC3EdUKztKpdBB2v+DJo8QxeD0VKdo7ZADIoqehHIsAN3q4
   ltQ1/0duAUqRu0oTdnA2BEbmELj8/3jlHvaRL50Iir69v5ACg+UYugoAG
   6u3p4fvF+NOtOAtGrwQM0lqFHdOybR4dJcyg8K0DJsrfTVurYq02B57jx
   2PUo23AAiUsHe+/pGxN/ZW+Wyal0uAL/PJTT2fVlWvt3q1VY0dR/VR2Uh
   w==;
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="167621991"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Aug 2022 03:27:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 3 Aug 2022 03:27:03 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 03:27:00 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 08/19] iio: adc: at91-sama5d2_adc: drop AT91_OSR_XSAMPLES defines
Date:   Wed, 3 Aug 2022 13:28:44 +0300
Message-ID: <20220803102855.2191070-9-claudiu.beznea@microchip.com>
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

Drop AT91_OSR_1SAMPLES, AT91_OSR_4SAMPLES, AT91_OSR_16SAMPLES defines
and insted use their values inline.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index ace4cc431a95..fe4bec03bea9 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -304,11 +304,6 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 #define AT91_HWFIFO_MAX_SIZE_STR	"128"
 #define AT91_HWFIFO_MAX_SIZE		128
 
-/* Possible values for oversampling ratio */
-#define AT91_OSR_1SAMPLES		1
-#define AT91_OSR_4SAMPLES		4
-#define AT91_OSR_16SAMPLES		16
-
 #define AT91_SAMA5D2_CHAN_SINGLE(index, num, addr)			\
 	{								\
 		.type = IIO_VOLTAGE,					\
@@ -743,15 +738,15 @@ static int at91_adc_config_emr(struct at91_adc_state *st,
 
 	/* select oversampling ratio from configuration */
 	switch (oversampling_ratio) {
-	case AT91_OSR_1SAMPLES:
+	case 1:
 		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_1SAMPLES,
 					    osr_mask);
 		break;
-	case AT91_OSR_4SAMPLES:
+	case 4:
 		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_4SAMPLES,
 					    osr_mask);
 		break;
-	case AT91_OSR_16SAMPLES:
+	case 16:
 		emr |= AT91_SAMA5D2_EMR_OSR(AT91_SAMA5D2_EMR_OSR_16SAMPLES,
 					    osr_mask);
 		break;
@@ -766,13 +761,13 @@ static int at91_adc_config_emr(struct at91_adc_state *st,
 
 static int at91_adc_adjust_val_osr(struct at91_adc_state *st, int *val)
 {
-	if (st->oversampling_ratio == AT91_OSR_1SAMPLES) {
+	if (st->oversampling_ratio == 1) {
 		/*
 		 * in this case we only have 12 bits of real data, but channel
 		 * is registered as 14 bits, so shift left two bits
 		 */
 		*val <<= 2;
-	} else if (st->oversampling_ratio == AT91_OSR_4SAMPLES) {
+	} else if (st->oversampling_ratio == 4) {
 		/*
 		 * in this case we have 13 bits of real data, but channel
 		 * is registered as 14 bits, so left shift one bit
@@ -1875,9 +1870,9 @@ static IIO_CONST_ATTR(hwfifo_watermark_min, "2");
 static IIO_CONST_ATTR(hwfifo_watermark_max, AT91_HWFIFO_MAX_SIZE_STR);
 
 static IIO_CONST_ATTR(oversampling_ratio_available,
-		      __stringify(AT91_OSR_1SAMPLES) " "
-		      __stringify(AT91_OSR_4SAMPLES) " "
-		      __stringify(AT91_OSR_16SAMPLES));
+		      __stringify(1) " "
+		      __stringify(4) " "
+		      __stringify(16));
 
 static struct attribute *at91_adc_attributes[] = {
 	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
@@ -1973,7 +1968,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 	bitmap_set(&st->touch_st.channels_bitmask,
 		   st->soc_info.platform->touch_chan_p, 1);
 
-	st->oversampling_ratio = AT91_OSR_1SAMPLES;
+	st->oversampling_ratio = 1;
 
 	ret = of_property_read_u32(pdev->dev.of_node,
 				   "atmel,min-sample-rate-hz",
-- 
2.34.1

