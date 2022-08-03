Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CC1588E07
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 15:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiHCN4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 09:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238751AbiHCNzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:55:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057432A2
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 06:55:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 715756141B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 13:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC836C433B5;
        Wed,  3 Aug 2022 13:55:38 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oJEqX-007kQd-30;
        Wed, 03 Aug 2022 09:55:37 -0400
Message-ID: <20220803135537.769811554@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Aug 2022 09:55:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Li zeming <zeming@nfschina.com>
Subject: [for-next][PATCH 2/5] tracepoints: It is CONFIG_TRACEPOINTS not CONFIG_TRACEPOINT
References: <20220803135508.240797292@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li zeming <zeming@nfschina.com>

When reading this note, CONFIG_TRACEPOINT searches my configuration
file, and the result is CONFIG_TRACEPOINTS, the search results are
consistent with the following macro definitions. I think it should be
repaired.

Link: https://lkml.kernel.org/r/20220721081904.3798-1-zeming@nfschina.com

Signed-off-by: Li zeming <zeming@nfschina.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/tracepoint.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 28031b15f878..2908cc5ed70e 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -151,7 +151,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 /*
  * Individual subsystem my have a separate configuration to
  * enable their tracepoints. By default, this file will create
- * the tracepoints if CONFIG_TRACEPOINT is defined. If a subsystem
+ * the tracepoints if CONFIG_TRACEPOINTS is defined. If a subsystem
  * wants to be able to disable its tracepoints from being created
  * it can define NOTRACE before including the tracepoint headers.
  */
-- 
2.35.1
