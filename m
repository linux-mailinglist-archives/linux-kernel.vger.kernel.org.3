Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F4057D51C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 22:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbiGUUuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbiGUUt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:49:57 -0400
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A258FD5D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 13:49:57 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id Ed7FomcBioEdDEd7FoD0CQ; Thu, 21 Jul 2022 22:49:55 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 21 Jul 2022 22:49:55 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     akpm@linux-foundation.org, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        ocfs2-devel@oss.oracle.com
Subject: [PATCH v2 3/3] ocfs2: Fix a typo in a comment
Date:   Thu, 21 Jul 2022 22:49:48 +0200
Message-Id: <4d4a6786e8ad522bfad6d2401b7f6634f8af0e5d.1658436259.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658436259.git.christophe.jaillet@wanadoo.fr>
References: <cover.1658436259.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/heartbaet/heartbeat

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v1 -> v2
- this patch is new in the serie
---
 fs/ocfs2/heartbeat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/heartbeat.c b/fs/ocfs2/heartbeat.c
index dd29d60af154..22da768e65b7 100644
--- a/fs/ocfs2/heartbeat.c
+++ b/fs/ocfs2/heartbeat.c
@@ -2,7 +2,7 @@
 /*
  * heartbeat.c
  *
- * Register ourselves with the heartbaet service, keep our node maps
+ * Register ourselves with the heartbeat service, keep our node maps
  * up to date, and fire off recovery when needed.
  *
  * Copyright (C) 2002, 2004 Oracle.  All rights reserved.
-- 
2.34.1

