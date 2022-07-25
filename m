Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564D1583F07
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbiG1MkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238776AbiG1MkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:40:20 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520B8AE46
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:40:16 -0700 (PDT)
X-QQ-mid: bizesmtp91t1659012012t0y43ff9
Received: from localhost.localdomain ( [171.223.98.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 28 Jul 2022 20:40:11 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: aBJFcW+uBGZX9wMCknQ/5ckaQFvKAWGd3lp+EgFlFy0U/4Ay/lNI3w6SQ/+eZ
        u6kXaYD7ILIEUpZeePl5hOjv7ijjT6DzHeVFbujQ63HGDxUHj6szdNqGQI57WHvnXXqZd0U
        ejoL0M625Tj19nbb6bfPq0PaDlAYzrfqxiLQ3MbfO0rMH1aYRkXUlMF6Rw1gTrGCgWkwEda
        dArcu34ctwJ8CSMe8Ir9P4Lu3HHK7W8HaChhmrkU2f9STFWpHk2Om02j0k+VbZob+OzoJ62
        tXzDZaxHL80g93rG8RaE7eG6ef5gYQS+R4OYQRCWblTe8Z3N3pQPVVS45bRbgTCA3D4KeUU
        jkOxXuWQhVezJLCDB9sa9oiIgHxKC9tTsfY4dl1ZZssguvm35cLWtTz6ozRiJoop4uyMJFY
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     phillip@squashfs.org.uk
Cc:     linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] squashfs: Fix comment typo
Date:   Mon, 25 Jul 2022 12:38:18 +0800
Message-Id: <20220725043818.7230-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `as' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 fs/squashfs/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/squashfs/cache.c b/fs/squashfs/cache.c
index 5062326d0efb..5595797c5178 100644
--- a/fs/squashfs/cache.c
+++ b/fs/squashfs/cache.c
@@ -22,7 +22,7 @@
  * It should be noted that the cache is not used for file datablocks, these
  * are decompressed and cached in the page-cache in the normal way.  The
  * cache is only used to temporarily cache fragment and metadata blocks
- * which have been read as as a result of a metadata (i.e. inode or
+ * which have been read as a result of a metadata (i.e. inode or
  * directory) or fragment access.  Because metadata and fragments are packed
  * together into blocks (to gain greater compression) the read of a particular
  * piece of metadata or fragment will retrieve other metadata/fragments which
-- 
2.35.1

