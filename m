Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C8F55737D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiFWHE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiFWHEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:04:25 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E97044A38;
        Thu, 23 Jun 2022 00:04:16 -0700 (PDT)
X-QQ-mid: bizesmtp88t1655967776tzr1mrq4
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 15:02:51 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000B00A0000000
X-QQ-FEAT: F3yR32iATbg+ZZLfMDZrCgBHXrXDQgig7yVhup0661i+Yv0IN9rThYTKTNS0Z
        5UaiDUCgvzGu0RAEiysLVEATxfp7Z6gZw1oHIesbxMKp0WWft+law+Pid9as6Pq3Ksz+paj
        0BQlyGTl3Dl7BDYy3tzccq/Msm5h/k3cgznvB1HjU95HCuU6wT6TeuEdm1trAxV7VrNAFVt
        EAh48GxXs6C5vwDpkW8aAPqcBGG3khh/DnskBYRE+vKUcLK5VABOFgsH7htwxP+TPgMZXBh
        Q5UcMOaC9OJCBrp6PGXZnx+iDwCdC9ktLEfrchoEK6LKx9W9o8XAr/BVvwIY50SqBCxNdy/
        CcLmR8ulbanDy5c50/wNSpxGO9qTw==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] scsi: mpt3sas: drop unexpected word 'a' in comments
Date:   Thu, 23 Jun 2022 15:02:49 +0800
Message-Id: <20220623070249.9977-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word 'a' in the comments that need to be dropped

file - drivers/scsi/mpt3sas/mpt3sas_base.c
line - 535

* FIXME: this relies on a a zero

changed to:

* FIXME: this relies on a a zero

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 9a1ae52bb621..af41ea53aa7d 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -532,7 +532,7 @@ static void _clone_sg_entries(struct MPT3SAS_ADAPTER *ioc,
 					    (le32_to_cpu(sgel->FlagsLength) &
 					    0x00ffffff));
 					/*
-					 * FIXME: this relies on a a zero
+					 * FIXME: this relies on a zero
 					 * PCI mem_offset.
 					 */
 					sgel->Address =
-- 
2.17.1

