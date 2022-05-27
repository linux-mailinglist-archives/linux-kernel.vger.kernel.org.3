Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106E553590C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239951AbiE0GGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbiE0GGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:06:50 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96BD13D2A;
        Thu, 26 May 2022 23:06:48 -0700 (PDT)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 24R66Ki6015921;
        Fri, 27 May 2022 15:06:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 24R66Ki6015921
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653631580;
        bh=uOIDWJ8nKzaQ9BGe8N8M3AtTjWOiIAuF9sunOv+fNxY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q/hghU838DgUDVdTkg2Jck4N4OhCRplB5FYYBOPWKSYFF9sxNLbnBBgLvNrg5CtLo
         VX+78YcZyJNpBCd5r3QpBQsVDYLuQui6aryDrTagkb/Lw7CKBbWSb/NGQUx1afJw1W
         jwqypzo9drZ7n/1mY7FtHffNVqtGU0FkLrYmH4fl6wbG520+ooJK4PTCf+puGmuQ+l
         hwNuEqMlyvn1/jlzypyH597omXMz0me0FneCFJ4ge+WgnmvscndxBlFY9ne5ZDSiNg
         RwJAUNdPsXtzqGoTOgXxlgoTXg4GKoRJGtwDIv2vavGcWJmPE3BBO+JUPCXyP8CzaO
         Pw9XClt8tYOWg==
X-Nifty-SrcIP: [209.85.215.175]
Received: by mail-pg1-f175.google.com with SMTP id 137so3124178pgb.5;
        Thu, 26 May 2022 23:06:20 -0700 (PDT)
X-Gm-Message-State: AOAM532DJMlndZFkmrXPZ3RfOiHDoXQLSlp7y3uGlCaEZEaKXXzyw+63
        1TuvB2nTIIDV9X1CSQAT4pSH/vVa75brYbQX0pw=
X-Google-Smtp-Source: ABdhPJzzO5dyztT/2btdqC4Zkc22mLsfsDF2KfG2J/NwIT8XsiiObhGku8b0kdM9W+kSN8gAWSNG43N2Q47sjPYEGJQ=
X-Received: by 2002:a05:6a00:234b:b0:519:c7c:e58b with SMTP id
 j11-20020a056a00234b00b005190c7ce58bmr8125105pfj.32.1653631579782; Thu, 26
 May 2022 23:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220523142431.10ff2f77@canb.auug.org.au> <20220523154758.11668628@canb.auug.org.au>
 <20220523162307.45dycvqld7maaj7l@treble> <CAK7LNAR5XWPhmTJV42sYiFCDan6DfB8gsOCJOWiqz4MV1cdE4Q@mail.gmail.com>
 <20220527044711.hrqxx5gz3jghydax@treble>
In-Reply-To: <20220527044711.hrqxx5gz3jghydax@treble>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 27 May 2022 15:04:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNATeHZK+qv9e375fsZwtiuUE_MrfBA9Rhzz3uY8tF4EXUg@mail.gmail.com>
Message-ID: <CAK7LNATeHZK+qv9e375fsZwtiuUE_MrfBA9Rhzz3uY8tF4EXUg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the tip tree with the kbuild tree
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 1:47 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On Fri, May 27, 2022 at 11:19:02AM +0900, Masahiro Yamada wrote:
> > [1] original behavior in Josh's commit
> >
> > $ git checkout 753da4179d08b625d8df72e97724e22749969fd3
> > $ make defconfig
> > $ make -j8 kernel/
> > $ head -n 1   kernel/.fork.o.cmd
> >
> >
> > I do not see the "--linked" parameter in the objtool command.
> >
> >
> >
> >
> > [2] behavior in linux-next
> >
> >
> > $ git checkout next-20220523
> > $ make defconfig
> > $ make -j8 kernel/
> > $ head -n 1   kernel/.fork.o.cmd
> >
> > I see the "--linked" parameter in the objtool command.
> >
> > kernel/fork.o  is a direct output from GCC,
> > not from linker.
>
> Yes, good catch.  That flag should only be used for linked objects like
> vmlinux.o or some_module.o.
>
> Objtool only runs on such objects when CONFIG_LTO_CLANG,
> CONFIG_X86_KERNEL_IBT, or CONFIG_NOINSTR_VALIDATION (vmlinux.o-only) is
> enabled.
>
> --
> Josh


When CONFIG_LTO_CLANG=y or CONFIG_X86_KERNEL_IBT=y
is "--linked" necessary for single-object modules?


"single-object module" means a module that consists of only one object.

See this figure:
https://patchwork.kernel.org/project/linux-kbuild/patch/20220513113930.10488-6-masahiroy@kernel.org/




In your commit, --linked is passed to all *.prelink.o
whether it consists of a single object or links
multiple objects.





-- 
Best Regards
Masahiro Yamada
