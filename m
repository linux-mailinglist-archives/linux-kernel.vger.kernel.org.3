Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A17246C6E9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242074AbhLGVs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:48:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48754 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241958AbhLGVsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:48:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72F75B81E89
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 21:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD98C341EC;
        Tue,  7 Dec 2021 21:44:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1muiGF-000I1L-9Q;
        Tue, 07 Dec 2021 16:44:31 -0500
Message-ID: <20211207214431.133392002@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 07 Dec 2021 16:44:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [for-next][PATCH 12/13] tracing: Fix synth_event_add_val() kernel-doc comment
References: <20211207214406.148423650@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiujun Huang <hqjagain@gmail.com>

It's named field here.

Link: https://lkml.kernel.org/r/20210516022410.64271-1-hqjagain@gmail.com

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 22db3ce95e74..98e002648994 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1978,7 +1978,7 @@ EXPORT_SYMBOL_GPL(synth_event_add_next_val);
 /**
  * synth_event_add_val - Add a named field's value to an open synth trace
  * @field_name: The name of the synthetic event field value to set
- * @val: The value to set the next field to
+ * @val: The value to set the named field to
  * @trace_state: A pointer to object tracking the piecewise trace state
  *
  * Set the value of the named field in an event that's been opened by
-- 
2.33.0
