Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0801257BF62
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 22:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiGTU7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 16:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiGTU66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 16:58:58 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F0A5247E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 13:58:47 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 51D2C5C013C;
        Wed, 20 Jul 2022 16:58:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 20 Jul 2022 16:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1658350725; x=1658437125; bh=yTm6CxT/11
        UIMClKMqrUw6+gld/5x+12tJ0ALfJm0Us=; b=iGteAEgpw7e9M8ORr/MsMTbGzP
        c9eOKcnXMOqtKCHQYR6kGZNwKlGMuenaOsTAfHqzPICiD7agSI+kVIaqGM4aLhtV
        AbKlfMtgNtUOdc4jypjaIT+fVYHymU7vqQrkVa8nRjFyXxxPogV13J4xNVlEAUDZ
        raanmLGTOGkYIbxrX6CQlrIjt5l7+46HINEhn4WU2QJny4xLsv2Kkoh9ySZ1cki3
        xmhm5v+/VRQ9/tdMQthQnEPuifUo0kx1h60BUSMUFe+W5/7HoraGpcDCquYgamTS
        tttKFqoDC/t6PvIID+w+GpMyFS1abC9VvAfQWOq5umlwBT6IBeuXehId9KkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658350725; x=1658437125; bh=yTm6CxT/11UIMClKMqrUw6+gld/5
        x+12tJ0ALfJm0Us=; b=h4PPxjfZrO7Wu24cwGhyK3/Slnd4qAOMpmsB6tnayBFn
        ExxLSBJnu5aHuC9+92iZG4VP1PnKI7rnG+3WnlK+O+2iDBsmNiCImARFRllFGE/p
        HPsv1PbzYHHIRPv06JLYRspX8wNLIoVvnTerrRaDgyCTXyGJmrM+QxNX6NRwxbtd
        y8qMllX0b1ic4mkEvB8uun0pqu+/McvHPJqMWZW7c+Ac0j879/R5JXY1hET5pt5G
        ejIxFEaIymr1N/BW2ESFQZXNihgT5sEoMs/Z+BfBd2I1OWolphTBveg2Cl6DKlXW
        JWV6ut5jxLfO/1nOadj+jza8DeM428Y2Jpo2mbh8HQ==
X-ME-Sender: <xms:hGzYYrX9bClWy4rvrPJIJGiuqNjamy4LTj8lw4dnoIwA5hoGMw5dUA>
    <xme:hGzYYjnAKrD-kOwwQ34VDWScyRE8-QCuw5W2k5j2AvPegJs5GxNe8NK9ZZNX6HmI_
    vxtlyrwtHjzCizt1zw>
X-ME-Received: <xmr:hGzYYnZm0wTyV7ypU50W5tUhN4QOK2lIf5w1S66dLJwyAdZzhIoAF8SUGUxdYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudelvddgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigt
    hhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtf
    frrghtthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteek
    lefhleelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:hGzYYmUQvAmFkQtagHp8i20m73oRGD8cHMIl_o_-GtDuf5blChmRfg>
    <xmx:hGzYYll9LQtzT3lI0rwf_uP0GZEpoQr8xuC9KTkv60a260iRv2bdBg>
    <xmx:hGzYYjfx7t1hsZcxQWQFD2hJt_KKyqfgVUCm9QIm1ZxOzu5uoMwdGQ>
    <xmx:hWzYYqx8X9P5BUCZCjRuL35RGOpIUdtkJ87f7b--v-xeH--uL0gP6A>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Jul 2022 16:58:43 -0400 (EDT)
Date:   Wed, 20 Jul 2022 14:58:42 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: __fatal_signal_pending() should also check
 PF_EXITING
Message-ID: <YthsgqAZYnwHZLn+@tycho.pizza>
References: <Ys2PwTS0qFmGNFqy@netflix>
 <20220713175305.1327649-1-tycho@tycho.pizza>
 <20220720150328.GA30749@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720150328.GA30749@mail.hallyn.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 10:03:28AM -0500, Serge E. Hallyn wrote:
> On Wed, Jul 13, 2022 at 11:53:05AM -0600, Tycho Andersen wrote:
> > The wait_* code uses signal_pending_state() to test whether a thread has
> > been interrupted, which ultimately uses __fatal_signal_pending() to detect
> > if there is a fatal signal.
> > 
> > When a pid ns dies, it does:
> > 
> >     group_send_sig_info(SIGKILL, SEND_SIG_PRIV, task, PIDTYPE_MAX);
> > 
> > for all the tasks in the pid ns. That calls through:
> > 
> >     group_send_sig_info() ->
> >       do_send_sig_info() ->
> >         send_signal_locked() ->
> >           __send_signal_locked()
> > 
> > which does:
> > 
> >     pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
> > 
> > which puts sigkill in the set of shared signals, but not the individual
> > pending ones. When complete_signal() is called at the end of
> > __send_signal_locked(), if the task already had PF_EXITING (i.e. was
> > already waiting on something in its fd closing path like a fuse flush),
> > complete_signal() will not wake up the thread, since wants_signal() checks
> > PF_EXITING before testing for SIGKILL.
> > 
> > If tasks are stuck in a killable wait (e.g. a fuse flush operation), they
> > won't see this shared signal, and will hang forever, since TIF_SIGPENDING
> > is set, but the fatal signal can't be detected. So, let's also look for
> > PF_EXITING in __fatal_signal_pending().
> > 
> > Signed-off-by: Tycho Andersen <tycho@tycho.pizza>
> 
> Cool, thanks for nailing this down!
> 
> I assume you've been running this on some boxes with no weird effects?

Yes, but I haven't tested all the paths.

> > ---
> >  include/linux/sched/signal.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> > index cafbe03eed01..c20b7e1d89ef 100644
> > --- a/include/linux/sched/signal.h
> > +++ b/include/linux/sched/signal.h
> > @@ -402,7 +402,8 @@ static inline int signal_pending(struct task_struct *p)
> >  
> >  static inline int __fatal_signal_pending(struct task_struct *p)
> >  {
> > -	return unlikely(sigismember(&p->pending.signal, SIGKILL));
> > +	return unlikely(sigismember(&p->pending.signal, SIGKILL) ||
> > +			p->flags & PF_EXITING);
> 
> Looking around at the callers this does seem safe, but the name does
> now seem misleading.  Should this be renamed to something like
> exiting_or_fatal_signal_pending()?  

This is why I like my original patch better: it is just expanding the
set of signals to include the shared signals, which are indeed still
fatal pending signals for the task. I don't really understand Eric's
argument about kernel threads ignoring SIGKILL, since kernel threads
can still ignore SIGKILL just fine after this patch.

But yes, assuming Eric is ok with this venison. I can send a v2 with
the name change as you suggest.

Thanks for looking.

Tycho
