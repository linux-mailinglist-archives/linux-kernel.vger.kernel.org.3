Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7624CE2B1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 06:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiCEFLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 00:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiCEFLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 00:11:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3014356419
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 21:10:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E18F9B82C86
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 05:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9963EC004E1;
        Sat,  5 Mar 2022 05:10:10 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nQMgD-00EgtM-GS;
        Sat, 05 Mar 2022 00:10:09 -0500
Message-ID: <20220305050948.857222764@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 05 Mar 2022 00:09:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/2] tracing: A couple of fixes
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Two tracing fixes:

 - Fix sorting on old "cpu" value in histograms

 - Fix return value of __setup() boot parameter handlers.

Head SHA1: 1d02b444b8d1345ea4708db3bab4db89a7784b55


Randy Dunlap (1):
      tracing: Fix return value of __setup handlers

Steven Rostedt (Google) (1):
      tracing/histogram: Fix sorting on old "cpu" value

----
 kernel/trace/trace.c             | 4 ++--
 kernel/trace/trace_events_hist.c | 6 +++---
 kernel/trace/trace_kprobe.c      | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)
