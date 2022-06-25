Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF27655ABB2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 19:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbiFYRE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 13:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiFYREz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 13:04:55 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC06414020;
        Sat, 25 Jun 2022 10:04:54 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:41708)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o59DJ-008ljH-LL; Sat, 25 Jun 2022 11:04:53 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57554 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o59DI-009wBm-Ke; Sat, 25 Jun 2022 11:04:53 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>
References: <20220620111520.1039685-1-vschneid@redhat.com>
Date:   Sat, 25 Jun 2022 12:04:46 -0500
In-Reply-To: <20220620111520.1039685-1-vschneid@redhat.com> (Valentin
        Schneider's message of "Mon, 20 Jun 2022 12:15:20 +0100")
Message-ID: <87r13c7jyp.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o59DI-009wBm-Ke;;;mid=<87r13c7jyp.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18w4luJIoAO0o2bnltbvBhRK+Y2TiFzlm0=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Valentin Schneider <vschneid@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 463 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 12 (2.6%), b_tie_ro: 10 (2.2%), parse: 1.02
        (0.2%), extract_message_metadata: 4.2 (0.9%), get_uri_detail_list:
        1.79 (0.4%), tests_pri_-1000: 4.3 (0.9%), tests_pri_-950: 1.28 (0.3%),
        tests_pri_-900: 1.09 (0.2%), tests_pri_-90: 73 (15.7%), check_bayes:
        71 (15.4%), b_tokenize: 9 (1.9%), b_tok_get_all: 9 (2.0%),
        b_comp_prob: 2.9 (0.6%), b_tok_touch_all: 46 (9.9%), b_finish: 1.14
        (0.2%), tests_pri_0: 340 (73.4%), check_dkim_signature: 1.02 (0.2%),
        check_dkim_adsp: 4.6 (1.0%), poll_dns_idle: 1.03 (0.2%), tests_pri_10:
        2.3 (0.5%), tests_pri_500: 14 (3.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2] panic, kexec: Make __crash_kexec() NMI safe
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valentin Schneider <vschneid@redhat.com> writes:

> Attempting to get a crash dump out of a debug PREEMPT_RT kernel via an NMI
> panic() doesn't work. The cause of that lies in the PREEMPT_RT definition
> of mutex_trylock():
>
> 	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES) && WARN_ON_ONCE(!in_task()))
> 		return 0;
>
> This prevents an NMI panic() from executing the main body of
> __crash_kexec() which does the actual kexec into the kdump kernel.
> The warning and return are explained by:
>
>   6ce47fd961fa ("rtmutex: Warn if trylock is called from hard/softirq context")
>   [...]
>   The reasons for this are:
>
>       1) There is a potential deadlock in the slowpath
>
>       2) Another cpu which blocks on the rtmutex will boost the task
> 	 which allegedly locked the rtmutex, but that cannot work
> 	 because the hard/softirq context borrows the task context.
>
> Furthermore, grabbing the lock isn't NMI safe, so do away with it and
> use an atomic variable to serialize reads vs writes of
> kexec_crash_image.
>
> Tested by triggering NMI panics via:
>
>   $ echo 1 > /proc/sys/kernel/panic_on_unrecovered_nmi
>   $ echo 1 > /proc/sys/kernel/unknown_nmi_panic
>   $ echo 1 > /proc/sys/kernel/panic
>
>   $ ipmitool power diag
>
> Fixes: 6ce47fd961fa ("rtmutex: Warn if trylock is called from hard/softirq context")
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

I am not particularly fond of this patch as it adds more complexity than
is necessary to solve the problem.

Calling a spade a spade PREEMPT_RT's mutex_trylock implementation is
broken as it can not support the use cases of an ordinary mutex_trylock.
I have not seen (possibly I skimmed too quickly) anywhere in the
discussion why PREEMPT_RT is not being fixed.  Looking at the code
there is enough going on in try_to_take_rt_mutex that I can imagine
that some part of that code is not nmi safe.  So I can believe
PREEMPT_RT may be unfix-ably broken.


At this point I recommend going back to being ``unconventional'' with
the kexec locking and effectively reverting commit 8c5a1cf0ad3a ("kexec:
use a mutex for locking rather than xchg()").

That would also mean that we don't have to worry about the lockdep code
doing something weird in the future and breaking kexec.

Your change starting to is atomic_cmpxchng is most halfway to a revert
of commit 8c5a1cf0ad3a ("kexec: use a mutex for locking rather than
xchg()").  So we might as well go the whole way and just document that
the kexec on panic code can not use conventional kernel locking
primitives and has to dig deep and build it's own.  At which point it
makes no sense for the rest of the kexec code to use anything different.

Eric
