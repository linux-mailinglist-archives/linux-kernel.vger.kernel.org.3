Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3C9550DFF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbiFTAlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiFTAlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:41:18 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A827064E0;
        Sun, 19 Jun 2022 17:41:17 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 25K0eqMu014065;
        Mon, 20 Jun 2022 09:40:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 25K0eqMu014065
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1655685653;
        bh=KO2bT9e9o1IlLF54RMsY4B67RQeQIcc8YsGFuQTNKLY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gCEMMxAqgN5MkR3ByO6vuxpk0MZ5UA1pn2VZ4l5Iz/W90yG1BTegn5Bg/VSYOgpEq
         FngUKyK5CjlZBSHDgmb3HarTPBPhucgdGVE07JG/FDcVaULahPASP2aw5OV7GOB9/I
         5PoL7VpRozqBtrFukWbVh0/FdOiCwnZ31AKfJvBu7v9/QPPltOjR5fPnLLIF12FnY1
         H2OKr19oEhpvapzIvIfEaU79N6jHZTJcA61RDZynSPOrRe0Imj8D0cXMu+3XGwPi1W
         +vcKr2Y6J3++n+EpRKXiVJTKtuV3QMGlqNM8dpfTHf5xD7kjJsVSsl6vReqJcM5idC
         lOFl290quIv+w==
X-Nifty-SrcIP: [209.85.221.49]
Received: by mail-wr1-f49.google.com with SMTP id i10so8745256wrc.0;
        Sun, 19 Jun 2022 17:40:52 -0700 (PDT)
X-Gm-Message-State: AJIora9xgrUudXH60WywrcCj7ejttWCzU8vnQxb1NuITe67UNMaGXMca
        AuzUjSDD+SmHPdGmFcWHclRuKSCy2MwdV9d3T8o=
X-Google-Smtp-Source: AGRyM1uugHpW+HpdtWiopVlodunIpeGyQF/T1HRP+yqxZMsIwBu975CxA4O4ugSBs0fyZGtwh8RmiCWj7jfTUPOc6As=
X-Received: by 2002:a5d:5e92:0:b0:21a:278c:b901 with SMTP id
 ck18-20020a5d5e92000000b0021a278cb901mr20414562wrb.461.1655685651233; Sun, 19
 Jun 2022 17:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220617165817.3204917-1-ndesaulniers@google.com> <Yqy0EkraT0O52Na7@dev-arch.thelio-3990X>
In-Reply-To: <Yqy0EkraT0O52Na7@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 20 Jun 2022 09:40:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQfDC-qGoqwaAsEpoevu8oawPjQMoyJ7pEthbdBn30f4Q@mail.gmail.com>
Message-ID: <CAK7LNAQfDC-qGoqwaAsEpoevu8oawPjQMoyJ7pEthbdBn30f4Q@mail.gmail.com>
Subject: Re: [PATCH] Documentation/llvm: Update Supported Arch table
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Michael Opdenacker <michael.opdenacker@bootlin.com>,
        Tom Rix <trix@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        clang-built-linux <llvm@lists.linux.dev>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2022 at 2:04 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Fri, Jun 17, 2022 at 09:58:17AM -0700, Nick Desaulniers wrote:
> > While watching Michael's new talk on Clang-built-Linux, I noticed the
> > arch table in our docs that he refers to is outdated.
> >
> > Add hexagon and User Mode.  Bump MIPS and RISCV to LLVM=1.  PowerPC is
> > almost LLVM=1 capable; ppc64le works, but ppc64 (big endian) and ppc32
> > still need more work.
> >
> > Link: https://youtu.be/W4zdEDpvR5c?t=399
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Thanks for updating this!
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>


Applied to linux-kbuild/fixes.
Thanks.


>
> > ---
> >  Documentation/kbuild/llvm.rst | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
> > index b854bb413164..6b2bac8e9ce0 100644
> > --- a/Documentation/kbuild/llvm.rst
> > +++ b/Documentation/kbuild/llvm.rst
> > @@ -129,18 +129,24 @@ yet. Bug reports are always welcome at the issue tracker below!
> >     * - arm64
> >       - Supported
> >       - ``LLVM=1``
> > +   * - hexagon
> > +     - Maintained
> > +     - ``LLVM=1``
> >     * - mips
> >       - Maintained
> > -     - ``CC=clang``
> > +     - ``LLVM=1``
> >     * - powerpc
> >       - Maintained
> >       - ``CC=clang``
> >     * - riscv
> >       - Maintained
> > -     - ``CC=clang``
> > +     - ``LLVM=1``
> >     * - s390
> >       - Maintained
> >       - ``CC=clang``
> > +   * - um (User Mode)
> > +     - Maintained
> > +     - ``LLVM=1``
> >     * - x86
> >       - Supported
> >       - ``LLVM=1``
> > --
> > 2.36.1.476.g0c4daa206d-goog
> >



-- 
Best Regards
Masahiro Yamada
