Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0747B4BA24B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241693AbiBQOBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:01:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241675AbiBQOBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:01:36 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4E72B0B05;
        Thu, 17 Feb 2022 06:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645106482; x=1676642482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jUmH2oh1/zhKA8uW9ugTgURaA0thp3pCRTkRTiYZ7ys=;
  b=u1+lZfFtnPbn3XI3kkP+CDtOTjMYdULC1piWM5XvK+KjxBAH8SvjZN+a
   15ndN4SSNqH8TFrSFBE7UPyiDCKnvCr2pfL85kUddFLJRhbIF4dZyduc1
   mPzd2XoFy++Q29fXyKgdXc9tQTBlz7odfDSTzBn5RKYtyH+ZCDHkr2jH5
   j0nZmKGo+wpVtFWbh815X3smZiYx+6+c+KYD9qxQGVJ7SLKNeMt/gK0q8
   miRl+oA8TY8lTLXoM2GHorLBvMXhtTHbidOpYid3QPYF02Ja1YOWELNDY
   mDHt9OMlW2gCM1fhYAK0LIilpgPa0l1eo8PSC0qfwK1N3uS3gDKm8PfPu
   g==;
IronPort-SDR: avoL3Fkb3v7KmMWIOTnQgg4iGkD9FjrS5bULFxvMZNKsBizS6UYMIkiD6skpAwnN78gcIe62xd
 xGMaMuFGGss3vpD3qZlL5CO+Ong7EIUzybSajOdaELLWLnhNnnmYOIWcg29KT6Ziu9KCvQ+qwi
 +pqil+SGcwickBV1mdLKQsj5U59/mfCcCeGxR8nRZPLP70HIXWnYTs8/HFOhzLZOeOXDjQ3QVS
 0SdCfu5dgYeKmgkg8D2RptPUljwP9Wwr2EIjCa1X1vUo5I2N57BVNzIkhWbc/+t74aSuZL6sOF
 rHSgwIYNCPgnnq+8EFKS6M7C
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="149064613"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2022 07:01:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 17 Feb 2022 07:01:21 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 17 Feb 2022 07:01:14 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <jacopo@jmondi.org>,
        <hverkuil-cisco@xs4all.nl>, <nicolas.ferre@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <claudiu.beznea@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v5 13/13] ARM: multi_v7_defconfig: add atmel video pipeline modules
Date:   Thu, 17 Feb 2022 15:56:45 +0200
Message-ID: <20220217135645.1427466-14-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217135645.1427466-1-eugen.hristev@microchip.com>
References: <20220217135645.1427466-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

