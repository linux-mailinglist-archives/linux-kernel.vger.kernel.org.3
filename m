Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B20F552673
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 23:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239799AbiFTVch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 17:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241677AbiFTVc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 17:32:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71C412D32
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 14:32:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4511CCE17C2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 21:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E68C3411B;
        Mon, 20 Jun 2022 21:32:23 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1o3P0P-003o0g-Un;
        Mon, 20 Jun 2022 17:32:21 -0400
Message-ID: <20220620213158.468216113@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 20 Jun 2022 17:31:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/4] tracing: Fixes for 5.19
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Gautam Menghani (1):
      tracing/uprobes: Remove unwanted initialization in __trace_uprobe_create()

Masami Hiramatsu (Google) (1):
      tracing/kprobes: Check whether get_kretprobe() returns NULL in kretprobe_dispatcher()

Xiang wangx (1):
      tracefs: Fix syntax errors in comments

sunliming (1):
      tracing: Simplify conditional compilation code in tracing_set_tracer()

----
 fs/tracefs/inode.c          |  2 +-
 kernel/trace/trace.c        |  2 --
 kernel/trace/trace_kprobe.c | 11 ++++++++++-
 kernel/trace/trace_uprobe.c |  1 -
 4 files changed, 11 insertions(+), 5 deletions(-)
