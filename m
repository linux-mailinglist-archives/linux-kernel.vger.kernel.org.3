Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCDF4DDC35
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbiCROyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiCROyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:54:15 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97912D0835;
        Fri, 18 Mar 2022 07:52:56 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:45878)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nVDyJ-00CJx6-HL; Fri, 18 Mar 2022 08:52:55 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38510 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nVDyI-006KVX-DP; Fri, 18 Mar 2022 08:52:55 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <87bl1kunjj.fsf@email.froward.int.ebiederm.org>
        <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
        <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
        <87tubyx0rg.fsf_-_@email.froward.int.ebiederm.org>
        <875yoe7qdp.fsf_-_@email.froward.int.ebiederm.org>
        <202203171210.1239C9CDA@keescook>
Date:   Fri, 18 Mar 2022 09:52:46 -0500
In-Reply-To: <202203171210.1239C9CDA@keescook> (Kees Cook's message of "Thu,
        17 Mar 2022 12:13:09 -0700")
Message-ID: <871qyz2tz5.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nVDyI-006KVX-DP;;;mid=<871qyz2tz5.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Xkk/rie1UVhNBW+4aa3Bko7e6gG4T0Kg=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 573 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 12 (2.0%), b_tie_ro: 10 (1.7%), parse: 1.12
        (0.2%), extract_message_metadata: 16 (2.8%), get_uri_detail_list: 1.92
        (0.3%), tests_pri_-1000: 25 (4.4%), tests_pri_-950: 1.37 (0.2%),
        tests_pri_-900: 1.08 (0.2%), tests_pri_-90: 209 (36.5%), check_bayes:
        207 (36.2%), b_tokenize: 8 (1.4%), b_tok_get_all: 8 (1.4%),
        b_comp_prob: 2.6 (0.5%), b_tok_touch_all: 185 (32.2%), b_finish: 0.93
        (0.2%), tests_pri_0: 291 (50.8%), check_dkim_signature: 0.65 (0.1%),
        check_dkim_adsp: 3.2 (0.6%), poll_dns_idle: 1.21 (0.2%), tests_pri_10:
        2.3 (0.4%), tests_pri_500: 11 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/2] ptrace: Return the signal to continue with from
 ptrace_stop
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Tue, Mar 15, 2022 at 06:22:26PM -0500, Eric W. Biederman wrote:
>> 
>> The signal a task should continue with after a ptrace stop is
>> inconsistently read, cleared, and sent.  Solve this by reading and
>> clearing the signal to be sent in ptrace_stop.
>> 
>> In an ideal world everything except ptrace_signal would share a common
>> implementation of continuing with the signal, so ptracers could count
>> on the signal they ask to continue with actually being delivered.  For
>> now retain bug compatibility and just return with the signal number
>> the ptracer requested the code continue with.
>> 
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  include/linux/ptrace.h | 12 ++++++------
>>  kernel/signal.c        | 31 ++++++++++++++++++-------------
>>  2 files changed, 24 insertions(+), 19 deletions(-)
>> 
>> diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
>> index 3e6b46e2b7be..15b3d176b6b4 100644
>> --- a/include/linux/ptrace.h
>> +++ b/include/linux/ptrace.h
>> @@ -60,7 +60,7 @@ extern int ptrace_writedata(struct task_struct *tsk, char __user *src, unsigned
>>  extern void ptrace_disable(struct task_struct *);
>>  extern int ptrace_request(struct task_struct *child, long request,
>>  			  unsigned long addr, unsigned long data);
>> -extern void ptrace_notify(int exit_code, unsigned long message);
>> +extern int ptrace_notify(int exit_code, unsigned long message);
>> [...]
>> -static void ptrace_stop(int exit_code, int why, int clear_code,
>> +static int ptrace_stop(int exit_code, int why, int clear_code,
>>  			unsigned long message, kernel_siginfo_t *info)
>> [...]
>> -static void ptrace_do_notify(int signr, int exit_code, int why, unsigned long message)
>> +static int ptrace_do_notify(int signr, int exit_code, int why, unsigned long message)
>> [...]
>> -void ptrace_notify(int exit_code, unsigned long message)
>> +int ptrace_notify(int exit_code, unsigned long message)
>
> Just for robustness, how about marking the functions that have switched
> from void to int return as __must_check (or at least just ptrace_notify)?

We can't.  There are historical cases that simply don't check if a
signal should be sent after the function, and they exist for every
function that is modified.

If we can modify the code so that everyone is checking the return value
than certainly, but that just doesn't happen to reflect how this
ptrace helper is being used today.

> With that and the style nit Oleg already mentioned, yeah, this looks
> good too.

Alright style nit fixed.

> Reviewed-by: Kees Cook <keescook@chromium.org>

Eric

