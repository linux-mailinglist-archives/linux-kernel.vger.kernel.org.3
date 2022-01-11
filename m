Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BB948B408
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345043AbiAKRcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344369AbiAKRbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:31:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52466C061757
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:31:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1F91B81C48
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF47C36AED;
        Tue, 11 Jan 2022 17:31:16 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1n7KzL-0032B3-Jq;
        Tue, 11 Jan 2022 12:31:15 -0500
Message-ID: <20220111173115.444531483@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 11 Jan 2022 12:30:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Geliang Tang <geliang.tang@suse.com>
Subject: [for-next][PATCH 12/31] tracing: Fix mismatched comment in __string_len
References: <20220111173030.999527342@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geliang Tang <geliang.tang@suse.com>

Here __assign_str_len() should be used for the __string_len type, instead
of __assign_str() in the comment.

Link: https://lkml.kernel.org/r/5c012db463392d0e6d4f0636203d778962ad060a.1640170494.git.geliang.tang@suse.com

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: 883b4aee4dec6 ("tracing: Add trace_event helper macros __string_len() and __assign_str_len()")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 samples/trace_events/trace-events-sample.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index 5ab74fc9a2df..cbbbb83beced 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -155,7 +155,7 @@
  *
  *         To assign this string, use the helper macro __assign_str_len().
  *
- *         __assign_str(foo, bar, len);
+ *         __assign_str_len(foo, bar, len);
  *
  *         Then len + 1 is allocated to the ring buffer, and a nul terminating
  *         byte is added. This is similar to:
-- 
2.33.0
