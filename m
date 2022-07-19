Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8873579205
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 06:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbiGSEgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 00:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbiGSEgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 00:36:31 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE65113
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 21:36:26 -0700 (PDT)
X-QQ-mid: bizesmtp67t1658205378tmlnfb24
Received: from harry-jrlc.. ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 12:36:08 +0800 (CST)
X-QQ-SSF: 0100000000600030C000B00A0000020
X-QQ-FEAT: 5sX+F+4VKJq/by0fXtxKmEYorDalB8YGcMY3eazqKZGVLKfxtPmE6TthUJrSf
        M7FfiP42jGwNJOZIvqTS+kmVRitNSTATE73ExENuWO2Cv7dL10V9CjnYu7HUvn0/mzSnMt2
        emvtxj/vnCAb7uMgCPN0CaW1pXAoPAzA9l4W1GFA4v+QCT12HgANd60hl+C/iSxXGLzZUHR
        leQhEzvRvfOx50PvZ+tJ+y0PZNDVDjf/hk0M3AawjaBcobbpoFdHQuYPKQ8snSxn7fSwuYf
        L6Hjsy8TaTv4SAzQCr+vEhq6o/FExPjbtIhqZTG6l3ditNhbfTydw5J1+FnC7gh4u8eQAaZ
        q/j0U6Cq4TVrH3Nuxxp7cyuFJ9JmhPgz7RJMBQ88dKNN/Lebdy6wsyUJ7tkZW5Wv2Hc1fb+
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     anton@tuxera.com
Cc:     linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] treewide:Unneeded semicolon
Date:   Tue, 19 Jul 2022 12:36:05 +0800
Message-Id: <20220719043605.5935-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unneeded semicolon

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 fs/ntfs/lcnalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/lcnalloc.c b/fs/ntfs/lcnalloc.c
index eda9972e6159..66c2b29e09dd 100644
--- a/fs/ntfs/lcnalloc.c
+++ b/fs/ntfs/lcnalloc.c
@@ -899,7 +899,7 @@ s64 __ntfs_cluster_free(ntfs_inode *ni, const VCN start_vcn, s64 count,
 		}
 		/* We have freed @to_free real clusters. */
 		real_freed = to_free;
-	};
+	}
 	/* Go to the next run and adjust the number of clusters left to free. */
 	++rl;
 	if (count >= 0)
-- 
2.30.2

