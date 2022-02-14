Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AF14B4F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352183AbiBNLrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:47:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352297AbiBNLjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:39:46 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A73FBF73
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:31:34 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id y6so45097731ybc.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mw/bxELONBcXUIQ4ZlitUOdIGwAvzRaHxRx0vzLKiwE=;
        b=asNcvjaxh2z9Q0eDPTF/MHVOJlSKunX9xOaEWoZyQdNjgTY0NuVZ7sE1xn32KshaoP
         e/VvGS71+1On+TQj1UU0xvIoAqRdhmdgLfNBYMRwZTVovhWcfFyJPGjLnWLZAlHhC0Wy
         PPrEhRWRTXHvve+RRSRuXHKR92j4hlVsihXwmIHFeRKTQxMLSmpc49sXb5WlxcUO0mxm
         dwgo5q6XGMLIXRJph9rbNQxSyVCNHL2om88A9AvSTkX3u5Yn3yPCdb8TO7B/p71vXdKK
         RqGGN2zYHPQ2Xc9/2rern1s7FdCZ0pHDH1Ll1gltaUMpYofmXLs1Rd5Q7JjcNG3rqlw7
         74PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mw/bxELONBcXUIQ4ZlitUOdIGwAvzRaHxRx0vzLKiwE=;
        b=c6OGkTP0ZjHwPMLCzClqh3a2JsORUeQwdl3Ndy/4kkpDtJCI8s94wIhf+8Yx7vQWV7
         rUUByXDBT86M+Su1gkh7WnHP4HNkkGivYwDe1kj03jujhEOgreGNeuMaIxiiarvgJkHU
         +pTYN880nD4VKo/GZcJge57GNo3/EzAezuZBYHodf6imUr2DGD4BJ3aHlvkHNg+AiPZH
         QecIVVWRa5HtUhgzLemv33ak8Btuj4QqVGoubzBm4E9t9INnvQFu5kWANrq3yjDawLEa
         Jae4Y0VVCH0Q18K3JWOpBE6VfAM1JvAxPEZrgJoNBxOELiSGmSHZ7ES5h5Zw5UMYyTL2
         23vQ==
X-Gm-Message-State: AOAM5314PCXwwX3MRp8FT5+XiwSJKqccmIa8dvkjqmTMTQeckD/neLiM
        HkLSql9csZVavHASMK+7dWzHUJU13V7XJCtDAr/fWA==
X-Google-Smtp-Source: ABdhPJxa6vrERknymq3wbgVH3aL7pi7aXuDhckCAoXVb99Mp/XV1TLitwoRL3UpFD22a/lTepFhatbY499rliNbMyjI=
X-Received: by 2002:a25:49c5:: with SMTP id w188mr11519207yba.200.1644838293317;
 Mon, 14 Feb 2022 03:31:33 -0800 (PST)
MIME-Version: 1.0
References: <20220214092510.221474733@linuxfoundation.org> <CA+G9fYvfx2jRPnU6zVK8v9vNbwXc4wV0KX0JfGWeNsAbL72y-g@mail.gmail.com>
 <Ygo8pUuBuNYmP9ds@kroah.com>
In-Reply-To: <Ygo8pUuBuNYmP9ds@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 14 Feb 2022 17:01:21 +0530
Message-ID: <CA+G9fYtkx8kqRR4L9oP-cO5PhU20i2CLfREJkQB+6UGK8ojvEw@mail.gmail.com>
Subject: Re: [PATCH 5.16 000/203] 5.16.10-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com, Arnd Bergmann <arnd@arndb.de>
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

On Mon, 14 Feb 2022 at 16:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Feb 14, 2022 at 04:29:43PM +0530, Naresh Kamboju wrote:
> > On Mon, 14 Feb 2022 at 15:23, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 5.16.10 release.
> > > There are 203 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Wed, 16 Feb 2022 09:24:36 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.16.10-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.16.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > On Linux mainline master branch with arm64 clang-nigtly build failed
> > due to following errors and warnings.
> > Now it is also noticed on stable-rc 5.15 and 5.16.
>
> Sounds like a compiler error.  Do the clang developers know about this?

I have reported a new issue on LLVM github.
https://github.com/llvm/llvm-project/issues/53811

- Naresh
