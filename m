Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84F44EFFC2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 10:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351052AbiDBIsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 04:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244967AbiDBIsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 04:48:43 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC0F1AAA4B
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 01:46:50 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 17so6731720lji.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 01:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aj9XTAr/1wAKq1WVY1B1OGIPL9lJ/xIj7GaRUxg+TfU=;
        b=uqzITrCuEDxkVhSaiQ69/mJhXL9nTyP0pEssq+Ygi9Ic3nj/wAmXNBMtMbtIqIUFQy
         l1pFEKZrlmy8hiXmYcdX18ODqT7VG7JPnvg0iK84enJjXvZFfLSjwXuXcjmxQvhprKsy
         e6QnjLim42Pgp7Kn024P6PPTT/Qp/eeZPxBiCo1GnZsLEkX+XyWj8urhj41q0j9K/+zy
         Sfy4kf4C8GbNGEH5Ee++3Ybvg95WG8hix8SgsL415C7vZQEyBuAF9RyR0KGc4bNr1ldR
         KNXLoJjgx1bTj3SruwRLUY9JZW8q8neNiHEu8YFXjN1xCKMY1If0Gvog3O4WWPz2Bx/v
         jWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aj9XTAr/1wAKq1WVY1B1OGIPL9lJ/xIj7GaRUxg+TfU=;
        b=6R5xKociWmtC5qRgMGvCyj3yvbk1ym9rY97EosoZ59+4Ry31RDL4ZUUKWcEnIt6yYb
         1hOC/R7ZLXUt5yfo5c0tCV7a+K6vAUrpYiZKTaS3VbNQwZNQljJKpUQid3msR7Jb4CYP
         66s1pLl0gceD1CktpGn/xDb/JEHo6LAZCVJ9dcg7EJnDH2wqulvZExk88/H8G0KD3fFJ
         zF0NSW2D+XJDzBBnSjp0W1UsHM59on/MfuFVxvkoaN2m4R8azakxQ8nPiU/HVLjx3pMg
         eshG5r8Ho0LRhhgeQhCtfeMsVJAObEjY+MdVLR8cglqb0OpFfMiR43kJSwPkMRqoKHtK
         T33A==
X-Gm-Message-State: AOAM533o9cKRGxaf2hT3Bz3ZJKMbPpzFm/RJ2a2a2ssGvWxkow1YCpNX
        b1JEgywmVi6fisgTv5xINBL0ZWy4wMmDP8qeU7FslA==
X-Google-Smtp-Source: ABdhPJxG6My1AsyNMTvc5wTrFvpznqO5wKjXQEBrlpgWZPNbE82FXJn7xU/G/soKfMsZGmdK1q8TBBMrIKokhx5GwPc=
X-Received: by 2002:a2e:7d05:0:b0:247:ed41:690d with SMTP id
 y5-20020a2e7d05000000b00247ed41690dmr15812746ljc.92.1648889209127; Sat, 02
 Apr 2022 01:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
 <7a7e1e21-df3d-4623-d9cd-51f5272919d5@arm.com> <CAKfTPtC36OLqrQ57bnGDi93N+3Ozk5cX-+KHHTWHkwCGp=z4gA@mail.gmail.com>
 <20220401121525.flngciwjtkn3mwlv@airbuntu>
In-Reply-To: <20220401121525.flngciwjtkn3mwlv@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Sat, 2 Apr 2022 10:46:37 +0200
Message-ID: <CAKfTPtD7YntSV+fJkdwZxX0iO52hL0SxZ9G5hZTBSyZf6hMYRQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add latency_nice priority
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org,
        parth@linux.ibm.com, chris.hyser@oracle.com,
        pkondeti@codeaurora.org, Valentin.Schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, Wei Wang <wvw@google.com>
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

On Fri, 1 Apr 2022 at 14:15, Qais Yousef <qais.yousef@arm.com> wrote:
>
> +CC Wei
>
> On 03/28/22 14:56, Vincent Guittot wrote:
> > Hi Dietmar,
> >
> >
> > On Mon, 28 Mar 2022 at 11:24, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> > >
> > > On 11/03/2022 17:14, Vincent Guittot wrote:
> > > > This patchset restarts the work about adding a latency nice priority to
> > > > describe the latency tolerance of cfs tasks.
> > > >
> > > > The patches [1-4] have been done by Parth:
> > > > https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com/
> > > >
> > > > I have just rebased and moved the set of latency priority outside the
> > > > priority update. I have removed the reviewed tag because the patches
> > > > are 2 years old.
> > > >
> > > > The patches [5-6] use latency nice priority to decide if a cfs task can
> > > > preempt the current running task. Patch 5 gives some tests results with
> > > > cyclictests and hackbench to highlight the benefit of latency nice
> > > > priority for short interactive task or long intensive tasks.
> > >
> > > The Android specific `latency_nice` (in Android `latency_sensitive`
> > > [latency_nice < 0]) use case `Skip energy aware task placement` favors
> > > an idle CPU over the EAS search path for a `latency_sensitive` task.
> > >
> > > https://lkml.kernel.org/r/2aa4b838-c298-ec7d-08f3-caa50cc87dc2@arm.com
> > >
> > > This is Android proprietary code similar to what we have in
> > > find_idlest_group_cpu() in mainline.
> > > We talked to the Android folks last week and IMHO they are not convinced
> > > that they can switch this to the proposed `latency_nice->tweak
> > > preemption` use case.
> >
> > Thanks for discussing this with Android folks. It's not always easy to
> > change the behavior of a product and I would be interested to discuss
> > this with them. Sometimes you need a PoC to get convinced
>
> I think it's good to clarify for me at least here whether you intend this as
> a replacement for disable EAS and revert to CAS or you see this as an
> additional thing? As I understood from the discussion we had on the cover
> letter, this is an additional improvement and not intended to replace any of
> the previous use cases we brought up before.

This is not a replacement but an additional way to improve latency.
The only thing that could happen is that this feature provides
enhancement that makes the policy of disabling EAS and revert to CAS
becoming less or no more interesting.


>
> Wei/Quentin, any thoughts on this?
>
> Thanks
>
> --
> Qais Yousef
