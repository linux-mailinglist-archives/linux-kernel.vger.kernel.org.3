Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93E0472E19
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbhLMNyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:54:13 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:49251 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhLMNyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:54:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639403651; x=1670939651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qOvatQr5WCLEOLjwEcdohe5rtMIJkAtFL76rRB+2+9U=;
  b=OuALwX3p/RR58JJLFpz0vw3+1vhL9hqC29CozQ5w8heS4drqDQJxTU7o
   lXkeLsJ0a4nHika77ZexwCCiH+BWmscWmcgVYzgRuSfZ40d/Hu5Fkko2l
   oYrXKm2s55iwQ6Z1C9duycjDK0vMUlHnBT6ERO1Fh2+LP70DL/rKiM7xj
   k6PrJjktsgXlZ5PX8XiIm9R/4BEX9c1oWQwKOi2/xEsO4kJUCvAfwJocy
   g1VYZXIbELlDBgZGQI/CVF1akbtSsR+EgRnaB6XsVrj3SkTBfHOHYKdB3
   MwK8gUz2alcyd+Ov7TPKnn/n7bJDlwPLZKRFjxITvfs4qTiV0a0LgLZYW
   w==;
IronPort-SDR: Ymmv/LRqnni8jZS0P9O/k5mXjWDllb7FpkIfx4kztAhNaPNWjNj0E4nDYlD7xbcVIAL5uZYHKL
 ZNgu5YEIGPC7Dd+XTrcU3UXwmT/WE1nxY8Zm8gCKOdQsK9pt6Z4q4Pl0o/UuwyakfRsJw+2wPe
 Xp7BSkDxYGKdTYmj5UvRMSAC0gHr0hTTEfxgoMfA8vhRZULxPjBWTYZA3IBEqcq4/c2KFDvqi3
 MOmVu+wtjZswrnIVljeeA9Y/MjM8ZZtqfeaEWF0eR9ec5UJtmzF6yPeyEZARs5YVeGT1GZoG05
 QAuPuqIOidzfUFa2rC7RH3yH
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="79361849"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 06:54:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 06:54:09 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 13 Dec 2021 06:53:42 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <robh+dt@kernel.org>,
        <jacopo@jmondi.org>, <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@iki.fi>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <nicolas.ferre@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v3 15/23] ARM: multi_v7_defconfig: add atmel video pipeline modules
Date:   Mon, 13 Dec 2021 15:49:32 +0200
Message-ID: <20211213134940.324266-16-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213134940.324266-1-eugen.hristev@microchip.com>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
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

