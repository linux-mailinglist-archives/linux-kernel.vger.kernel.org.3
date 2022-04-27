Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A943D5122DC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbiD0TkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiD0Tjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:39:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B4BF34
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:36:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31F0661B6D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 19:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA5EC385BA;
        Wed, 27 Apr 2022 19:36:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1njnSq-002IrR-MG;
        Wed, 27 Apr 2022 15:36:40 -0400
Message-ID: <20220427193640.523588188@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Apr 2022 15:36:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Shiang <oscar0225@livemail.tw>
Subject: [for-next][PATCH 06/21] tracing: Fix inconsistent style of mini-HOWTO
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

From: Oscar Shiang <oscar0225@livemail.tw>

Each description should start with a hyphen and a space. Insert
spaces to fix it.

Link: https://lkml.kernel.org/r/TYCP286MB19130AA4A9C6FC5A8793DED2A1359@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM

Signed-off-by: Oscar Shiang <oscar0225@livemail.tw>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f4de111fa18f..4f9c499368c4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5475,7 +5475,7 @@ static const char readme_msg[] =
 	"  error_log\t- error log for failed commands (that support it)\n"
 	"  buffer_size_kb\t- view and modify size of per cpu buffer\n"
 	"  buffer_total_size_kb  - view total size of all cpu buffers\n\n"
-	"  trace_clock\t\t-change the clock used to order events\n"
+	"  trace_clock\t\t- change the clock used to order events\n"
 	"       local:   Per cpu clock but may not be synced across CPUs\n"
 	"      global:   Synced across CPUs but slows tracing down.\n"
 	"     counter:   Not a clock, but just an increment\n"
@@ -5484,7 +5484,7 @@ static const char readme_msg[] =
 #ifdef CONFIG_X86_64
 	"     x86-tsc:   TSC cycle counter\n"
 #endif
-	"\n  timestamp_mode\t-view the mode used to timestamp events\n"
+	"\n  timestamp_mode\t- view the mode used to timestamp events\n"
 	"       delta:   Delta difference against a buffer-wide timestamp\n"
 	"    absolute:   Absolute (standalone) timestamp\n"
 	"\n  trace_marker\t\t- Writes into this file writes into the kernel buffer\n"
-- 
2.35.1
