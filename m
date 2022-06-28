Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCC255E60F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348092AbiF1PP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348103AbiF1PP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:15:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5189F3190C;
        Tue, 28 Jun 2022 08:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656429317; x=1687965317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LEsflcyVfhw7OuN1kmNKDveU6IFbC/8KIJgDXAVZUU0=;
  b=BNVp958DLFRBhKF2RpZLehHNXUhM16uQ6y/nE/ffHCMALnn7tJPG9rew
   iuuHMgn+MbxZbDb9YrKaXnZdQiNfpYz2d9KZ7dcsh6jxFVf0VPMaApn5t
   OoQWcq9VX/IPNzK+yEWZ43fNeXRi5GsNd10B56Vvwh5Nb1ATyqt2tuNNf
   vOBoSPKg51mv+SlzK8P9HoTdr/pqEUBGuKgvpgEgCEq2sIMBikaygb55Y
   ucYxaaVLsxdBCKxLCwic9PTrDPz7LciQ5IbTClf08JC14CPj3Y6OLz0C8
   sp6wqMBB5odvuLkd4kpobTfyFff+y8Y6pC4lbkceu0uTfVJ9/NcpZglaX
   g==;
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="179860215"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2022 08:15:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 28 Jun 2022 08:15:08 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 28 Jun 2022 08:15:05 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 16/19] dt-bindings: iio: adc: at91-sama5d2_adc: add id for temperature channel
Date:   Tue, 28 Jun 2022 18:16:28 +0300
Message-ID: <20220628151631.3116454-17-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220628151631.3116454-1-claudiu.beznea@microchip.com>
References: <20220628151631.3116454-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

