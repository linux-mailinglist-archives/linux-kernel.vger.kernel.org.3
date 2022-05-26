Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C5E53562C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 00:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348630AbiEZWya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 18:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343582AbiEZWy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 18:54:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6F5E7314
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 15:54:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5147C61C55
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 22:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC31C3411F;
        Thu, 26 May 2022 22:54:25 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nuMN6-002Tg3-KS;
        Thu, 26 May 2022 18:54:24 -0400
Message-ID: <20220526225424.464292505@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 26 May 2022 18:53:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveria <bristot@kernel.org>,
        John Kacur <jkacur@redhat.com>
Subject: [for-next][PATCH 4/6] rtla: Minor grammar fix for rtla README
References: <20220526225345.068997320@goodmis.org>
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

From: John Kacur <jkacur@redhat.com>

- Change to "The rtla meta-tool includes"
- Remove an unnecessary "But, "
- Adjust the formatting of the paragraph resulting from the changes.
- Simplify the wording for the libraries and tools.

Link: https://lkml.kernel.org/r/437f0accdde53713ab3cce46f3564be00487e031.1651247710.git.bristot@kernel.org
Link: https://lore.kernel.org/r/20220408161012.10544-1-jkacur@redhat.com/

Cc: Daniel Bristot de Oliveria <bristot@kernel.org>
Fixes: 79ce8f43ac5a ("rtla: Real-Time Linux Analysis tool")
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: John Kacur <jkacur@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/README.txt | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/tracing/rtla/README.txt b/tools/tracing/rtla/README.txt
index 6c88446f7e74..0fbad2640b8c 100644
--- a/tools/tracing/rtla/README.txt
+++ b/tools/tracing/rtla/README.txt
@@ -1,15 +1,13 @@
 RTLA: Real-Time Linux Analysis tools
 
-The rtla is a meta-tool that includes a set of commands that
-aims to analyze the real-time properties of Linux. But, instead of
-testing Linux as a black box, rtla leverages kernel tracing
-capabilities to provide precise information about the properties
-and root causes of unexpected results.
+The rtla meta-tool includes a set of commands that aims to analyze
+the real-time properties of Linux. Instead of testing Linux as a black box,
+rtla leverages kernel tracing capabilities to provide precise information
+about the properties and root causes of unexpected results.
 
 Installing RTLA
 
-RTLA depends on some libraries and tools. More precisely, it depends on the
-following libraries:
+RTLA depends on the following libraries and tools:
 
  - libtracefs
  - libtraceevent
-- 
2.35.1
