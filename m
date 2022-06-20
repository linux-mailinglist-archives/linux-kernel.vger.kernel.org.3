Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455F5552675
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 23:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245324AbiFTVcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 17:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243278AbiFTVc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 17:32:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF2C12D32
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 14:32:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2F56B811EC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 21:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704E8C341CB;
        Mon, 20 Jun 2022 21:32:23 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1o3P0Q-003o2N-GK;
        Mon, 20 Jun 2022 17:32:22 -0400
Message-ID: <20220620213222.344762745@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 20 Jun 2022 17:32:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [for-linus][PATCH 3/4] tracefs: Fix syntax errors in comments
References: <20220620213158.468216113@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang wangx <wangxiang@cdjrlc.com>

Delete the redundant word 'to'.

Link: https://lkml.kernel.org/r/20220605092729.13010-1-wangxiang@cdjrlc.com

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index de7252715b12..81d26abf486f 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -553,7 +553,7 @@ struct dentry *tracefs_create_dir(const char *name, struct dentry *parent)
  *
  * Only one instances directory is allowed.
  *
- * The instances directory is special as it allows for mkdir and rmdir to
+ * The instances directory is special as it allows for mkdir and rmdir
  * to be done by userspace. When a mkdir or rmdir is performed, the inode
  * locks are released and the methods passed in (@mkdir and @rmdir) are
  * called without locks and with the name of the directory being created
-- 
2.35.1
