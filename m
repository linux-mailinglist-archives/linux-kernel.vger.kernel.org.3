Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4B2490B67
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240472AbiAQPco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:32:44 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:52512 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbiAQPcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:32:41 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:54108)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n9Tzs-004w04-6E; Mon, 17 Jan 2022 08:32:40 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:42762 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n9Tzr-0037Dt-3S; Mon, 17 Jan 2022 08:32:39 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>
References: <878rvhlvh2.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wgS865kHU=4NO=AvK07fcK7M6C6EYGdk80R1tkPKTLyhQ@mail.gmail.com>
Date:   Mon, 17 Jan 2022 09:31:48 -0600
In-Reply-To: <CAHk-=wgS865kHU=4NO=AvK07fcK7M6C6EYGdk80R1tkPKTLyhQ@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 17 Jan 2022 06:08:49 +0200")
Message-ID: <87bl0aidjv.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n9Tzr-0037Dt-3S;;;mid=<87bl0aidjv.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19ZWVrcOdq1hisGxVJ5gj7TZ9EAQIwa2/M=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMSubMetaSxObfu_03,XMSubMetaSx_00 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 477 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (2.3%), b_tie_ro: 9 (2.0%), parse: 0.87 (0.2%),
         extract_message_metadata: 16 (3.3%), get_uri_detail_list: 2.5 (0.5%),
        tests_pri_-1000: 14 (3.0%), tests_pri_-950: 1.21 (0.3%),
        tests_pri_-900: 1.02 (0.2%), tests_pri_-90: 61 (12.7%), check_bayes:
        59 (12.4%), b_tokenize: 9 (1.8%), b_tok_get_all: 11 (2.2%),
        b_comp_prob: 3.0 (0.6%), b_tok_touch_all: 33 (6.9%), b_finish: 0.85
        (0.2%), tests_pri_0: 361 (75.6%), check_dkim_signature: 0.54 (0.1%),
        check_dkim_adsp: 2.7 (0.6%), poll_dns_idle: 1.10 (0.2%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 7 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] signal/exit/ptrace changes for v5.17
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, Jan 15, 2022 at 2:00 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> I am currently investigating to figure out if wake_up_interruptible
>> (instead of simply wake_up) ever makes sense outside of the signal code.
>
> It may not be a huge deal, but it *absolutely* makes sense.
>
> Any subsystem that uses "wait_event_interruptible()" (or variations of
> that) should by default only use "wake_up_interruptible()" to wake the
> wait queue.
>
> The reason? Being (interruptibly) on one wait-queue does *NOT* make it
> impossible that the very same process isn't waiting non-interruptibly
> on another one.
>
> It's not hugely common, but the Linux kernel wait-queues have very
> much been designed for the whole "one process can be on multiple wait
> queues for different reasons at the same time" model. That is *very*
> core.
>
> People sometimes think that is just a "poll/select()" thing, but
> that's not at all true. It's quite valid to do things like
>
>         add_wait_queue(..)
>         for (.. some loop ..) {
>                 set_current_state(TASK_INTERRUPTIBLE);
>                 ... do various things, checking state etc ..
>                schedule();
>         }
>         set_current_state(TASK_RUNNABLE);
>         remove_wait_queue();
>
> and part of that "do various things" is obviously checking for signals
> and other "exit this wait loop", but other things can be things like
> taking a page fault because you copied data from user space etc.
>
> And that in turn may end up having a nested wait on another waitqueue
> (for the IO), and the outer wait queue should basically strive to not
> wake up unrelated "deeper" sleeps, because that is pointless and just
> causes extra wakeups.
>
> So the page fault event will cause a nested TASK_UNINTERRUPTIBLE
> sleep, and when that IO has completed, it goes into TASK_RUNNABLE, so
> the outer (interruptible) loop above will have a "dummy schedule()"
> and loop around again to be put back into TASK_INTERRUPTIBLE sleep
> next time around.
>
> But note how it would be pointless to use a "wake_up()" on this outer
> wait queue - it would wake up the deeper IO sleep too, and that would
> just see "oh, the IO I'm waiting for hasn't completed, so I'll just
> have to go to sleep again".
>
> Would it still _work_? Yes. Is the above _common_? No. But it's a
> really fundamnetal pattern in the kernel, and it's fundamentally how
> wait queues work, and how they should work, and an interruptible sleep
> should generally be seen as pairing with an interruptible wake,
> because that's just how things are.
>
> Why would you want to change something basic like that? Yes, using
> "wake_up()" instead of "wake_up_interruptible()" would still result in
> a working kernel, but it's just _pointless_.

Thank you for the detailed reply.  I am going to have to spend a little
bit digesting it.

They why is that I am digging into how to reliably test for and get
just the wakeups needed in the coredump code.

As a first approximation writing to files and causing dump_interrupted
to change for signal_pending to fatal_sending_pending worked like a
charm.  Unfortunately the pipe code is still performing interruptible
waits and io_uring causes truncated coredumps.

I would like to have a version of pipe_write that sleeps in
TASK_KILLABLE.  I want the I/O wake-ups and I want the SIGKILL wake ups
but I don't want any other wake-ups.  Unfortunately the I/O wake-ups in
the pipe code are sent with wake_up_interruptible.  So a task sleeping
in TASK_KILLABLE won't get them.

Which means that the obvious solution of changing
wait_event_interruptible to wake_event_killable breaks coredump support
(as I found out the hard way).

I understand things well enough that I can change the signal code and
not make the coredump code worse.  I am still trying to figure out what
a clean maintainable solution for coredumps writing to pipes is going to
be.  So I will dig in and read the code that has the nested wait queues
and see if I can understand that logic, and keep thinking about the
coredump support.

Eric
