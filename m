Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803D65853FD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 18:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236499AbiG2Qt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 12:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236239AbiG2QtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 12:49:07 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D7089A4A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 09:48:55 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 085FC5C0040;
        Fri, 29 Jul 2022 12:48:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 29 Jul 2022 12:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659113335; x=1659199735; bh=9Q3jKNoPOM
        DsUxTjuwuK3c1+pfhfKoA4juw4IILDsr8=; b=VmsjcSyOjKra8u7MLQstCXB2OC
        O23iCovLvTEfiIM7JND6YjwNniyAhyqydPv0cL8XPI40zzeeAiE7YNXyXRhfqf+U
        LDbK3nzmwR8zEYu7fV5op3LZpxSke5SOvcyPFUAc9N+HDnh5AAvcFZXDa2vkhZ9d
        bQ+9Oxtt7D2o45SUK3LjOUIb33cT2KbCJaVcU7lg44brGM4HQXjUxg5GbQNgTbeb
        r1vfiCYXdoqi24LWl8DIZeJNHcx+/dEFR+ZuzoOAqdzUBNo+g+mA4LcVJFhLPfWm
        wqt1hy0JnI5OzuzbYtekFFKehkqwDuEHAedWafINd3UtIuBeK9IdMPDkYifw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1659113335; x=1659199735; bh=9Q3jKNoPOMDsUxTjuwuK3c1+pfhf
        KoA4juw4IILDsr8=; b=R99HR95zvGlJOGDo0A/QdOBYXvYr81GD7eRC09KMW0A3
        99QrAAGYZAV4OryO+3FMiIwHXuHgPWeQiuFxPMAa82iMcDOLtAsM3CrxtsbraKBF
        Wi7+iZI7DmPXAgFiAepNwIdHRbGrmR6bD3TRIvdcrjX2MWjMt8NDMeeFBa5+r2lP
        TvMlcYIJ546tHEsKmpqZj/ThIelvbBfRUnNSpl96IMF5AkaHtKhg0Cg3SNE5zTuC
        EblKUdI5h9f9LZZuHow4UN1UNO6FPKO+fS8Y20DG+Qc9p/s9pgYiW8bpSX3SkhW3
        2VhQn/aCjzGBMMbE4gl1AROB+MKbmyv5NZZcZdY/fQ==
X-ME-Sender: <xms:dg_kYkL3FWdRYMafAcbKxPbnqmsdxNUPrCsXcRehIx-z1n1Wft5xNw>
    <xme:dg_kYkKvTRU1KsVn7Sra8f60PZ1xUHcxb_OYS6j_CTM0Qu2R7DmOQ7oYAojKdE25p
    Fv4OebVdzOGiuDB2A4>
X-ME-Received: <xmr:dg_kYktDwaFPz4Avq2zOKLS3z6_LMfgSBllJ5TLvk7wPimffjlCbbkEC6LxBFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddujedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigt
    hhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtf
    frrghtthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteek
    lefhleelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:dg_kYhZ1xtmPai7txeZbgic9g7FIGZZqnCAhaJICaPucuyznrjSG_Q>
    <xmx:dg_kYrZiPUeQP9snmRlli7CHV_ZIsUbAIBHlcwaxw-hq2XPmm0NM0Q>
    <xmx:dg_kYtAngdB7_IoCzG3wowIjkQg6nAPrCKnJF7Qfjpv_iqGuGI0qvg>
    <xmx:dw_kYnG3GO9dAevo6xvAnsgyuao7v33WgUzv5nlCH-8lZQXij3pLUQ>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Jul 2022 12:48:52 -0400 (EDT)
Date:   Fri, 29 Jul 2022 10:48:51 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: __fatal_signal_pending() should also check
 PF_EXITING
Message-ID: <YuQPc51yXhnBHjIx@tycho.pizza>
References: <YuFdUj5X4qckC/6g@tycho.pizza>
 <20220727175538.GC18822@redhat.com>
 <YuGBXnqb5rPwAlYk@tycho.pizza>
 <20220727191949.GD18822@redhat.com>
 <YuGUyayVWDB7R89i@tycho.pizza>
 <20220728091220.GA11207@redhat.com>
 <YuL9uc8WfiYlb2Hw@tycho.pizza>
 <87pmhofr1q.fsf@email.froward.int.ebiederm.org>
 <YuPlqp0jSvVu4WBK@tycho.pizza>
 <87v8rfevz3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8rfevz3.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 11:15:28AM -0500, Eric W. Biederman wrote:
> Tycho Andersen <tycho@tycho.pizza> writes:
> 
> > On Fri, Jul 29, 2022 at 12:04:17AM -0500, Eric W. Biederman wrote:
> >> Tycho Andersen <tycho@tycho.pizza> writes:
> >> 
> >> > On Thu, Jul 28, 2022 at 11:12:20AM +0200, Oleg Nesterov wrote:
> >
> >> >> Finally. if fuse_flush() wants __fatal_signal_pending() == T when the
> >> >> caller exits, perhaps it can do it itself? Something like
> >> >> 
> >> >> 	if (current->flags & PF_EXITING) {
> >> >> 		spin_lock_irq(siglock);
> >> >> 		set_thread_flag(TIF_SIGPENDING);
> >> >> 		sigaddset(&current->pending.signal, SIGKILL);
> >> >> 		spin_unlock_irq(siglock);
> >> >> 	}
> >> >> 
> >> >> Sure, this is ugly as hell. But perhaps this can serve as a workaround?
> >> >
> >> > or even just
> >> >
> >> >     if (current->flags & PF_EXITING)
> >> >         return;
> >> >
> >> > since we don't have anyone to send the result of the flush to anyway.
> >> > If we don't end up converging on a fix here, I'll just send that
> >> > patch. Thanks for the suggestion.
> >> 
> >> If that was limited to the case you care about that would be reasonable.
> >> 
> >> That will have an effect on any time a process that opens files on a
> >> fuse filesystem exits and depends upon the exit path to close it's file
> >> descriptors to the fuse filesystem.
> >> 
> >> 
> >> I do see a plausible solution along those lines.
> >> 
> >> In fuse_flush instead of using fuse_simple_request call an equivalent
> >> function that when PF_EXITING is true skips calling request_wait_answer.
> >> Or perhaps when PF_EXITING is set uses schedule_work to call the
> >> request_wait_answer.
> >
> > I don't see why this is any different than what I proposed. It changes
> > the semantics to flush happening out-of-order with task exit, instead
> > of strictly before, which you point out might be a problem. What am I
> > missing?
> 
> What you proposed skips the flush operation entirely.

Sorry, I wasn't clear. I was thinking of roughly similar to what you
were, returning from request_wait_answer() early if we have
PF_EXITING. Sounds like we agree that it shouldn't be an issue. I'll
give it a test and send out a patch Monday.

Tycho
