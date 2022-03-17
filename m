Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143FB4DCC20
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 18:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbiCQRNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 13:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbiCQRNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 13:13:08 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90B4210459
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 10:11:51 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a20so2295056uaq.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 10:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IjdO2gAXjrlONlc4x17XqznmOuozTYDeD6qXOclL8Xg=;
        b=CwdCUg0Y2CycSS2sODVaVFEPGPmVu3qugMo+QRAXAtV7pYVntF5x+BkSUtFdCGHQaW
         pGvAlmu+V70UQyUpnjbCZJwV8T+f3eW7TaVUe+N2BdyGb2qT80nvi+GxvHd88g3WCxyE
         ZSHAwFy0U6tpxPJMqg4NVgX9nBtf8l9yyKONrFk3LtAFV1+BXSeqsqpnmQnsytJq2th4
         6O++hWC7s+Gp2Nblh5heQVw52IN1rE//OnNwZ8TZ+Vygx+Dk6q+R1PXkx+iuJcYvd6cp
         ViZYYzV7bc4zP2ci0i4nKUPg92+QCSt0htd3jVsdjALfcam9mIv9SMNxDd3BdB9LvTK4
         fF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IjdO2gAXjrlONlc4x17XqznmOuozTYDeD6qXOclL8Xg=;
        b=FBL/LIFTbJOxRNU3WOro09nl+PU8pmH1x3dbwLVnF/97DaA8uGCINlx/Pgxy5TUjKj
         /wjTy9FdoFtE5Otw/FTAoNtENFXxAhyhlxOHPFilwVuJFlLyeD6xLmFVdnGH/xTC0mE9
         g9oXqWGsGsraDg60cNEKUdNFnyXdv56FKJRqcZp3UG7SPuOpKxT8uKOBg2RHEyxrAwYv
         4wXZ9S4mdbaegds4q1FM0KOFT2VW3LyIQVo148JqCzu2aoxc/VVpiPKRjuusoDM/1xh5
         KGIrnGXFyBP8SHvzDgrrnTp0AO4pFhO8wfjaJsamjLE85Vndwv8AFIiYdJgLMoZ5oUg1
         fTjg==
X-Gm-Message-State: AOAM532qrELKUwI2JWcWylPvXb+KjcyXzltf+h3EtdR6vYZvZa6ZSvzX
        VmVP4NxNdrtkIf+Ja9CTMBWC4twBymoIDtpoeQoPtQ==
X-Google-Smtp-Source: ABdhPJyb7WPnqx1FZmSlxqsQUzcgxVrP6ntKUE7PeoirkBJ1qI0T/XyfGVje0YBHOSWMY/Mpj0xinpmcn8gPGkeO9Kw=
X-Received: by 2002:ab0:1667:0:b0:34b:d5b4:3ccb with SMTP id
 l36-20020ab01667000000b0034bd5b43ccbmr2020917uae.79.1647537110711; Thu, 17
 Mar 2022 10:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220208211637.2221872-1-eranian@google.com> <20220208211637.2221872-7-eranian@google.com>
 <YgPedIWUiPIzF8OW@hirez.programming.kicks-ass.net> <YiI0DKEzc41bF15C@hirez.programming.kicks-ass.net>
 <CABPqkBRQwYnxcXigKwF83BPhQmombqa6nuF5-krqN=00Loy_gg@mail.gmail.com> <20220315120853.GG8939@worktop.programming.kicks-ass.net>
In-Reply-To: <20220315120853.GG8939@worktop.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 17 Mar 2022 10:11:39 -0700
Message-ID: <CABPqkBT=6NX+jZeT97_EwMrAyQMrcTp5RAwAC85fM2cB0ihoQQ@mail.gmail.com>
Subject: Re: [PATCH v6 06/12] perf/x86/amd: add AMD branch sampling period adjustment
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 5:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Mar 09, 2022 at 03:03:39PM -0800, Stephane Eranian wrote:
> > On Fri, Mar 4, 2022 at 7:45 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Feb 09, 2022 at 04:32:04PM +0100, Peter Zijlstra wrote:
> > > > On Tue, Feb 08, 2022 at 01:16:31PM -0800, Stephane Eranian wrote:
> > > > > Add code to adjust the sampling event period when used with the Branch
> > > > > Sampling feature (BRS). Given the depth of the BRS (16), the period is
> > > > > reduced by that depth such that in the best case scenario, BRS saturates at
> > > > > the desired sampling period. In practice, though, the processor may execute
> > > > > more branches. Given a desired period P and a depth D, the kernel programs
> > > > > the actual period at P - D. After P occurrences of the sampling event, the
> > > > > counter overflows. It then may take X branches (skid) before the NMI is
> > > > > caught and held by the hardware and BRS activates. Then, after D branches,
> > > > > BRS saturates and the NMI is delivered.  With no skid, the effective period
> > > > > would be (P - D) + D = P. In practice, however, it will likely be (P - D) +
> > > > > X + D. There is no way to eliminate X or predict X.
> > > > >
> > > > > Signed-off-by: Stephane Eranian <eranian@google.com>
> > > > > ---
> > > > >  arch/x86/events/core.c       |  7 +++++++
> > > > >  arch/x86/events/perf_event.h | 12 ++++++++++++
> > > > >  2 files changed, 19 insertions(+)
> > > > >
> > > > > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > > > > index c2a890caeb0a..ed285f640efe 100644
> > > > > --- a/arch/x86/events/core.c
> > > > > +++ b/arch/x86/events/core.c
> > > > > @@ -1374,6 +1374,13 @@ int x86_perf_event_set_period(struct perf_event *event)
> > > > >         x86_pmu.set_topdown_event_period)
> > > > >             return x86_pmu.set_topdown_event_period(event);
> > > > >
> > > > > +   /*
> > > > > +    * decrease period by the depth of the BRS feature to get
> > > > > +    * the last N taken branches and approximate the desired period
> > > > > +    */
> > > > > +   if (has_branch_stack(event))
> > > > > +           period = amd_brs_adjust_period(period);
> > > > > +
> > > > >     /*
> > > > >      * If we are way outside a reasonable range then just skip forward:
> > > > >      */
> > > > > diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> > > > > index 3485a4cf0241..25b037b571e4 100644
> > > > > --- a/arch/x86/events/perf_event.h
> > > > > +++ b/arch/x86/events/perf_event.h
> > > > > @@ -1263,6 +1263,14 @@ static inline bool amd_brs_active(void)
> > > > >     return cpuc->brs_active;
> > > > >  }
> > > > >
> > > > > +static inline s64 amd_brs_adjust_period(s64 period)
> > > > > +{
> > > > > +   if (period > x86_pmu.lbr_nr)
> > > > > +           return period - x86_pmu.lbr_nr;
> > > > > +
> > > > > +   return period;
> > > > > +}
> > > >
> > > > This makes no sense to me without also enforcing that the event is in
> > > > fact that branch retired thing.
> > >
> > > So what are we going to do with all these patches? Note that I did pick
> > > them up for testing and I've fixed at least 2 build problems with them.
> > >
> > > But I still don't think they're actually completely sane. So there's the
> > > above issue, subtracting lbr_nr from a random event just makes no sense.
> >
> >
> > You are right. Initially, I had it such that only retired_branch_taken was
> > the only event possible. In that case, subtracting lbr_nr made sense.
> > Since, I have relaxed the event but it exposes this problem. I think
> > given how BRS works, I am okay restricting to retired_br_taken
> > because no matter what the hw is going to activate at P (period)
> > and wait for 16  taken branches before delivering the NMI. So if I
> > am sampling on cycles with P=1000000, then the NMI is delivered
> > at P + X + Z, where X = number of cycles elapsed for the 16 taken
> > branches (unpredictable) and Z the interrupt skid for NMI (which is
> > extremely big on AMD). With retired_branch_taken, that formula
> > becomes: P + 16 + Z, where Z is the number of taken branches
> > during the skid. But given BRS saturates when full, you do lose
> > the content because of the Z skid. My opinion is we keep the
> > lbr_nr subtraction and force event to be only retired_branch_taken.
>
> OK, can you do me a delta patch and tell me which commit to merge it in?
>
You want a delta patch covering the restriction allowing only
retired_taken_branch
as the sampling event. Is that right? I can also post a V7 that has
all the changes
including fixes in the perf tool strerror code. Whatever you prefer?

> > > But there's also the whole exclusion thing, IIRC you're making it
> > > exclusive against other LBR users, but AFAICT having one LBR user active
> > > will completely screw over any other sampling event due to introducing
> > > these massive skids.
> >
> >
> > The skid is not massive compared to the actual skid of regular interrupt-based
> > sampling. You are looking at the time it takes to execute 16 taken branches
> > vs. 2000+ cycles for the NMI skid.  And this would happen only if the other
> > events overflow during that 16 taken branch window.
>
> Wait, you're telling me that regs->ip is 2000 cycles/CPI further along
> than the instruction that caused the PMI on AMD? That seems beyond
> useless.
>
Yes, depending on the conditions, the skid can be large. Remember that AMD added
a loop to poll on amd_pmu_disable_all(). See commit:
914123fa3904 x86/perf/amd: Resolve race condition when disabling PMC

> That's also not what I seem to remember from the last time I used perf
> on AMD (admittedly a while ago). Normally the reported IP is a few
> instructions beyond the eventing IP. Yielding the normal perf-annotate
> output that's shifted but mostly trivially readable.
>
It all depends on what event you are sampling on. If you are sampling on
cycles and you are stalled, then you cannot make forward progress and
therefore the skid appears small and the profile still points you in the right
direction.

> However, if you delay that NMI for however many instructions it takes to
> do 16 branches, the reported IP (regs->ip) will be completely unrelated
> to the eventing IP (the one that actually triggered PMI).
>
No, because  once the BRS is full and saturates, the CPU delivers the NMI, still
subject to the skid. The regs->ip will be at the closest possible from
the last taken
branch recorded, just like with regular (non BRS sampling).

In the code we usually have, there are a lot of taken branches. In the case
of autoFDO, the regs->ip is not used, only the content of the branch buffer
is used.

> In that case the perf-annotate output becomes really hard to interpret.
> Esp. if you don't know which IPs were basically garbage.
>
That is true. But usually LBR data is not used for visualization by perf report.
It is post-processed for pure LBR data analysis, such as FDO.

> One possible work-around might be to discard the sample for any
> !retired_branch_taken overflow and reprogram those counters with a very
> small (1?) value to 'insta' take a new sample without interference. But
> that's yuck too.
>
Yes, that is ugly.

Thanks.
