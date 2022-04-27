Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EF65122DB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbiD0TkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbiD0Tjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:39:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10BE2618
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:36:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5545E61B66
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 19:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC287C385AA;
        Wed, 27 Apr 2022 19:36:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1njnSp-002Ioh-Ou;
        Wed, 27 Apr 2022 15:36:39 -0400
Message-ID: <20220427193639.603914965@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Apr 2022 15:36:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Rix <trix@redhat.com>
Subject: [for-next][PATCH 01/21] tracing: Cleanup double word in comment
References: <20220427193623.529296556@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'is' and 'to'.

Link: https://lkml.kernel.org/r/20220207131216.2059997-1-trix@redhat.com

Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/pid_list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
index a2ef1d18126a..95106d02b32d 100644
--- a/kernel/trace/pid_list.c
+++ b/kernel/trace/pid_list.c
@@ -118,9 +118,9 @@ static inline unsigned int pid_join(unsigned int upper1,
 /**
  * trace_pid_list_is_set - test if the pid is set in the list
  * @pid_list: The pid list to test
- * @pid: The pid to to see if set in the list.
+ * @pid: The pid to see if set in the list.
  *
- * Tests if @pid is is set in the @pid_list. This is usually called
+ * Tests if @pid is set in the @pid_list. This is usually called
  * from the scheduler when a task is scheduled. Its pid is checked
  * if it should be traced or not.
  *
-- 
2.35.1
