Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456F149F3B2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242569AbiA1Gbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 01:31:36 -0500
Received: from out0.migadu.com ([94.23.1.103]:35322 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231443AbiA1Gbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:31:35 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1643351490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3gnu0gdUvBhRaPzRgWwozfOSkEi2aAueuxwsAfheSTk=;
        b=KYWk2o5JWUGAkVF0GHFkw5Poqrmk7jJabD0+MCLgupFsA/OTk6FUHUVCaEYC6ki5seYDcs
        sOtVAGrsRIZTZ1wySRe6yBVkwl1d1uTINOgM3LE6eL+Ln16lwYKlU0n/li3oQnzWZZreC4
        FbP1UwMjARGZPC9EhxklWbbv0CzvLTo=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Saurav Kashyap <skashyap@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: bnx2fc: Fix typo in comments
Date:   Fri, 28 Jan 2022 14:31:01 +0800
Message-Id: <20220128063101.6953-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'Offlaod' with 'Offload'.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 drivers/scsi/bnx2fc/bnx2fc_tgt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_tgt.c b/drivers/scsi/bnx2fc/bnx2fc_tgt.c
index 9200b718085c..2c246e80c1c4 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_tgt.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_tgt.c
@@ -482,7 +482,7 @@ void bnx2fc_rport_event_handler(struct fc_lport *lport,
 		}
 
 		/*
-		 * Offlaod process is protected with hba mutex.
+		 * Offload process is protected with hba mutex.
 		 * Use the same mutex_lock for upload process too
 		 */
 		mutex_lock(&hba->hba_mutex);
-- 
2.25.1

