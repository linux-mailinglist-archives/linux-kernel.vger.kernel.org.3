Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D71757532C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239825AbiGNQoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235769AbiGNQng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:43:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE7D1835C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:43:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3963B8273C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 16:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B224C34114;
        Thu, 14 Jul 2022 16:43:29 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1oC1w0-004lLE-8K;
        Thu, 14 Jul 2022 12:43:28 -0400
Message-ID: <20220714164328.093858818@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 14 Jul 2022 12:42:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [for-next][PATCH 01/23] tracing/user_events: Fix syntax errors in comments
References: <20220714164256.403842845@goodmis.org>
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

Delete the redundant word 'have'.

Link: https://lkml.kernel.org/r/20220606023007.23377-1-wangxiang@cdjrlc.com

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 706e1686b5eb..a6621c52ce45 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -567,7 +567,7 @@ static int user_event_set_call_visible(struct user_event *user, bool visible)
 	 * to allow user_event files to be less locked down. The extreme case
 	 * being "other" has read/write access to user_events_data/status.
 	 *
-	 * When not locked down, processes may not have have permissions to
+	 * When not locked down, processes may not have permissions to
 	 * add/remove calls themselves to tracefs. We need to temporarily
 	 * switch to root file permission to allow for this scenario.
 	 */
-- 
2.35.1
