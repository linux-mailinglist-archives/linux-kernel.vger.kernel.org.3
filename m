Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3082F46EA1A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238719AbhLIOkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:40:51 -0500
Received: from mga11.intel.com ([192.55.52.93]:56674 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231363AbhLIOku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:40:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="235621907"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="235621907"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 06:37:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="612518972"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 09 Dec 2021 06:37:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7E5F94C7; Thu,  9 Dec 2021 16:37:21 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v1 3/3] ata: sata_dwc_460ex: Remove unused forward declaration
Date:   Thu,  9 Dec 2021 16:35:19 +0200
Message-Id: <20211209143519.60498-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211209143519.60498-1-andriy.shevchenko@linux.intel.com>
References: <20211209143519.60498-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sata_dwc_port_stop() is not used before being defined,
remove redundant forward declaration.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/sata_dwc_460ex.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 5421f74c0199..bd4859563796 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -185,7 +185,6 @@ static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag);
 static int sata_dwc_qc_complete(struct ata_port *ap, struct ata_queued_cmd *qc,
 				u32 check_status);
 static void sata_dwc_dma_xfer_complete(struct ata_port *ap, u32 check_status);
-static void sata_dwc_port_stop(struct ata_port *ap);
 static void sata_dwc_clear_dmacr(struct sata_dwc_device_port *hsdevp, u8 tag);
 
 #ifdef CONFIG_SATA_DWC_OLD_DMA
-- 
2.33.0

