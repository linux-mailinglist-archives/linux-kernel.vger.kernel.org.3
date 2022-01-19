Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31354493F1B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356443AbiASRdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356438AbiASRd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:33:28 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317CEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 09:33:28 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso1348948wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 09:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E5e/gbMD1CI1oNnHoXsVfQit0AqJzsZNFNoMFZIa3yo=;
        b=WmT8mo/Jdy5x0dloa8gkKdAaIf8hr7M/ebJkJWZ/RWfXSCx+/MARi8gUcqkp0XtFrz
         rM4cstaSkdu91SBqo5K1zXG+ti72XZ/IUGrNAP1vnrxuXWgBuJAYro2LtQFxLvNWTi2h
         5ZLXWm28rZ68n3PX5lNuQSmhYOXMThUfK5Yym7fixUJZchEpMDZldGD9byToOQc830RZ
         ZsQUsTuwqNoAOm7g/BSTjFs/Igm3qC02l+4IiR33HANapb8mfs/42RNpC8utTrfLiEXt
         m6InW8giQaNDO6owF9gYElq7AsEsiL6GURWMQCvwfB9V+FDTY7KuNjzNK0sjcNIEQTL1
         2fBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E5e/gbMD1CI1oNnHoXsVfQit0AqJzsZNFNoMFZIa3yo=;
        b=P9uawgcJKT1Jq1bG+mZRKrxV6cVOAjWGTWGdVoxox+0xMGjmFCOsOP4rB50XYi2CzJ
         49B1e9dhBVnEg7Q97th+5U1qRKKhFJf4e0f7/dB734mbM9pDk/Syc/F9w3xxM4/sorl6
         9+h9+kFWrsv6UUQYZKR9kXXl2vH8TK1JK7bTxCZC8U25OU8kdjizgl/7sJGnSvF5J9iv
         TYBtnOJjLhR9fYRDrWPvNQjQ0mJvFNhZoLtlMGllaWnAtV2bYRPKb3BI5vEIM5Mk01Lz
         Lsrl1CxBHJGS73n58qkoIXkvXPQXiVVziS69+V+dTLME3tKm4LffOtu9pfAeC35ZrS7l
         aBsw==
X-Gm-Message-State: AOAM5311F5tLe3b57y3er0L2GM7/kqd0vFnh5hSPrvqYE6LnTyhiabNE
        djsa80gKF/tx3c2cPn8QkFIynGBg9XQJmUzcAYhWTw==
X-Google-Smtp-Source: ABdhPJwu7kUqdN9jzIk+hqALXPHegLrqP/weejs07XlgrmOWp0FWwVtOZH3CpffoM+v4k+wrQFDN0VBR42C/FK14AnQ=
X-Received: by 2002:adf:9dc7:: with SMTP id q7mr6096353wre.148.1642613606589;
 Wed, 19 Jan 2022 09:33:26 -0800 (PST)
MIME-Version: 1.0
References: <20211214204445.665580974@infradead.org> <20211214205358.701701555@infradead.org>
 <20211221171900.GA580323@dev-hv> <YeGEM7TP3tekBVEh@hirez.programming.kicks-ass.net>
 <YeaRx9oDp08ABvyU@hirez.programming.kicks-ass.net> <CAPNVh5cdGiDqut90kUo-HXyya6Nbz_CjuUObYXfprgDhQHnUmg@mail.gmail.com>
 <YefQJXn3x3JJtB1d@hirez.programming.kicks-ass.net>
In-Reply-To: <YefQJXn3x3JJtB1d@hirez.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@google.com>
Date:   Wed, 19 Jan 2022 09:33:15 -0800
Message-ID: <CAPNVh5eBJB+QDr+gH4DvK1raho0tQx=w_LUFm5Gq7TVijoKrBg@mail.gmail.com>
Subject: Re: [RFC][PATCH 3/3] sched: User Mode Concurency Groups
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Peter Oskolkov <posk@posk.io>, mingo@redhat.com,
        tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 12:47 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jan 18, 2022 at 10:19:21AM -0800, Peter Oskolkov wrote:
> > ============= worker-to-worker context switches
> >
> > One example: absl::Mutex (https://abseil.io/about/design/mutex) has
> > google-internal extensions that are "fiber aware". More specifically,
> > consider this situation:
> >
> > - worker W1 acqured the mutex and is doing its work
> > - worker W2 calls mutex::lock()
> >   mutex::lock(), being aware of workers, understands that W2 is going to sleep;
> >   so instead of just doing so, waking the server, and letting
> >   the server figure out what to run in place of the sleeping worker,
> > mutex::lock()
> >   calls into the userspace scheduler in the context of W2 running, and the
> >   userspace scheduler then picks W3 to run and does W2->W3 context switch.
> >
> > The optimization above replaces W2->Server and Server->W3 context switches
> > with a single W2->W3 context switch, which is a material performance gain.
>
> Yes, I've also already reconsidered. Things like pipelines and other
> fixed order scheduling policies will greatly benefit from
> worker-to-worker switching.
>
> But I think all of them are explicit. That is, we can limit the
> ::next_tid usage to sys_umcg_wait() and never look at it for implicit
> blocks.

Yes, of course - when a worker blocks, its server gets notified.

>
> > In addition, when W1 calls mutex::unlock(), the scheduling code determines
> > that W2 is waiting on the mutex, and thus calls W2::wake() from the context of
> > running W1 (you asked earlier why do we need "WAKE_ONLY").
>
> This I'm not at all convinced on. That sounds like it will violate the
> 1:1 thing.

wake_only is a wakeup event, meaning the worker gets added to the wake
queue, not scheduled on a CPU; we don't have to implement it in the
kernel, though - the userspace may keep its own wake queue for workers
like this. So feel free to ignore this operation.
