Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A09595BB8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiHPMWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbiHPMW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:22:26 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6103130F4D
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:22:21 -0700 (PDT)
X-QQ-mid: bizesmtp74t1660652523tm3jfi3j
Received: from localhost.localdomain ( [182.148.12.144])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 16 Aug 2022 20:22:02 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: znfcQSa1hKYowTww0p/VVWTvue5+lI/HhL65loV0AfLRhNqdD+rDan9bknwz7
        SO2dU1AsH2Fe7UuGyd/nNxOz45ml9YkotMrq0E/zIzhhr/zFBisJlFjYM6YkS8MPk9+th/z
        k0vsF3onuKo/HGn9q0JJZTEbgVBl2gWP5SNZELO6EO1DRXstdfF2byD6PID8/YCn5Ekc4SU
        g1njnL2hbzG6D7/yWQA1NJY3JpUKiZ32mWRrjVHb8tLQ+1pxGFdZpmgB1Je3ZAIbuM89dhr
        xFS4LQ1YA2aFqGMVpdTFxsfQ3NvdGJxKKqlW8CJ5J3bjrlreGqNdW+Wom5QrhY1m0sWw03v
        CWIzkUsBUAhANUPNWjPCdhlXRmY+NmqCcu0CGIMn/1oMqLWP7XBjXEIrHcag9nQRUVKw5ez
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     dhowells@redhat.com, marc.dionne@auristor.com
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] fs/afs: fix repeated words in comments
Date:   Tue, 16 Aug 2022 20:21:55 +0800
Message-Id: <20220816122155.770-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'that'.
 Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 fs/afs/cell.c  | 2 +-
 fs/afs/flock.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 07ad744eef77..a7b94208cce5 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -227,7 +227,7 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
  * @excl:	T if an error should be given if the cell name already exists.
  *
  * Look up a cell record by name and query the DNS for VL server addresses if
- * needed.  Note that that actual DNS query is punted off to the manager thread
+ * needed.  Note that actual DNS query is punted off to the manager thread
  * so that this function can return immediately if interrupted whilst allowing
  * cell records to be shared even if not yet fully constructed.
  */
diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index c4210a3964d8..801fe305878f 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -152,7 +152,7 @@ static void afs_next_locker(struct afs_vnode *vnode, int error)
 }
 
 /*
- * Kill off all waiters in the the pending lock queue due to the vnode being
+ * Kill off all waiters in the pending lock queue due to the vnode being
  * deleted.
  */
 static void afs_kill_lockers_enoent(struct afs_vnode *vnode)
-- 
2.36.1

