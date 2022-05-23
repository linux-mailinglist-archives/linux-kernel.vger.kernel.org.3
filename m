Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E295310C8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbiEWM6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbiEWM6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:58:54 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80894527EC
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:58:53 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id i11so25222037ybq.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=glvNFTarGwjhG6/nAlpcwFLi6TN3OkPew5JbaTXKiDU=;
        b=TgxKoyWM+MA9O5OpBlq3Zf8r8lsU4Nnq0DR9oSD//Wqd8YmIPlLHLr5nTx32cK/stX
         9nYfnG82HquzVq5UrSj1msNvJ3dXK5HUvWGNggY33SbYaNXwwWh+5KJ7dzV2RlByg0BY
         DUNJTX5gMNdA7VxOwiaBJQaD04uoFzfX20m4e0TMi34Y4WWBquYVLsKf7IRTWJAX6+yp
         VpNdk8wevHMfXVuDcyL0z3Cg5t8QJ3mQ/+vpA5XOYgAdoyu9g/M3W49o39w0rv1uMHTM
         95GADoiV59C/2ucOV9cYNsqxFUOJcFQoj2q1zWFSXUXA7LYv7KxFSFScKLsy65ccya/C
         WoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=glvNFTarGwjhG6/nAlpcwFLi6TN3OkPew5JbaTXKiDU=;
        b=cScqj5rNWMeZSmPp6aT5FCcV2etPIkRM8WgHjcS6k3i01QpAoP+A0SwmF5yfu2MW69
         hAt44NAGd8k3QmrJcXPVt6eaBUt1eavIOaxbbL/b2Pdwdxs/jsCooi+2iTlfWzjJVAiw
         x/PrePG6NU3WhgkAcGa+G2dHPuKYXpG7hW8jhsJqq+PFwiBNyZ1vrqGK9qI+Bt2sCaJK
         ReRbUS2JOAy9peB4yOCIt0Evy91O8U57nQeAyQECrEF98OUbzBOtY6y3dOj5VlYYBEA5
         bCmrtGQ9BbeMNvGVSAIvXlAr3XI51zO62JXIiQqFIOZHNYbtG8NHzG8rHWq6VTDh3J9g
         lpbw==
X-Gm-Message-State: AOAM532SXLhUie4A4CX/bpMnWTTkJXABzueUcOuHszijoAwYzsWtLOBQ
        64aUK1fHfvkxpdm7oM8ZxnJcsMCddfqvkrBoBZ1pZg==
X-Google-Smtp-Source: ABdhPJx6QCEQg043DDUfDrm7m72OUym1Jm+HsRa6xV/JOLtYIOgfQ4H78rOKs6AUaqA+v3iuNLqS5TcRm3SokNbeCoQ=
X-Received: by 2002:a25:23d2:0:b0:64e:a1e4:683c with SMTP id
 j201-20020a2523d2000000b0064ea1e4683cmr22059259ybj.211.1653310732706; Mon, 23
 May 2022 05:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220512163534.2572-1-vincent.guittot@linaro.org>
 <20220512163534.2572-6-vincent.guittot@linaro.org> <CABk29Ns-3L1S2xuRg15VxzcXJyNpA6nB2A4jdM9eyx0jiWjn+Q@mail.gmail.com>
 <CAKfTPtCx_fhud-VsxCi9jS==yGavn7zgRBQyUfzXgbTiX2+77g@mail.gmail.com> <CABk29NvF2H2oSAw806tUQjj39TWNa57bEcbA0ao+qyk5ZgV9Kg@mail.gmail.com>
In-Reply-To: <CABk29NvF2H2oSAw806tUQjj39TWNa57bEcbA0ao+qyk5ZgV9Kg@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 23 May 2022 14:58:41 +0200
Message-ID: <CAKfTPtBRd-i6sJYpAFTbV-WpPTZt=wUyK0ZKR99+vgsxeTivaw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] sched/fair: Take into account latency nice at wakeup
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, parth@linux.ibm.com,
        Qais Yousef <qais.yousef@arm.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        Paul Turner <pjt@google.com>, pavel@ucw.cz,
        Tejun Heo <tj@kernel.org>, Quentin Perret <qperret@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
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

On Thu, 19 May 2022 at 22:07, Josh Don <joshdon@google.com> wrote:
>
> On Thu, May 19, 2022 at 6:57 AM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Tue, 17 May 2022 at 02:54, Josh Don <joshdon@google.com> wrote:
> > >
> > > Hi Vincent,
> > >
> > > On Thu, May 12, 2022 at 9:36 AM Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > > >
> > > > Take into account the nice latency priority of a thread when deciding to
> > > > preempt the current running thread. We don't want to provide more CPU
> > > > bandwidth to a thread but reorder the scheduling to run latency sensitive
> > > > task first whenever possible.
> > > >
> > > > As long as a thread didn't use its bandwidth, it will be able to preempt
> > > > the current thread.
> > > >
> > > > At the opposite, a thread with a low latency priority will preempt current
> > > > thread at wakeup only to keep fair CPU bandwidth sharing. Otherwise it will
> > > > wait for the tick to get its sched slice.
> > >
> > > Following up from the discussion on the prior series, I'm still not
> > > sure why this approach is exclusive of extending the entity placement
> > > code; I think both changes together would be useful.
> > >
> > > By only changing the wakeup preemption decision, you're only
> > > guaranteeing that the latency-sensitive thing on cpu won't be
> > > preempted until the next sched tick, which can occur at any time
> > > offset from the wakeup, from 0ns to the length of one tick. If a
> >
> > In fact, you are ensured to run a minimum time of 3ms at least on >=8
> > cores system before tick can preempt you. I considered updating this
> > part as well to increase the value for negative weight but didn't do
> > it for now. I can have a look
>
> If the latency sensitive thing on cpu has already been running close
> to or greater than that min granularity, that doesn't apply; can still
> get preempted pretty quickly from the tick by the newly woken task.

The 3ms is ensured from the task wakeup whatever the previous run and
whatever can wakeup in the mean time but didn't preempt it at wakeup.
As mentioned above, it is probably worth having this value scale with
latency, especially for low latency task.

>
> A possible change would be to reduce the sleeper credit when the
> waking entity has lower latency priority than the current entity (ie.
> similar to the se_is_idle() check already being made in
> place_entity()).
>
> > > latency-tolerant task wakes up with a lot of sleeper credit, it would
> > > pretty quickly preempt a latency-sensitive task on-cpu, even if it
> > > doesn't initially do so due to the above changes to wakeup preemption.
> > >
> > > Adjusting place_entity wouldn't impact cpu bandwidth in steady-state
> > > competition between threads of different latency prio, it would only
> > > impact slightly at wakeup, in a similar but more consistent manner to
> > > the changes above to wakeup_preempt_entity (ie. a task that is not
> > > latency sensitive might have to wait a few ticks to preempt a latency
> > > sensitive task, even if it was recently sleeping for a while).
