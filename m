Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A87754F29F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380301AbiFQIQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiFQIQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:16:51 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79F626830F;
        Fri, 17 Jun 2022 01:16:50 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 90C121E80D95;
        Fri, 17 Jun 2022 16:15:03 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JPidF03qNBeW; Fri, 17 Jun 2022 16:15:00 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: renyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 507DF1E80D72;
        Fri, 17 Jun 2022 16:15:00 +0800 (CST)
From:   Ren Yu <renyu@nfschina.com>
To:     jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        qixu@nfschina.com, hukun@nfschina.com, yuzhe@nfschina.com,
        Ren Yu <renyu@nfschina.com>
Subject: [PATCH] drivers:scsi: fix typo in comment
Date:   Fri, 17 Jun 2022 16:15:57 +0800
Message-Id: <20220617081557.9009-1-renyu@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling mistakes in comment,non-succesfull -> non-successful.

Signed-off-by: Ren Yu <renyu@nfschina.com>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index b519f4b59d30..a8a8c2d969c2 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -5294,7 +5294,7 @@ _scsih_normalize_sense(char *sense_buffer, struct sense_info *data)
 }
 
 /**
- * _scsih_scsi_ioc_info - translated non-succesfull SCSI_IO request
+ * _scsih_scsi_ioc_info - translated non-successful SCSI_IO request
  * @ioc: per adapter object
  * @scmd: pointer to scsi command object
  * @mpi_reply: reply mf payload returned from firmware
-- 
2.11.0

