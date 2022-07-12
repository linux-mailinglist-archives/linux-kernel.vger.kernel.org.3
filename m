Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C89572782
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiGLUkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbiGLUj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:39:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19368CC7B5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:39:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BEBF8B81658
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 20:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880B7C3411C;
        Tue, 12 Jul 2022 20:39:56 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1oBMfj-0049NV-J3;
        Tue, 12 Jul 2022 16:39:55 -0400
Message-ID: <20220712203924.060569640@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 12 Jul 2022 16:39:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/6] tracing: Fixes and minor clean ups for 5.19
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Douglas Anderson (1):
      tracing: Fix sleeping while atomic in kdb ftdump

Li kunyu (1):
      blk-iocost: tracing: atomic64_read(&ioc->vtime_rate) is assigned an extra semicolon

Steven Rostedt (Google) (1):
      ftrace: Be more specific about arch impact when function tracer is enabled

Tiezhu Yang (1):
      samples: Use KSYM_NAME_LEN for kprobes

Zheng Yejian (1):
      tracing/histograms: Fix memory leak problem

sunliming (1):
      fprobe/samples: Make sample_probe static

----
 include/trace/events/iocost.h       |  2 +-
 kernel/trace/Kconfig                |  3 ++-
 kernel/trace/trace.c                | 11 ++++++-----
 kernel/trace/trace_events_hist.c    |  2 ++
 samples/fprobe/fprobe_example.c     |  2 +-
 samples/kprobes/kprobe_example.c    |  5 ++---
 samples/kprobes/kretprobe_example.c |  5 ++---
 7 files changed, 16 insertions(+), 14 deletions(-)
