Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A424C3ABD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbiBYBIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiBYBIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:08:47 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A5C11EF0C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:08:13 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V5QpB06_1645751290;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V5QpB06_1645751290)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Feb 2022 09:08:11 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] mm/pagewalk: remove unneeded semicolon
Date:   Fri, 25 Feb 2022 09:08:09 +0800
Message-Id: <20220225010809.125947-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:
./mm/pagewalk.c:459:35-36: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 mm/pagewalk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index fdfea080c5ff..53e5c145fcce 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -456,7 +456,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 		} else { /* inside vma */
 			walk.vma = vma;
 			next = min(end, vma->vm_end);
-			vma = find_vma(mm, vma->vm_end);;
+			vma = find_vma(mm, vma->vm_end);
 
 			err = walk_page_test(start, next, &walk);
 			if (err > 0) {
-- 
2.20.1.7.g153144c

