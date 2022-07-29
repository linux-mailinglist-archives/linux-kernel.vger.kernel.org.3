Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84F058535A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 18:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbiG2QSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 12:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiG2QSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 12:18:15 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF0C88CEC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 09:18:10 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:36524)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oHSgj-006ViV-07; Fri, 29 Jul 2022 10:18:09 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34452 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oHSgh-003rm2-VS; Fri, 29 Jul 2022 10:18:08 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org
References: <YthsgqAZYnwHZLn+@tycho.pizza>
        <20220721015459.GA4297@mail.hallyn.com> <YuFdUj5X4qckC/6g@tycho.pizza>
        <20220727175538.GC18822@redhat.com> <YuGBXnqb5rPwAlYk@tycho.pizza>
        <20220727191949.GD18822@redhat.com> <YuGUyayVWDB7R89i@tycho.pizza>
        <20220728091220.GA11207@redhat.com> <YuL9uc8WfiYlb2Hw@tycho.pizza>
        <87pmhofr1q.fsf@email.froward.int.ebiederm.org>
        <YuPlqp0jSvVu4WBK@tycho.pizza>
Date:   Fri, 29 Jul 2022 11:15:28 -0500
In-Reply-To: <YuPlqp0jSvVu4WBK@tycho.pizza> (Tycho Andersen's message of "Fri,
        29 Jul 2022 07:50:34 -0600")
Message-ID: <87v8rfevz3.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oHSgh-003rm2-VS;;;mid=<87v8rfevz3.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX190TV86l60ISfkFnfhVXBGwRERgjN7W5wI=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Tycho Andersen <tycho@tycho.pizza>
X-Spam-Relay-Country: 
X-Spam-Timing: total 460 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.8 (1.0%), b_tie_ro: 3.3 (0.7%), parse: 1.10
        (0.2%), extract_message_metadata: 11 (2.4%), get_uri_detail_list: 2.5
        (0.5%), tests_pri_-1000: 10 (2.1%), tests_pri_-950: 1.04 (0.2%),
        tests_pri_-900: 0.77 (0.2%), tests_pri_-90: 120 (26.1%), check_bayes:
        117 (25.5%), b_tokenize: 6 (1.3%), b_tok_get_all: 66 (14.4%),
        b_comp_prob: 3.1 (0.7%), b_tok_touch_all: 39 (8.4%), b_finish: 0.68
        (0.1%), tests_pri_0: 298 (64.7%), check_dkim_signature: 0.39 (0.1%),
        check_dkim_adsp: 2.6 (0.6%), poll_dns_idle: 0.95 (0.2%), tests_pri_10:
        2.6 (0.6%), tests_pri_500: 8 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] sched: __fatal_signal_pending() should also check
 PF_EXITING
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tycho Andersen <tycho@tycho.pizza> writes:

> On Fri, Jul 29, 2022 at 12:04:17AM -0500, Eric W. Biederman wrote:
>> Tycho Andersen <tycho@tycho.pizza> writes:
>> 
>> > On Thu, Jul 28, 2022 at 11:12:20AM +0200, Oleg Nesterov wrote:
>
>> >> Finally. if fuse_flush() wants __fatal_signal_pending() == T when the
>> >> caller exits, perhaps it can do it itself? Something like
>> >> 
>> >> 	if (current->flags & PF_EXITING) {
>> >> 		spin_lock_irq(siglock);
>> >> 		set_thread_flag(TIF_SIGPENDING);
>> >> 		sigaddset(&current->pending.signal, SIGKILL);
>> >> 		spin_unlock_irq(siglock);
>> >> 	}
>> >> 
>> >> Sure, this is ugly as hell. But perhaps this can serve as a workaround?
>> >
>> > or even just
>> >
>> >     if (current->flags & PF_EXITING)
>> >         return;
>> >
>> > since we don't have anyone to send the result of the flush to anyway.
>> > If we don't end up converging on a fix here, I'll just send that
>> > patch. Thanks for the suggestion.
>> 
>> If that was limited to the case you care about that would be reasonable.
>> 
>> That will have an effect on any time a process that opens files on a
>> fuse filesystem exits and depends upon the exit path to close it's file
>> descriptors to the fuse filesystem.
>> 
>> 
>> I do see a plausible solution along those lines.
>> 
>> In fuse_flush instead of using fuse_simple_request call an equivalent
>> function that when PF_EXITING is true skips calling request_wait_answer.
>> Or perhaps when PF_EXITING is set uses schedule_work to call the
>> request_wait_answer.
>
> I don't see why this is any different than what I proposed. It changes
> the semantics to flush happening out-of-order with task exit, instead
> of strictly before, which you point out might be a problem. What am I
> missing?

What you proposed skips the flush operation entirely.  Which means
that a fuse server that tracks opens and closes of a file descriptor
will see more opens than closes and will have a reference counting
problem (probably resulting in things not being freed).

Simply skipping the wait for the result from the fuse server means
the fuse server sees what it has always seen.  The kernel simply won't
block until that result has been returned.  Which means the other file
descriptors can be closed.


For the specific case you are looking at with the server being killed
and server's file descriptors not yet being closed, the difference
does not matter.  In the ordinary case of a process exit closing file
descriptors to a fuse filesystem where the server continues to live
and function not waiting for the response from the server simply
winds up being an optimization, in exit.  The key part is the fuse
server continues to see the same traffic.  In particular the open
requests and the flush requests continue to balance, so reference
counting in the fuse server is not broken.

Eric
