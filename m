Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D864D3696
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbiCIQw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbiCIQpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:45:18 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBBD34B84
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:38:38 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2db2add4516so29687567b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 08:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FYem1Pt/Xe9Lh/kXSus3+7B7F4+IckmOlwawpP7mogA=;
        b=pe0TRecPrltVfciFdizjQSCxwxWp6DJOZb6bed+UsJamf1GlcRlaSr6xxRhVBUHApu
         gbDXHSOskTCcRjMM86GcKJuwZd8ag3Di6bZDAEmyxfosweVlE8LkrLQIKzRe7Z+TYsNr
         LoFthUEGmvtTACjAAmMyJ93MmEpBQWQ7dJuoyZ/mH5R4GIXRzCSPMSNQgfZ7q64t+cbZ
         cJ0VYdQKbsbOgjuJEZ3RweSw5TB1A+o6fNDau++YDHFaV9w6hn8XEm4ElYJ/oPBMruYr
         +rWeFUsbRphdfweEKvy/H0SRfjWskp5XVvZS/MD6wSi5bp/LV2ZWzGBbpVqmyDrlZzvI
         sZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FYem1Pt/Xe9Lh/kXSus3+7B7F4+IckmOlwawpP7mogA=;
        b=WmrlWmSMgZ5/tc6r80TWizmcrmLJIOFSSuIA6fXHWAGSE4qY7J+GmddSNph3QATQEe
         pDLkELEiLsA3CdKsivCbzM8AvBSdL5wCLvBcYZAyUdEqT3fI9C7pGeglSsGpaG+u7ujy
         aSKtR+B77621bfzq/cq8jybhtekJXUIYAfV+cX+DkDu2/HqGPITETkwbDJLXhCdleyW/
         uXG4PVIDthAaJlIKcuGJ15CW/Z1Lzsypa3XodtxbLmrB0vLg8PoeJwR1UTCBC+/V5O2s
         NOcDHB5SAOsLOH5CJhZfmapE+uwD5x/7QYJZZWafVXfxD14iotUXh7nyCKH3yTDzDWbh
         hQkQ==
X-Gm-Message-State: AOAM530wC/8WnQBcm55fLbQR+7v+o5gDh13CmdMMFH86LjP19XRLdKYU
        IMNa6eBET6+Qt+S824gihdVFjAxRZ3Kb0+pA77oJjA==
X-Google-Smtp-Source: ABdhPJy+ds2lSwlGEfqaJaQYi0bp8LMxsaCcGaBI0XNqMMJDHIY4lSe3/bruwhh+507hh0NIPNVtx8zXSaoWDd8Ml2w=
X-Received: by 2002:a81:2f12:0:b0:2d7:d366:164a with SMTP id
 v18-20020a812f12000000b002d7d366164amr521610ywv.265.1646843917980; Wed, 09
 Mar 2022 08:38:37 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYtpy8VgK+ag6OsA9TDrwi5YGU4hu7GM8xwpO7v6LrCD4Q@mail.gmail.com>
 <YiiDZ7jjG38gqP+Q@shell.armlinux.org.uk> <CAMj1kXHTdk1Abm7ShoZzrW6EpM9eyFMPSdaa58Ziie4ZMecCnQ@mail.gmail.com>
 <CA+G9fYvCvBBi+dZ+CnUy=ZK6GhCFhBw72_==Cav=Q8QP5T1r5w@mail.gmail.com>
 <CA+G9fYt73AYs=z-BeZh22RBp==sf73pKky6m4iPSH7a4FssK7w@mail.gmail.com>
 <CAMj1kXEFZVeWLaRQJmwO+Nn6uW4q6vXJOaNNTVKju1p2bMQksA@mail.gmail.com> <YijCkHHhpleeADAO@shell.armlinux.org.uk>
In-Reply-To: <YijCkHHhpleeADAO@shell.armlinux.org.uk>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 9 Mar 2022 22:08:25 +0530
Message-ID: <CA+G9fYtjrAMg8TykZdRyZEfRthyqom_73x87F-60C_QFeEL8Bg@mail.gmail.com>
Subject: Re: [next] arm: Internal error: Oops: 5 PC is at __read_once_word_nocheck
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
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

Hi Russell,

On Wed, 9 Mar 2022 at 20:37, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Mar 09, 2022 at 03:57:32PM +0100, Ard Biesheuvel wrote:
> > On Wed, 9 Mar 2022 at 15:44, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
<trim>
> Well, we unwound until:
>
>  __irq_svc from migrate_disable+0x0/0x70
>
> and then crashed - and the key thing there is that we're at the start
> of migrate_disable() when we took an interrupt.
>
> For some reason, this triggers an access to address 0x10, which faults.
> We then try unwinding again, and successfully unwind all the way back
> to the same point (the line above) which then causes the unwinder to
> again access address 0x10, and the cycle repeats with the stack
> growing bigger and bigger.
>
> I'd suggest also testing without the revert but with my patch.

I have tested your patch on top of linux next-20220309 and still see kernel
crash as below [1]. build link [2].

[   26.812060] 8<--- cut here ---
[   26.813459] Unhandled fault: page domain fault (0x01b) at 0xb6a3ab70
[   26.816139] [b6a3ab70] *pgd=fb28a835
[   26.817770] Internal error: : 1b [#1] SMP ARM
[   26.819636] Modules linked in:
[   26.820956] CPU: 0 PID: 211 Comm: haveged Not tainted
5.17.0-rc7-next-20220309 #1
[   26.824519] Hardware name: Generic DT based system
[   26.827148] PC is at __read_once_word_nocheck+0x0/0x8
[   26.829856] LR is at unwind_frame+0x7dc/0xab4

- Naresh

[1] https://lkft.validation.linaro.org/scheduler/job/4688599#L596
[2] https://builds.tuxbuild.com/269gYLGuAdmltuLhIUDAjS2fg1Q/
