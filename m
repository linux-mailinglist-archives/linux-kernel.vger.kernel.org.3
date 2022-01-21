Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CE7495FA4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 14:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380670AbiAUNRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 08:17:40 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:51221 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346124AbiAUNRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 08:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642771054; x=1674307054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3aLq+6t34WawSD7x49jHw5NnHLDsUbXrYRwccy4TZv0=;
  b=eRPlDvcgTdiFjdLiotJkvLlpHavPm4ho+7CP3HTS7yT9ei7rxID9UFiw
   gsbPSTKbnGOsfLR9U5OjNnJxFk+2pWuZQ+KYkNmzhYG5fF0krdytYSQkt
   jZ/fQ9o0M/ijFD3UEjT/zKHd48ygjigg2Hs/2SVVRJMKEnjLDFQlDUQDr
   j+FjAqCoKd6IWxy7G3dHHlX95IW1oXR3vR+ToC0pN8nA1cX1tEKYlKtus
   iQ2imE7umjqZa25EigfRDvCmxa/boNssRBDBtGjvPr5Brju9ZPyddF2F7
   jb1YPv+yagJeHJwJfxKwQtX4S+6cEzDH0CkY/4lWcq3zY8lo0Vp5DHOdR
   w==;
IronPort-SDR: H01MhyBaMOfYI8uW02iFw6vkq+2T6VFRst/c21MSGibH6A0ThfY6K9MEv8bnPmdJVPeDcDFkCM
 ZApBHhUJcCsrhgzv9BxfJ1F3+Ly90OUS1hsq2W2wkLr+LIscS3cKsoqVsQ4fz4JCrJ+lJmnCGr
 t4t2WJhuYoSBR90uY/8shp8XaKXG/cVvI738NmoZiHi3+MHyzGDC1WZPv0z/rStgDoTLJPkVxI
 Ukis1MFUPWJRtHaKSwh679mHCaQ0SwjGEUOE7dMTQ7gBrcdA4H/ivId2z7uhE2kagqjpZZh0gr
 zEBT13Dmj+ko+Nwmxkhb69FL
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="151005063"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2022 06:17:34 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 21 Jan 2022 06:17:33 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 21 Jan 2022 06:17:17 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <robh+dt@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <jacopo+renesas@jmondi.org>, <hverkuil-cisco@xs4all.nl>
CC:     <nicolas.ferre@microchip.com>, <sakari.ailus@iki.fi>,
        <laurent.pinchart@ideasonboard.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v4 10/11] ARM: configs: at91: sama7: add xisc and csi2dc
Date:   Fri, 21 Jan 2022 15:14:15 +0200
Message-ID: <20220121131416.603972-11-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121131416.603972-1-eugen.hristev@microchip.com>
References: <20220121131416.603972-1-eugen.hristev@microchip.com>
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

