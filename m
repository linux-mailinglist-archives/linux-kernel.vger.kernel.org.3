Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD9D48DA32
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbiAMOz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:55:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36848 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbiAMOz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:55:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C33C61D19
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 14:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DA0C36AE9;
        Thu, 13 Jan 2022 14:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642085757;
        bh=WeS5bElinXfzmmxF8Rr8m+76QZElMklZ2mCYbdsIY7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LU/NLnP58ZyhqgotKfZdy6XNJOOVzgoRATmla/0o8wlolQt/iFWzdrj9vxc7S0hIF
         5A4jAo03bsqybLUqApcAQZnZJYrnuv+X0dHa3EwAM7D8a6Z/G0JhKk9dwFUp81T1FI
         Yjc2rMOkLCdKvlf5BzN9bkdDwiWdjqrq+KG+Em6e+xOpD5tThl3VAVDN+BSLhBUIwA
         O48dQUDTOiQh5HqMQDKtFYI7xgJH1Xs8YLa6UDGSUPAlmh2ndTywY3vheQOK7WIoig
         f8JyJFM1lJ8BdqVfHkKztVsgGFxX3otZ8nhixA3qT8/msx+PUEvMpnJ/hTxJ0c0KEG
         lV2/hErW8Cxxw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jianhua Liu <jianhua.ljh@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [PATCH 3/3] ia64: kprobes: Cleanup unused 'template' local variable
Date:   Thu, 13 Jan 2022 23:55:54 +0900
Message-Id: <164208575387.1590449.8278421820882450166.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <164208572899.1590449.14007562142219520042.stgit@devnote2>
References: <164208572899.1590449.14007562142219520042.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused 'template' local variable. This seems to be introduced
accidentally by a cleanup patch.

Fixes: a5403183d84d ("[PATCH] Kprobes IA64: arch_prepare_kprobes() cleanup")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
---
 arch/ia64/kernel/kprobes.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
index 1a7bab1c5d7c..31ed086d61c9 100644
--- a/arch/ia64/kernel/kprobes.c
+++ b/arch/ia64/kernel/kprobes.c
@@ -322,9 +322,6 @@ static void __kprobes get_kprobe_inst(bundle_t *bundle, uint slot,
 	       	unsigned long *kprobe_inst, uint *major_opcode)
 {
 	unsigned long kprobe_inst_p0, kprobe_inst_p1;
-	unsigned int template;
-
-	template = bundle->quad0.template;
 
 	switch (slot) {
 	  case 0:

