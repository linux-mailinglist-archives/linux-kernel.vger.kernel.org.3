Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619D9472E2D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbhLMNzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:55:54 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:42878 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbhLMNzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:55:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639403752; x=1670939752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zZ8vw5n+IADsTxBeKLeMDfqdHRLqoiSyX/5v63a+ngw=;
  b=S5Yi8dCBzqjcDmbm5EKCyU7CUFG82rtc6/tRUBxDjMpsx7mJY5HGoEVS
   6R+8eSQpMKDRdiXYSaYCYHjtiE/xjX8KmjXUjCy17Wg9x8PSta9gDRPMo
   2A5/vKmDennYzb6W56ZFw/IJmzCa1GBbsB/FxZjSCpdCI0DwGQ6e1VUcO
   MaAIGpHWeCk/FZBc4A1rsooaVK9eB37f0YH2NAofjPjamEclNls0b+mVH
   JUfeX+XRABS6JLHk2+CYmVabiOoUoP1U8A1X2Lg96aAw7oF1lqYe+GIxe
   xwPLdwbp3qobvcG+vH+p/4BmLi9A4ZxNmOv77W+UNKfZ5tcbf97IeqBTQ
   Q==;
IronPort-SDR: 6hkhgZnz+l0Bu+SsZdlI27YIJqvw6qDqwsY7QsdUCqp8rSPi+u8wmZln1MHSop0OhIMRPMR2Gn
 3X3qS5uqL12f13+glfYTesvzM6gJihr1SyGZHi+5k05ooldXlqXjX4AgRbh2k4ea3UJi66tprx
 TWEvXkEtwlLvo2v6Rk1Zv94BWJRnaovK5/goxmgY5kfQKbFlGOnJ6d2tJThUiLIjVp/W+De091
 LLvrEjr1Ub3R/vtjSSro3rZSnQUoTxHVfy9QPTuTjTwHAj8OqyCWzEOYR7pmPBJpDCOixrlksm
 DmOzfefTobHspLWxmL5JJpP1
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="155270261"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 06:55:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 06:55:52 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 13 Dec 2021 06:55:42 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <robh+dt@kernel.org>,
        <jacopo@jmondi.org>, <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@iki.fi>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <nicolas.ferre@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v3 20/23] media: atmel: atmel-sama7g5-isc: fix UYVY input format mbus_code typo
Date:   Mon, 13 Dec 2021 15:49:37 +0200
Message-ID: <20211213134940.324266-21-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213134940.324266-1-eugen.hristev@microchip.com>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the mbus code for UYVY input format type to the right color rotation.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/media/platform/atmel/atmel-sama7g5-isc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/atmel/atmel-sama7g5-isc.c b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
index d2ac80b1ccc3..38721bd902e2 100644
--- a/drivers/media/platform/atmel/atmel-sama7g5-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
@@ -188,7 +188,7 @@ static struct isc_format sama7g5_formats_list[] = {
 	},
 	{
 		.fourcc		= V4L2_PIX_FMT_UYVY,
-		.mbus_code	= MEDIA_BUS_FMT_YUYV8_2X8,
+		.mbus_code	= MEDIA_BUS_FMT_UYVY8_2X8,
 		.pfe_cfg0_bps	= ISC_PFE_CFG0_BPS_EIGHT,
 	},
 	{
-- 
2.25.1

