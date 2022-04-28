Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD61E513E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352723AbiD1Vza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352563AbiD1Vy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:54:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BBB2FFC8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 14:51:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 450F4B83077
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 21:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B875C385AF;
        Thu, 28 Apr 2022 21:51:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nkC31-003MY1-Rr;
        Thu, 28 Apr 2022 17:51:39 -0400
Message-ID: <20220428215102.260147624@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 28 Apr 2022 17:51:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/8] tracing: Updates for 5.19
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next-core

Head SHA1: ba27d8555867b0e02e15709f4ddb79aec5cf2efc


Jakob Koschel (4):
      tracing: Remove usage of list iterator after the loop body
      tracing: Remove usage of list iterator variable after the loop
      tracing: Replace usage of found with dedicated list iterator variable
      tracing: Remove check of list iterator against head past the loop body

Kurt Kanzenbach (2):
      tracing: Introduce trace clock tai
      tracing: Add documentation for trace clock tai

Steven Rostedt (Google) (2):
      ring-buffer: Have absolute time stamps handle large numbers
      ring-buffer: Have 32 bit time stamps use all 64 bits

----
 Documentation/trace/ftrace.rst      | 12 ++++++
 kernel/trace/ftrace.c               | 20 ++++++----
 kernel/trace/ring_buffer.c          | 77 +++++++++++++++++++++++++++++--------
 kernel/trace/trace.c                |  1 +
 kernel/trace/trace_eprobe.c         | 14 ++++---
 kernel/trace/trace_events.c         | 27 +++++++------
 kernel/trace/trace_events_hist.c    | 15 ++++----
 kernel/trace/trace_events_trigger.c | 24 ++++++------
 kernel/trace/trace_output.c         | 13 +++++--
 9 files changed, 135 insertions(+), 68 deletions(-)
