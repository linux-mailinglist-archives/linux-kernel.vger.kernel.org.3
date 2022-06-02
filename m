Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015A153B36F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiFBGV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiFBGVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:21:22 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9CD188E42
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:21:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VF9F.26_1654150876;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VF9F.26_1654150876)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Jun 2022 14:21:17 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] mm: Fix one kernel-doc comment
Date:   Thu,  2 Jun 2022 14:21:16 +0800
Message-Id: <20220602062116.61199-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove one warning found by running scripts/kernel-doc,
which is caused by using 'make W=1'.
mm/page_isolation.c:304: warning: Function parameter or member
'skip_isolation' not described in 'isolate_single_pageblock'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 mm/page_isolation.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index d200d41ad0d3..9d73dc38e3d7 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -286,6 +286,8 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * @flags:			isolation flags
  * @gfp_flags:			GFP flags used for migrating pages
  * @isolate_before:	isolate the pageblock before the boundary_pfn
+ * @skip_isolation:	the flag to skip the pageblock isolation in second
+ *			isolate_single_pageblock()
  *
  * Free and in-use pages can be as big as MAX_ORDER-1 and contain more than one
  * pageblock. When not all pageblocks within a page are isolated at the same
-- 
2.20.1.7.g153144c

