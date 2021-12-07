Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5345346C6DD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241971AbhLGVsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:48:05 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:53824 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhLGVsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:48:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 03B5CCE1E75
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 21:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C99C341C1;
        Tue,  7 Dec 2021 21:44:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1muiGD-000HvC-8C;
        Tue, 07 Dec 2021 16:44:29 -0500
Message-ID: <20211207214429.089114928@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 07 Dec 2021 16:44:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.i.king@gmail.com>
Subject: [for-next][PATCH 01/13] tracing: Fix spelling mistake "aritmethic" -> "arithmetic"
References: <20211207214406.148423650@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.i.king@googlemail.com>

There is a spelling mistake in the tracing mini-HOWTO text. Fix it.

Link: https://lkml.kernel.org/r/20211108201513.42876-1-colin.i.king@gmail.com

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 88de94da596b..4821fe6a40a5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5635,7 +5635,7 @@ static const char readme_msg[] =
 	"\t        - a numeric literal: e.g. ms_per_sec=1000,\n"
 	"\t        - an arithmetic expression: e.g. time_secs=current_timestamp/1000\n"
 	"\n"
-	"\t    hist trigger aritmethic expressions support addition(+), subtraction(-),\n"
+	"\t    hist trigger arithmetic expressions support addition(+), subtraction(-),\n"
 	"\t    multiplication(*) and division(/) operators. An operand can be either a\n"
 	"\t    variable reference, field or numeric literal.\n"
 	"\n"
-- 
2.33.0
