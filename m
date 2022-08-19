Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430B859A559
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350700AbiHSS3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 14:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349836AbiHSS3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 14:29:42 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6640BA9C2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 11:29:41 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id o14so2712648ilt.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 11:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=q/AKxBAoGuIGbw50ofhyCLKrbO9AgUVTeplds+BuUCU=;
        b=uH5PyXDmPHsIXPrkyxT6Y3rEqmV112PumYE2Or+P8B65EMPD1ZEwogxLhwssPzz4sr
         hFxwtYsIWikwlqkaPRuZOjxbQry6cBwmgZfe9T5dJVChsgE1PHUec0wSeUWfcarAbXYh
         xoMp4Z1U1cmuG4d7IlAUhK30gWFwvLuRhJp4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=q/AKxBAoGuIGbw50ofhyCLKrbO9AgUVTeplds+BuUCU=;
        b=Auy7I4dDKovrrjZHm89o0hKu0LecctocelL1fYXMSLzBK9VxrKuaSBCL70i1xynYZi
         +Iiv8V1z2f9IRo7FmFfdxSzCtmm+wBFeZlvKIeiWuLDA+/hHpenZtgox9fzlRbi8OdO9
         OJ4hqnv5f3XbnsOzNs3kFSNv++aDLIO5/AStMP3OxsufUw2rOaTWRiUgn0I636/UykG5
         JWeWoxtV6ffr2KGxgEBSkDRLv/+fwsdhbWBiVKXqpyjlkMOCHFIbAxSi+79lpp5PJ/Cz
         S4gSMyVsmkhAjh4LiYqZ46iX2szowGue98hClZqnvzOmmPXkcKzCZPT2rvrEJXfsde8b
         L3nw==
X-Gm-Message-State: ACgBeo1ID5GTRoJpg69Jr73/ATt2tL2DenKatjX1Os14x9znUCXvDa3+
        Z3+EEHPhon6cH/04vmI4p7HUYDsxR+0Frm8QfgWtdU9FJyc=
X-Google-Smtp-Source: AA6agR6hmPcagkGPqpN710GPGIER30OCN9Cjyb0YXVdQifGj0juUylG+lMx1xQ6HGw8nj1Fnp88oM+a2AytUoJDIMgc=
X-Received: by 2002:a05:6e02:1c26:b0:2e5:8680:e842 with SMTP id
 m6-20020a056e021c2600b002e58680e842mr4386935ilh.148.1660933781301; Fri, 19
 Aug 2022 11:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220809034517.3867176-5-joel@joelfernandes.org>
 <CAEXW_YQuGga9Eivq4G6o1XjvPn-nMMDiM8FOY6HXJTMzwv1Emg@mail.gmail.com>
 <CAEXW_YQOXBRwCLZXjspXttGkNhbJK3HGVDuYj5TcYD=Xj1cK0A@mail.gmail.com>
 <CAEXW_YT3VnK5KJTbyXdCzs8j4jw9XFTSCF4Dt9QwLPtkPSb1tA@mail.gmail.com>
 <20220819023550.GN2125313@paulmck-ThinkPad-P17-Gen-1> <4deb7354-bac7-b530-47ba-54cf50cfce58@joelfernandes.org>
 <2d56e4ad-7d6e-2abb-461f-15f20128d42b@joelfernandes.org> <20220819171249.GP2125313@paulmck-ThinkPad-P17-Gen-1>
 <fa8b7857-b9fd-72ad-36a7-8b09e4472816@joelfernandes.org> <CAEXW_YTxtfbbQ_rOiSbu62GpDPBDFpfWrNBef06MAkYPybNJ2A@mail.gmail.com>
 <20220819182645.GQ2125313@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220819182645.GQ2125313@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 19 Aug 2022 14:29:29 -0400
Message-ID: <CAEXW_YT0==us-Suq74W5HV-ZbykmAY3cGoNDU2KQbTG3ZksgjQ@mail.gmail.com>
Subject: Re: [PATCH v3 resend 4/6] fs: Move call_rcu() to call_rcu_lazy() in
 some paths
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 2:26 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Aug 19, 2022 at 02:17:32PM -0400, Joel Fernandes wrote:
> > On Fri, Aug 19, 2022 at 2:14 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > [..]
> > > >> Things are much better with the following change. However, this brings
> > > >> me to a question about lock-contention based or any deferring and boot time.
> > > >>
> > > >> If you have a path like selinux doing a synchronize_rcu(), shouldn't we
> > > >> skip the jiffie waiting for the bypass timer? Otherwise things
> > > >> synchronously waiting will slow down more than usual. Maybe bypassing
> > > >> should not be done for any case until boot up is done. I'm curious to
> > > >> see if that improves boot time.
> > > >
> > > > Why not simply disable laziness at boot time and enable it only after
> > > > booting is complete?  The exiting rcupdate.rcu_normal_after_boot kernel
> > > > boot parameter uses a similar scheme.
> > >
> > > That sounds like the right thing to good, but unfortunately it wont help
> > > this problem. The boot time issue happens after init has started. So the
> > > OS is still "booting" even though the kernel has.
> > >
> > > Also the problem can happen after boot as well, like if RCU
> > > lazy/non-lazy callbacks come back to back quickly, or so.
> > >
> > > But yes nonetheless, I can see the value of disabling it till the
> > > in-kernel boot completets.
> >
> > My mail client is acting weird. I meant to add to this, I wonder if
> > there is a way other subsystems detect when userspace boots using some
> > heuristic?
>
> I don't know of one, but I bet that ChromeOS has ways.  If nothing else,
> might you add a sysfs write to one of the boot-up phases?

Yes, that's possible :) Thanks, I will consider this idea.

Thanks,

 - Joel
