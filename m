Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8683D4B2C04
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352298AbiBKRrV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Feb 2022 12:47:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbiBKRrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:47:19 -0500
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E3838D;
        Fri, 11 Feb 2022 09:47:18 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:59888)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nIa0r-002bKF-9q; Fri, 11 Feb 2022 10:47:17 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:47708 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nIa0p-000awb-T4; Fri, 11 Feb 2022 10:47:16 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Robert =?utf-8?B?xZp3acSZY2tp?= <robert@swiecki.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20220210025321.787113-1-keescook@chromium.org>
        <871r0a8u29.fsf@email.froward.int.ebiederm.org>
        <202202101033.9C04563D9@keescook>
        <87pmnu5z28.fsf@email.froward.int.ebiederm.org>
        <202202101137.B48D02138@keescook>
        <87k0e249tt.fsf@email.froward.int.ebiederm.org>
        <202202101710.668EDCDC@keescook>
        <875ypm41kb.fsf@email.froward.int.ebiederm.org>
        <202202101827.4B16DF54@keescook>
        <CAP145phAg3ZSPJw7x2kKVQe86puy-XyKatVoByVoM27RP4aw_g@mail.gmail.com>
Date:   Fri, 11 Feb 2022 11:46:53 -0600
In-Reply-To: <CAP145phAg3ZSPJw7x2kKVQe86puy-XyKatVoByVoM27RP4aw_g@mail.gmail.com>
        ("Robert =?utf-8?B?xZp3acSZY2tpIidz?= message of "Fri, 11 Feb 2022 13:54:26
 +0100")
Message-ID: <87a6ex1ek2.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1nIa0p-000awb-T4;;;mid=<87a6ex1ek2.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19jyVwxhC+hd4WN4KzZaWrSUkzBjMUuQTQ=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAD_ENC_HEADER,BAYES_00,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: =?ISO-8859-1?Q?**;Robert =c5=9awi=c4=99cki <robert@swiecki.net>?=
X-Spam-Relay-Country: 
X-Spam-Timing: total 690 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 9 (1.3%), b_tie_ro: 8 (1.1%), parse: 1.07 (0.2%),
        extract_message_metadata: 13 (1.9%), get_uri_detail_list: 2.5 (0.4%),
        tests_pri_-1000: 12 (1.8%), tests_pri_-950: 1.25 (0.2%),
        tests_pri_-900: 1.01 (0.1%), tests_pri_-90: 120 (17.4%), check_bayes:
        116 (16.9%), b_tokenize: 9 (1.3%), b_tok_get_all: 9 (1.4%),
        b_comp_prob: 3.2 (0.5%), b_tok_touch_all: 91 (13.1%), b_finish: 0.99
        (0.1%), tests_pri_0: 506 (73.2%), check_dkim_signature: 0.59 (0.1%),
        check_dkim_adsp: 2.7 (0.4%), poll_dns_idle: 0.51 (0.1%), tests_pri_10:
        4.1 (0.6%), tests_pri_500: 20 (2.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/3] signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Święcki <robert@swiecki.net> writes:

>> It's mainly about the exit stuff having never been run before on these
>> kinds of process states, so things don't make sense. For example, on the
>> SIGSYS death, the registers have been rewound for the coredump, so when
>> the exit trace runs on x86 it sees the syscall return value as equal to
>> the syscall number (since %rax is used for the syscall number on entry
>> and for the syscall result on exit). So when a tracer watches a seccomp
>> fatal SIGSYS, it sees the syscall exit before it sees the child exit
>> (and therefore the signal). For example, x86_64 write (syscall number
>> 1), will return as if it had written 1 byte. :P
>>
>> So, it's not harmful, but it's confusing and weird. :)
>>
>> > I am trying to figure out if there is a case to be made that it was a
>> > bug that these events were missing.
>>
>> I don't think so -- the syscall did not finish, so there isn't a valid
>> return code. The process exited before it completed.

With the process state rewound for the coredump it makes sense
why the syscall exit would be meaningless.  So at least for
now I am convinced function that clears all syscall_work flags
is the way to go.

> A tangential point: please ignore for the purpose of fixing the
> problem at hand. I'm mostly making it, in case it can be taken into
> account in case some bigger changes to this code path are to be made -
> given that it touches the problem of signal delivery.
>
> When I noticed this problem, I was looking for a way to figure out
> what syscall caused SIGSYS (via SECCOMP_RET_KILL_*), and there's no
> easy way to do that programmatically from the perspective of a parent
> process. There are three ways of doing this that come to mind.

Unless I am misunderstanding what you are looking for
this information is contained within the SIGSYS siginfo.
The field si_syscall contains the system call number and
the field si_errno contains return code from the seccomp filter.

All of that can be read from the core dump of the process that exited.

Looking quickly I don't see a good way to pull that signal information
out of the kernel other than with a coredump.

It might be possible to persuade PTRACE_EVENT_EXIT to give it to you,
but I haven't looked at it enough to see if that would be a sensible
strategy.


> 1). Keep reference to /proc/<child>/syscall and read it upon process
> exiting by SIGSYS (and reading it with wait/id(WNOWAIT) from parent).
> This used to work a long time ago, but was racy (I reported this
> problem many years ago), and currently only -1 0 0 is returned (as in,
> no syscall in progress).

That might be a bug worth fixing.  But it would definitely need a test
that is run regularly to prevent future regressions.

> 2). Use ptrace - it works but it changes the logic of the signal
> delivery inside a traced process and requires non-trivial code to make
> it work correctly: use of PT_INTERRUPT, understanding all signal
> delivery events, registers and their mapping to syscall arguments per
> CPU arch.

I guess this works because you can see which syscall occurred before the
SECCOMP_RET_KILL.  Except for the bugs we are discussing fixing there
isn't a ptrace_stop after SECCOMP_RET_KILL.

> 3). auditd will print details of failed syscall to kmsg, but the
> string is not very structured, and auditd might not be always present
> inside kernels. And reading that data via netlink requires root IIRC.

I assume this is the same you can see which syscall occurred before
the SECCOMP_RET_KILL.

>
> I think it'd be good to have some way of doing it from the perspective
> of a parent process - it'd simplify development of sandboxing managers
> (eg nsjail, minijail, firejail), and creation of good seccomp
> policies.

By development do you mean debugging sandbox managers?  Or do you mean
something that sandbox managers can use on a routine basis?

Eric
