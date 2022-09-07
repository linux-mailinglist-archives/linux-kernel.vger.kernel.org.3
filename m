Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC635B09DE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiIGQPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiIGQPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:15:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135EE79630
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:15:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AB6761931
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C4CC43470;
        Wed,  7 Sep 2022 16:15:28 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oVxij-00CsUy-2I;
        Wed, 07 Sep 2022 12:16:09 -0400
Message-ID: <20220907161609.539947679@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 07 Sep 2022 12:15:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-linus][PATCH 2/7] MAINTAINERS: Add Runtime Verification (RV) entry
References: <20220907161511.694486342@goodmis.org>
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

From: Daniel Bristot de Oliveira <bristot@kernel.org>

Add a Runtime Verification (RV) entry in the MAINTAINERS file
with Steven Rostedt and myself as maintainers.

Link: https://lkml.kernel.org/r/b24c13553b6947a8da16d884ca464e4233eb8fb7.1661268579.git.bristot@kernel.org

Cc: Joe Perches <joe@perches.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d30f26e07cd3..b89b70af0b07 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17735,6 +17735,17 @@ L:	linux-rdma@vger.kernel.org
 S:	Maintained
 F:	drivers/infiniband/ulp/rtrs/
 
+RUNTIME VERIFICATION (RV)
+M:	Daniel Bristot de Oliveira <bristot@kernel.org>
+M:	Steven Rostedt <rostedt@goodmis.org>
+L:	linux-trace-devel@vger.kernel.org
+S:	Maintained
+F:	Documentation/trace/rv/
+F:	include/linux/rv.h
+F:	include/rv/
+F:	kernel/trace/rv/
+F:	tools/verification/
+
 RXRPC SOCKETS (AF_RXRPC)
 M:	David Howells <dhowells@redhat.com>
 M:	Marc Dionne <marc.dionne@auristor.com>
-- 
2.35.1
