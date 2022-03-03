Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC30D4CC190
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbiCCPie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbiCCPi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:38:27 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C00DFAC;
        Thu,  3 Mar 2022 07:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646321858; x=1677857858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=inbCfOApjHcZj6rPnStLuoDA+QTiQF8O+NIL6iLwJf0=;
  b=TvrNN7H1tkiKSiGVHXJH2L6X4rI305txZx+4aMli7Dz1y45dyrRtN/WR
   cVzTEnr18cl/Jsv9evsmF52O9NeKEq2JNIQwT+K5eDT2AaPpkbB2Zcszv
   lQWPEmY7z6iFBSeMeE2X/x/L9uABJf4mPVr2VpDJuKqnfwFiEKd2+9a14
   k3SNa0X34Vm4W+70bofHzTTTIu88I5HqU3HN0eXJzlQOA/S5BIPOBZ1vD
   FYNgn7xuUicDu0AU1NivwwQlgbn8RfnudHBZ44nRwT3EdXmuCMDxOgHVw
   P12bBEDOTIUi/cypDSz0rK9HqSw2kscGequPa3JRM/O+GjmRY40QF65Tf
   w==;
X-IronPort-AV: E=Sophos;i="5.90,151,1643698800"; 
   d="scan'208";a="150738031"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Mar 2022 08:37:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 3 Mar 2022 08:37:36 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 3 Mar 2022 08:37:32 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <jacopo@jmondi.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <claudiu.beznea@microchip.com>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH v6 07/13] media: atmel: atmel-isc: compact the controller formats list
Date:   Thu, 3 Mar 2022 17:36:12 +0200
Message-ID: <20220303153618.2084156-8-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220303153618.2084156-1-eugen.hristev@microchip.com>
References: <20220303153618.2084156-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

