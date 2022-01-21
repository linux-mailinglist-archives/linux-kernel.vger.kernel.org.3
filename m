Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D1F495FA9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 14:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380680AbiAUNSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 08:18:05 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:63052 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380671AbiAUNSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 08:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642771084; x=1674307084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qOvatQr5WCLEOLjwEcdohe5rtMIJkAtFL76rRB+2+9U=;
  b=1ZxnREiM5oZZRiRvJWNcxPWKPpRffnOv1KtUBI/Yl9+q4vlluYTEIr2Y
   cR4NE0nnyGiel8u5PySLynelWNPsUOq5AQEDSWiKYMMi66PO80TmcF8L4
   iNNeESkl5iNJrrZP1dOrpKDT+j07h2JminqsUu8Jkj/yspgrS0AMuzaCQ
   DEC88/cQZLmfN/hv/TX1p8VNWhivR264gsfViKB2hIsDXGG124Pa46yEW
   VjYFEn3AIGmd2RHx5Hq9fQQt9tx64HmYxvWEv0L9g2gQk/QAYtVQYs1zS
   QxpGXgLw99RObs6gPZjWGWjy7beZMYgbtRSfma83SqCDEEmIgFeuDbAEY
   g==;
IronPort-SDR: SCVNfW1izcTIts47DTWKP58xQQsbnjbq4awxmWKrXY3Qv5hQx94Di/rGvrQxItDJnwKuVHI3rA
 KJLzFPcDS1f3WaFcno8nHzi1rRpZQus12qC4FacRvOCcRFank75Q79XwF6TiVIMEwJq+h3nY+B
 3GsnP+bK7ui7CSF1+bWq7HmpazAIF74RJfjrWR7XwjrO79A0WNE4lYzbQ6VniEQNCMXkWZAmLT
 v1G4Cpwyjtb2U3Y6XIkOQ/sgu18AI+57xArRJBDOY4aJvnaey9odVGYYjFctZKNpoR3t9nwL8S
 Cq8HBdCxkuC3/hC3pTTZgj+K
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="159519917"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2022 06:18:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 21 Jan 2022 06:18:02 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 21 Jan 2022 06:17:35 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <robh+dt@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <jacopo+renesas@jmondi.org>, <hverkuil-cisco@xs4all.nl>
CC:     <nicolas.ferre@microchip.com>, <sakari.ailus@iki.fi>,
        <laurent.pinchart@ideasonboard.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v4 11/11] ARM: multi_v7_defconfig: add atmel video pipeline modules
Date:   Fri, 21 Jan 2022 15:14:16 +0200
Message-ID: <20220121131416.603972-12-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121131416.603972-1-eugen.hristev@microchip.com>
References: <20220121131416.603972-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add drivers for the atmel video capture pipeline: atmel isc, xisc and
microchip csi2dc.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index c951aeed2138..92b7749a6df8 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -638,7 +638,10 @@ CONFIG_VIDEO_S5P_MIPI_CSIS=m
 CONFIG_VIDEO_EXYNOS_FIMC_LITE=m
 CONFIG_VIDEO_EXYNOS4_FIMC_IS=m
 CONFIG_VIDEO_RCAR_VIN=m
+CONFIG_VIDEO_ATMEL_ISC=m
+CONFIG_VIDEO_ATMEL_XISC=m
 CONFIG_VIDEO_ATMEL_ISI=m
+CONFIG_VIDEO_MICROCHIP_CSI2DC=m
 CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_SAMSUNG_S5P_JPEG=m
 CONFIG_VIDEO_SAMSUNG_S5P_MFC=m
-- 
2.25.1

