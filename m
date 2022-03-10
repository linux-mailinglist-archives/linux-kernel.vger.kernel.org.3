Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD3D4D43FC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241050AbiCJJyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241003AbiCJJxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:53:53 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075DDE9C;
        Thu, 10 Mar 2022 01:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646905971; x=1678441971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=inbCfOApjHcZj6rPnStLuoDA+QTiQF8O+NIL6iLwJf0=;
  b=qmJJ6uQq0kKauMzpcWUCC6/zR479/yu4//+sB765AgOB6hQn/BSCJBzl
   OUmWBziMn8409Kj7a3nH5uPYxQjDqxbInAEkgPbsP0gQPSDCQGdMq2fUs
   1HMX+dcb6+eJR6p0u4+2vTiLs/IT9ve7G+59MMVHJBAClbPVhHAexiunw
   27oCijoJiCLnCJbI/wy2qMksT+aLojRM2vDDYWj7kqrnShmLOp//hK7Kn
   0KoDgBlhVJDLIvzQ1QLT5NrKSkN5/V8VvmsWB6RQGcbmVVwjundo5J/Sq
   RpClC4MEamMiCsvPbC3hBohgAVWKHNZ9mOls9cRcrPdD8B5WYJqZvjIQI
   g==;
X-IronPort-AV: E=Sophos;i="5.90,170,1643698800"; 
   d="scan'208";a="148746148"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Mar 2022 02:52:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 10 Mar 2022 02:52:49 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 10 Mar 2022 02:52:43 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <jacopo@jmondi.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <claudiu.beznea@microchip.com>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH v9 07/13] media: atmel: atmel-isc: compact the controller formats list
Date:   Thu, 10 Mar 2022 11:51:56 +0200
Message-ID: <20220310095202.2701399-8-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310095202.2701399-1-eugen.hristev@microchip.com>
References: <20220310095202.2701399-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

