Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB0D58511D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbiG2NvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbiG2Nux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:50:53 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E32E3342F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 06:50:40 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2FB6B5C00FC;
        Fri, 29 Jul 2022 09:50:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 29 Jul 2022 09:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659102637; x=1659189037; bh=kKFiV6gyWo
        av6+Enn7P+BnJhXrGuC4LVFBAihgW511M=; b=IIakNWhASf+JRqce8/F/qYCiQh
        cg3MrUy6zpGrbsgfFH++OvHT0lFqyrWkQkbv6fGJtgs1qVriHk0Siz0FbGLGQHaZ
        j4cp/ziZHc+yY6K7eR7Ie9UsPmEUkdwDYIvsjK+pXXfsSUb+MISKfDiLU+naBw+O
        iMytad2vZQpU3X72hUo0j2gN0NZnk6OeQVerFmedym0+jJkksq+jfZ1WJFNwYDcA
        N1NmF2O+MuxnXvGufW4JwPl27i8Unl25LMfFO6e1hlXedx27Yrm5m8m8n/EpIDTc
        xhHYVTUuX8RfXH2MtV0MxDnsp7bgSuVwDiVPj+2r4K8DGh/Vx+qx+hP4dMqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1659102637; x=1659189037; bh=kKFiV6gyWoav6+Enn7P+BnJhXrGu
        C4LVFBAihgW511M=; b=XJmwo7qHhMWTPbFWc77m65SSc6w4T5m9h3iWDeahJVgF
        qMnQl6IbN+8iOJ4jIb7EIhG2NUvvD9L46jTF5DVRQQvWPgEwLlxo6iR6vETIzmkj
        6QezJeh2WcmgEkd8g6k1OVZLEKgttx9TbcSqAHr9KJzeKvBpWqkBXhADJy45yAN3
        WQRz8itfLIO+u0UezUOQpBJPkXrx0nyTSWVef1PNSRMo5T6LHd/g4cJ3hpKKAkZA
        kvt6LNlW+JHH0uZElBrww8BEhOTSjBF732Nr1yFEbLL1gYGBgVJDC6ZaDpZL3dde
        VTAIXJltRV6uNc5HACXiNK+TnBeJs6oAjqF5G2EOQg==
X-ME-Sender: <xms:rOXjYltoKI6KwHkzRGSIo2iG1P_LyW9HbybYVjw2SSlZJv829Eif8g>
    <xme:rOXjYudM0DoXEvXkfBU3RUFAO5QlubORdpkNUODyYjQZsaHXaWfTJbK9gNSI9rpAT
    -81JmAYn5yhbeIjFqI>
X-ME-Received: <xmr:rOXjYoygHF6Es7_vsVAZU2WKKuwzcpgDlHbYYABjzBnNvzC3uwsa6SxPUAQyExX0xUvEuBijzMk7VW9ZhnUSj2aqSrBF0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddujedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:rOXjYsOPYXhHJLtRKMo7sXoJ1AO6y-GaIPtd8YPKuUhI006fYNMG0w>
    <xmx:rOXjYl8su8bRBD1hXJ3F1gTFVZ4uO4clK5r627bmsrTJlj0tgunbqQ>
    <xmx:rOXjYsXaCZJ-zzO-m6uYdzernvjk_kMc4MrK48prBfxGv5ODcxaDfQ>
    <xmx:reXjYgb0RtFIX41nXhKx85Z-bwaoCVvFEx2OfRBJcNm_gYS8PxBpew>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Jul 2022 09:50:36 -0400 (EDT)
Date:   Fri, 29 Jul 2022 07:50:34 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: __fatal_signal_pending() should also check
 PF_EXITING
Message-ID: <YuPlqp0jSvVu4WBK@tycho.pizza>
References: <YthsgqAZYnwHZLn+@tycho.pizza>
 <20220721015459.GA4297@mail.hallyn.com>
 <YuFdUj5X4qckC/6g@tycho.pizza>
 <20220727175538.GC18822@redhat.com>
 <YuGBXnqb5rPwAlYk@tycho.pizza>
 <20220727191949.GD18822@redhat.com>
 <YuGUyayVWDB7R89i@tycho.pizza>
 <20220728091220.GA11207@redhat.com>
 <YuL9uc8WfiYlb2Hw@tycho.pizza>
 <87pmhofr1q.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmhofr1q.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 12:04:17AM -0500, Eric W. Biederman wrote:
> Tycho Andersen <tycho@tycho.pizza> writes:
> 
> > On Thu, Jul 28, 2022 at 11:12:20AM +0200, Oleg Nesterov wrote:
> >> This is clear, but it seems you do not understand me. Let me try again
> >> to explain and please correct me if I am wrong.
> >> 
> >> To simplify, lets suppose we have a single-thread task T which simply
> >> does
> >> 	__set_current_state(TASK_KILLABLE);
> >> 	schedule();
> >> 
> >> in the do_exit() paths after exit_signals() which sets PF_EXITING. Btw,
> >> note that it even documents that this thread is not "visible" for the
> >> group-wide signals, see below.
> >> 
> >> Now, suppose that this task is running and you send SIGKILL. T will
> >> dequeue SIGKILL from T->penging and call do_exit(). However, it won't
> >> remove SIGKILL from T->signal.shared_pending(), and this means that
> >> signal_pending(T) is still true.
> >> 
> >> Now. If we add a PF_EXITING or sigismember(shared_pending, SIGKILL) check
> >> into __fatal_signal_pending(), then yes, T won't block in schedule(),
> >> schedule()->signal_pending_state() will return true.
> >> 
> >> But what if T exits on its own? It will block in schedule() forever.
> >> schedule()->signal_pending_state() will not even check __fatal_signal_pending(),
> >> signal_pending() == F.
> >> 
> >> Now if you send SIGKILL to this task, SIGKILL won't wake it up or even
> >> set TIF_SIGPENDING, complete_signal() will do nothing.
> >> 
> >> See?
> >> 
> >> I agree, we should probably cleanup this logic and define how exactly
> >> the exiting task should react to signals (not only fatal signals). But
> >> your patch certainly doesn't look good to me and it is not enough.
> >> May be we can change get_signal() to not remove SIGKILL from t->pending
> >> for the start... not sure, this needs another discussion.
> >
> > Thank you for this! Between that and Eric's line about:
> >
> >> Frankly that there are some left over SIGKILL bits in the pending mask
> >> is a misfeature, and it is definitely not something you should count on.
> >
> > I think I finally maybe understand the objections.
> >
> > Is it fair to say that a task with PF_EXITING should never wait? I'm
> > wondering if a solution would be to patch the wait code to look for
> > PF_EXITING, in addition to checking the signal state.
> 
> That will at a minimum change zap_pid_ns_processes to busy wait
> instead of sleeping while it waits for children to die.
> 
> So we would need to survey the waits that can happen when closing file
> descriptors and any other place on the exit path to see how much impact
> a such a change would do.

Oh, yes, of course.

> It might be possible to allow an extra SIGKILL to terminate such waits.
> We do something like that for coredumps.  But that is incredibly subtle
> and a pain to maintain so I want to avoid that if we can.

Yeah, it feels better to clean up these waits. If we thought we got
them all we could maybe even stick a WARN() in the wait code.

> >> Finally. if fuse_flush() wants __fatal_signal_pending() == T when the
> >> caller exits, perhaps it can do it itself? Something like
> >> 
> >> 	if (current->flags & PF_EXITING) {
> >> 		spin_lock_irq(siglock);
> >> 		set_thread_flag(TIF_SIGPENDING);
> >> 		sigaddset(&current->pending.signal, SIGKILL);
> >> 		spin_unlock_irq(siglock);
> >> 	}
> >> 
> >> Sure, this is ugly as hell. But perhaps this can serve as a workaround?
> >
> > or even just
> >
> >     if (current->flags & PF_EXITING)
> >         return;
> >
> > since we don't have anyone to send the result of the flush to anyway.
> > If we don't end up converging on a fix here, I'll just send that
> > patch. Thanks for the suggestion.
> 
> If that was limited to the case you care about that would be reasonable.
> 
> That will have an effect on any time a process that opens files on a
> fuse filesystem exits and depends upon the exit path to close it's file
> descriptors to the fuse filesystem.
> 
> 
> I do see a plausible solution along those lines.
> 
> In fuse_flush instead of using fuse_simple_request call an equivalent
> function that when PF_EXITING is true skips calling request_wait_answer.
> Or perhaps when PF_EXITING is set uses schedule_work to call the
> request_wait_answer.

I don't see why this is any different than what I proposed. It changes
the semantics to flush happening out-of-order with task exit, instead
of strictly before, which you point out might be a problem. What am I
missing?

Tycho
