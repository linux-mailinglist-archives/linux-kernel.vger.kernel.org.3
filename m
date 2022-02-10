Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D4D4B02B5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbiBJB7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:59:18 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbiBJB6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:58:01 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8512AA1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:49:26 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V41QR40_1644454130;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V41QR40_1644454130)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Feb 2022 08:48:51 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] mm/munlock: Fix kernel-doc formatting issues
Date:   Thu, 10 Feb 2022 08:48:49 +0800
Message-Id: <20220210004849.69017-1-yang.lee@linux.alibaba.com>
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

Some functions had kernel-doc that used a hash instead of a colon to
separate the parameter name from the one line description.

Replacing them to remove warnings found by running scripts/kernel-doc,
which is caused by using 'make W=1'.

mm/mlock.c:218: warning: Function parameter or member 'page' not
described in 'mlock_page'
mm/mlock.c:240: warning: Function parameter or member 'page' not
described in 'mlock_new_page'
mm/mlock.c:260: warning: Function parameter or member 'page' not
described in 'munlock_page'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 mm/mlock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index d50d48961b22..7fb97e1242f1 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -212,7 +212,7 @@ bool need_mlock_page_drain(int cpu)
 
 /**
  * mlock_page - mlock a page already on (or temporarily off) LRU
- * @page - page to be mlocked, either a normal page or a THP head.
+ * @page: page to be mlocked, either a normal page or a THP head.
  */
 void mlock_page(struct page *page)
 {
@@ -234,7 +234,7 @@ void mlock_page(struct page *page)
 
 /**
  * mlock_new_page - mlock a newly allocated page not yet on LRU
- * @page - page to be mlocked, either a normal page or a THP head.
+ * @page: page to be mlocked, either a normal page or a THP head.
  */
 void mlock_new_page(struct page *page)
 {
@@ -254,7 +254,7 @@ void mlock_new_page(struct page *page)
 
 /**
  * munlock_page - munlock a page
- * @page - page to be munlocked, either a normal page or a THP head.
+ * @page: page to be munlocked, either a normal page or a THP head.
  */
 void munlock_page(struct page *page)
 {
-- 
2.20.1.7.g153144c

