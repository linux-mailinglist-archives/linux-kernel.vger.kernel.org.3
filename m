Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425BF55F733
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 08:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbiF2G4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 02:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiF2G4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 02:56:14 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BB312E680;
        Tue, 28 Jun 2022 23:56:13 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 5AD931E80D11;
        Wed, 29 Jun 2022 14:55:02 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FcwvYR22CChY; Wed, 29 Jun 2022 14:54:59 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 3534F1E80CDC;
        Wed, 29 Jun 2022 14:54:59 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        anil.gurumurthy@qlogic.com, sudarsana.kalluru@qlogic.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] scsi: bfa: Fix spelling mistake
Date:   Wed, 29 Jun 2022 14:56:07 +0800
Message-Id: <20220629065607.24213-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change 'Mangement' to 'Management'.
Change 'paramater' to 'parameter'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 drivers/scsi/bfa/bfa_fc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/bfa/bfa_fc.h b/drivers/scsi/bfa/bfa_fc.h
index 0314e4b9e1fb..8f4573c48bf2 100644
--- a/drivers/scsi/bfa/bfa_fc.h
+++ b/drivers/scsi/bfa/bfa_fc.h
@@ -218,8 +218,8 @@ enum {
 	FC_ELS_FAN = 0x60,	/* Fabric Address Notification */
 	FC_ELS_RSCN = 0x61,	/* Reg State Change Notification */
 	FC_ELS_SCR = 0x62,	/* State Change Registration. */
-	FC_ELS_RTIN = 0x77,	/* Mangement server request */
-	FC_ELS_RNID = 0x78,	/* Mangement server request */
+	FC_ELS_RTIN = 0x77,	/* Management server request */
+	FC_ELS_RNID = 0x78,	/* Management server request */
 	FC_ELS_RLIR = 0x79,	/* Registered Link Incident Record */
 
 	FC_ELS_RPSC = 0x7D,	/* Report Port Speed Capabilities */
@@ -462,7 +462,7 @@ struct fc_rsi_s {
 };
 
 /*
- * structure for PRLI paramater pages, both request & response
+ * structure for PRLI parameter pages, both request & response
  * see FC-PH-X table 113 & 115 for explanation also FCP table 8
  */
 struct fc_prli_params_s {
-- 
2.34.1

