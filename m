Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EEC4ECA3A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349153AbiC3RFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349141AbiC3RFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:05:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27206344D4;
        Wed, 30 Mar 2022 10:03:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A09FCB81DA6;
        Wed, 30 Mar 2022 17:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B695C340EC;
        Wed, 30 Mar 2022 17:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648659812;
        bh=chK2qbB5D/LYv0rx7RdNf49OUEThRDCKHrbLz8l+vKY=;
        h=Subject:From:To:Date:From;
        b=Fpf34Aqgd+dq0hsevijXXEKgp7MPWP2u7Y1xvrC1KFnHfxOxI90t6no2WxKNRZpS8
         ms0SRdMsyZwoLKadUq5vWwfTmtdnXNaM3yVgmGw4h696bnZJsCJ1pAspJF98CJC/Fv
         3cbblIX+ZwTm5JjCZinYjvmj6cY6FCtE+yZMuUsqiGLsqTEy/HiKEKWHS9SzDKVi+9
         trbU10bJMdKdRlDwyWcfBHmeC7xVkiRni7d0nfUJaYIOPWxwKTMoF/ZC5uCQ7uT2xH
         x3zuC1Lpp6hCQNypcD4iLcwSHOf8omfKidnP1EJbdZu7WfBkVLNQ34rZxAplkwmA5u
         5hFOb9sAqkJcQ==
Message-ID: <d1dfc82e8fb7ccb3975e58aabef8c24dbe224601.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.182-rt72
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Date:   Wed, 30 Mar 2022 12:03:29 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 5.4.182-rt72 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 9ec5060e670727f499db330d72369cb428d39851

Or to build 5.4.182-rt72 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.182.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.182-rt72.patch.xz


You can also build from 5.4.182-rt71 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.182-rt71-rt72.patch.xz

Enjoy!

   Tom

Changes from v5.4.182-rt71:
---

Tom Zanussi (2):
      eventfd: Fix stable-rt v5.4.182-rt71 conflict fixup issue
      Linux 5.4.182-rt72
---
include/linux/sched.h | 8 --------
 localversion-rt       | 2 +-
 2 files changed, 1 insertion(+), 9 deletions(-)
---
diff --git a/include/linux/sched.h b/include/linux/sched.h
index e1dfb01f4623..91f1aac3c86a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -802,14 +802,6 @@ struct task_struct {
 	/* to be used once the psi infrastructure lands upstream. */
 	unsigned			use_memdelay:1;
 #endif
-#ifdef CONFIG_PSI
-	/* Stalled due to lack of memory */
-	unsigned			in_memstall:1;
-#endif
-#ifdef CONFIG_PAGE_OWNER
-	/* Used by page_owner=on to detect recursion in page tracking. */
-	unsigned			in_page_owner:1;
-#endif
 #ifdef CONFIG_EVENTFD
 	/* Recursion prevention for eventfd_signal() */
 	unsigned			in_eventfd_signal:1;
diff --git a/localversion-rt b/localversion-rt
index f38a3cc7f310..2c95a3cdbcb8 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt71
+-rt72

