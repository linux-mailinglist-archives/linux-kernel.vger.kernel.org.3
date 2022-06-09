Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CE45445E4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241155AbiFIIbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241150AbiFIIal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:30:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035FA15A3FF;
        Thu,  9 Jun 2022 01:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654763441; x=1686299441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lwNsDeOTZVQub9esWKyv/jU7ahSsIafHFB6O76N6FzU=;
  b=jVdIDe4mSWlEGggZvxBilRDBxqXWEk6VUeQ22vxB+Whwpl8YpwsyHFF9
   tAjszon/bgzXav5S9tBm099phgUBzqipeB1fikfoNAl+0pgt+UNzIgxiT
   nbCokC+/PswAAKQgZLsJ5JGXQwK0lX9V7b2o8T4hx+ZqDTXjv2hDksCTq
   SjPOTOZboTBvGuPbvalEkXCKTnSeo6uZ4/xsK6nYuOQzUxy0aoHUmRjod
   CNj7Y1fA4WMMCprH8gwYB8k2mRQwdtERqP3diCdVAqT65JN6uO4zN3p3P
   NSAeUNuNFSRwJq0+Ct82RmDXZxc0Yv9FHh7SIl8GG8yK4zlP0SK8RUkgj
   g==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="167403713"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2022 01:30:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Jun 2022 01:30:36 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 9 Jun 2022 01:30:33 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <ludovic.desroches@atmel.com>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 12/16] dt-bindings: iio: adc: at91-sama5d2_adc: add id for temperature channel
Date:   Thu, 9 Jun 2022 11:32:09 +0300
Message-ID: <20220609083213.1795019-13-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
References: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ID for temperature channel of AT91 SAMA5D2 ADC.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
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

