Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE5C4B455C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242757AbiBNJPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:15:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242727AbiBNJPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:15:38 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A57606CF;
        Mon, 14 Feb 2022 01:15:30 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V4OcSXd_1644830123;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V4OcSXd_1644830123)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 14 Feb 2022 17:15:28 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     rafael@kernel.org
Cc:     pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] block: Fix non-kernel-doc comment
Date:   Mon, 14 Feb 2022 17:15:22 +0800
Message-Id: <20220214091522.100669-1-jiapeng.chong@linux.alibaba.com>
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

Fixes the following W=1 kernel build warning:

kernel/power/swap.c:120: warning: This comment starts with '/**', but
isn't a kernel-doc comment. Refer
Documentation/doc-guide/kernel-doc.rst.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/power/swap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 6c4f983cbacc..91fffdd2c7fb 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -88,7 +88,7 @@ struct swap_map_page_list {
 	struct swap_map_page_list *next;
 };
 
-/**
+/*
  *	The swap_map_handle structure is used for handling swap in
  *	a file-alike way
  */
@@ -116,7 +116,7 @@ struct swsusp_header {
 
 static struct swsusp_header *swsusp_header;
 
-/**
+/*
  *	The following functions are used for tracing the allocated
  *	swap pages, so that they can be freed in case of an error.
  */
@@ -170,7 +170,7 @@ static int swsusp_extents_insert(unsigned long swap_offset)
 	return 0;
 }
 
-/**
+/*
  *	alloc_swapdev_block - allocate a swap page and register that it has
  *	been allocated, so that it can be freed in case of an error.
  */
@@ -189,7 +189,7 @@ sector_t alloc_swapdev_block(int swap)
 	return 0;
 }
 
-/**
+/*
  *	free_all_swap_pages - free swap pages allocated for saving image data.
  *	It also frees the extents used to register which swap entries had been
  *	allocated.
-- 
2.20.1.7.g153144c

