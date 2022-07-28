Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A8E5847A8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 23:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiG1VVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 17:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbiG1VVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 17:21:19 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119F66F7C4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 14:21:05 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D03CF5C0073;
        Thu, 28 Jul 2022 17:21:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 28 Jul 2022 17:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659043261; x=1659129661; bh=XDMn+JtvAc
        3XzUDSBht90uwYTc5j02Sh5vjdVaoCjOA=; b=j0tWskr3jGsudIfO9eQwv8gwNc
        +jLq4kAmBP655o3giL6Rb1197/p3qItQvtDK07FWedL7Qw0RuJo8K99KY9QoYqe8
        NaSW2DLRCe7flBFHdkKJt73uR1Ujx9ML2QHxjCH7BGAUxcTHIC+ti6B/Q2Kh+5Ve
        LJjVs0XMbEmyUhczqHfGcDqeRSgK/cbYLfUEUR2oUeV7zEPhLooDDNAsWlJ6VyFr
        mqFWbFVy3bsn4h1TUTow2iD7ssB9ttYfPo9J+sDmZ6HYyRF7nTxm5s+KUGjQnoo0
        8/sJggiWI9rKWfjvcZ58uQjJaGYVPBQzYD4sHOEk4UpK5hfoHqQqKqzGE5zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1659043261; x=1659129661; bh=XDMn+JtvAc3XzUDSBht90uwYTc5j
        02Sh5vjdVaoCjOA=; b=Xn/lTuIoPaqDsVNTfB5SiRY1FOINuTqhRqQU8gcNKFeZ
        5s2Yg+p/rHLRObBX66FIX1JnVt19Lg0AD9DIIgOTQ0u4Tj8VIiy0CfMNNZjkKLqv
        FUcUKO2nnjpDZ4W2iti8Y2+TRIQTaYMA1ABg7rJ8rkwe2e/1yZJw9mws/c6gh0Lo
        102AFA7AF4hKgDRCjqelwKNkJmj3pkN7P9iLg8qAkT1JNpgQdG9rBRDQ0YErmvwn
        QN3PiFfK4UcU7GtH2ZUGu1tJfue2P0gS1FqFSdyd8zCL4ShAIh8KKhrOUUuY2Jzd
        /7Mqnbx7/UKa1Um5QePRsnxmDMkkYCD3+5blAU7ZQQ==
X-ME-Sender: <xms:vP3iYtl0Aqc0yYy0rnVDWMibp2QE6XHde9E37oKAUOPuxFH1zBbHKw>
    <xme:vP3iYo3SCH_KRkElO2I2MH7OTK5o9kB3fbL_O9PIQ_LQNqY7WRCz62hyDsApT7sze
    QG0vm51tQK9NUvukQ8>
X-ME-Received: <xmr:vP3iYjqsSFskjUpz_JjzcUzLfvVBGnUwsJVhSHp66kVjDpjxNLanMxPI5AGTOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdduhedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:vP3iYtncCH_x4pFqW8AuX1CSczNLo0AQsPkil1mHoeeZ_4P_2ji9FQ>
    <xmx:vP3iYr3CgA9Q-Be8TnWYr8azQZ_8UdILkd3TtXSYqU1SjX9cOqsYVA>
    <xmx:vP3iYstU6zUlzk-kSEZRs8fveGbBOyyurrb_WkFWforW56RWhZSxUg>
    <xmx:vf3iYsxo_1h5ad-MoJ7pkJ-YSALCwSRmvjc8SGWI-8YwD14Zl0aKQw>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Jul 2022 17:20:59 -0400 (EDT)
Date:   Thu, 28 Jul 2022 15:20:57 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: __fatal_signal_pending() should also check
 PF_EXITING
Message-ID: <YuL9uc8WfiYlb2Hw@tycho.pizza>
References: <20220713175305.1327649-1-tycho@tycho.pizza>
 <20220720150328.GA30749@mail.hallyn.com>
 <YthsgqAZYnwHZLn+@tycho.pizza>
 <20220721015459.GA4297@mail.hallyn.com>
 <YuFdUj5X4qckC/6g@tycho.pizza>
 <20220727175538.GC18822@redhat.com>
 <YuGBXnqb5rPwAlYk@tycho.pizza>
 <20220727191949.GD18822@redhat.com>
 <YuGUyayVWDB7R89i@tycho.pizza>
 <20220728091220.GA11207@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728091220.GA11207@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 11:12:20AM +0200, Oleg Nesterov wrote:
> This is clear, but it seems you do not understand me. Let me try again
> to explain and please correct me if I am wrong.
> 
> To simplify, lets suppose we have a single-thread task T which simply
> does
> 	__set_current_state(TASK_KILLABLE);
> 	schedule();
> 
> in the do_exit() paths after exit_signals() which sets PF_EXITING. Btw,
> note that it even documents that this thread is not "visible" for the
> group-wide signals, see below.
> 
> Now, suppose that this task is running and you send SIGKILL. T will
> dequeue SIGKILL from T->penging and call do_exit(). However, it won't
> remove SIGKILL from T->signal.shared_pending(), and this means that
> signal_pending(T) is still true.
> 
> Now. If we add a PF_EXITING or sigismember(shared_pending, SIGKILL) check
> into __fatal_signal_pending(), then yes, T won't block in schedule(),
> schedule()->signal_pending_state() will return true.
> 
> But what if T exits on its own? It will block in schedule() forever.
> schedule()->signal_pending_state() will not even check __fatal_signal_pending(),
> signal_pending() == F.
> 
> Now if you send SIGKILL to this task, SIGKILL won't wake it up or even
> set TIF_SIGPENDING, complete_signal() will do nothing.
> 
> See?
> 
> I agree, we should probably cleanup this logic and define how exactly
> the exiting task should react to signals (not only fatal signals). But
> your patch certainly doesn't look good to me and it is not enough.
> May be we can change get_signal() to not remove SIGKILL from t->pending
> for the start... not sure, this needs another discussion.

Thank you for this! Between that and Eric's line about:

> Frankly that there are some left over SIGKILL bits in the pending mask
> is a misfeature, and it is definitely not something you should count on.

I think I finally maybe understand the objections.

Is it fair to say that a task with PF_EXITING should never wait? I'm
wondering if a solution would be to patch the wait code to look for
PF_EXITING, in addition to checking the signal state.

> Finally. if fuse_flush() wants __fatal_signal_pending() == T when the
> caller exits, perhaps it can do it itself? Something like
> 
> 	if (current->flags & PF_EXITING) {
> 		spin_lock_irq(siglock);
> 		set_thread_flag(TIF_SIGPENDING);
> 		sigaddset(&current->pending.signal, SIGKILL);
> 		spin_unlock_irq(siglock);
> 	}
> 
> Sure, this is ugly as hell. But perhaps this can serve as a workaround?

or even just

    if (current->flags & PF_EXITING)
        return;

since we don't have anyone to send the result of the flush to anyway.
If we don't end up converging on a fix here, I'll just send that
patch. Thanks for the suggestion.

Tycho
