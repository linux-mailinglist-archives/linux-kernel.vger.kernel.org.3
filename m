Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C167653D04C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 20:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346186AbiFCSCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 14:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347254AbiFCRwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:52:10 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1B51159
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 10:51:32 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:37448)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nxBSN-00GgKJ-0w; Fri, 03 Jun 2022 11:51:31 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:42808 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nxBSL-000zwa-Va; Fri, 03 Jun 2022 11:51:30 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>
References: <87v8th7i58.fsf@email.froward.int.ebiederm.org>
Date:   Fri, 03 Jun 2022 12:51:23 -0500
In-Reply-To: <87v8th7i58.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Fri, 03 Jun 2022 12:48:19 -0500")
Message-ID: <87mtet7i04.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nxBSL-000zwa-Va;;;mid=<87mtet7i04.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18fPrEmiIrn/0HI7pFDWas7OHiyQuUxNu0=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 515 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 12 (2.3%), b_tie_ro: 10 (1.9%), parse: 1.13
        (0.2%), extract_message_metadata: 14 (2.8%), get_uri_detail_list: 2.8
        (0.5%), tests_pri_-1000: 15 (2.9%), tests_pri_-950: 1.56 (0.3%),
        tests_pri_-900: 1.15 (0.2%), tests_pri_-90: 107 (20.9%), check_bayes:
        106 (20.5%), b_tokenize: 10 (1.9%), b_tok_get_all: 9 (1.8%),
        b_comp_prob: 3.0 (0.6%), b_tok_touch_all: 79 (15.3%), b_finish: 1.09
        (0.2%), tests_pri_0: 340 (66.0%), check_dkim_signature: 0.69 (0.1%),
        check_dkim_adsp: 2.6 (0.5%), poll_dns_idle: 0.75 (0.1%), tests_pri_10:
        3.2 (0.6%), tests_pri_500: 16 (3.2%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL v2] kthread cleanups for v5.19
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the kthread-cleanups-for-v5.19 tag from the git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git kthread-cleanups-for-v5.19
  HEAD: 31cae1eaae4fd65095ad6a3659db467bc3c2599e sched,signal,ptrace: Rework TASK_TRACED, TASK_STOPPED state

This set of changes updates init and user mode helper tasks to be
ordinary user mode tasks.

In commit 40966e316f86 ("kthread: Ensure struct kthread is present for
all kthreads") caused init and the user mode helper threads that call
kernel_execve to have struct kthread allocated for them.  This struct
kthread going away during execve in turned made a use after free of
struct kthread possible.

The commit 343f4c49f243 ("kthread: Don't allocate kthread_struct for
init and umh") is enough to fix the use after free and is simple enough
to be backportable.

The rest of the changes pass struct kernel_clone_args to clean things
up and cause the code to make sense.

In making init and the user mode helpers tasks purely user mode tasks
I ran into two complications.  The function task_tick_numa was
detecting tasks without an mm by testing for the presence of
PF_KTHREAD.  The initramfs code in populate_initrd_image was using
flush_delayed_fput to ensuere the closing of all it's file descriptors
was complete, and flush_delayed_fput does not work in a userspace thread.

I have looked and looked and more complications and in my code review
I have not found any, and neither has anyone else with the code sitting
in linux-next.

Link: https://lkml.kernel.org/r/87mtfu4up3.fsf@email.froward.int.ebiederm.org

Eric W. Biederman (8):
      kthread: Don't allocate kthread_struct for init and umh
      fork: Pass struct kernel_clone_args into copy_thread
      fork: Explicity test for idle tasks in copy_thread
      fork: Generalize PF_IO_WORKER handling
      init: Deal with the init process being a user mode process
      fork: Explicitly set PF_KTHREAD
      fork: Stop allowing kthreads to call execve
      sched: Update task_tick_numa to ignore tasks without an mm

 arch/alpha/kernel/process.c      | 13 ++++++------
 arch/arc/kernel/process.c        | 13 ++++++------
 arch/arm/kernel/process.c        | 12 ++++++-----
 arch/arm64/kernel/process.c      | 12 ++++++-----
 arch/csky/kernel/process.c       | 15 ++++++-------
 arch/h8300/kernel/process.c      | 10 ++++-----
 arch/hexagon/kernel/process.c    | 12 ++++++-----
 arch/ia64/kernel/process.c       | 15 +++++++------
 arch/m68k/kernel/process.c       | 12 ++++++-----
 arch/microblaze/kernel/process.c | 12 ++++++-----
 arch/mips/kernel/process.c       | 13 ++++++------
 arch/nios2/kernel/process.c      | 12 ++++++-----
 arch/openrisc/kernel/process.c   | 12 ++++++-----
 arch/parisc/kernel/process.c     | 18 +++++++++-------
 arch/powerpc/kernel/process.c    | 15 +++++++------
 arch/riscv/kernel/process.c      | 12 ++++++-----
 arch/s390/kernel/process.c       | 12 ++++++-----
 arch/sh/kernel/process_32.c      | 12 ++++++-----
 arch/sparc/kernel/process_32.c   | 12 ++++++-----
 arch/sparc/kernel/process_64.c   | 12 ++++++-----
 arch/um/kernel/process.c         | 15 +++++++------
 arch/x86/include/asm/fpu/sched.h |  2 +-
 arch/x86/include/asm/switch_to.h |  8 +++----
 arch/x86/kernel/fpu/core.c       |  4 ++--
 arch/x86/kernel/process.c        | 18 +++++++++-------
 arch/xtensa/kernel/process.c     | 17 ++++++++-------
 fs/exec.c                        |  8 ++++---
 include/linux/sched/task.h       |  8 +++++--
 init/initramfs.c                 |  2 ++
 init/main.c                      |  2 +-
 kernel/fork.c                    | 46 +++++++++++++++++++++++++++++++++-------
 kernel/sched/fair.c              |  2 +-
 kernel/umh.c                     |  6 +++---
 33 files changed, 234 insertions(+), 160 deletions(-)

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

p.s.  My apologies for this coming in so late.  The code has been ready
just everyone in my house has been sick since the start of the merge window.

p.p.s.  Resent as I left out which tag to pull when I sent this a minute
ago.
