Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662C55752A8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiGNQWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiGNQWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:22:10 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD35155081;
        Thu, 14 Jul 2022 09:22:09 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-31bf3656517so22094977b3.12;
        Thu, 14 Jul 2022 09:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8PLNmXxl330LfuHB/ULIc5yFPBlPwtCsvTmuIMEY5vA=;
        b=dLqbRYRTbz//P2gYc1pZHfFAE7Y+lqUE0qZa2LhvvNfxOI6moys75wiIYrlgt34jIg
         cntt5bSx9j0nKHZ2RKJnCjnE8DBBgsSjBYdyqETxY81Yrt3OK4/BVQ5+MmMoS+xYDQVS
         oIwcJq86/w0x9rBpN5CNmhA6CMq+95P7vll/mv9TDxVXoIUXIKsyld90NB96/HK97u72
         R1v0WXS5EyjTjl179NvWS5glLHPVFwBoF83gU6z6LMIqjDZO+ko9AiJhmVf7WFN1PlQ6
         zdXOPj6eMeBg4LcViEA8r7xHYWMT2IQ1J8UkiquYxzY/p7nSKt/RXLuzKce1VR+Swq/P
         vROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8PLNmXxl330LfuHB/ULIc5yFPBlPwtCsvTmuIMEY5vA=;
        b=BN4Ex0Xg7XrehsuYNJ/F/Qz8LU0h2Goqn2IOZjnLq2+ZL14UtE6DpLCyZQBFMJtYoc
         n3H8wnlPDq3jj2Mxv42KWERF1xE0TaT0exmTG33F+duA3K8VyIIDi39OAOyeRGG2EQWE
         6XP2H/l1HccG91AFGMP4VMC/x4FC/iRazeScrs7d3nN5n6MStciH2a5CluVOQXxFpi/u
         LwxcFeLkbGCiPoEG4ejGW6sV/vTwniIgfLHUjMEw8Mfe/HbWdtaxmkRxrA4VD8eNmOE0
         QUG5rMjbDqN8LOrdcK8R15/L2gRoLQNvcxJfltiEaLq31902rKu/G5RQgeB22pyTBuqO
         gHnw==
X-Gm-Message-State: AJIora8UxOtq8jMubfN5Gd3zYAmi6aBFI9QfjHMuXEpg0QALOrQpbhAr
        h/H6oZYpjuGHFlgJ2Zgx7eOZt279Imivlq8hj7tGdNg6ajlqwA==
X-Google-Smtp-Source: AGRyM1skykoApRV1gfbIMqLhePAJT0SCwPyajDzu0o3LZfwwpxU3/9f1BZYxWQ2vLHGLZ+tB/Ju3VZhvG8yo7SJUNTY=
X-Received: by 2002:a81:6783:0:b0:31c:8668:ed85 with SMTP id
 b125-20020a816783000000b0031c8668ed85mr10691429ywc.194.1657815729064; Thu, 14
 Jul 2022 09:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220714185514.7d1a2ac9@canb.auug.org.au> <Ys/42uMzQy+CFTGI@debian>
 <YtA+127QgRifnRBZ@dev-arch.thelio-3990X>
In-Reply-To: <YtA+127QgRifnRBZ@dev-arch.thelio-3990X>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 14 Jul 2022 17:21:32 +0100
Message-ID: <CADVatmOTNA8uVqDEx6kp=+_O=wEhV2jbS9-frct-c4ZqBxcspg@mail.gmail.com>
Subject: Re: linux-next: Tree for Jul 14
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
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

Hi Nathan,

On Thu, Jul 14, 2022 at 5:05 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Sudip,
>
> On Thu, Jul 14, 2022 at 12:07:06PM +0100, Sudip Mukherjee (Codethink) wrote:
> > Hi Stephen,
> >
> > On Thu, Jul 14, 2022 at 06:55:14PM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > Changes since 20220713:
> >
> > Build failures on next-20220714:
>
> <snip>
>
> > x86_64 allmodconfig with clang fails with:
> >
> > drivers/clk/qcom/gpucc-sm8350.c:111:2: error: initializer element is not a compile-time constant
> >         gpu_cc_parent,
> >         ^~~~~~~~~~~~~
> > drivers/clk/qcom/gpucc-sm8350.c:126:2: error: initializer element is not a compile-time constant
> >         gpu_cc_parent,
> >         ^~~~~~~~~~~~~
>
> I sent https://lore.kernel.org/20220711174004.3047516-1-nathan@kernel.org/
> for this a few days ago, it just needs to be picked up.
>
> > arch/x86/kernel/cpu/bugs.c:58:21: error: section attribute is specified on redeclared variable [-Werror,-Wsection]
> > DEFINE_PER_CPU(u64, x86_spec_ctrl_current);
> >                     ^
> > ./arch/x86/include/asm/nospec-branch.h:283:12: note: previous declaration is here
> > extern u64 x86_spec_ctrl_current;
>
> This is now fixed in -tip so it should be fixed in -next tomorrorow:
>
> https://git.kernel.org/tip/db866d3352ec85e821e730e191481cba3a2bfa6e

This should also go to Linus. This failure is in the mainline also.
https://lore.kernel.org/lkml/Ys6sZj6KYthnDppq@debian/

>
> In the future, consider CC'ing our mailing list (llvm@lists.linux.dev)
> for any clang related issues so that we can get them taken care of ASAP,
> we have a MAINTAINERS entry for a reason :) thank you for testing with
> clang; the more people that use it, hopefully the easier it will be to
> get things unbroken.

Sure. I run arm, arm64, powerpc and x86_64 allmodconfigs with clang
(along with gcc) every night for mainline, started with linux-next
from today. Trying to setup the mips build also, I will mail llvm list
asking for help with the mips build.
Currently I only monitor the clang output from x86_64 as thats the one
which builds. If you want I can send the other reports also.


-- 
Regards
Sudip
