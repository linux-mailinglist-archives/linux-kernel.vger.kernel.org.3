Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A177F495F97
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 14:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380628AbiAUNQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 08:16:26 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:4288 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350614AbiAUNQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 08:16:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642770984; x=1674306984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=inbCfOApjHcZj6rPnStLuoDA+QTiQF8O+NIL6iLwJf0=;
  b=r9nUmOjhp1/ZcXNat+J+N2oQN5ez/mURoOQgOCFZbmtuP3lZa1I57zQ6
   5BuJSUt8ziZRWEaKZiscALJgizfcjyd3nU86evQ1hUZC/pTuJQYGHQ8cQ
   h2uXlZ8ezLqBR15LSm7951SI/OECjC8zHihElpRBoVvZcqEzx/KqSa4Ca
   uD8XoOcCXFgMde7JV/Cb7kJzq9Pw1CJCP4bqFmDdXjWZ4XAV7HPFugvi/
   TCZZqM7xpNp4RXniPH41wMBaHkNlJXkyg/tl6k04tugLbznHFz+nvVfU8
   7WkzyBE+5dX9AscO/eDaT4ooVBRpyMVuN5kh2s2INrkpuH/8MH58dkLLQ
   A==;
IronPort-SDR: l0lvAG1NJJMfWXGsMk0PdirAfQeRzOONF4gI9+jDEw5ih2QTFOUUI2ea1vrvn08aHn3M0LSzcG
 lbiaBvuwuVggANeONqDSOikdhRzZfiHj3baZGod+Ocyetu9BguJWk9g3hSxXL+Z5tCKhvz9UH+
 SNxrh/Z4RGmRKg6T+ggHscAeg5dFBAPogD8rPpROMDG/E2HBn6I3tEkcLdrQGJIy8LmPJsNJ2A
 u8wr5GM+jROxAU2+ohyCOAq1Hz9jO+iZCfD19H25cEa2KvZlCohepPNOR+lATAAnVCg3Ylk3mB
 hAX55+17FGyC7nlZNRDMLVsD
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="143468689"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2022 06:16:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 21 Jan 2022 06:16:23 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 21 Jan 2022 06:15:59 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <robh+dt@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <jacopo+renesas@jmondi.org>, <hverkuil-cisco@xs4all.nl>
CC:     <nicolas.ferre@microchip.com>, <sakari.ailus@iki.fi>,
        <laurent.pinchart@ideasonboard.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v4 06/11] media: atmel: atmel-isc: compact the controller formats list
Date:   Fri, 21 Jan 2022 15:14:11 +0200
Message-ID: <20220121131416.603972-7-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121131416.603972-1-eugen.hristev@microchip.com>
References: <20220121131416.603972-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compact the list array to be more readable.
No other changes, only cosmetic.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 .../media/platform/atmel/atmel-sama5d2-isc.c  | 51 ++++++----------
 .../media/platform/atmel/atmel-sama7g5-isc.c  | 60 +++++++------------
 2 files changed, 37 insertions(+), 74 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
index 025c3e8a7e95..d96ee3373889 100644
--- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
@@ -60,56 +60,39 @@
 static const struct isc_format sama5d2_controller_formats[] = {
 	{
 		.fourcc		= V4L2_PIX_FMT_ARGB444,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_ARGB555,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_RGB565,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_ABGR32,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_XBGR32,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_YUV420,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_YUYV,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_YUV422P,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_GREY,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_Y10,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SBGGR8,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SGBRG8,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SGRBG8,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SRGGB8,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SBGGR10,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SGBRG10,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SGRBG10,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SRGGB10,
 	},
 };
diff --git a/drivers/media/platform/atmel/atmel-sama7g5-isc.c b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
index 9dc75eed0098..e07ae188c15f 100644
--- a/drivers/media/platform/atmel/atmel-sama7g5-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
@@ -63,65 +63,45 @@
 static const struct isc_format sama7g5_controller_formats[] = {
 	{
 		.fourcc		= V4L2_PIX_FMT_ARGB444,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_ARGB555,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_RGB565,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_ABGR32,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_XBGR32,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_YUV420,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_UYVY,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_VYUY,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_YUYV,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_YUV422P,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_GREY,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_Y10,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_Y16,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SBGGR8,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SGBRG8,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SGRBG8,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SRGGB8,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SBGGR10,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SGBRG10,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SGRBG10,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SRGGB10,
 	},
 };
-- 
2.25.1

