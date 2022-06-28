Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E63055CC69
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243378AbiF1CNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 22:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242750AbiF1CNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 22:13:46 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DECA22BF8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 19:13:45 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 275AB1E80CEF;
        Tue, 28 Jun 2022 10:12:44 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id phA5ZvFT4cTr; Tue, 28 Jun 2022 10:12:41 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id E4EBC1E80C3F;
        Tue, 28 Jun 2022 10:12:40 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     akpm@linux-foundation.org, ebiederm@xmission.com,
        roman.gushchin@linux.dev, tytso@mit.edu, longman@redhat.com,
        legion@kernel.org, songmuchun@bytedance.com
Cc:     linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] ipc/mqueue: remove unnecessary (void*) conversions.
Date:   Tue, 28 Jun 2022 10:12:51 +0800
Message-Id: <20220628021251.17197-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary void* type casting.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 ipc/mqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 12ad7860bb88..f98de32aeea1 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -489,7 +489,7 @@ static struct vfsmount *mq_create_mount(struct ipc_namespace *ns)
 
 static void init_once(void *foo)
 {
-	struct mqueue_inode_info *p = (struct mqueue_inode_info *) foo;
+	struct mqueue_inode_info *p = foo;
 
 	inode_init_once(&p->vfs_inode);
 }
-- 
2.11.0

