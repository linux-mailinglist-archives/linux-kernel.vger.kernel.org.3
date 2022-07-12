Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689B157277E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbiGLUkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbiGLUj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:39:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750DBCC792
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:39:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD9E361AA2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 20:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4761FC341D0;
        Tue, 12 Jul 2022 20:39:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1oBMfk-0049Pl-Bo;
        Tue, 12 Jul 2022 16:39:56 -0400
Message-ID: <20220712203956.202305958@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 12 Jul 2022 16:39:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Li kunyu <kunyu@nfschina.com>
Subject: [for-linus][PATCH 4/6] blk-iocost: tracing: atomic64_read(&ioc->vtime_rate) is assigned an
 extra semicolon
References: <20220712203924.060569640@goodmis.org>
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

From: Li kunyu <kunyu@nfschina.com>

Remove extra semicolon.

Link: https://lkml.kernel.org/r/20220629030013.10362-1-kunyu@nfschina.com

Cc: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Li kunyu <kunyu@nfschina.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/iocost.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/iocost.h b/include/trace/events/iocost.h
index e282ce02fa2d..6d1626e7a4ce 100644
--- a/include/trace/events/iocost.h
+++ b/include/trace/events/iocost.h
@@ -160,7 +160,7 @@ TRACE_EVENT(iocost_ioc_vrate_adj,
 
 	TP_fast_assign(
 		__assign_str(devname, ioc_name(ioc));
-		__entry->old_vrate = atomic64_read(&ioc->vtime_rate);;
+		__entry->old_vrate = atomic64_read(&ioc->vtime_rate);
 		__entry->new_vrate = new_vrate;
 		__entry->busy_level = ioc->busy_level;
 		__entry->read_missed_ppm = missed_ppm[READ];
-- 
2.35.1
