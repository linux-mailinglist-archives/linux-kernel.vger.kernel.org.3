Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBA45181B8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbiECJ4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 05:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbiECJ4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 05:56:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073CE34B99;
        Tue,  3 May 2022 02:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651571578; x=1683107578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Iy7Cqe1rd4eJUoJHEF/V0I7xBTknOl4DOUWOohz8XY8=;
  b=dWxD6hHsBrz9hyUDUPlPRem/iD2PhSE3xdREPuMW1Bq1M6wzAjDOPBZU
   yyV8uhSODx0ZXUo2kZEk+AgoBpdWqr7uhQ872wckPP+6px9FnKrxdiY3o
   hc2MTMLIdLXebB7Zb+9NKM/DNJy6yJUoV1mS0NNEuaiaEqX54e59DxNex
   hKX8utuxkrcV+RkxtPiN2r8Pqvod1/La/Z4PM4ksu0yMumJO55fL8kHHG
   vL0OVKRQJtPbAdkTsirsNZIxzk3NLaeOay8Rc5Sd1TDtsFsJ2a6EoViIB
   Oyut7aw7W6Tmop82vPQnK6d/s8e04lwy2H0vI/BNHbJn+gZinwadPcPXm
   g==;
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="171747261"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 May 2022 02:52:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 3 May 2022 02:52:57 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 3 May 2022 02:52:45 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <hverkuil@xs4all.nl>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <claudiu.beznea@microchip.com>, <nicolas.ferre@microchip.com>,
        <jacopo@jmondi.org>, Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v10 5/5] ARM: multi_v7_defconfig: add atmel video pipeline modules
Date:   Tue, 3 May 2022 12:51:27 +0300
Message-ID: <20220503095127.48710-6-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220503095127.48710-1-eugen.hristev@microchip.com>
References: <20220503095127.48710-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 6e0c8c19b35c..621bd1cbaf7c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -662,7 +662,10 @@ CONFIG_VIDEO_S5P_MIPI_CSIS=m
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

