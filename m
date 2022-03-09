Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5D34D30CF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbiCIOIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiCIOIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:08:20 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D5117DB81
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 06:07:18 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id u3so4584970ybh.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 06:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5HT2h80lnibZhJBvnGZywx4ZmrOaqIdDqke0BNvZjD8=;
        b=i0P5AaBhFm+ZgOCecsRLrSBiPusUntyyw8Jgsp7c72mfyQdaEBinejSZfSe5Aiy/d0
         EIiUGIagjA7TVUEy+THydeXthBR1/RuBf1lsuCXGhGslyrbiDMkBfYrtl8Bve0QA9sRC
         HnMaPRvX4o1LUyirLTPfZHj37v11xL6pYf5MWpabx97ZO+3kIUO3dfLJT1MbW6WWDWPs
         TOFdx/SszAQO65ZeAa/jaOQ9eFfXfASzfMA9LDKQjb2+pUZL9Gcx+TPnLulR0EfhLRdr
         idCyfJmmTmcRXQ732Lsi3VaUQ0ManV3PmC4lghMtH9Lp+f4ItadekqPxZvid91DeGgvt
         rBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5HT2h80lnibZhJBvnGZywx4ZmrOaqIdDqke0BNvZjD8=;
        b=zYTBPIpZ2tP9aDutxx8T6WibX02azktaak/rxlX+IKnLAeaox7kb+FG7kOAZB0P7W4
         uTLm12WJ7obiC3cnxbf1aOkIeIr9d/gt1UpM7M3sNxCw5wuTc+2JjN5aCMgQWqnxVVCj
         gbzk++E4yK9SGc4NjMN+lJNakVkKOjBSkQU1sgzWU3K6SKaFa70L9r1E09dQ3hBeIFWw
         9oLob6MIwz+/XWoycTX9GT3L7MnMop3hoeunB6bjHYKA7hHJ2ahSXRJXcGaG09P+3bPX
         GhRcW81FeNg8qsDilTAQbAOxYwBRAZc0NACoMcNROG86ZylBPA751wZ1W7kKHEv0Wrf6
         SeWQ==
X-Gm-Message-State: AOAM530iW2oQegflIdsWB7d/vQJj+KYsKpo+yPGlTEuAftmkDS+frd5L
        IcTJVX4IXo8RsG2EVJmuyg815SMAF+xDIZ4VNC3nrQ==
X-Google-Smtp-Source: ABdhPJxUAt2jKYmOxzjRz1AanW9ecIVOygJFBDur3mBMmvMhF4ZpUyB+1V8daMxrIshDfw0fRbKA9Qljv+MCcWgZj3s=
X-Received: by 2002:a25:4109:0:b0:628:7778:fb18 with SMTP id
 o9-20020a254109000000b006287778fb18mr16149936yba.412.1646834837778; Wed, 09
 Mar 2022 06:07:17 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYtpy8VgK+ag6OsA9TDrwi5YGU4hu7GM8xwpO7v6LrCD4Q@mail.gmail.com>
 <YiiDZ7jjG38gqP+Q@shell.armlinux.org.uk> <CAMj1kXHTdk1Abm7ShoZzrW6EpM9eyFMPSdaa58Ziie4ZMecCnQ@mail.gmail.com>
In-Reply-To: <CAMj1kXHTdk1Abm7ShoZzrW6EpM9eyFMPSdaa58Ziie4ZMecCnQ@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 9 Mar 2022 19:37:06 +0530
Message-ID: <CA+G9fYvCvBBi+dZ+CnUy=ZK6GhCFhBw72_==Cav=Q8QP5T1r5w@mail.gmail.com>
Subject: Re: [next] arm: Internal error: Oops: 5 PC is at __read_once_word_nocheck
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
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

On Wed, 9 Mar 2022 at 16:16, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 9 Mar 2022 at 11:37, Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Wed, Mar 09, 2022 at 03:18:12PM +0530, Naresh Kamboju wrote:
> > > While boting linux next-20220308 on BeagleBoard-X15 and qemu arm the following
> > > kernel crash reported which is CONFIG_KASAN enabled build [1] & [2].
> >
> > The unwinder is currently broken in linux-next. Please try reverting
> > 532319b9c418 ("ARM: unwind: disregard unwind info before stack frame is
> > set up")
> >
>
> Yeah.
>
> This is the same spot Corentin hit before, where the double
> dereference of vsp is not guarded by anything like
> get_kernel_nofault(). We should probably fix that, but that doesn't
> address the underlying issue, of course.
>
> I'm a bit puzzled, though, that this appears now, and didn't before.
>
> Naresh, I take it you did not see this occurring on earlier linux-nexts?

Yes.
Earlier  linux-next arm boot failed due to [1],
         unwind: Index not found

> I'll try to reproduce this, and see if I can make sense of it. In the
> mean time, please do the revert Russell suggested, and if that doesn't
> help, maybe try a bisect?

I will try your suggestions and get back to you.

- Naresh

[1] https://lore.kernel.org/linux-arm-kernel/20220301220536.1302898-1-ardb@kernel.org/T/
