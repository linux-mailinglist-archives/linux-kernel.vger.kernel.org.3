Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1188E5362A6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350250AbiE0MiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348285AbiE0MiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:38:00 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FAA1A7D04;
        Fri, 27 May 2022 05:20:24 -0700 (PDT)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 24RCK0Mp012972;
        Fri, 27 May 2022 21:20:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 24RCK0Mp012972
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653654001;
        bh=0D8p3lAezW7RCHWFuSl3YlxjjAyflRfSwWRcaMWkB1c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YdyRY+2dyUfImPC1CKqYW2U3nkc4Vi67h6buZPOiM0cTWD/FNHUMUNH3QQpmf6cdW
         hFhPQiMGftXLxEi38W7uuOVx5T5L4X0jM6fhLbsLgtRikL3CHX7Lsf+EeaCHesMDM/
         FQ65vUHST7tuq/Wufs59hF2Hfto47jKBQY5/JFpxF2odBLwCPMeNnf2k+BF5LW1xvH
         e7UJq9lrrjqyI1eaX6h6S2c5+Mjk7Tq24M+aDm4Q1aHB6+HcaemGmUpaRT4onqqyhQ
         0jhVhfqmX/JMoG1p1GVoFGr8q0FQiKsIRJ3Ff7033+FfudRFpiuoyeQdBUdqrMuov+
         cmwUUKevRJauw==
X-Nifty-SrcIP: [209.85.216.45]
Received: by mail-pj1-f45.google.com with SMTP id n10so4443489pjh.5;
        Fri, 27 May 2022 05:20:00 -0700 (PDT)
X-Gm-Message-State: AOAM532rzoapZpCnj7o74HuW6axuEFAgQrY1IT2LoEn4UwLEJwgRS0Dv
        3qaEnIMW9H6IDh7HXvbPEIL8RMM7Q/1Nsq/lsMU=
X-Google-Smtp-Source: ABdhPJyNuurAZSU4RrV/gNR0QM3ve15YafhODDVnWIldoX3OuLp3Sxx6/a4nkhk1XJRUudsZ6XCW0PfgoO64SnZS+cU=
X-Received: by 2002:a17:903:1205:b0:15e:8cbc:fd2b with SMTP id
 l5-20020a170903120500b0015e8cbcfd2bmr43023919plh.99.1653653999799; Fri, 27
 May 2022 05:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220523142431.10ff2f77@canb.auug.org.au> <20220523154758.11668628@canb.auug.org.au>
 <20220523162307.45dycvqld7maaj7l@treble> <CAK7LNAR5XWPhmTJV42sYiFCDan6DfB8gsOCJOWiqz4MV1cdE4Q@mail.gmail.com>
 <20220527044711.hrqxx5gz3jghydax@treble> <CAK7LNATeHZK+qv9e375fsZwtiuUE_MrfBA9Rhzz3uY8tF4EXUg@mail.gmail.com>
In-Reply-To: <CAK7LNATeHZK+qv9e375fsZwtiuUE_MrfBA9Rhzz3uY8tF4EXUg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 27 May 2022 21:18:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNARc_Ku2=TkuFNspzW434f2kjYEjs_GDzOCdBF-3feVstg@mail.gmail.com>
Message-ID: <CAK7LNARc_Ku2=TkuFNspzW434f2kjYEjs_GDzOCdBF-3feVstg@mail.gmail.com>
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

On Fri, May 27, 2022 at 3:04 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Fri, May 27, 2022 at 1:47 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > On Fri, May 27, 2022 at 11:19:02AM +0900, Masahiro Yamada wrote:
> > > [1] original behavior in Josh's commit
> > >
> > > $ git checkout 753da4179d08b625d8df72e97724e22749969fd3
> > > $ make defconfig
> > > $ make -j8 kernel/
> > > $ head -n 1   kernel/.fork.o.cmd
> > >
> > >
> > > I do not see the "--linked" parameter in the objtool command.
> > >
> > >
> > >
> > >
> > > [2] behavior in linux-next
> > >
> > >
> > > $ git checkout next-20220523
> > > $ make defconfig
> > > $ make -j8 kernel/
> > > $ head -n 1   kernel/.fork.o.cmd
> > >
> > > I see the "--linked" parameter in the objtool command.
> > >
> > > kernel/fork.o  is a direct output from GCC,
> > > not from linker.
> >
> > Yes, good catch.  That flag should only be used for linked objects like
> > vmlinux.o or some_module.o.
> >
> > Objtool only runs on such objects when CONFIG_LTO_CLANG,
> > CONFIG_X86_KERNEL_IBT, or CONFIG_NOINSTR_VALIDATION (vmlinux.o-only) is
> > enabled.
> >
> > --
> > Josh
>
>
> When CONFIG_LTO_CLANG=y or CONFIG_X86_KERNEL_IBT=y
> is "--linked" necessary for single-object modules?
>
>
> "single-object module" means a module that consists of only one object.
>
> See this figure:
> https://patchwork.kernel.org/project/linux-kbuild/patch/20220513113930.10488-6-masahiroy@kernel.org/
>
>
>
>
> In your commit, --linked is passed to all *.prelink.o
> whether it consists of a single object or links
> multiple objects.




Anyway, please let me clean up this part in the kbuild tree:

https://patchwork.kernel.org/project/linux-kbuild/patch/20220527100155.1996314-2-masahiroy@kernel.org/





-- 
Best Regards
Masahiro Yamada
