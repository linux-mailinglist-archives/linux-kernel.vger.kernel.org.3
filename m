Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDEF544658
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242312AbiFIInZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242380AbiFIIlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:41:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E26440E69;
        Thu,  9 Jun 2022 01:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654764028; x=1686300028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Oaa6POuTrFoq1Nmz2rF5KjdgtPVUEHRqWrgwki6jQ5E=;
  b=Z2btZrDIRvEtqHVoo2hUsJ0+3Ft6WQkj3m1w1FRncRtzxIzW2UZdMzUr
   s1WBWZt/wYAwVJ5Owz2XnZIZU0TYTdq9xoF2hDjsLr4pdYRUTYluvDS12
   LRRSNaaVENSolBdiEQEe2fG12cvxHaA9QYWUjbVSKNghvCmXARKFHVHrs
   FEwo6uJg1faO67hVbFkyd3jZ+XYl0dljbWXsvmQ6ul+82SeXy5hbh5YLc
   Shl0ENqcRWZ/oXrEWCPD60C4+Wcrlx8xhT/HOarmtMhHdIbadgPVPsHMC
   C3Sm+xxlt/yORXD4qhc2IYfAzfZDjGqhg6Rr2OxOxaCbtin9sNph4pS18
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="167405374"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2022 01:40:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Jun 2022 01:40:26 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 9 Jun 2022 01:40:23 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <broonie@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <tudor.ambarus@microchip.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/3] spi: atmel-quadspi: align condition to parenthesis
Date:   Thu, 9 Jun 2022 11:42:46 +0300
Message-ID: <20220609084246.1795419-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220609084246.1795419-1-claudiu.beznea@microchip.com>
References: <20220609084246.1795419-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align condition to parenthesis.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/spi/atmel-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index dea8a0311aaa..976a217e356d 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -286,7 +286,7 @@ static bool atmel_qspi_supports_op(struct spi_mem *mem,
 
 	/* special case not supported by hardware */
 	if (op->addr.nbytes == 2 && op->cmd.buswidth != op->addr.buswidth &&
-		op->dummy.nbytes == 0)
+	    op->dummy.nbytes == 0)
 		return false;
 
 	return true;
-- 
2.34.1

