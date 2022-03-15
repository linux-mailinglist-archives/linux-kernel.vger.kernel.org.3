Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D7F4DA2DE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351237AbiCOTEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351212AbiCOTEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:04:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5062A5A155
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:02:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9131C616D4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE704C340F4;
        Tue, 15 Mar 2022 19:02:43 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nUCRO-003jfR-PM;
        Tue, 15 Mar 2022 15:02:42 -0400
Message-ID: <20220315190214.613102181@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 15 Mar 2022 15:02:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/15] rtla: Updates for 5.18
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 75016ca3acd0de79868ef5b0694195fe05288ade


Daniel Bristot de Oliveira (15):
      rtla/osnoise: Add support to adjust the tracing_thresh
      rtla/osnoise: Add an option to set the threshold
      rtla/osnoise: Add the automatic trace option
      rtla/timerlat: Add the automatic trace option
      rtla/trace: Add trace events helpers
      rtla: Add -e/--event support
      rtla/trace: Add trace event trigger helpers
      rtla: Add --trigger support
      rtla/trace: Add trace event filter helpers
      rtla: Add --filter support
      rtla/trace: Save event histogram output to a file
      rtla: Check for trace off also in the trace instance
      rtla/osnoise: Fix osnoise hist stop tracing message
      rtla/timerlat: Add --dma-latency option
      rtla: Tools main loop cleanup

----
 Documentation/tools/rtla/common_options.rst        |  19 ++
 .../tools/rtla/common_osnoise_options.rst          |  10 +
 .../tools/rtla/common_timerlat_options.rst         |  12 +
 tools/tracing/rtla/src/osnoise.c                   |  83 +++++
 tools/tracing/rtla/src/osnoise.h                   |   8 +
 tools/tracing/rtla/src/osnoise_hist.c              |  95 +++++-
 tools/tracing/rtla/src/osnoise_top.c               |  91 +++++-
 tools/tracing/rtla/src/timerlat_hist.c             | 108 ++++++-
 tools/tracing/rtla/src/timerlat_top.c              | 103 +++++-
 tools/tracing/rtla/src/trace.c                     | 345 +++++++++++++++++++++
 tools/tracing/rtla/src/trace.h                     |  23 ++
 tools/tracing/rtla/src/utils.c                     |  33 ++
 tools/tracing/rtla/src/utils.h                     |   1 +
 13 files changed, 903 insertions(+), 28 deletions(-)
