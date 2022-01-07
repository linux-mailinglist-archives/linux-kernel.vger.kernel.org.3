Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE46487B5D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 18:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240232AbiAGR0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 12:26:02 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:49627 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232166AbiAGR0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 12:26:00 -0500
X-IronPort-AV: E=Sophos;i="5.88,270,1635174000"; 
   d="scan'208";a="106368109"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 08 Jan 2022 02:25:58 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id DF1BC40BA839;
        Sat,  8 Jan 2022 02:25:56 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Pavel Machek <pavel@denx.de>,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: rzg2l_adc: Fix typo
Date:   Fri,  7 Jan 2022 17:25:29 +0000
Message-Id: <20220107172529.12361-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo RZG2L_ADSMP_DEFUALT_SAMPLING -> RZG2L_ADSMP_DEFAULT_SAMPLING.

Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 32fbf57c362f..aa56cd2e3de2 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -55,7 +55,7 @@
 #define RZG2L_ADCR(n)			(0x30 + ((n) * 0x4))
 #define RZG2L_ADCR_AD_MASK		GENMASK(11, 0)
 
-#define RZG2L_ADSMP_DEFUALT_SAMPLING	0x578
+#define RZG2L_ADSMP_DEFAULT_SAMPLING	0x578
 
 #define RZG2L_ADC_MAX_CHANNELS		8
 #define RZG2L_ADC_CHN_MASK		0x7
@@ -395,7 +395,7 @@ static int rzg2l_adc_hw_init(struct rzg2l_adc *adc)
 	reg &= ~RZG2L_ADM3_ADIL_MASK;
 	reg &= ~RZG2L_ADM3_ADCMP_MASK;
 	reg &= ~RZG2L_ADM3_ADSMP_MASK;
-	reg |= (RZG2L_ADM3_ADCMP_E | RZG2L_ADSMP_DEFUALT_SAMPLING);
+	reg |= (RZG2L_ADM3_ADCMP_E | RZG2L_ADSMP_DEFAULT_SAMPLING);
 	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
 
 exit_hw_init:
-- 
2.17.1

