Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB56591BF2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 18:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240011AbiHMQNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 12:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239668AbiHMQNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 12:13:12 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D4AF5B4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 09:13:09 -0700 (PDT)
X-QQ-mid: bizesmtp66t1660407182td40hywb
Received: from localhost.localdomain ( [110.188.55.240])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 14 Aug 2022 00:12:30 +0800 (CST)
X-QQ-SSF: 0100000000000080H000000A0000020
X-QQ-FEAT: 5q30pvLz2idyuLISzKeqUCJTe8R7dCPGHX0v+WntEIyVUWpH7+ce9z3jamIkV
        bblrqdzA2O/OY8Z18lPacq+0hzHF20WEQEwIAsOoe0UUPp5kuiuv0QEGogvQVZLxo5xWIRA
        HD0mM4qbocWb+du9BTKOvo6JjEbk4Ofvt3IjdjdaO6MV27Drh7PukO5Sf3KTfRsppdqh6TB
        O/as+ZWwuxuZSBlHS4C/lrINby/j3OXEMD/lf0u6S7RQzOOenC1oMgYCn6FXm4ZjT6RxhQl
        kG+dFajZgYpJ64Nw8LKZip4VtMRBBv67YCBpxPibO13qNwQaDDf1iEGhqh1+mKf8JiF85CR
        sUn1Ag/9eILMzWi4Jr4QDP3BjAacLQi+PRaCkl1EVBR1vK6/QI=
X-QQ-GoodBg: 0
From:   min tang <tangmin@cdjrlc.com>
To:     anton@tuxera.com
Cc:     linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        min tang <tangmin@cdjrlc.com>
Subject: [PATCH] NTFS: Unneeded semicolon
Date:   Sun, 14 Aug 2022 00:12:20 +0800
Message-Id: <20220813161220.6039-1-tangmin@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no semicolon after '}' in line 902.

Signed-off-by: min tang <tangmin@cdjrlc.com>
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
2.17.1

