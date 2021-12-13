Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E73472E38
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238469AbhLMN42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:56:28 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:42943 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbhLMN4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:56:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639403785; x=1670939785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iDn38qLLDUVzDvTio1pAkVFXjv/LkdzY3CQPYibDNMo=;
  b=EjzQOICIRz1Cf0SkXy35Vj8uEUufeZsouefWT8xXuERrcaTRaSOyJ6+4
   IgtS7D/9cviugsuk4RWEwlojd3fZ7OAsoRSMU/mMKIHU7p1hwIqYMbCI9
   eLL6tLIU26tbO2v+gAHrhItuKIvxUNj8Ho5sMUwUNjfjLd1DOBEtNY1GO
   mOFqW1VbQAds4KC1mbkaSyMdHMt0xDHZahcEjzEPwTsmgHTpkjPYbbl+e
   4jQ2F677X/lcu/+QEQeMZakqNjo9w1FXf59bBbJzFucTXDtg2v0yyt0Y6
   Ftq3O/+uQLdiEubZW+xkfBf07y//FWyKTwTfdZ2nSLmvvNXHpOF8zRzBG
   Q==;
IronPort-SDR: U9Qlkx4hNKHN2vlf/UQY5UNvVdzcfwF+r1vkhtLSyf0CzKfErmR5vRCIjBkb/7KoLSME6gOMvK
 +i9AigUBCIwQQUVd1dpbI8jKnfqJmyyUZ76+MRi6TXFXQcyjFGXwtwKh/wYvicIl4Qx/VxmWtv
 t4sIVh9Y7id37VGdIXjRUYHeW5c68wzVBqt0aVFsCQB6gSqtOjT+UITcfSGaoqplrwiFPC2517
 nBgbcWMw88ejsisnXx3hyKVKmKSpKJZS2rozYXs8w+C5T220KviqRzT3lT49gqN14S0H1dnY3O
 QDAU7sj9iwlehLf2dYSYtswl
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="155270362"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 06:56:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 06:56:24 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 13 Dec 2021 06:56:10 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <robh+dt@kernel.org>,
        <jacopo@jmondi.org>, <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@iki.fi>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <nicolas.ferre@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v3 22/23] media: atmel: atmel-isc: compact the controller formats list
Date:   Mon, 13 Dec 2021 15:49:39 +0200
Message-ID: <20211213134940.324266-23-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213134940.324266-1-eugen.hristev@microchip.com>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compact the list array to be more readable.
No other changes, only cosmetic.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
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

