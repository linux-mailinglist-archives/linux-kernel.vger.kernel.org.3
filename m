Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E74658BB1E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 15:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbiHGNzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 09:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbiHGNzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 09:55:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E95A45B
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 06:55:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2DD1B80AB2
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 13:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1176C433D6;
        Sun,  7 Aug 2022 13:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659880504;
        bh=qRUXjSow7MzhEUAHylcw5jllRhRjqsPkHTLZm3pFqNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IbgQNXE6sB3nvt84xPrDS2uJI4mW2g9pkS7nMcSy8HUmTxjjqNLVPrlGyXrEJbsVW
         pRg9xIQiy3KA1ZsrHOM2rLkcPrhaYR5KMlQvTKQYPqGF3h52uA1tQLBdqannHl+v1j
         uNW6qBmpwteDdA1lhVkR+rGj2tXNVlvmGIAj8ePnFdJZ9uRAXVN0qRwbjZ6gH2YcjR
         fRMMp2PW6i1OdOhdqLyTn/YHDWDltKtZSk2hV4YcFYjY7KZyl9k6ysKxqsUy2nwh0E
         Tw4qsQ3YM0BNuSXjRVIBTftIhlRF4OP8gb0+F8WsOAPWpkqLmzK4rgBIOzKipNQhd7
         Fxl45QAhmxd+g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 6/6] habanalabs: remove secured PCI IDs
Date:   Sun,  7 Aug 2022 16:54:52 +0300
Message-Id: <20220807135452.1219894-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220807135452.1219894-1-ogabbay@kernel.org>
References: <20220807135452.1219894-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Secured PCI ID will not be supported in new asics because the
security status can always be read from the f/w.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs_drv.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index d59d8cdf33e6..8026793d9083 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -58,14 +58,12 @@ MODULE_PARM_DESC(boot_error_status_mask,
 #define PCI_IDS_GAUDI_SEC		0x1010
 
 #define PCI_IDS_GAUDI2			0x1020
-#define PCI_IDS_GAUDI2_SEC		0x1030
 
 static const struct pci_device_id ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_HABANALABS, PCI_IDS_GOYA), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_HABANALABS, PCI_IDS_GAUDI), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_HABANALABS, PCI_IDS_GAUDI_SEC), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_HABANALABS, PCI_IDS_GAUDI2), },
-	{ PCI_DEVICE(PCI_VENDOR_ID_HABANALABS, PCI_IDS_GAUDI2_SEC), },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, ids);
@@ -95,9 +93,6 @@ static enum hl_asic_type get_asic_type(u16 device)
 	case PCI_IDS_GAUDI2:
 		asic_type = ASIC_GAUDI2;
 		break;
-	case PCI_IDS_GAUDI2_SEC:
-		asic_type = ASIC_GAUDI2_SEC;
-		break;
 	default:
 		asic_type = ASIC_INVALID;
 		break;
@@ -110,7 +105,6 @@ static bool is_asic_secured(enum hl_asic_type asic_type)
 {
 	switch (asic_type) {
 	case ASIC_GAUDI_SEC:
-	case ASIC_GAUDI2_SEC:
 		return true;
 	default:
 		return false;
-- 
2.25.1

