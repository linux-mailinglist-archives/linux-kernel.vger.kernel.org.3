Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DFD50B582
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446857AbiDVKsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446851AbiDVKsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:48:53 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD0E3FBFA;
        Fri, 22 Apr 2022 03:45:59 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id w1so13575928lfa.4;
        Fri, 22 Apr 2022 03:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wGWQsodsPCEvTet53bPj88p4jYhZ/d++dMltkcbaEYI=;
        b=mAgORrZD4oGwxnomgnH+TjiwLaKb2n8RwwlVy9gojA6VXZvgpCuQHQFkyqo+L5hSg7
         P/CfljKHsQEkc4wyZRStj3cokDs5YI3oqJNK1uGWh3hbb2s22dB6WydHn15mu8u7mMO1
         8xBbXHxbRZmFXP5y3CV4pHpt0MPycn8SbcxahMoLHnhpFRQkLqGn5XzYyhFRC8N8m2Wk
         KItYYPtNrYMxiSoEyFk/4cxmCOQ0eQoqfllAQBynyv5OpDO4/x98HAzYmVKwcgvFIjPS
         lV6xZfyH+TW+wVOrnPE+U18irxyThdJTg1usk374FlxJQ/bcWJ3is8Gcp91qT4ffBaXY
         0Iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wGWQsodsPCEvTet53bPj88p4jYhZ/d++dMltkcbaEYI=;
        b=Vnhzk3WCyxhFGKTD2kkKcTd1joc6W3il2yVzQaF+pEF2SjHk+wTKGhEIQkGRMMoMnD
         bQ57VxswqHvqUgk4I3LnMy9QFhxe0tfsYgTPnaQntknMf4Pxy0UEHaLnKLvHOqQoDXAD
         7vebOzh2FYtYPxNyWTEVeqm+RThvUTaVK2Uo/riFEHkt9PNN0XNMaN75lB53MUFyeauh
         CBFb4mN77eozMBCg3jOrGJ+bBTbrzXx/GnMurjNzm+rsrmkyhgaJ3b5x4RqLALy8YBCK
         0BM8accF8OYGUPzy/KdrT8mGPB6tPrAM/q7aXeg29ES/qekxn8jiNql83cWSo8ObhxeI
         KWFQ==
X-Gm-Message-State: AOAM5316VYovy/GI6hcjgVIAxIPY0BNaQlmtN1rvJqtiI65PaUQXQpAE
        ZL44m9m7IxLYFLcZK/Gtuxng1gLW+6Iudf5GMq8=
X-Google-Smtp-Source: ABdhPJwDhLfB/RddN8AJO1OXvAzh43JVwTYgu7pKH9N74RGPzr1t5+yHvvDMmvwJ0C1Lq06TJ+kPl88b4hRASryM51Q=
X-Received: by 2002:a05:6512:31cc:b0:471:d125:162c with SMTP id
 j12-20020a05651231cc00b00471d125162cmr2737873lfe.96.1650624357838; Fri, 22
 Apr 2022 03:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220418043735.11441-1-patrick.wang.shcn@gmail.com>
 <20220418143404.55c8fcab@gandalf.local.home> <CAGcnep8bH4Nncbt3t+VRLff35ZyD8JyzHcEgkq-u6TEq47jqzQ@mail.gmail.com>
 <CAGcnep_Gx+3KiUvDVronYKn_divU3OM-RQEOPZakv7MRYh4EJw@mail.gmail.com>
 <20220420114454.69ab108c@gandalf.local.home> <20220420122633.55d4ff6b@gandalf.local.home>
 <CAGcnep86pd2trfTovU8_z1msOstx7gKCdndm=pHLDGTy+_K7=g@mail.gmail.com> <20220421085047.2cb8edf9@gandalf.local.home>
In-Reply-To: <20220421085047.2cb8edf9@gandalf.local.home>
From:   patrick wang <patrick.wang.shcn@gmail.com>
Date:   Fri, 22 Apr 2022 18:45:46 +0800
Message-ID: <CAGcnep9Ez-S962vukR_a=otzcSxDRo5HUW2vG_YCBanCfURGXw@mail.gmail.com>
Subject: Re: [PATCH] rcu: ftrace: avoid tracing a few functions executed in multi_cpu_stop()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 8:50 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 21 Apr 2022 19:36:06 +0800
> patrick wang <patrick.wang.shcn@gmail.com> wrote:
>
> > On Thu, Apr 21, 2022 at 12:26 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Wed, 20 Apr 2022 11:44:54 -0400
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > >
> > > Interesting. On x86 when we used stop machine[*] it was not an issue to
> > > modify the code that is being executed in stop machine. I'm curious to
> > > exactly what the issue is if something does get traced in the stop machine
> > > processing. Why does it crash?
> >
> > I looked up the commit history. When x86 turned to breakpoints, stop
> > machine's state machine loop had no calls during waiting. So there
> > was no function being called during modifying code. Which means
> > there were no other cpus would load those instructions to be updated
> > in this period. While the stop machine currently will call other functions
> > and the call chain is fairly deep. So it may not quite be suitable for ftrace
> > now because it can not make sure the instructions within its own call
> > chain are updated atomically.
>
> Are you saying that the RISC-V stop machine implementation has code being
> called on the other CPUs while they wait?
>

Yes, and not just RISC-V. It's arch-independent. It's the internal change of
stop machine implementation.

----------------------------------------------------------------
Former stop machine wait loop:
do {
    cpu_relax(); => macro
    ...
} while (curstate != STOPMACHINE_EXIT);
-----------------------------------------------------------------
Current stop machine wait loop:
do {
    stop_machine_yield(cpumask); => function (notraced)
    ...
    touch_nmi_watchdog(); => function (notraced, inside calls also notraced)
    ...
    rcu_momentary_dyntick_idle(); => function (notraced, inside calls traced)
} while (curstate != MULTI_STOP_EXIT);
------------------------------------------------------------------

Thanks,
Patrick
