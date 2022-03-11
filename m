Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941484D5713
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 02:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344964AbiCKBCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 20:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237426AbiCKBCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 20:02:34 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEF81A39E3;
        Thu, 10 Mar 2022 17:01:31 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id x4so8523626iop.7;
        Thu, 10 Mar 2022 17:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=pRxA0EhnfxgZREQ1JvLzAPp++HtgLS4XlH6e6oYQepQ=;
        b=Vjyrm+kxdESZsbe9Az2HSAn1ZpwOhiXOQhxWSpGgTSM6JMYxnEEe0SCktudWT3F5XE
         swt0tuE0Hy+xbGfbZn3E7alYtyxeQI7b30khdNhKZd2moPZ5H/yCp2PUiHKFGDqi4fXv
         iJu7wQTUj1bxP/oV5fScpxSWxptw7coza83wBrqnoqidrZBXDwx7bg11LchfTWjGofEa
         pRYj07cJAvx0KLkoncwItp+hX7own7GZp0HIbCa8T5P0L+ffzQy/SOxiuejlFmIXDEbF
         O7+ZLSSAOm6Tuam5uE5mYwADZzyArnJziKAYIE6kVjMAVypCWgLfj5J81e06T/m8VD18
         VjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=pRxA0EhnfxgZREQ1JvLzAPp++HtgLS4XlH6e6oYQepQ=;
        b=BPjaB7L2bpwfMpvvNQKFM12KH4NtoLPQa016Vw0O069OBNZlIjHsWNJi3ZzbxMRkz+
         djYUjq1A/O8Hom1cSiN6TCZZu8HoAOXTOtFGoaaQBi+H5xXaRd8EbH3PAI1qFyrvn0Ha
         vK/crG0I5t4XrGLj1sZ+3Fp3U4ANHDloRWH6aw7BRZJbw44kubwTVXOrHPNmI9g+2Rcm
         TssbnbYHeF+K8WaeV/h0hSuvW6hD2BYqcbtucQVbOaTASO/UFOIf9Fe5hxAQSM/cA94T
         2Z8fmpf4+Kthn+W8S/PL+zFOmJoWOMx0e55XX1LzrJVZZY46YHA7/g8f8cYPQcENDK2d
         qQsw==
X-Gm-Message-State: AOAM531ry1TKf2H+l4HS8xhQc7J1u7AyKwCntF+NZE8t2VFEWG4oVFhe
        rTIHdsxgWkhJWWTwvEdlUFY4gNgQryorhRaEx+c=
X-Google-Smtp-Source: ABdhPJzg+9ZIr0/5erj9eCsxaC8HgT2nZx0GKAKjWV4ekUcW2ZeWfYetjEmfk7Yd433gAaCBj883R1wfARex/2tSmKU=
X-Received: by 2002:a6b:8f15:0:b0:645:dfdb:7a35 with SMTP id
 r21-20020a6b8f15000000b00645dfdb7a35mr5902984iod.36.1646960490953; Thu, 10
 Mar 2022 17:01:30 -0800 (PST)
MIME-Version: 1.0
References: <20220308215615.14183-1-arnd@kernel.org> <CAHk-=wjsCrVxToP0Zx+cUAVZmSKi=Y6NP1+VnBcoPyPPEBfonQ@mail.gmail.com>
 <CAK7LNAQoFFVLfkhA7FC9vDbvc4wdLginYeRHL0xHVAumu6p=uw@mail.gmail.com>
 <CAK7LNASuy5hSOU7Y7Tr8_6Ks1ZqEeUKv_-c6fDjMubq0_ENRaw@mail.gmail.com> <YilBFcKIN1Ao5Ld1@dev-arch.thelio-3990X>
In-Reply-To: <YilBFcKIN1Ao5Ld1@dev-arch.thelio-3990X>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 11 Mar 2022 02:00:55 +0100
Message-ID: <CA+icZUX0SXwBF+CzaOAPKzOujSRVOKRZwS7nppPjraLvOSeMDw@mail.gmail.com>
Subject: Re: [PATCH 0/4] [v4] Kbuild: std=gnu11 changes
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@kernel.org>, Alex Shi <alexs@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Marco Elver <elver@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 5:01 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Wed, Mar 09, 2022 at 06:18:18PM +0900, Masahiro Yamada wrote:
> > On Wed, Mar 9, 2022 at 11:16 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > On Wed, Mar 9, 2022 at 9:09 AM Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > >
> > > > On Tue, Mar 8, 2022 at 1:56 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > > >
> > > > > From: Arnd Bergmann <arnd@arndb.de>
> > > > >
> > > > > I've incorporated the feedback from Masahiro Yamada in this
> > > > > version, splitting out one more patch, rebasing on top of
> > > > > the kbuild tree, and changing the order of the patches.
> > > > >
> > > > > Please apply to the kbuild tree.
> > > >
> > > > I'd actually like to see this as a separate branch, so that I can
> > > > merge it early - or other peoples git branches end up depending on it.
> > >
> > >
> > > OK, I can apply this to a separate branch, kbuild-gnu11.
> > > (and I will queue this up shortly because it is already -rc7)
> > >
> > > Then, I will send two pull reqs in the next MW,
> > > but please note they will conflict with each other,
> > > between this gnu11 patch set and the following
> > > one in my usual kbuild branch:
> > >
> > > https://patchwork.kernel.org/project/linux-kbuild/patch/20220201213542.2808035-1-quic_eberman@quicinc.com/
> > >
> > >
> > > I hope this is not a complex conflict, but please let me know
> > > if you have any requests to me.
> > >
> > >
> > >
> > >
> > >
> >
> >
> > All, applied to linux-kbuild/kbuild-gnu11.
> >
> > If somebody wants to give Reviewed-by, Acked-by, Tested-by, please.
> >
> > I will append them later.
>
> For the series:
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>

For the series:

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM/Clang v13.0.0 (x86-64)

- Sedat -
