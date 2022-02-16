Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D52D4B826F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiBPH7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:59:20 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiBPH7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:59:18 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA17A14099
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:59:06 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V4c7Ght_1644998322;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V4c7Ght_1644998322)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Feb 2022 15:59:04 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] tracing: Fix kernel-doc
Date:   Wed, 16 Feb 2022 15:58:40 +0800
Message-Id: <20220216075840.63755-1-jiapeng.chong@linux.alibaba.com>
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

Fix the following W=1 kernel warnings:

kernel/trace/trace.c:1181: warning: expecting prototype for
tracing_snapshot_cond_data(). Prototype was for
tracing_cond_snapshot_data() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/trace/trace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7c2578efde26..326d96304b84 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1122,7 +1122,7 @@ void tracing_snapshot_instance(struct trace_array *tr)
 	tracing_snapshot_instance_cond(tr, NULL);
 }
 
-/**
+/*
  * tracing_snapshot - take a snapshot of the current buffer.
  *
  * This causes a swap between the snapshot buffer and the current live
@@ -1144,7 +1144,7 @@ void tracing_snapshot(void)
 }
 EXPORT_SYMBOL_GPL(tracing_snapshot);
 
-/**
+/*
  * tracing_snapshot_cond - conditionally take a snapshot of the current buffer.
  * @tr:		The tracing instance to snapshot
  * @cond_data:	The data to be tested conditionally, and possibly saved
@@ -1163,8 +1163,8 @@ void tracing_snapshot_cond(struct trace_array *tr, void *cond_data)
 }
 EXPORT_SYMBOL_GPL(tracing_snapshot_cond);
 
-/**
- * tracing_snapshot_cond_data - get the user data associated with a snapshot
+/*
+ * tracing_cond_snapshot_data - get the user data associated with a snapshot
  * @tr:		The tracing instance
  *
  * When the user enables a conditional snapshot using
-- 
2.20.1.7.g153144c

