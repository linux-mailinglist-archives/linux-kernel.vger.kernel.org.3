Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5C14BB6AE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 11:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbiBRKRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 05:17:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbiBRKQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:16:42 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A277438BE;
        Fri, 18 Feb 2022 02:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645179386; x=1676715386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S+uT64mp+Afl3y2BOOq/0yNH7TCGPfhkbQO12u0O5o8=;
  b=HX1zRDpAzn7gpWf9PKtPVHe9nIAATFxK3GGGGJUsXPQeywa9nVdg/Oy0
   vTSXXDARxClePCKUnx8aWcHd4eNFvy+w60XLWGpGztcYEBgA0JdQNsFNU
   LELxYdeILtBKorXFmbpWwBPXe4IA2I/ugu/2jmvXLdDlSaH0MlKYtRPOy
   s6QDZmO4ZdS8bn30NtPEY5RimWyHF07Sodsmarm+7XmW0tSgiWyASMIju
   5T2yyXYbS8epyiFBXpJ4yd0IR4PRW6h7dxnc3rbqO3d9ETTFhsEH5AOxX
   8Z6HzzPi4WIugj9SNBCkH95Exd126ajFfDqNoPNGFKgYBLu/+bVIG/c19
   w==;
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="149200699"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Feb 2022 03:16:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 18 Feb 2022 03:16:25 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 18 Feb 2022 03:16:22 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mpm@selenic.com>, <herbert@gondor.apana.org.au>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-crypto@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 7/7] hwrnd: atmel - remove extra line
Date:   Fri, 18 Feb 2022 12:17:12 +0200
Message-ID: <20220218101712.530576-8-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220218101712.530576-1-claudiu.beznea@microchip.com>
References: <20220218101712.530576-1-claudiu.beznea@microchip.com>
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

Remove extra line.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/char/hw_random/atmel-rng.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/hw_random/atmel-rng.c b/drivers/char/hw_random/atmel-rng.c
index b662d44a09a6..b8effe77d80f 100644
--- a/drivers/char/hw_random/atmel-rng.c
+++ b/drivers/char/hw_random/atmel-rng.c
@@ -165,7 +165,6 @@ static int atmel_trng_remove(struct platform_device *pdev)
 {
 	struct atmel_trng *trng = platform_get_drvdata(pdev);
 
-
 	atmel_trng_cleanup(trng);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-- 
2.32.0

