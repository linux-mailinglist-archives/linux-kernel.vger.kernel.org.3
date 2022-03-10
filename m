Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52D74D541F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 23:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240265AbiCJWHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 17:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiCJWHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:07:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D161903F3;
        Thu, 10 Mar 2022 14:06:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 792A361AD2;
        Thu, 10 Mar 2022 22:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4CCC340E8;
        Thu, 10 Mar 2022 22:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646949989;
        bh=eXiXxMTG2p/Om9bcg7vYHQ1rDSxu9DHWqWu8LYKN9Cw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p1dg6Sx/fejHsKvJdRgtiKUvje9NqiawN51CgRUZSCNp/6R/XalgUw2KLkfqIrrsy
         v4/A4p2RdsudO2mzHINileZfP7V51CY2CSF7I+E1AbBVQvCxnBnet3oWGb3ew1g2C9
         /OkadhqCcnT9/x89kSUZXdaFUigsAztBMD//wCJRU0YsA6KRy3bs33422PStf717Bb
         /Se7oDBaAUne+QCIM80DDgkf6o/mYsOnMdVC+PsHmLGAsiKB3IdP4EzsqghzqloOBE
         pd3GfONQtHRn+zdJ53l84be1G65Zc2mbPvZ37uR53FgYdgLrN3YPDmjt5Ab/lL5eaz
         V6AMJ9xcw9Oeg==
Received: by mail-yb1-f173.google.com with SMTP id u10so13609167ybd.9;
        Thu, 10 Mar 2022 14:06:29 -0800 (PST)
X-Gm-Message-State: AOAM531+bXxXAi7rFmrf1Q6f00uZYJIOjszd9SpSmkqC7y0UauQNbn4k
        Yy5GealzxzBRzjpaLMxgAt8OvHL7KYRqdQ1W9DI=
X-Google-Smtp-Source: ABdhPJzrZWRb0PaCbckqVtB9PE/wLjvPoMJUe3Xu/dkSQDQbw1CFW/HUGbz0bYpRIQQnLjmsEfNg1BI8X6YaYxFUO38=
X-Received: by 2002:a25:af8e:0:b0:622:c778:c0a2 with SMTP id
 g14-20020a25af8e000000b00622c778c0a2mr6000960ybh.50.1646949988830; Thu, 10
 Mar 2022 14:06:28 -0800 (PST)
MIME-Version: 1.0
References: <CAMj1kXEFZVeWLaRQJmwO+Nn6uW4q6vXJOaNNTVKju1p2bMQksA@mail.gmail.com>
 <YijCkHHhpleeADAO@shell.armlinux.org.uk> <CA+G9fYtjrAMg8TykZdRyZEfRthyqom_73x87F-60C_QFeEL8Bg@mail.gmail.com>
 <YijfzAhWAgfGGqCO@shell.armlinux.org.uk> <CAMj1kXFvjawvOzeTb2m1H=P-_aXgW-ozvaOK1FtjBv7G0sCDFA@mail.gmail.com>
 <Yij2cZVKwPexGsTf@shell.armlinux.org.uk> <CAMj1kXE02HH7vRUjF3iKAL+1idKTy-oOYyGnBd3g90m6eObBxg@mail.gmail.com>
 <YikByJteDEtKi4Xv@shell.armlinux.org.uk> <CAMj1kXGnwbe=YYWaRxaXioEfTJOdXg9JYcNddO8iifpWLRZCWg@mail.gmail.com>
 <Yinwq3Z9l0selLLS@shell.armlinux.org.uk> <Yin2jQqW+pUWJZ7E@shell.armlinux.org.uk>
 <CAMj1kXGkUJ=-4oA4GvBZNK94A1MrZ7UwKDN_tJRgwq8KF06VmA@mail.gmail.com>
 <CA+G9fYvEANOMekjvtu7agdVYQ_b8OMtxQdyAV2JT_vMdBU3VRA@mail.gmail.com>
 <CAMj1kXEVVZTKX_86bbTfLpFuDriV0-uwCMgSKDP+dzcD1L4XCw@mail.gmail.com> <CA+G9fYuO-sy+sZnhSz=A7Xm0LdSp2AT+7jCKLB33tZzK4izj3g@mail.gmail.com>
In-Reply-To: <CA+G9fYuO-sy+sZnhSz=A7Xm0LdSp2AT+7jCKLB33tZzK4izj3g@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 10 Mar 2022 23:06:17 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGb_0FNU7capJEDWTZF2OegmZyBphhH8GuNqL7+YYLjZQ@mail.gmail.com>
Message-ID: <CAMj1kXGb_0FNU7capJEDWTZF2OegmZyBphhH8GuNqL7+YYLjZQ@mail.gmail.com>
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

On Thu, 10 Mar 2022 at 22:50, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Fri, 11 Mar 2022 at 02:55, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Thu, 10 Mar 2022 at 22:18, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > Hi Ard and Russell,
> > >
> > > The boot test pass on linux next-20220310 tag with  KASAN=y on BeagleBoard x15
> > > device. but LTP cve tests reproduced the reported kernel crash  [1].
> > > From the available historical data I can confirm that this is an
> > > intermittent issue on
> > > BeagleBoard x15 devices.
> > >
> > > OTOH, the kernel crash is always reproducible on qemu-arm with KASAN=y
> > > while booting which has been known to fail for a long time.
> > >
> > > From the Ardb tree I have boot tested qemu-arm with KASAN=y the reported
> > > kernel crash is always reproducible.
> > >
> > > The build steps [3] and extra Kconfigs.
> > >
> > > - Naresh
> > > [1] https://lkft.validation.linaro.org/scheduler/job/4701310
> > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/
> > > [3] https://builds.tuxbuild.com/2661dIAPUjE2DMJvye91He2gus0/tuxmake_reproducer.sh
> >
> > Thanks Naresh. I'm having trouble to make sense of this, though. The
> > linked output log appears to be from a build that lacks my 'ARM:
> > entry: fix unwinder problems caused by IRQ stacks' patch, as it
> > doesn't show any occurrences of call_with_stack() on any of the call
> > stacks.
> >
> > Do you have a link to the vmlinux and zImage files for this build?
>
> Yes.
>
> vmlinux.xz:  https://builds.tuxbuild.com/26BmIasJnAyCii0SkgbKarkF369/vmlinux.xz
> zImage: https://builds.tuxbuild.com/26BmIasJnAyCii0SkgbKarkF369/zImage
> System.map: https://builds.tuxbuild.com/26BmIasJnAyCii0SkgbKarkF369/System.map
> Build log: https://builds.tuxbuild.com/26BmIasJnAyCii0SkgbKarkF369/
>

This kernel does not appear to have

ARM: unwind: set frame.pc correctly for current-thread unwinding
ARM: entry: fix unwinder problems caused by IRQ stacks
ARM: Revert "unwind: dump exception stack from calling frame"

so it is expected that the same issue is still being observed.

Could you please try -next with those patches applied?
