Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7060D518007
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 10:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbiECItt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 04:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbiECItT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 04:49:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83242B27B;
        Tue,  3 May 2022 01:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651567547; x=1683103547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a5xkrWJu+gSiZzGorL0TWhGz25+bfDvivW5NHRlKG7g=;
  b=nkmkgoW3OY1LnK3poESwCQFyRj/9dJ9tWwflriJjntlRTbQ/Hst33xB7
   lTlwjcn479YDbcyrft6Mp+fjtQ+TDDgK1rkGIexuCNPX8zpnKRksbWkRI
   7YKDVodpQeXouSZmqFQktmwbjmSLF9ieYhCfuc/8BBzThcwlpnLpfFDBu
   v3bvi3fOwSDky5PNSBK0eYE23/LItmJJyJ53YJYlaGkJCiHep17Rz4AiA
   vO67YLydrAMFFqJluGAf1S+jB+5UxE1VYqiVIhvX5xNnuVfwG9fL/FMn1
   j17fF2GmcQRLhf70G8uAzbKKca39C/AHv1a8YVfeUfHvhSsmCSUmseBN1
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="94358273"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 May 2022 01:45:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 3 May 2022 01:45:46 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 3 May 2022 01:45:39 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <hverkuil@xs4all.nl>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jacopo@jmondi.org>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v10 7/8] media: atmel: atmel-sama7g5-isc: remove stray line
Date:   Tue, 3 May 2022 11:44:20 +0300
Message-ID: <20220503084421.40682-8-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220503084421.40682-1-eugen.hristev@microchip.com>
References: <20220503084421.40682-1-eugen.hristev@microchip.com>
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

Remove stray line from formats struct.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/media/platform/atmel/atmel-sama7g5-isc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/atmel/atmel-sama7g5-isc.c b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
index 5a9db6f41056..83b175070c06 100644
--- a/drivers/media/platform/atmel/atmel-sama7g5-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
@@ -205,7 +205,6 @@ static struct isc_format sama7g5_formats_list[] = {
 		.mbus_code	= MEDIA_BUS_FMT_Y10_1X10,
 		.pfe_cfg0_bps	= ISC_PFG_CFG0_BPS_TEN,
 	},
-
 };
 
 static void isc_sama7g5_config_csc(struct isc_device *isc)
-- 
2.25.1

