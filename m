Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E5451E183
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 23:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444646AbiEFWDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 18:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350991AbiEFWDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 18:03:00 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BF8255AC;
        Fri,  6 May 2022 14:59:16 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:41340)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nn5yh-008b7d-Gi; Fri, 06 May 2022 15:59:11 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37292 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nn5yg-00Aw1E-9W; Fri, 06 May 2022 15:59:11 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net, oleg@redhat.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        tj@kernel.org, linux-pm@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Jann Horn <jannh@google.com>,
        linux-ia64@vger.kernel.org, Robert O'Callahan <roc@pernos.co>,
        Kyle Huey <khuey@pernos.co>
References: <20220421150248.667412396@infradead.org>
        <20220421150654.817117821@infradead.org>
        <87czhap9dy.fsf@email.froward.int.ebiederm.org>
        <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
        <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
        <202205061348.927E94729E@keescook>
Date:   Fri, 06 May 2022 16:59:03 -0500
In-Reply-To: <202205061348.927E94729E@keescook> (Kees Cook's message of "Fri,
        6 May 2022 14:26:36 -0700")
Message-ID: <87h762z5js.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nn5yg-00Aw1E-9W;;;mid=<87h762z5js.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/VPXqGxLyk6k3FEwGJyXklghMod61nqrE=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 506 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.2%), b_tie_ro: 10 (1.9%), parse: 1.00
        (0.2%), extract_message_metadata: 12 (2.5%), get_uri_detail_list: 1.90
        (0.4%), tests_pri_-1000: 14 (2.7%), tests_pri_-950: 1.30 (0.3%),
        tests_pri_-900: 1.15 (0.2%), tests_pri_-90: 74 (14.6%), check_bayes:
        73 (14.4%), b_tokenize: 10 (1.9%), b_tok_get_all: 12 (2.4%),
        b_comp_prob: 4.2 (0.8%), b_tok_touch_all: 43 (8.5%), b_finish: 0.91
        (0.2%), tests_pri_0: 360 (71.2%), check_dkim_signature: 0.58 (0.1%),
        check_dkim_adsp: 2.6 (0.5%), poll_dns_idle: 0.43 (0.1%), tests_pri_10:
        2.6 (0.5%), tests_pri_500: 25 (5.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v4 0/12] ptrace: cleaning up ptrace_stop
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Thu, May 05, 2022 at 01:25:57PM -0500, Eric W. Biederman wrote:
>> The states TASK_STOPPED and TASK_TRACE are special in they can not
>> handle spurious wake-ups.  This plus actively depending upon and
>> changing the value of tsk->__state causes problems for PREEMPT_RT and
>> Peter's freezer rewrite.
>> 
>> There are a lot of details we have to get right to sort out the
>> technical challenges and this is my parred back version of the changes
>> that contains just those problems I see good solutions to that I believe
>> are ready.
>> 
>> A couple of issues have been pointed but I think this parred back set of
>> changes is still on the right track.  The biggest change in v4 is the
>> split of "ptrace: Admit ptrace_stop can generate spuriuos SIGTRAPs" into
>> two patches because the dependency I thought exited between two
>> different changes did not exist.  The rest of the changes are minor
>> tweaks to "ptrace: Admit ptrace_stop can generate spuriuos SIGTRAPs";
>> removing an always true branch, and adding an early  test to see if the
>> ptracer had gone, before TASK_TRAPPING was set.
>> 
>> This set of changes should support Peter's freezer rewrite, and with the
>> addition of changing wait_task_inactive(TASK_TRACED) to be
>> wait_task_inactive(0) in ptrace_check_attach I don't think there are any
>> races or issues to be concerned about from the ptrace side.
>> 
>> More work is needed to support PREEMPT_RT, but these changes get things
>> closer.
>> 
>> This set of changes continues to look like it will provide a firm
>> foundation for solving the PREEMPT_RT and freezer challenges.
>
> One of the more sensitive projects to changes around ptrace is rr
> (Robert and Kyle added to CC). I ran rr's selftests before/after this
> series and saw no changes. My failures remained the same; I assume
> they're due to missing CPU features (pkeys) or build configs (bpf), etc:
>
> 99% tests passed, 19 tests failed out of 2777
>
> Total Test time (real) = 773.40 sec
>
> The following tests FAILED:
>          42 - bpf_map (Failed)
>          43 - bpf_map-no-syscallbuf (Failed)
>         414 - netfilter (Failed)
>         415 - netfilter-no-syscallbuf (Failed)
>         454 - x86/pkeys (Failed)
>         455 - x86/pkeys-no-syscallbuf (Failed)
>         1152 - ttyname (Failed)
>         1153 - ttyname-no-syscallbuf (Failed)
>         1430 - bpf_map-32 (Failed)
>         1431 - bpf_map-32-no-syscallbuf (Failed)
>         1502 - detach_sigkill-32 (Failed)
>         1802 - netfilter-32 (Failed)
>         1803 - netfilter-32-no-syscallbuf (Failed)
>         1842 - x86/pkeys-32 (Failed)
>         1843 - x86/pkeys-32-no-syscallbuf (Failed)
>         2316 - crash_in_function-32 (Failed)
>         2317 - crash_in_function-32-no-syscallbuf (Failed)
>         2540 - ttyname-32 (Failed)
>         2541 - ttyname-32-no-syscallbuf (Failed)
>
> So, I guess:
>
> Tested-by: Kees Cook <keescook@chromium.org>
>
> :)

Thank you.  I was thinking it would be good to add the rr folks to the
discussion.

Eric

