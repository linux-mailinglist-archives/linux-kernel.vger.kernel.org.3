Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF305888E9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 10:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbiHCIy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 04:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbiHCIyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 04:54:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E711EAD5;
        Wed,  3 Aug 2022 01:54:24 -0700 (PDT)
Date:   Wed, 03 Aug 2022 08:54:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659516863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=O/NSsIc6TVFL4PnJzZ2d/RiVsM4iODEMnlsSeYNlHjE=;
        b=om1l4U8afPskB+vcuFo7UNYcEK4Z+Fm4grjBwMenj9IRJOyB126r6VCLC8wuQihs6bpmJY
        MaslNejD2qbuh94TmyMwb5otPiOit6AVkeNsdy9mo8T9Vt3RlPbR0bzjq5/Wl9OMDhYXJj
        4DKFbkIETim4lXd83Ikonrj0R3CoIFio9b1Ae3lHrzrIwF5lFEVbbczCe6r7q09aD/dcoo
        ngxwDowvAtehBTA+HGLlbLeKA3jICuvn1tfn6RljU+VZUiWbxrZcjJTRnpDbmVrLRDNDGE
        DoEwLU6+myMWtZs0w2YxrUquAj3R1WtJ4ckv40d9XoryBbZi2IUPoTzAmpCCUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659516863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=O/NSsIc6TVFL4PnJzZ2d/RiVsM4iODEMnlsSeYNlHjE=;
        b=rg6XggWgAhzRrrQZJj9B9wmdlyv9gObxLRWxvq0TFM4OFQJVz5XobMlNUB12fpzH2YxcWj
        L18LGqZu7YEd6ICw==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] exit: Fix typo in comment: s/sub-theads/sub-threads
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
MIME-Version: 1.0
Message-ID: <165951686214.15455.15985773663272649627.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     dcca34754a3f5290406403b8066e3b15dda9f4bf
Gitweb:        https://git.kernel.org/tip/dcca34754a3f5290406403b8066e3b15dda9f4bf
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 03 Aug 2022 10:43:42 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Aug 2022 10:44:54 +02:00

exit: Fix typo in comment: s/sub-theads/sub-threads

Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/exit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 64c938c..84021b2 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1051,7 +1051,7 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
 		 * p->signal fields because the whole thread group is dead
 		 * and nobody can change them.
 		 *
-		 * psig->stats_lock also protects us from our sub-theads
+		 * psig->stats_lock also protects us from our sub-threads
 		 * which can reap other children at the same time. Until
 		 * we change k_getrusage()-like users to rely on this lock
 		 * we have to take ->siglock as well.
