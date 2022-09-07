Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C585B09E4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiIGQQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiIGQPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:15:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8E1796B1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:15:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D92F3CE1CD1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBB4C43143;
        Wed,  7 Sep 2022 16:15:29 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oVxij-00CsVW-2t;
        Wed, 07 Sep 2022 12:16:09 -0400
Message-ID: <20220907161609.728013341@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 07 Sep 2022 12:15:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [for-linus][PATCH 3/7] MAINTAINERS: add scripts/tracing/ to TRACING
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

From: Lukas Bulwahn <lukas.bulwahn@gmail.com>

The files in scripts/tracing/ belong to the TRACING subsystem.

Add a corresponding file entry for TRACING.

Link: https://lkml.kernel.org/r/20220825115927.20598-1-lukas.bulwahn@gmail.com

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b89b70af0b07..93ffebc3e6c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20612,6 +20612,7 @@ F:	include/*/ftrace.h
 F:	include/linux/trace*.h
 F:	include/trace/
 F:	kernel/trace/
+F:	scripts/tracing/
 F:	tools/testing/selftests/ftrace/
 
 TRACING MMIO ACCESSES (MMIOTRACE)
-- 
2.35.1
