Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A874D36DA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbiCIQxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbiCIQpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:45:46 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4698FE41D;
        Wed,  9 Mar 2022 08:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646844060; x=1678380060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jUmH2oh1/zhKA8uW9ugTgURaA0thp3pCRTkRTiYZ7ys=;
  b=f7vu47/C+VcSO/RxWG+HNzQIaojzQgW+wBpj1190qkEamWhIE9vqwmqs
   20y38i2FyE2Y1q3Gq/i9+7cXcNM6RSxXAjbyhFHOttE27RtNAINKz1SSE
   +suIEmBC2x38kxq37UcMqKOn5ikYtAzBLxX/TvBK9U2FHlQgR7dP05G12
   cDVaTAoMNZXEQm6chMzenIndgc0P5mmq+Pq0C2NTHARKk8jTcNGRk7hvw
   ZEb1TxQlBfYbh9QQHJ8Tf7PU9qJg0tLOif41ECmhN8jLgA+x0RGMztdUf
   NvilZQ8WzmFZ+qyGY94vPA1pmi6Hdz2CcdlegEzVokIBzrjTma+fgsGrK
   g==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643698800"; 
   d="scan'208";a="88382244"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Mar 2022 09:40:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Mar 2022 09:40:42 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 9 Mar 2022 09:40:32 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <jacopo@jmondi.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <claudiu.beznea@microchip.com>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v8 13/13] ARM: multi_v7_defconfig: add atmel video pipeline modules
Date:   Wed, 9 Mar 2022 18:37:58 +0200
Message-ID: <20220309163758.2672727-14-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309163758.2672727-1-eugen.hristev@microchip.com>
References: <20220309163758.2672727-1-eugen.hristev@microchip.com>
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

Add drivers for the atmel video capture pipeline: atmel isc, xisc and
microchip csi2dc.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 8863fa969ede..b768abad8df0 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -639,7 +639,10 @@ CONFIG_VIDEO_S5P_MIPI_CSIS=m
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

