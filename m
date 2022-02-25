Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D924C4B65
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243241AbiBYQxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242759AbiBYQwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:52:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBDD1A82A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 08:52:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E690F61CB5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 16:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58473C340E7;
        Fri, 25 Feb 2022 16:52:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nNdpK-00B8IZ-D2;
        Fri, 25 Feb 2022 11:52:18 -0500
Message-ID: <20220225165218.234313520@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 25 Feb 2022 11:51:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-linus][PATCH 01/13] rtla: Fix systme -> system typo on man page
References: <20220225165151.824659113@goodmis.org>
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

From: Arnaldo Carvalho de Melo <acme@kernel.org>

Link: https://lkml.kernel.org/r/YhZsZxqk+IaFxorj@kernel.org

Fixes: 496082df01bb08a4 ("rtla: Add rtla osnoise man page")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/tools/rtla/common_osnoise_description.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/tools/rtla/common_osnoise_description.rst b/Documentation/tools/rtla/common_osnoise_description.rst
index 8973c5df888f..d5d61615b967 100644
--- a/Documentation/tools/rtla/common_osnoise_description.rst
+++ b/Documentation/tools/rtla/common_osnoise_description.rst
@@ -1,7 +1,7 @@
 The **rtla osnoise** tool is an interface for the *osnoise* tracer. The
 *osnoise* tracer dispatches a kernel thread per-cpu. These threads read the
 time in a loop while with preemption, softirq and IRQs enabled, thus
-allowing all the sources of operating systme noise during its execution.
+allowing all the sources of operating system noise during its execution.
 The *osnoise*'s tracer threads take note of the delta between each time
 read, along with an interference counter of all sources of interference.
 At the end of each period, the *osnoise* tracer displays a summary of
-- 
2.34.1
