Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E3A536A58
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 04:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355727AbiE1Cx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 22:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355614AbiE1Cw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 22:52:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9390212E318
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 19:52:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0A9EB82691
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 02:52:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8C3C34113;
        Sat, 28 May 2022 02:52:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1numZQ-000LVe-KY;
        Fri, 27 May 2022 22:52:52 -0400
Message-ID: <20220528025252.473441111@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 27 May 2022 22:50:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        sunliming <sunliming@kylinos.cn>
Subject: [for-next][PATCH 21/23] x86/traceponit: Fix comment about irq vector tracepoints
References: <20220528025028.850906216@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sunliming <sunliming@kylinos.cn>

Commit:

  4b9a8dca0e58 ("x86/idt: Remove the tracing IDT completely")

removed the 'tracing IDT' from arch/x86/kernel/tracepoint.c,
but left related comment. So that the comment become anachronistic.
Just remove the comment.

Link: https://lkml.kernel.org/r/20220526110831.175743-1-sunliming@kylinos.cn

Signed-off-by: sunliming <sunliming@kylinos.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/x86/kernel/tracepoint.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/tracepoint.c b/arch/x86/kernel/tracepoint.c
index f39aad69fb64..03ae1caaa878 100644
--- a/arch/x86/kernel/tracepoint.c
+++ b/arch/x86/kernel/tracepoint.c
@@ -1,9 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Code for supporting irq vector tracepoints.
- *
  * Copyright (C) 2013 Seiji Aguchi <seiji.aguchi@hds.com>
- *
  */
 #include <linux/jump_label.h>
 #include <linux/atomic.h>
-- 
2.35.1
