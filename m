Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B812A47178D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 02:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhLLB0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 20:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbhLLB0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 20:26:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64740C0617A1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 17:26:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DC95B80C6E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 01:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F07C341CB;
        Sun, 12 Dec 2021 01:26:45 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mwDdV-000kDB-3B;
        Sat, 11 Dec 2021 20:26:45 -0500
Message-ID: <20211212012644.940336536@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 11 Dec 2021 20:26:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yinan Liu <yinan@linux.alibaba.com>
Subject: [for-next][PATCH 02/11] script/sorttable: Code style improvements
References: <20211212012617.690710310@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yinan Liu <yinan@linux.alibaba.com>

Modified the code style issue of if() {},
keep the code style consistent.

Link: https://lkml.kernel.org/r/20211207151348.54921-3-yinan@linux.alibaba.com

Signed-off-by: Yinan Liu <yinan@linux.alibaba.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 scripts/sorttable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index a2baa2fefb13..7b9745cf8c70 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -364,11 +364,11 @@ static int do_sort(Elf_Ehdr *ehdr,
 		void *retval = NULL;
 		/* wait for ORC tables sort done */
 		rc = pthread_join(orc_sort_thread, &retval);
-		if (rc)
+		if (rc) {
 			fprintf(stderr,
 				"pthread_join failed '%s': %s\n",
 				strerror(errno), fname);
-		else if (retval) {
+		} else if (retval) {
 			rc = -1;
 			fprintf(stderr,
 				"failed to sort ORC tables '%s': %s\n",
-- 
2.33.0
