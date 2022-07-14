Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1E457504E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbiGNOGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiGNOGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:06:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B927388
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:06:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id m16so2532753edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dsg8YYc09ufj/733yPHJPZ/Qpv37mtovDB2OzYPiOCE=;
        b=iyA5BWSyZmGW4efDa6L9cV0aNwgKlR+5yS7SzaiI9KYAEnIuWEyZXLb7TSJvCHKTTu
         EzyMVH+I+dhprih3HMM+Hh2bJ+uh9pi1OuSVBXLvVHU1Qn+0MqxUiXL2Z+otHuexdKzr
         k4CscznuGXiGQWNNKzf3DZ/VSTXcuboA2aCNYRoVnN4zLbOO+5kwVqFB4bIXk7mobSfk
         l4UTmYdXVO4r0KKxVQyqUgMaRkk7rnFqk6lB7vQOBLWdnU2hEevkbfockM/5TtEBGvg0
         OcjS+oX7HD1V1v5vYkVDoer7flIyGJR3QpzXsn3DlY1/gjscA4nkX2YtM+uYz2Z9YOPh
         HHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dsg8YYc09ufj/733yPHJPZ/Qpv37mtovDB2OzYPiOCE=;
        b=gwXXdjwgPiReqV2f1Sh43Imiuq6ol7BW35AaoTx1qaoEbwZwA1n+25UxC/PH9Of/WJ
         dzr1VXft/etr+VsiArDwSGRdmS7UgV5MM1M31nU9rrvejkhkD1rbXwonMUwGO2Wfyvkh
         jGPnJPssCjfYYMKgE4Va8KhiKnD+ljrNfDx+giDZb0KizYyMvOiP6UVP9xAuySAaaldS
         vGOT7jEUrIyWCdJbMC2eOD4CosfxElrDYWSTEcm4j9NfGNfYxtMLD/Eho4tHxUH8h8eY
         u1OVzUX1qXi49ahEMJazxCa5KmhbqNuCvCNJEuxAh4gig/p4dChOBGUmPLgya2jERAS2
         z3sw==
X-Gm-Message-State: AJIora/cliJAtTx3au47CWnGlApk/Kf/QFc2rhTa2apsMcNpCv+hBtoX
        PK0eBVTczfZCQIixzwoXBK5ipJotl5Wmq0YLunEIrQ==
X-Google-Smtp-Source: AGRyM1vX01PFbMINeoOPTOuuGCFZGYjM8LyoidrJ7hG1Tp+ZGVJW1QxJ9117n1TmMCi2JTzT4+sr76nJbMp6U7tiyLM=
X-Received: by 2002:a05:6402:1d53:b0:43a:9ba7:315b with SMTP id
 dz19-20020a0564021d5300b0043a9ba7315bmr12606977edb.350.1657807561607; Thu, 14
 Jul 2022 07:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtOX-6=f70FA5PuDVA=kX=2L4spXKXS8=LHkUphafXowg@mail.gmail.com>
 <Ys1g8PH4M2W7Z50U@sirena.org.uk> <CA+G9fYu7mJ6X3_xhboODP_cjABE4QTJCON_NMduQ60x4Z7N78Q@mail.gmail.com>
 <Ys/9TSV5muvKXN6W@FVFF77S0Q05N> <YtABEDylGJkYLXrJ@sirena.org.uk>
 <YtASzuHo1MXe5LJH@FVFF77S0Q05N.cambridge.arm.com> <YtAU1AHLLgK/v7RP@FVFF77S0Q05N.cambridge.arm.com>
 <YtAcW9DRrdun/pW9@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <YtAcW9DRrdun/pW9@FVFF77S0Q05N.cambridge.arm.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 14 Jul 2022 19:35:50 +0530
Message-ID: <CA+G9fYvmrraS7ANdRA0XDoM-u-oVvcHFWsrFuBya9Es_WN3fkw@mail.gmail.com>
Subject: Re: FVP: kernel BUG at arch/arm64/kernel/traps.c:497 - Internal
 error: Oops - BUG: 0
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Aishwarya TCV <Aishwarya.TCV@arm.com>
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

Hi Mark,

On Thu, 14 Jul 2022 at 19:09, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Jul 14, 2022 at 02:06:28PM +0100, Mark Rutland wrote:
>
> > ... and I've just reproduced the issue by running the script from a different
> > directory, since apprarently the semihosting interface just grabs the file from
> > the current directory.
> >
> > I'm pretty sure this means that *something* is clobbering the Image early on
> > during boot, and the semihisting loading happens to refresh it.
>
> I had a go with my own kernel built from my arm64/traps/rework branch:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/traps/rework
>
> ... and Naresh's config:
>
>   https://builds.tuxbuild.com/2BnQMpJj3kDTJXoCwd2pY5gW9CN/config
>
> When *only* using the initial loading into memory, that blows up in stackdepot
> and with a subsequent bogus pointer dereference (full log below), and when
> loaded via semihosting that just works. Note that my kernel is based on the
> arm64 for-next/core branch, which itself is based on v5.19-rc3.
>
> My failing kernel Image is ~47M, as is Naresh's original Image. When using
> smaller Images (as large as 43M so far), I don't see any issues.
>
> I also note that if I enable KASAN_OUTLINE, the kernel is so big that it
> clobbers the DTB, and cannot be booted. So this looks liek a problem with tha
> arbitrary placement / limits chosen for U-Boot being too small, and this is not
> a kernel bug.

Now I have understood the reason.

> Naresh, please can you fix your boot flow before reporting any further issues?

Yes.

> This sort of corruption will manifest in a number of ways, and we need to rule
> that out for any other bug reports.

Any further reports I will do needful initial investigation.

- Naresh
