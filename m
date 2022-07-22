Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F7957DF25
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbiGVJsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbiGVJrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:47:36 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA1288B4A1;
        Fri, 22 Jul 2022 02:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=oCUel
        Tv043ICb5AHgO2RDvogVgnSWRF3XguHcIruvNY=; b=XoMEhtct0Gv3iP3hu4OG1
        gzf9WjkShUGmNhOHgrWzfge+udGa7S/8bkQ5B9728VPa9Aq5fH1E0oajpwh9Aqvv
        p08WwQKMMVjnsn1+Ib/Lj3OljYK6KIrrmw5LTNpiQVdR/tenYG68C+axFlt7LFin
        t6EV84e4AizwRi3BUxNlsI=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp4 (Coremail) with SMTP id HNxpCgD3NneAcdpiiaeBQA--.23115S2;
        Fri, 22 Jul 2022 17:44:33 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com, hare@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] scsi: fcoe: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 17:44:29 +0800
Message-Id: <20220722094429.78346-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgD3NneAcdpiiaeBQA--.23115S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUWr4UCFy5Cr18GF1rJFb_yoW3tFgEgw
        4UtrZ2kw18tF97Jw1rtF15ZayIyw40v3Wfur4vg3ySvay5XrsrAw1vvrn5ZrWUK39rXF9r
        Jr1DXr1Fyr47GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtzuX3UUUUU==
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCdQlGZGBbEb1xAAAAs4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
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
2.25.1

