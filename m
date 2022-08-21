Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D5C59B65F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 22:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiHUU4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 16:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiHUU4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 16:56:49 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179AE1403A
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 13:56:48 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 2so3556724edx.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 13:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc;
        bh=0nefd+NnCx6zWb2CJYYEbzw1TYkXNtS9Tbg4NsokQ2c=;
        b=YxSiKnDlJua61qHThipZeP7uCAJuffvE4TQa1vJUBHQlt0feO35DnYJNnqvpIBZ9/l
         fl+TAcncaeR9h21cF+WP3NXSAP7Hz/E5NylSp1MGouk2qhS2TEUUOXUz+HhE+uy/yYQ3
         HTj5BBA279GLxQAeTA/yD0SYQtU/HeSSzK45Js+eIu+v7YBH1p22KNZY3SrprMWNd4+D
         57/PnN5Yuxd/U2tZoCXFqs+k4HIpozOfKwb9w+Gy/N8pOA2G5G5/GTNxPbZ8iH07xCJb
         9rSRjkQe4UbY0kKrnOyBp+Wq905/YOq5HEdAz3OPgxsYkKNPO8tbAYpBwgr2Pug12HNc
         k6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc;
        bh=0nefd+NnCx6zWb2CJYYEbzw1TYkXNtS9Tbg4NsokQ2c=;
        b=s/CvLHed472wtndXQqkseiuuLkDib9uXq1VNUPeHERVHeTas9siXuNotbtoK+61cKM
         Ryn+mEon7eVELrlBbv90fr5m+yuFAj50EVYmN5ubBMnA0ZcHudVbnWJnXseaLNrXvMgX
         bTEx7KbNQeKRarOd5fbzC7CAdOg1owWen1WjqMDaF4pE5JndqWxIEkgGmzZ6ah84OPDR
         3qK5X0ikw5Vhj2Y3suGxnRax/SuqGzP3X6KMf1/N8+AkiMZ7K2nqDMrWr24yMzWDXvn6
         fsjATaJFWwXgIqmAkrx8Nk4MkuSk2Bz4+zD+O7f0nhQ0bzbSDBRilDEhdf87V7Z63Tke
         4hfQ==
X-Gm-Message-State: ACgBeo0teRAQR0J9T1syUjZo+duJYjbVm+N20z+PPgae+r2SVIoo0WFu
        b9GDm56/2FRKyXTLDWPhMWs=
X-Google-Smtp-Source: AA6agR6z/dpE8IYOrS5QHCt1cDOVnowVXWut4QMNJL5HgfExI7TJWnomyJGIQTf/1vocVVXRrRidjQ==
X-Received: by 2002:a05:6402:d05:b0:435:b2a6:94eb with SMTP id eb5-20020a0564020d0500b00435b2a694ebmr13693049edb.87.1661115406477;
        Sun, 21 Aug 2022 13:56:46 -0700 (PDT)
Received: from gmail.com (195-38-113-151.pool.digikabel.hu. [195.38.113.151])
        by smtp.gmail.com with ESMTPSA id kx26-20020a170907775a00b0073cb0801104sm4275942ejc.147.2022.08.21.13.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 13:56:45 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 21 Aug 2022 22:56:43 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] kprobes fix
Message-ID: <YwKcC0dUSQS3vy7n@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2022-08-21

   # HEAD: 8924779df820c53875abaeb10c648e9cb75b46d4 x86/kprobes: Fix JNG/JNLE emulation

Fix a kprobes bug in JNG/JNLE emulation when a kprobe is
installed at such instructions, possibly resulting in
incorrect execution (the wrong branch taken).

 Thanks,

	Ingo

------------------>
Nadav Amit (1):
      x86/kprobes: Fix JNG/JNLE emulation


 arch/x86/kernel/kprobes/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 74167dc5f55e..4c3c27b6aea3 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -505,7 +505,7 @@ static void kprobe_emulate_jcc(struct kprobe *p, struct pt_regs *regs)
 		match = ((regs->flags & X86_EFLAGS_SF) >> X86_EFLAGS_SF_BIT) ^
 			((regs->flags & X86_EFLAGS_OF) >> X86_EFLAGS_OF_BIT);
 		if (p->ainsn.jcc.type >= 0xe)
-			match = match && (regs->flags & X86_EFLAGS_ZF);
+			match = match || (regs->flags & X86_EFLAGS_ZF);
 	}
 	__kprobe_emulate_jmp(p, regs, (match && !invert) || (!match && invert));
 }
