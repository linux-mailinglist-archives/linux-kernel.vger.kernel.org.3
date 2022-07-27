Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4630358328B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 20:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbiG0S4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 14:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbiG0S4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 14:56:04 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE8789EB4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 10:55:51 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 197EA3200916;
        Wed, 27 Jul 2022 13:55:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 27 Jul 2022 13:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1658944547; x=1659030947; bh=pKs6T4WGKF
        20rXlh25ysa3f2j1+q+odx8NMOTR3xoyE=; b=SCbk3DIf9o5P7JRfpdfGEkc9QQ
        VE0JQWcqDxC3aoGbY16dLKMl1RxMul9mb1mSoJrCSpD3jxPsbDvXTBTwfw0M9Qzk
        5xX67VGagpwBcooA41joDmooKanjCd8sl2TOEayEwFs7YBXwLXAAI/3cOiZugGy0
        uG9OnUV0Lar+o2a16LggdNFNf0vR9uhuyYRUHeILvw5moNYZRwiFZCYJyGtfdNEE
        HFddSnyJQDTxgmC/UYcXhlB/nNN88QismbFptN+W8UpLSWS1R+PBntUzBtr8w8gK
        WxNe7aMrhKrjm0n0ihYBV2Oj/yBKo1WnTTt9M8hTF/tlATu8gM8/y3EiGmCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658944547; x=1659030947; bh=pKs6T4WGKF20rXlh25ysa3f2j1+q
        +odx8NMOTR3xoyE=; b=UMdLdkKdJP37f8rRU8oCkOU/rxNq18J9cYUkJX2btSMp
        WPkzfzwdFeKd6ET/Fda4ZGGATX3B+6cEMdEKqd2eA6MMTDltz1G3QQ54WeLkSK9Z
        mM/fpjrwDW9Kc1/XlJ3YXuVhSDD5z85J1hQ2NvLMNtYRvanqG7Z46mPmzmD08tMH
        vgntM6CWbIyhRAwrblWauFGjPP5I2cJi+zcsWMaoUhK5r4vSstwjxV+xJ/0Dok8W
        j7G9kcTvzWYEr7hJj0p5/8pm+hWLQetPnU3VD+M8a/gMJWPQopm9CEPbU5SvORZR
        KSrFwj6HFZ0kvJVvho2CAHBtkqH7Uo5VRzTdeqZkfw==
X-ME-Sender: <xms:I3zhYhIaAZOvgq2uuiIV5-6pRoLjZSsQ_Z0f4DmjFZcui-C5BpNfEQ>
    <xme:I3zhYtJhcoHxbSIi8gbXA25nq0zAH3rJo2Prj1Izt19JMfqkTmd4MSQx_xoNSmiWI
    ElF8OEGWR4WxhnkpgA>
X-ME-Received: <xmr:I3zhYpuqjiJwgkJRIUR3ksn2UxnBItYgFQ_mNG5ZL7hOFo06wM0IWINqY0fwjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdduvddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigt
    hhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtf
    frrghtthgvrhhnpeejieeitdekgeevhfefhefgvdehjeegudegudeltddvjeevieejhfev
    vdekffdtheenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthihtghhohesthihtghhohdrphhi
    iiiirg
X-ME-Proxy: <xmx:I3zhYiZSzdnW-sqSqrPt3vI6XPMemfbwUk6-WquHjUo8n9cZaKSUZg>
    <xmx:I3zhYobihR_Y7Kn5Omc6BYOLAkft5eyvSieSXB4h3_MlUfJ0fqD8ag>
    <xmx:I3zhYmBz9D3PVBHpm13PRmeHZB7XeFUcCMGWrrUgV_cuJcGJ2_8SVw>
    <xmx:I3zhYgHlswLfYUTsx-gyhrJpExq20LgObtWiQ60tWYyhp81uH_1szg>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Jul 2022 13:55:46 -0400 (EDT)
Date:   Wed, 27 Jul 2022 11:55:43 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] sched: __fatal_signal_pending() should also check
 PF_EXITING
Message-ID: <YuF8H3ZVNugbLtFC@tycho.pizza>
References: <Ys2PwTS0qFmGNFqy@netflix>
 <20220713175305.1327649-1-tycho@tycho.pizza>
 <20220720150328.GA30749@mail.hallyn.com>
 <YthsgqAZYnwHZLn+@tycho.pizza>
 <20220721015459.GA4297@mail.hallyn.com>
 <YuFdUj5X4qckC/6g@tycho.pizza>
 <871qu6bjp3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qu6bjp3.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 11:32:08AM -0500, Eric W. Biederman wrote:
> Tycho Andersen <tycho@tycho.pizza> writes:
> 
> > Hi all,
> >
> > On Wed, Jul 20, 2022 at 08:54:59PM -0500, Serge E. Hallyn wrote:
> >> Oh - I didn't either - checking the sigkill in shared signals *seems*
> >> legit if they can be put there - but since you posted the new patch I
> >> assumed his reasoning was clear to you.  I know Eric's busy, cc:ing Oleg
> >> for his interpretation too.
> >
> > Any thoughts on this?
> 
> Having __fatal_signal_pending check SIGKILL in shared signals is
> completely and utterly wrong.
> 
> What __fatal_signal_pending reports is if a signal has gone through
> short cirucuit delivery after determining that the delivery of the
> signal will terminate the process.

This short-circuiting you're talking about happens in __send_signal()?
The problem here is that __send_signal() will add things to the shared
queue:

    pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;

and indeed we add it to the shared set because of the way
zap_pid_ns_processes() calls it:

    roup_send_sig_info(SIGKILL, SEND_SIG_PRIV, task, PIDTYPE_MAX);

> Using "sigismember(&tsk->pending.signal, SIGKILL)" to report that a
> fatal signal has experienced short circuit delivery is a bit of an
> abuse, but essentially harmless as tkill of SIGKILL to a thread will
> result in every thread in the process experiencing short circuit
> delivery of the fatal SIGKILL.  So a pending SIGKILL can't really mean
> anything else.

This is the part I don't follow. If it's ok to send a signal to this
set, why is it not ok to also look there (other than that it was a
slight hack in the first place)? Maybe it will short circuit
more threads, but that seems ok.

> After having looked at the code a little more I can unfortunately also
> say that testing PF_EXITING in __fatal_signal_pending will cause
> kernel_wait4 in zap_pid_ns_processes to not sleep, and instead to return
> 0.  Which will cause zap_pid_ns_processes to busy wait.  That seems very
> unfortunate.
> 
> I hadn't realized it at the time I wrote zap_pid_ns_processes but I
> think anything called from do_exit that cares about signal pending state
> is pretty much broken and needs to be fixed.

> So the question is how do we fix the problem in fuse that shows up
> during a pid namespace exit without having interruptible sleeps we need
> to wake up?
> 
> What are the code paths that experience the problem?

[<0>] request_wait_answer+0x282/0x710 [fuse]
[<0>] fuse_simple_request+0x502/0xc10 [fuse]
[<0>] fuse_flush+0x431/0x630 [fuse]
[<0>] filp_close+0x96/0x120
[<0>] put_files_struct+0x15c/0x2c0
[<0>] do_exit+0xa00/0x2450
[<0>] do_group_exit+0xb2/0x2a0
[<0>] get_signal+0x1eed/0x2090
[<0>] arch_do_signal_or_restart+0x89/0x1bc0
[<0>] exit_to_user_mode_prepare+0x11d/0x1b0
[<0>] syscall_exit_to_user_mode+0x19/0x50
[<0>] do_syscall_64+0x50/0x90
[<0>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

is the full call stack, I have a reproducer here (make check will run
it): https://github.com/tych0/kernel-utils/tree/master/fuse2

In addition to fuse, it looks like nfs_file_flush() eventually ends up
in __fatal_signal_pending(), and probably a few others that want to
synchronize with something outside the local kernel.

> Will refactoring zap_pid_ns_processes as I have proposed so that it does
> not use kernel_wait4 help sort this out?  AKA make it work something
> like thread group leader of a process and not allow wait to reap the
> init process of a pid namespace until all of the processes in a pid
> namespaces have been gone.  Not that I see the problem in using
> kernel_wait4 it looks like zap_pid_ns_processes needs to stop calling
> kernel_wait4 regardless of the fuse problem.

I can look at this, but I really don't think it will help: in this
brave new world, what wakes up tasks stuck like the above? They're
still looking at the wrong signal set.

Tycho
