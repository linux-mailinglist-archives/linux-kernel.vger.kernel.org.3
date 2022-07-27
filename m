Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13D85833C7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 21:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbiG0Tld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 15:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiG0TlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 15:41:14 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A221121
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 12:41:03 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 52FE35C00D6;
        Wed, 27 Jul 2022 15:41:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 27 Jul 2022 15:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1658950861; x=1659037261; bh=9SJH53lxjC
        C8sHNElWVPiHBchpfU5rpCYTirdYYl4V0=; b=kKT+Fw9lO0nVt4pglWQT6JoLwH
        xUed/SuDTCgJCm5DkiVg8cWzUNB0CgypGJNK7/osbKo4lIB6F84FURvgxTly5rW6
        wp+7S90fk+le3d8VZjSS8fOsxhDapNnXmRGikzz3VY0PCQq9VTC/IarS6ILkOxkq
        kQnWiwZeSEGHRFgyehwXxggQao2CR3ebhk/txV5EUXMgJn2OjlyitKJY4PYOv4NO
        XEY+TP3Nneie2cPJu0ShyxyB3bkqRAKpB3ko0LW40S++v+KQwCDX2zzaIOMLwZEP
        RG+JB/mwjC0eYOGw3NY83XWnnAD4I4bx/LeLt720z93GdPY0VNmD+P51jYTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658950861; x=1659037261; bh=9SJH53lxjCC8sHNElWVPiHBchpfU
        5rpCYTirdYYl4V0=; b=znngmkk+z4M7vOPii5EKBwuTm1Sb79+YuXEoVekgjE3D
        /D2C1IL7NPfd4Kv1nCrUvQW5m44HIG5CCGwv90kr2gNfE53i15Ncv7ohIbXhFEVs
        ui7sXBs65YnxD8H08QEzDf1RfSAUQpvOO99Uxe77I/6wUkB/jW9p0RF8O74jMRnz
        di7JHbe+pinDvNuLoXyft6vMPN9+xiocTBsm8LO7gIlID9aVi/wTLvOne1HWap1n
        7pxXE55OWBXONysY/jy3pLQPh6ct7fRy2qX6IpcG3RY2v2nI3TCDPLYeuFOrbBrY
        A3VXPh8T4MMf5CJhD4GVOsN+hC3OnAlhtfeymNraZg==
X-ME-Sender: <xms:zJThYj2nKZy_uNLiY4EqVGjjdmgioBbYdGpP9xewOSE8efcJ37rB3g>
    <xme:zJThYiEfL0QgNrAyYo7QJFID0haZ6QhxXfigukkyuQOtdnRPIoQHQeRaiMWjpQd8d
    TUNORjJVVrE73pZlaU>
X-ME-Received: <xmr:zJThYj4_1KUxkIQZLbIUwCCZBtzH6cjez1drUhQmdV38VelYwv-hfzvPfbMzZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdduvddgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigt
    hhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtf
    frrghtthgvrhhnpeetfeehjeduuedufedvhfdutefgtdeileegkedufeffledvvdffiefg
    ieevffeuheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigt
    hhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:zJThYo0NPKLEMZu6tPYP4_tDOE_obgt8Mk3zLtkaETTyjIyxo8z0Ig>
    <xmx:zJThYmE3_gde651_5x9-F8dhKFbIbJW0Csx7Uti6UXAxRTlyDJdJTQ>
    <xmx:zJThYp9WUXnK6WxUWuWa23fm9k9P4gNE6Y9SvOM2MLCIgui0y-baBQ>
    <xmx:zZThYiBR7FM1CXGEU_UsoS0-EItWOoR-3YdQ-hd2Ln0iDWTKHSQhSA>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Jul 2022 15:40:59 -0400 (EDT)
Date:   Wed, 27 Jul 2022 13:40:57 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: __fatal_signal_pending() should also check
 PF_EXITING
Message-ID: <YuGUyayVWDB7R89i@tycho.pizza>
References: <Ys2PwTS0qFmGNFqy@netflix>
 <20220713175305.1327649-1-tycho@tycho.pizza>
 <20220720150328.GA30749@mail.hallyn.com>
 <YthsgqAZYnwHZLn+@tycho.pizza>
 <20220721015459.GA4297@mail.hallyn.com>
 <YuFdUj5X4qckC/6g@tycho.pizza>
 <20220727175538.GC18822@redhat.com>
 <YuGBXnqb5rPwAlYk@tycho.pizza>
 <20220727191949.GD18822@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727191949.GD18822@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 09:19:50PM +0200, Oleg Nesterov wrote:
> On 07/27, Tycho Andersen wrote:
> >
> > On Wed, Jul 27, 2022 at 07:55:39PM +0200, Oleg Nesterov wrote:
> > > On 07/27, Tycho Andersen wrote:
> > > >
> > > > Hi all,
> > > >
> > > > On Wed, Jul 20, 2022 at 08:54:59PM -0500, Serge E. Hallyn wrote:
> > > > > Oh - I didn't either - checking the sigkill in shared signals *seems*
> > > > > legit if they can be put there - but since you posted the new patch I
> > > > > assumed his reasoning was clear to you.  I know Eric's busy, cc:ing Oleg
> > > > > for his interpretation too.
> > > >
> > > > Any thoughts on this?
> > >
> > > Cough... I don't know what can I say except I personally dislike this
> > > patch no matter what ;)
> > >
> > > And I do not understand how can this patch help. OK, a single-threaded
> > > PF_EXITING task sleeps in TASK_KILLABLE. send_signal_locked() won't
> > > wake it up anyway?
> > >
> > > I must have missed something.
> >
> > What do you think of the patch in
> > https://lore.kernel.org/all/YsyHMVLuT5U6mm+I@netflix/ ? Hopefully that
> > has an explanation that makes more sense.
> 
> Sorry, I still do not follow. Again, I can easily miss something. But how
> can ANY change in __fatal_signal_pending() ensure that SIGKILL will wakeup
> a PF_EXITING task which already sleeps in TASK_KILLABLE state? or even set
> TIF_SIGPENDING as the changelog states?

__fatal_signal_pending() just checks the non-shared set:

    sigismember(&p->pending.signal, SIGKILL)

When init in a pid namespace dies, it calls zap_pid_ns_processes(),
which does:

    group_send_sig_info(SIGKILL, SEND_SIG_PRIV, task, PIDTYPE_MAX);

that eventually gets to __send_signal_locked() which does:

    pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;

i.e. it decides to put the signal in the shared set, instead of the individual
set. If we change __fatal_signal_pending() to look in the shared set too, it
will exit all the wait code in this case.

Maybe it should be fixed somehow by complete_signal(), but that doesn't work if
the thread is already PF_EXITING, because wants_signal() will cause it to
ignore the task, so it remains stuck forever.

Does that make sense? Maybe it's me who is missing something. I have a
reproducer here:
https://github.com/tych0/kernel-utils/tree/master/fuse2

Tycho
