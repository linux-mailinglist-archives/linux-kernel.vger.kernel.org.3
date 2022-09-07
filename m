Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705265B09DF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiIGQPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiIGQPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:15:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CAF792E5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:15:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62782619BD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD71AC433D6;
        Wed,  7 Sep 2022 16:15:28 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oVxij-00CsTp-13;
        Wed, 07 Sep 2022 12:16:09 -0400
Message-ID: <20220907161511.694486342@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 07 Sep 2022 12:15:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/7] tracing: Fixes and updates for 6.0
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alison Schofield (1):
      tracepoint: Allow trace events in modules with TAINT_TEST

Daniel Bristot de Oliveira (2):
      rv/monitors: Make monitor's automata definition static
      MAINTAINERS: Add Runtime Verification (RV) entry

Lukas Bulwahn (1):
      MAINTAINERS: add scripts/tracing/ to TRACING

Masami Hiramatsu (Google) (1):
      tracing: Fix to check event_mutex is held while accessing trigger list

Xiu Jianfeng (1):
      rv/reactor: add __init/__exit annotations to module init/exit funcs

Yipeng Zou (1):
      tracing: hold caller_addr to hardirq_{enable,disable}_ip

----
 MAINTAINERS                          | 12 ++++++++++++
 kernel/trace/rv/monitors/wip/wip.h   |  2 +-
 kernel/trace/rv/monitors/wwnr/wwnr.h |  2 +-
 kernel/trace/rv/reactor_panic.c      |  4 ++--
 kernel/trace/rv/reactor_printk.c     |  4 ++--
 kernel/trace/trace_events_trigger.c  |  3 ++-
 kernel/trace/trace_preemptirq.c      |  4 ++--
 kernel/tracepoint.c                  |  5 +++--
 8 files changed, 25 insertions(+), 11 deletions(-)
