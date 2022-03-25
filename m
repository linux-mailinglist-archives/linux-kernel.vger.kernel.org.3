Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428024E7430
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 14:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356576AbiCYN3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 09:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353115AbiCYN3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 09:29:22 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27095BD2F2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 06:27:48 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id t25so13374426lfg.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 06:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BUtoFC6ywyL37K0zn09XnYfSUFvtwDz/50hx1dXYrdU=;
        b=ER2R2i/nbH0qKeLoBBXGWglgmKrFfI8rtVs00xxk0gehkHCIbVQVmYTO4+fCUArBCV
         +2gWnrcG9xlaudAkMv5GJvWOfsmtlBNEY46X76qTcO2/zfAc9vn0XT9NCNNyuFBw5vm9
         H9XFZYHlnwUTi0Bpj/B5NmJBeViS/9HUQkVQ+D+ln4vQn5jYJk+57cOHl717+aoAMx/U
         kZvAaBqD8YLRxQMhLrT8+lk4NDWKcbuinZtfgE4euNghnXHwZ8jjSipe8eOxZ6QdUzmQ
         5GNuHn++cLVMGN7iMaRWaAzRJ+Uw8okjqV7FBo2tWjD4InzD62NEIgA7sY2pho1bxKA3
         JoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BUtoFC6ywyL37K0zn09XnYfSUFvtwDz/50hx1dXYrdU=;
        b=3Loxm6SlnzyL4vZ9CwgPULBsPCQixkSSVvv2jyoP5bDUsFIYWZP+W4IfbuSNYRBzhW
         TtOTNNCCzWURftLZKFHAq6ghxEXGgUbEcJmd89nFC+lnyQqJHrQcws6xeiA3leF+haa0
         A6lU+qk97qBzVgTUTD8dDXyo2UCmQ+Qm4jX3q0x9LvWBkDoUgnpCmsHz+R2rCgswkZZ9
         qxS1ZaABIKW0+XXuD/YKQfTZgXfDmzlxLmw8g43Fzda550sFlt2fYx6PZ53yPH2xXCVS
         X7+4KtKvy5mHKO+O0caVlnLgh94/OBAQF4jpg29U9gmAWtqsRgzZ3F/KAxk7e+yS8Kd1
         ewfw==
X-Gm-Message-State: AOAM533OFbpGzr89EnTLfsTeZ+01NqSiC/FOHAaghOD/olkBGw635UOP
        oAq1sdlkB3Im5cTmadoVbjGtmLcNlzVy89ueQUhnVpLaJ6Y=
X-Google-Smtp-Source: ABdhPJwQ1BSqdBkvXhsGP1GcHHJV8FTPZ8S9zdiv0JiprSghkWbnGErpVtRJeL2ESxZQpDr4KDobqr66k15cnBESWGE=
X-Received: by 2002:a05:6512:6cf:b0:44a:25d1:a27 with SMTP id
 u15-20020a05651206cf00b0044a25d10a27mr7751081lff.18.1648214866341; Fri, 25
 Mar 2022 06:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
 <20220322163911.3jge4unswuap3pjh@wubuntu> <CAKfTPtBYuEt=JuLLKFVJfzq_rNRoKPYfAnq7a2Jw=fBKMj6a3g@mail.gmail.com>
 <20220324172528.lrjiehsqrwvnwg2x@wubuntu>
In-Reply-To: <20220324172528.lrjiehsqrwvnwg2x@wubuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 25 Mar 2022 14:27:34 +0100
Message-ID: <CAKfTPtDpskXzJ4ZXt9=+NAbypZyfFMHE0w+N23CtArsA35s=UA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add latency_nice priority
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        chris.hyser@oracle.com, pkondeti@codeaurora.org,
        Valentin.Schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com
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

removed Dhaval's email which returns error

On Thu, 24 Mar 2022 at 18:25, Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 03/23/22 16:32, Vincent Guittot wrote:
> > On Tue, 22 Mar 2022 at 17:39, Qais Yousef <qais.yousef@arm.com> wrote:
> > >
> > > Hi Vincent
> > >
> > > Thanks for reviving this patchset!
> > >
> > > On 03/11/22 17:14, Vincent Guittot wrote:
> > > > This patchset restarts the work about adding a latency nice priority to
> > > > describe the latency tolerance of cfs tasks.
> > > >
> > > > The patches [1-4] have been done by Parth:
> > > > https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com/
> > > >
> > > > I have just rebased and moved the set of latency priority outside the
> > > > priority update. I have removed the reviewed tag because the patches
> > > > are 2 years old.
> > >
> > > AFAIR the blocking issue we had then is on agreement on the interface. Has this
> > > been resolved now? I didn't see any further discussion since then.
> >
> > I think that there was an agreement about using a latency nice
> > priority in the range [-20:19] with -20 meaning sensitive to latency
> > whereas 19 means that task doesn't care about scheduling latency.  The
> > open point was about how to use this input in the scheduler with some
> > behavior being opposed.
>
> What I remember is that the problem was to consolidate on use cases then
> discuss interfaces.
>
> See https://lwn.net/Articles/820659/
>
>         "  Youssef said that the interface to all of this is the sticking
>         point.  Thomas Gleixner agreed, saying that the -20..19 range "requires
>         a crystal ball" to use properly. Zijlstra repeated his call to
>         enumerate the use cases before getting into the interface details.
>         Giani repeated that the interface does not look correct now, and agreed
>         that a more comprehensive look at the use cases was needed. Things were
>         being done backwards currently, he said.  "
>

At LPC, everybody seemed aligned with latency_nice so I assumed that
there was an agreement on this interface.
Latency_nice fits well with my proposal because it's all about
relative comparison between the running task to the others. The
current nice priority is used to set how much cpu bandwidth a task
will have compared to others and the latency_nice is used in a similar
way to know which one should run compared to the others.

> >
> > >
> > > >
> > > > The patches [5-6] use latency nice priority to decide if a cfs task can
> > > > preempt the current running task. Patch 5 gives some tests results with
> > > > cyclictests and hackbench to highlight the benefit of latency nice
> > > > priority for short interactive task or long intensive tasks.
> > >
> > > This is a new use case AFAICT. For Android, we want to do something in EAS path
> >
> > I don't think it's new, it's about being able to run some tasks in
>
> I meant new use case to latency-nice interface. I don't think we had this in
> any of our discussions before? I don't mind it, but it'd be good to clarify if
> it has any relation about the other use cases and what should happen to the
> other use cases.

Several discussions happened about changing the preemption policy of
CFS. I have Mel's example in mind with hackbench where we want to
reduce the preemption capabilities for the threads and on the other
side the multimedia tasks which complain about having to wait before
being scheduled. All this is about preempting or not the others. And
all this has been kept outside topology consideration but only for the
local run queue

Regards,
Vincent

>
>
> Thanks
>
> --
> Qais Yousef
