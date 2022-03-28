Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A765D4EA3F4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 02:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiC1X6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 19:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiC1X6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 19:58:38 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CF3137F5E;
        Mon, 28 Mar 2022 16:56:56 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:58544)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nYzEF-00FvWG-5d; Mon, 28 Mar 2022 17:56:55 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:41530 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nYzED-005Hs8-2U; Mon, 28 Mar 2022 17:56:54 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexey Gladkov <legion@kernel.org>, Kyle Huey <me@kylehuey.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>, <linux-api@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <87bl1kunjj.fsf@email.froward.int.ebiederm.org>
        <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
        <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
        <87tubyx0rg.fsf_-_@email.froward.int.ebiederm.org>
Date:   Mon, 28 Mar 2022 18:56:46 -0500
In-Reply-To: <87tubyx0rg.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Tue, 15 Mar 2022 18:18:59 -0500")
Message-ID: <87a6d9pr5t.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nYzED-005Hs8-2U;;;mid=<87a6d9pr5t.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Tf8du8XGTtxjfBiYpwsvd8V8xcfv+BF8=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1483 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.6 (0.2%), b_tie_ro: 2.4 (0.2%), parse: 0.71
        (0.0%), extract_message_metadata: 9 (0.6%), get_uri_detail_list: 2.2
        (0.1%), tests_pri_-1000: 9 (0.6%), tests_pri_-950: 0.92 (0.1%),
        tests_pri_-900: 0.77 (0.1%), tests_pri_-90: 66 (4.5%), check_bayes: 65
        (4.4%), b_tokenize: 10 (0.7%), b_tok_get_all: 10 (0.7%), b_comp_prob:
        1.81 (0.1%), b_tok_touch_all: 41 (2.8%), b_finish: 0.67 (0.0%),
        tests_pri_0: 1383 (93.2%), check_dkim_signature: 0.39 (0.0%),
        check_dkim_adsp: 1.46 (0.1%), poll_dns_idle: 0.33 (0.0%),
        tests_pri_10: 1.77 (0.1%), tests_pri_500: 6 (0.4%), rewrite_mail: 0.00
        (0.0%)
Subject: [GIT PULL] ptrace: Cleanups for v5.18
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the ptrace-cleanups-for-v5.18 tag from the git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ptrace-cleanups-for-v5.18

  HEAD: dcbc65aac28360df5f5a3b613043ccc0e81da3cf ptrace: Remove duplicated include in ptrace.c

This set of changes removes tracehook.h, moves modification of all of
the ptrace fields inside of siglock to remove races, adds a missing
permission check to ptrace.c

The removal of tracehook.h is quite significant as it has been a major
source of confusion in recent years.  Much of that confusion was
around task_work and TIF_NOTIFY_SIGNAL (which I have now decoupled
making the semantics clearer).

For people who don't know tracehook.h is a vestiage of an attempt to
implement uprobes like functionality that was never fully merged, and
was later superseeded by uprobes when uprobes was merged.  For many
years now we have been removing what tracehook functionaly a little
bit at a time.  To the point where now anything left in tracehook.h is
some weird strange thing that is difficult to understand.

Eric W. Biederman (15):
      ptrace: Move ptrace_report_syscall into ptrace.h
      ptrace/arm: Rename tracehook_report_syscall report_syscall
      ptrace: Create ptrace_report_syscall_{entry,exit} in ptrace.h
      ptrace: Remove arch_syscall_{enter,exit}_tracehook
      ptrace: Remove tracehook_signal_handler
      task_work: Remove unnecessary include from posix_timers.h
      task_work: Introduce task_work_pending
      task_work: Call tracehook_notify_signal from get_signal on all architectures
      task_work: Decouple TIF_NOTIFY_SIGNAL and task_work
      signal: Move set_notify_signal and clear_notify_signal into sched/signal.h
      resume_user_mode: Remove #ifdef TIF_NOTIFY_RESUME in set_notify_resume
      resume_user_mode: Move to resume_user_mode.h
      tracehook: Remove tracehook.h
      ptrace: Move setting/clearing ptrace_message into ptrace_stop
      ptrace: Return the signal to continue with from ptrace_stop

Jann Horn (1):
      ptrace: Check PTRACE_O_SUSPEND_SECCOMP permission on PTRACE_SEIZE

Yang Li (1):
      ptrace: Remove duplicated include in ptrace.c


 MAINTAINERS                          |   1 -
 arch/Kconfig                         |   5 +-
 arch/alpha/kernel/ptrace.c           |   5 +-
 arch/alpha/kernel/signal.c           |   4 +-
 arch/arc/kernel/ptrace.c             |   5 +-
 arch/arc/kernel/signal.c             |   4 +-
 arch/arm/kernel/ptrace.c             |  12 +-
 arch/arm/kernel/signal.c             |   4 +-
 arch/arm64/kernel/ptrace.c           |  14 +--
 arch/arm64/kernel/signal.c           |   4 +-
 arch/csky/kernel/ptrace.c            |   5 +-
 arch/csky/kernel/signal.c            |   4 +-
 arch/h8300/kernel/ptrace.c           |   5 +-
 arch/h8300/kernel/signal.c           |   4 +-
 arch/hexagon/kernel/process.c        |   4 +-
 arch/hexagon/kernel/signal.c         |   1 -
 arch/hexagon/kernel/traps.c          |   6 +-
 arch/ia64/kernel/process.c           |   4 +-
 arch/ia64/kernel/ptrace.c            |   6 +-
 arch/ia64/kernel/signal.c            |   1 -
 arch/m68k/kernel/ptrace.c            |   5 +-
 arch/m68k/kernel/signal.c            |   4 +-
 arch/microblaze/kernel/ptrace.c      |   5 +-
 arch/microblaze/kernel/signal.c      |   4 +-
 arch/mips/kernel/ptrace.c            |   5 +-
 arch/mips/kernel/signal.c            |   4 +-
 arch/nds32/include/asm/syscall.h     |   2 +-
 arch/nds32/kernel/ptrace.c           |   5 +-
 arch/nds32/kernel/signal.c           |   4 +-
 arch/nios2/kernel/ptrace.c           |   5 +-
 arch/nios2/kernel/signal.c           |   4 +-
 arch/openrisc/kernel/ptrace.c        |   5 +-
 arch/openrisc/kernel/signal.c        |   4 +-
 arch/parisc/kernel/ptrace.c          |   7 +-
 arch/parisc/kernel/signal.c          |   4 +-
 arch/powerpc/kernel/ptrace/ptrace.c  |   8 +-
 arch/powerpc/kernel/signal.c         |   4 +-
 arch/riscv/kernel/ptrace.c           |   5 +-
 arch/riscv/kernel/signal.c           |   4 +-
 arch/s390/include/asm/entry-common.h |   1 -
 arch/s390/kernel/ptrace.c            |   1 -
 arch/s390/kernel/signal.c            |   5 +-
 arch/sh/kernel/ptrace_32.c           |   5 +-
 arch/sh/kernel/signal_32.c           |   4 +-
 arch/sparc/kernel/ptrace_32.c        |   5 +-
 arch/sparc/kernel/ptrace_64.c        |   5 +-
 arch/sparc/kernel/signal32.c         |   1 -
 arch/sparc/kernel/signal_32.c        |   4 +-
 arch/sparc/kernel/signal_64.c        |   4 +-
 arch/um/kernel/process.c             |   4 +-
 arch/um/kernel/ptrace.c              |   5 +-
 arch/x86/kernel/ptrace.c             |   1 -
 arch/x86/kernel/signal.c             |   5 +-
 arch/x86/mm/tlb.c                    |   1 +
 arch/xtensa/kernel/ptrace.c          |   5 +-
 arch/xtensa/kernel/signal.c          |   4 +-
 block/blk-cgroup.c                   |   2 +-
 fs/coredump.c                        |   1 -
 fs/exec.c                            |   1 -
 fs/io-wq.c                           |   6 +-
 fs/io_uring.c                        |  11 +-
 fs/proc/array.c                      |   1 -
 fs/proc/base.c                       |   1 -
 include/asm-generic/syscall.h        |   2 +-
 include/linux/entry-common.h         |  47 +-------
 include/linux/entry-kvm.h            |   2 +-
 include/linux/posix-timers.h         |   1 -
 include/linux/ptrace.h               |  81 ++++++++++++-
 include/linux/resume_user_mode.h     |  64 ++++++++++
 include/linux/sched/signal.h         |  17 +++
 include/linux/task_work.h            |   5 +
 include/linux/tracehook.h            | 226 -----------------------------------
 include/uapi/linux/ptrace.h          |   2 +-
 kernel/entry/common.c                |  19 +--
 kernel/entry/kvm.c                   |   9 +-
 kernel/exit.c                        |   3 +-
 kernel/livepatch/transition.c        |   1 -
 kernel/ptrace.c                      |  47 +++++---
 kernel/seccomp.c                     |   1 -
 kernel/signal.c                      |  62 +++++-----
 kernel/task_work.c                   |   4 +-
 kernel/time/posix-cpu-timers.c       |   1 +
 mm/memcontrol.c                      |   2 +-
 security/apparmor/domain.c           |   1 -
 security/selinux/hooks.c             |   1 -
 85 files changed, 372 insertions(+), 495 deletions(-)

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

