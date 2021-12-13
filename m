Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8D8473413
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbhLMSdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241901AbhLMScx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:32:53 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76526C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:32:52 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id m192so14757318qke.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IAnl8vgRr7H2Yz93xoteX5sgksEiW8J2i2rl/LiRXPQ=;
        b=G9PlSV80s/UD+Va+xCjc+d7UKXiyIIT7AGL3j4HCQkSFDzI/oWQcKYwkB9g7lCPbtc
         aJvmUOMB41qVlKSKUG4lYq5WhSICOOC7mwtIrw4EJgwCn/ZCPQfxcajLci91XPsi6Izp
         CBia6xdmsSgWfn5YmSlQA2BBIbu/r/wFjX9ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IAnl8vgRr7H2Yz93xoteX5sgksEiW8J2i2rl/LiRXPQ=;
        b=VXe5QNsV16wap3+Hua5a6TWmyrIp7AGJaWQPjGP37R/P3FQH6YokmerZoRkpGWcaSY
         +w7yl3C928XLy78xa+KZg1BoCVitgyzcSX3JZEmCnuLIICNitcUNjKMbmyBGx/m9kvNc
         me0QZDNjPRi8OKtJ1MYnFpOF61BcBpimv8+3eEJrlpLV48U6gEym3ZS8uQRIaUK95DB4
         g5rwTmXakSbQkeX4xALnZwTNT49qAZ09o+8NGbdzlQgTk1WD3tBibWIwSK581RdOlxhk
         Q+np5s/dyeZZZMkvlW8nWixOxFIvwRGsR7e2c6WDmftoSgfCD8VjwlEn79ZsCHZFwXuT
         JUSw==
X-Gm-Message-State: AOAM531INlohersDpbDPFS2nMJbnPfLr1Nm27Lf8pY4S1JZv9wZ3O/Tx
        2yc/5J+3BhxjoGx4OEcndiJOcQjBtwORIg==
X-Google-Smtp-Source: ABdhPJzVVpGoO8l7+E1xKlE/oTWjmCSwrIeeOOWQGZRnyQ4PXxOPNYH3Qu1d70t2RgByKHx2qwbeUg==
X-Received: by 2002:ae9:f11a:: with SMTP id k26mr59741qkg.444.1639420370971;
        Mon, 13 Dec 2021 10:32:50 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id o17sm6336294qkp.89.2021.12.13.10.32.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 10:32:50 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id q74so40445607ybq.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:32:50 -0800 (PST)
X-Received: by 2002:a25:3ac1:: with SMTP id h184mr214761yba.734.1639420369818;
 Mon, 13 Dec 2021 10:32:49 -0800 (PST)
MIME-Version: 1.0
References: <20211115170241.1.I94825a614577505bd1a8be9aeff208a49cb39b3d@changeid>
 <CAD=FV=UZNxt7y6bTipyvYFGMJhgp6nRozNt=iEaOYP6yc4OFpg@mail.gmail.com>
 <CAJWu+ora8F0eurnYkSXRqcT4mB8k8wy9CyKj1EGk52vEVEkT3A@mail.gmail.com>
 <20211202111127.gew4lqquvtn3lkbc@e107158-lin.cambridge.arm.com>
 <CAD=FV=V8aB7_6tEq9SbW+vNC5Y7G+8JMsWXo6+zdtF3tmJ97EQ@mail.gmail.com> <20211213130853.gdywukt2ibxnwzse@e107158-lin.cambridge.arm.com>
In-Reply-To: <20211213130853.gdywukt2ibxnwzse@e107158-lin.cambridge.arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 Dec 2021 10:32:36 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vt1AjtYvX-NEAomCy3piHOVa-E-9G=OtKdvDRp-E3HpQ@mail.gmail.com>
Message-ID: <CAD=FV=Vt1AjtYvX-NEAomCy3piHOVa-E-9G=OtKdvDRp-E3HpQ@mail.gmail.com>
Subject: Re: [PATCH] sched/rt: Don't reschedule a throttled task even if it's
 higher priority
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Joel Fernandes <joelaf@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 13, 2021 at 5:09 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> > > Note that Peter fixed the kernel so that it produces known RT priorities (as
> > > opposed to developers setting random values in the past):
> > >
> > >   * sched_set_fifo_low() ==> not really RT but needs to be above cfs. Runs at
> > >     priority 1.
> > >   * sched_set_fifo() ==> sets priority MAX_RT_PRIO/2 ==> 50
[ ... cut ... ]
> > I would also say that with Peter's fix above the problem is perhaps
> > _more_ urgent? You just said that there's a whole bunch of kernel
>
> I can't see the problem still tbh.

I think this is the key, so let me explain more here. I don't think
it's worth nitpicking the documentation more to figure out what the
original author might have meant. Even if the current behavior is
expected, it's still a broken behavior that's worth fixing.

Here's my point of view:

1. The fact that the kernel has some of its threads running w/
sched_set_fifo_low() is not ABI to userspace, right? The kernel's
usage of this function on some tasks is an implementation detail and
not something that userspace should need to know about or worry about.

2. Presumably when the kernel is using sched_set_fifo_low() it's doing
so for tasks that are important for the running of the system. I
suppose you could say that _all_ kernel tasks are important to the
running of the system, but presumably these ones are higher priority
and thus more important.

3. If userspace is bothering with all the setup of RT_GROUP_SCHED, it
presumably is expecting it to do something useful. Presumably this
"useful" thing is to keep other parts of the system (those not in the
RT group) working normally. Specifically userspace wouldn't be
expecting the system to crash or a big chunk of kernel functionality
to just stop working if the scheduling allocation is exceeded.

4. Userspace expects priorities other than the "lowest" priority to be
useful for something. If they're not then they should be disallowed.

Maybe from the above points my argument is clear? Said another way:
Userspace is allowed to use a priority other than the lowest one.
Userspace wouldn't be setting up RT_GROUP_SCHED if it didn't think it
would be needed. Userspace doesn't want the kernel to crash / chunks
of functionality to fail when RT_GROUP_SCHED triggers. Userspace can't
know / account for kernel tasks using sched_set_fifo_low()

As an actual example, on my system (which has important kernel tasks
using sched_set_fifo_low()) a big chunk of the kernel is unusable if I
run my testcase. We can't get keyboard input nor do any other
communication to one of the important components in our system.


-Doug
