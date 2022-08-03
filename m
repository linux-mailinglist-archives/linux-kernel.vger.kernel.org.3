Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6841C588E08
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 15:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238117AbiHCN4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 09:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238750AbiHCNzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:55:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4DF101DE
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 06:55:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B940F61582
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 13:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6E6C433D7;
        Wed,  3 Aug 2022 13:55:39 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oJEqY-007kRB-0M;
        Wed, 03 Aug 2022 09:55:38 -0400
Message-ID: <20220803135537.946670434@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Aug 2022 09:55:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Slark Xiao <slark_xiao@163.com>
Subject: [for-next][PATCH 3/5] scripts/tracing: Fix typo the the in comment
References: <20220803135508.240797292@goodmis.org>
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

From: Slark Xiao <slark_xiao@163.com>

Replace 'the the' with 'the' in the comment.

Link: https://lkml.kernel.org/r/20220722102907.81949-1-slark_xiao@163.com

Signed-off-by: Slark Xiao <slark_xiao@163.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/tracing/draw_functrace.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/tracing/draw_functrace.py b/scripts/tracing/draw_functrace.py
index 7011fbe003ff..438516bdfb3c 100755
--- a/scripts/tracing/draw_functrace.py
+++ b/scripts/tracing/draw_functrace.py
@@ -8,7 +8,7 @@ This script parses a trace provided by the function tracer in
 kernel/trace/trace_functions.c
 The resulted trace is processed into a tree to produce a more human
 view of the call stack by drawing textual but hierarchical tree of
-calls. Only the functions's names and the the call time are provided.
+calls. Only the functions's names and the call time are provided.
 
 Usage:
 	Be sure that you have CONFIG_FUNCTION_TRACER
-- 
2.35.1
