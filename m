Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DAC4D3722
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbiCIRBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbiCIRBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:01:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DA49AE4E;
        Wed,  9 Mar 2022 08:48:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16283B82214;
        Wed,  9 Mar 2022 16:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0311C340E8;
        Wed,  9 Mar 2022 16:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646844474;
        bh=r4HgBdigGRlJ/gib60srGnwEHU/ybPJ/Pd5UYLaa/5U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TkB1wVXvtcj4gyhPwRPqGBevqJcu1ebizXT5hVQfLlCLJu0HjHSQFhBjiA90sZyW4
         84Qk1XhX1Q+Bsc9Em4xWdS19uoHVfuHqZKKhfRoBin4C9ot1Jr44QfbIyiIBO1e5sV
         /T0Ktjq+RltVNFwG+9bWx2xKgD/zz3OmZyah08+LdZawEt+VM28xzIMqYaLB9sIE/v
         bYyTvQT3bc7sgiHnBvF9oMyaDCy5UPZSPtEFU/2juhlKfByltD85BLk5cyhCTletGF
         t0irZ7Zax720mXqo+CE73vHHJyIiVR+cSPc+2vFIpHmd+jtPrAVgbv2eMZe0P4NVdD
         CDtwqUeZmtDIw==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2db2add4516so30019627b3.1;
        Wed, 09 Mar 2022 08:47:54 -0800 (PST)
X-Gm-Message-State: AOAM5315oTcghjA2LsSoY8iAdBIAbIrhSO9zOYZ/jScTrrg4Ao4TWXBe
        siFHYHHWZgpXmBlstqn6B+0Yc61A20yMM2R44KU=
X-Google-Smtp-Source: ABdhPJwTrLVc12ChigXAssUQnpoojMnDXnWV9IDaS2JOgpBGIvi5QMCh/lM/0MimigCSJq7lMdHUuhCmzuZDIH6dDVg=
X-Received: by 2002:a81:854:0:b0:2db:255b:dd6 with SMTP id 81-20020a810854000000b002db255b0dd6mr585378ywi.140.1646844473928;
 Wed, 09 Mar 2022 08:47:53 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYtpy8VgK+ag6OsA9TDrwi5YGU4hu7GM8xwpO7v6LrCD4Q@mail.gmail.com>
 <YiiDZ7jjG38gqP+Q@shell.armlinux.org.uk> <CAMj1kXHTdk1Abm7ShoZzrW6EpM9eyFMPSdaa58Ziie4ZMecCnQ@mail.gmail.com>
 <CA+G9fYvCvBBi+dZ+CnUy=ZK6GhCFhBw72_==Cav=Q8QP5T1r5w@mail.gmail.com>
 <CA+G9fYt73AYs=z-BeZh22RBp==sf73pKky6m4iPSH7a4FssK7w@mail.gmail.com>
 <CAMj1kXEFZVeWLaRQJmwO+Nn6uW4q6vXJOaNNTVKju1p2bMQksA@mail.gmail.com>
 <YijCkHHhpleeADAO@shell.armlinux.org.uk> <CA+G9fYtjrAMg8TykZdRyZEfRthyqom_73x87F-60C_QFeEL8Bg@mail.gmail.com>
In-Reply-To: <CA+G9fYtjrAMg8TykZdRyZEfRthyqom_73x87F-60C_QFeEL8Bg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 9 Mar 2022 17:47:42 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFG5m5qfs9W9BfULj36kA-mTxtGZgkRLbgtaATLnPYb1g@mail.gmail.com>
Message-ID: <CAMj1kXFG5m5qfs9W9BfULj36kA-mTxtGZgkRLbgtaATLnPYb1g@mail.gmail.com>
Subject: Re: [next] arm: Internal error: Oops: 5 PC is at __read_once_word_nocheck
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2022 at 17:38, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Hi Russell,
>
> On Wed, 9 Mar 2022 at 20:37, Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Wed, Mar 09, 2022 at 03:57:32PM +0100, Ard Biesheuvel wrote:
> > > On Wed, 9 Mar 2022 at 15:44, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > >
> <trim>
> > Well, we unwound until:
> >
> >  __irq_svc from migrate_disable+0x0/0x70
> >
> > and then crashed - and the key thing there is that we're at the start
> > of migrate_disable() when we took an interrupt.
> >
> > For some reason, this triggers an access to address 0x10, which faults.
> > We then try unwinding again, and successfully unwind all the way back
> > to the same point (the line above) which then causes the unwinder to
> > again access address 0x10, and the cycle repeats with the stack
> > growing bigger and bigger.
> >
> > I'd suggest also testing without the revert but with my patch.
>
> I have tested your patch on top of linux next-20220309 and still see kernel
> crash as below [1]. build link [2].
>
> [   26.812060] 8<--- cut here ---
> [   26.813459] Unhandled fault: page domain fault (0x01b) at 0xb6a3ab70
> [   26.816139] [b6a3ab70] *pgd=fb28a835
> [   26.817770] Internal error: : 1b [#1] SMP ARM
> [   26.819636] Modules linked in:
> [   26.820956] CPU: 0 PID: 211 Comm: haveged Not tainted
> 5.17.0-rc7-next-20220309 #1
> [   26.824519] Hardware name: Generic DT based system
> [   26.827148] PC is at __read_once_word_nocheck+0x0/0x8
> [   26.829856] LR is at unwind_frame+0x7dc/0xab4
>

Thanks Naresh,

Is this something that could be bisected? With the unwind change
reverted, it is not obvious where the problem originated. Also, could
you check whether it is reproducible on the ARM tree? (for-next on
git://git.armlinux.org.uk/~rmk/linux-arm.git)

Unfortunately, after having been able to reproduce this locally, the
issue went away when I did the revert, so I am no longer seeing the
problem.

-- 
Ard.
