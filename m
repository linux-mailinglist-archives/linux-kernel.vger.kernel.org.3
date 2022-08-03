Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33BB588E09
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 15:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbiHCN4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 09:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238759AbiHCNzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:55:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772EB304
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 06:55:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CF8BB822B4
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 13:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9D1C433C1;
        Wed,  3 Aug 2022 13:55:38 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oJEqX-007kPU-1o;
        Wed, 03 Aug 2022 09:55:37 -0400
Message-ID: <20220803135508.240797292@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Aug 2022 09:55:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/5] tracing: Final clean ups for 5.20 (or 6.0)
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li zeming (1):
      tracepoints: It is CONFIG_TRACEPOINTS not CONFIG_TRACEPOINT

Masami Hiramatsu (Google) (1):
      tracing/eprobe: Show syntax error logs in error_log file

Slark Xiao (1):
      scripts/tracing: Fix typo 'the the' in comment

Steven Rostedt (Google) (1):
      tracing: Use alignof__(struct {type b;}) instead of offsetof()

Zhiqiang Liu (1):
      tracing: Use free_trace_buffer() in allocate_trace_buffers()

----
 include/linux/tracepoint.h                 |  2 +-
 include/trace/stages/stage4_event_fields.h |  2 +-
 kernel/trace/trace.c                       | 25 +++++++++++--------------
 kernel/trace/trace_eprobe.c                | 11 +++++++++--
 kernel/trace/trace_probe.h                 |  5 ++++-
 scripts/tracing/draw_functrace.py          |  2 +-
 6 files changed, 27 insertions(+), 20 deletions(-)
