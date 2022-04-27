Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09015122E4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbiD0Tkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiD0Tjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:39:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121EF2716
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:36:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 639D061B74
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 19:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F833C385AA;
        Wed, 27 Apr 2022 19:36:42 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1njnSr-002It8-7m;
        Wed, 27 Apr 2022 15:36:41 -0400
Message-ID: <20220427193641.075910863@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Apr 2022 15:36:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [for-next][PATCH 09/21] tracing: Fix tracing_map_sort_entries() kernel-doc comment
References: <20220427193623.529296556@goodmis.org>
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

From: Yang Li <yang.lee@linux.alibaba.com>

Add the description of @n_sort_keys and make @sort_key ->
@sort_keys in tracing_map_sort_entries() kernel-doc comment
to remove warnings found by running scripts/kernel-doc, which
is caused by using 'make W=1'.

kernel/trace/tracing_map.c:1073: warning: Function parameter or member
'sort_keys' not described in 'tracing_map_sort_entries'
kernel/trace/tracing_map.c:1073: warning: Function parameter or member
'n_sort_keys' not described in 'tracing_map_sort_entries'
kernel/trace/tracing_map.c:1073: warning: Excess function parameter
'sort_key' description in 'tracing_map_sort_entries'

Link: https://lkml.kernel.org/r/20220402072015.45864-1-yang.lee@linux.alibaba.com

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/tracing_map.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 9628b5571846..9901708ce6b8 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -1045,7 +1045,8 @@ static void sort_secondary(struct tracing_map *map,
 /**
  * tracing_map_sort_entries - Sort the current set of tracing_map_elts in a map
  * @map: The tracing_map
- * @sort_key: The sort key to use for sorting
+ * @sort_keys: The sort key to use for sorting
+ * @n_sort_keys: hitcount, always have at least one
  * @sort_entries: outval: pointer to allocated and sorted array of entries
  *
  * tracing_map_sort_entries() sorts the current set of entries in the
-- 
2.35.1
