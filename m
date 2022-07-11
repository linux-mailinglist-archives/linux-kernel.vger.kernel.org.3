Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD75570A36
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 20:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiGKS6b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Jul 2022 14:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGKS6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 14:58:30 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4412981D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 11:58:29 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:60174)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oAyc0-009Spw-17; Mon, 11 Jul 2022 12:58:28 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:36236 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oAyby-00BbzY-Qe; Mon, 11 Jul 2022 12:58:27 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <YrslT9h0whngMIhw@zx2c4.com>
        <20220628161441.892925-1-Jason@zx2c4.com> <YsLbggVXONPJcZsn@zx2c4.com>
        <CAHmME9qt9hUTgJQSdv3_Yzkc3e7H8OkhPSv_pUaXV_2AOA1S=g@mail.gmail.com>
Date:   Mon, 11 Jul 2022 13:57:55 -0500
In-Reply-To: <CAHmME9qt9hUTgJQSdv3_Yzkc3e7H8OkhPSv_pUaXV_2AOA1S=g@mail.gmail.com>
        (Jason A. Donenfeld's message of "Mon, 11 Jul 2022 19:53:58 +0200")
Message-ID: <87o7xvcw98.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1oAyby-00BbzY-Qe;;;mid=<87o7xvcw98.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+yibo3j9tgKX9sWkguCQrnLgqK1MYZqKI=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;"Jason A. Donenfeld" <Jason@zx2c4.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 632 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 13 (2.1%), b_tie_ro: 12 (1.8%), parse: 1.74
        (0.3%), extract_message_metadata: 35 (5.6%), get_uri_detail_list: 6
        (1.0%), tests_pri_-1000: 35 (5.5%), tests_pri_-950: 1.45 (0.2%),
        tests_pri_-900: 1.11 (0.2%), tests_pri_-90: 71 (11.3%), check_bayes:
        65 (10.2%), b_tokenize: 13 (2.1%), b_tok_get_all: 11 (1.8%),
        b_comp_prob: 3.7 (0.6%), b_tok_touch_all: 33 (5.2%), b_finish: 0.87
        (0.1%), tests_pri_0: 452 (71.5%), check_dkim_signature: 0.92 (0.1%),
        check_dkim_adsp: 7 (1.1%), poll_dns_idle: 0.54 (0.1%), tests_pri_10:
        3.8 (0.6%), tests_pri_500: 13 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3] signal: break out of wait loops on kthread_stop()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:

> Hi Eric,
>
> On Mon, Jul 4, 2022 at 2:22 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>>
>> Hey Eric,
>>
>> On Tue, Jun 28, 2022 at 06:14:41PM +0200, Jason A. Donenfeld wrote:
>> > I was recently surprised to learn that msleep_interruptible(),
>> > wait_for_completion_interruptible_timeout(), and related functions
>> > simply hung when I called kthread_stop() on kthreads using them. The
>> > solution to fixing the case with msleep_interruptible() was more simply
>> > to move to schedule_timeout_interruptible(). Why?
>> >
>> > The reason is that msleep_interruptible(), and many functions just like
>> > it, has a loop like this:
>> >
>> >         while (timeout && !signal_pending(current))
>> >                 timeout = schedule_timeout_interruptible(timeout);
>> >
>> > The call to kthread_stop() woke up the thread, so schedule_timeout_
>> > interruptible() returned early, but because signal_pending() returned
>> > true, it went back into another timeout, which was never woken up.
>> >
>> > This wait loop pattern is common to various pieces of code, and I
>> > suspect that the subtle misuse in a kthread that caused a deadlock in
>> > the code I looked at last week is also found elsewhere.
>> >
>> > So this commit causes signal_pending() to return true when
>> > kthread_stop() is called, by setting TIF_NOTIFY_SIGNAL.
>> >
>> > The same also applies to the similar kthread_park() functionality.
>> >
>> > Cc: Ingo Molnar <mingo@redhat.com>
>> > Cc: Peter Zijlstra <peterz@infradead.org>
>> > Cc: Eric W. Biederman <ebiederm@xmission.com>
>> > Cc: Toke Høiland-Jørgensen <toke@redhat.com>
>> > Cc: Kalle Valo <kvalo@kernel.org>
>> > Cc: Johannes Berg <johannes@sipsolutions.net>
>> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>> > ---
>> >  kernel/kthread.c | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> > diff --git a/kernel/kthread.c b/kernel/kthread.c
>> > index 3c677918d8f2..63d5a1f4cb93 100644
>> > --- a/kernel/kthread.c
>> > +++ b/kernel/kthread.c
>> > @@ -661,12 +661,14 @@ int kthread_park(struct task_struct *k)
>> >
>> >       set_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
>> >       if (k != current) {
>> > +             test_and_set_tsk_thread_flag(k, TIF_NOTIFY_SIGNAL);
>> >               wake_up_process(k);
>> >               /*
>> >                * Wait for __kthread_parkme() to complete(), this means we
>> >                * _will_ have TASK_PARKED and are about to call schedule().
>> >                */
>> >               wait_for_completion(&kthread->parked);
>> > +             clear_tsk_thread_flag(k, TIF_NOTIFY_SIGNAL);
>> >               /*
>> >                * Now wait for that schedule() to complete and the task to
>> >                * get scheduled out.
>> > @@ -704,8 +706,10 @@ int kthread_stop(struct task_struct *k)
>> >       kthread = to_kthread(k);
>> >       set_bit(KTHREAD_SHOULD_STOP, &kthread->flags);
>> >       kthread_unpark(k);
>> > +     test_and_set_tsk_thread_flag(k, TIF_NOTIFY_SIGNAL);
>> >       wake_up_process(k);
>> >       wait_for_completion(&kthread->exited);
>> > +     clear_tsk_thread_flag(k, TIF_NOTIFY_SIGNAL);
>> >       ret = kthread->result;
>> >       put_task_struct(k);
>> >
>> > --
>> > 2.35.1
>> >
>>
>> Is this more to the tune of what you had in mind in your message [1]?
>>
>> Jason
>>
>> [1] https://lore.kernel.org/lkml/877d51udc7.fsf@email.froward.int.ebiederm.org/
>
> Paging again...

Overall it looks reasonable.

For kthread_stop clearing TIF_NOTIFY_SIGNAL seems pointless as the
process has exited.

I wonder if we should clear TIF_NOTIFY_SIGNAL in kthread_parkme.

Ordinarily TIF_NOTIFY_SIGNAL gets cleared when the target process
calls get_signal.  Which doesn't happen for kernel threads.
So I am not certain what the best pattern is, but my sense is that
keeping things as close to how TIF_NOTIFY_SIGNAL is processed
in the rest of the kernel seems the least error prone pattern.

So I am thinking the code should do something like:

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 544fd4097406..c80e8d44e405 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -266,6 +266,7 @@ static void __kthread_parkme(struct kthread *self)
 		 * changin from TASK_PARKED and us failing the
 		 * wait_task_inactive() in kthread_park().
 		 */
+		clear_notify_signal();
 		set_special_state(TASK_PARKED);
 		if (!test_bit(KTHREAD_SHOULD_PARK, &self->flags))
 			break;


To ensure that TIF_NOTIFY_SIGNAL is not set.

I am trying to think about how things interact if two threads call
kthread_park.  If the target thread is not responsible for clearing
TIF_NOTIFY_SIGNAL it feels like two threads could get into a race.  A
race where one thread sees the target thread has parked itself right
after another thread calls kthread_park and sets TIF_NOTIFY_SIGNAL.

Given the nature of kthread_park that scenario is probably completely
ridiculous, but it is all I can think of at the moment to demonstrate
my concerns.

In practice kthread_park is pretty specialized.  Do you have any
evidence that we need to break out of interruptible loops to make it
more reliable.  Perhaps it is best just to handle kthread_stop, and
leave kthread_park for when it actually matters.  Which would ensure
there are examples that people care about to help sort through exactly
how the code should behave in the kthread_park case.

Which I guess my long way of saying I think you can just change
kthread_stop to say:

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 544fd4097406..52e9b3432496 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -704,6 +704,7 @@ int kthread_stop(struct task_struct *k)
 	kthread = to_kthread(k);
 	set_bit(KTHREAD_SHOULD_STOP, &kthread->flags);
 	kthread_unpark(k);
+	set_tsk_thread_flag(k, TIF_NOTIFY_SIGNAL);
 	wake_up_process(k);
 	wait_for_completion(&kthread->exited);
 	ret = kthread->result;


Your patch is correct that most of set_notify_signal is redundant with
wake_up_process(k).  Further if you aren't going to use the return value
like set_notify_signal does there is no need to test if the flag gets
set.

Eric

