Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84D549FDF8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350150AbiA1QYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:24:01 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35354 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350067AbiA1QXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:23:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 469F1B82649
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268BDC340EB;
        Fri, 28 Jan 2022 16:23:45 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nDU2K-00AT0n-Au;
        Fri, 28 Jan 2022 11:23:44 -0500
Message-ID: <20220128162344.174630205@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 28 Jan 2022 11:18:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [for-linus][PATCH 05/10] rtla: Make doc build optional
References: <20220128161802.711119424@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuah Khan <skhan@linuxfoundation.org>

rtla build fails due to doc build dependency on rst2man. Make
doc build optional so rtla could be built without docs. Leave
the install dependency on doc_install alone.

Link: https://lkml.kernel.org/r/20220126001301.79096-1-skhan@linuxfoundation.org

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 2d52ff0bff7d..7c39728d08de 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -59,7 +59,7 @@ endif
 .PHONY:	all
 all:	rtla
 
-rtla: $(OBJ) doc
+rtla: $(OBJ)
 	$(CC) -o rtla $(LDFLAGS) $(OBJ) $(LIBS)
 
 static: $(OBJ)
-- 
2.33.0
