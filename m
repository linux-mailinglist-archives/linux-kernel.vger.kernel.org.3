Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF205549C4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357448AbiFVL43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357293AbiFVL4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:56:20 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86493D1F2;
        Wed, 22 Jun 2022 04:56:13 -0700 (PDT)
X-QQ-mid: bizesmtp68t1655898957tcalen1y
Received: from ubuntu.localdomain ( [223.104.103.173])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 19:55:52 +0800 (CST)
X-QQ-SSF: 01000000008000B0B000B00A0000000
X-QQ-FEAT: RMVj0UrY8cCFOea5C5ARBmv0k7vBcpfkzIQziTBbryMHCxKiCBHSQJn+bq9x9
        GMVbFEThT1NEVg7Wfti3c1hpYxvR1iBZ02eEDPBT9YB+BSIt0gm7oF0IMIoIr9yXx9WtHc3
        UjTWKBSXsESFfZgU2CquUtRbqKniZ2XHcX/etJOHAGvRDLU5LzUJsWoOUAg5UDTKZ2BKVuN
        EjyXSnh3XE+IZbCflWkqht+4WfiyCRXuugQc9ftEqPionE8OFN9eAlJFfh6Oy6VNfWm4Uwh
        Z3SMabF7w68Mazn/h4vLdjPbn6gBtRb0c3CnrZBbjAU/Rc64cGO1P1NPjfeY4TYiWeKyu9o
        0Mswb6s5edJx/nwUdI99Qvq4w7TUR+uMTw799cI
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     hare@suse.de, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] scsi: fcoe: drop unexpected word "the" in the comments
Date:   Wed, 22 Jun 2022 19:55:49 +0800
Message-Id: <20220622115549.14771-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

file: drivers/scsi/fcoe/fcoe_ctlr.c
line: 208

      * age_fcfs are protected by the the fcoe_ctlr's mutex.
changed to:
      * age_fcfs are protected by the fcoe_ctlr's mutex.

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/scsi/fcoe/fcoe_ctlr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 39e16eab47aa..28e8b9f1e1a4 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -205,7 +205,7 @@ static int fcoe_sysfs_fcf_add(struct fcoe_fcf *new)
 		 * that doesn't have a priv (fcf was deleted). However,
 		 * libfcoe will always delete FCFs before trying to add
 		 * them. This is ensured because both recv_adv and
-		 * age_fcfs are protected by the the fcoe_ctlr's mutex.
+		 * age_fcfs are protected by the fcoe_ctlr's mutex.
 		 * This means that we should never get a FCF with a
 		 * non-NULL priv pointer.
 		 */
-- 
2.17.1

