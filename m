Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725A2472E15
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238291AbhLMNxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:53:43 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:24417 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbhLMNxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639403622; x=1670939622;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3aLq+6t34WawSD7x49jHw5NnHLDsUbXrYRwccy4TZv0=;
  b=p5coJjM+kGVAX0ioOY+iDCopSh8OcU8G/XFeLalj66yKKszOoXwor4rl
   Jhdy9reDe6IJZvUp7QRuICTaSLkHhaTbKGiE5oN/4AE7Ukn+3RYags2C9
   pPGdsYIcdGcZKrnPLqS96Olqsby9arz52bMMc3ASUhZJW3av4e701+uj8
   MQmBLkP+wXi4rBo6x8facOnbPxoXdVKCP058Th4zqU0pYgI70EIqts2CU
   S8mQeIQGD/1wrZ2I5JiOvFHmt1DxVfmeA6SpfUowmxJJKnfsBVxk8MH82
   pfMuvMezHLyMBTC8DmyJsKiQJ5P3Woc19eGRjmXNz1mrEdJLiMcpUckn+
   w==;
IronPort-SDR: T5ZMjAAS9yWhOPQl4zbrZbC1MwCeMtFLq804xgZ3RgBiRtZWVtFPkSAlTtzlL9R2uvJ+yNbvob
 rUNWll6emGHTvEkr9pOvOiZ0wsxDb6QE7OnVps76caWgW4ilz2OT5j9H1+cJ7klvDZnoPTfRAZ
 q72uXptuQB1dj0ZvY+nqJTNgCZeiXFjar3/PpIIaiTvXSjPrB/2niKb2kvvxKgAc+mXlA6UKw4
 SS0THcjcYyF8WkD1eHEgvNcPJkQJb5Ts+YgSQNeb2Im12DdNcvx5wLcM2m+pSxdZcBMRpDoiDq
 GuGN7VXZ1dMxhOgLnIjq+yDX
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="146466494"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 06:53:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 06:53:41 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 13 Dec 2021 06:53:19 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <robh+dt@kernel.org>,
        <jacopo@jmondi.org>, <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@iki.fi>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <nicolas.ferre@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v3 14/23] ARM: configs: at91: sama7: add xisc and csi2dc
Date:   Mon, 13 Dec 2021 15:49:31 +0200
Message-ID: <20211213134940.324266-15-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213134940.324266-1-eugen.hristev@microchip.com>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable XISC and CSI2DC drivers.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/configs/sama7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index 938aae4bd80b..15978f2ab4ea 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -126,6 +126,8 @@ CONFIG_MEDIA_SUPPORT_FILTER=y
 CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_MEDIA_PLATFORM_SUPPORT=y
 CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_VIDEO_ATMEL_XISC=y
+CONFIG_VIDEO_MICROCHIP_CSI2DC=y
 CONFIG_VIDEO_IMX219=m
 CONFIG_VIDEO_IMX274=m
 CONFIG_VIDEO_OV5647=m
-- 
2.25.1

