Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D074F6269
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbiDFOx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbiDFOw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:52:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2813F29B7;
        Tue,  5 Apr 2022 18:33:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97A7CB8203A;
        Wed,  6 Apr 2022 01:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481BFC385AB;
        Wed,  6 Apr 2022 01:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649208778;
        bh=XpvRyWQibs5U7H0NRwftD7kh9ztYJOg4NmB70y/JR0c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BUidOn6eR29LJmE2NHApcc449KHBc1lxLFlFrYVlnFeV+tyqGdB42oP4tC5ZTeP/R
         UcWKho4QCrgsem7C166iXrO68B+2bTBBJqm6cV3VzkBRJvbOwPcKLcH4lSZV6J6XdT
         jrMKQu+rMK8lpeQUC3aYQD53q4P2IUEqhHd4JjZvi4QJopmyMZG1LRUbf+p2XiAIqs
         SKptDQG83bXtk2JUkH1EHs0WAr7+4VhIEKk3RlRWnOcZxfPb7GJHlTFjDLWhHManLG
         LIR8b4E4sm6+zq5FUl6xnGii1j+I4gMZZBrMsfuhq8FKYbbBpltRrfG782f3MvDELk
         QiJjQo0p8vosA==
Received: by mail-vk1-f171.google.com with SMTP id g25so458110vkl.6;
        Tue, 05 Apr 2022 18:32:58 -0700 (PDT)
X-Gm-Message-State: AOAM5324Pyodj3mu/eVpQAMdtx+i8LHFiktwVUSyhH+DDK1CVzj2cUK3
        By4HKeWZKws9AIm3QgjLDfQHHXJh0pXVfLh3vkA=
X-Google-Smtp-Source: ABdhPJzav7/zsbYcqRTWKyLRMmW/wUoG3z2ctFpfrzr8BqmpNb/HTabQkiDzQ/qWUmxCkD3Sp5ceqOVOwtSovwFqWmg=
X-Received: by 2002:a1f:f283:0:b0:33f:5e3e:921b with SMTP id
 q125-20020a1ff283000000b0033f5e3e921bmr2261970vkh.2.1649208777147; Tue, 05
 Apr 2022 18:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAJF2gTQkGZnwXrXsbx8drL0AicVpOMW=JmOcrieuvyEf91XPhg@mail.gmail.com>
 <mhng-cfa7bfb9-bab8-423c-85ad-ecd407d6e806@palmer-ri-x1c9> <CAJF2gTQgU=V+snWp7a8_txsX49BzAct1nkB18k-p4BZEd+s+eQ@mail.gmail.com>
In-Reply-To: <CAJF2gTQgU=V+snWp7a8_txsX49BzAct1nkB18k-p4BZEd+s+eQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 6 Apr 2022 09:32:46 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT+pHSkF-mHa9Gq6fm5jmDqaoC5z0yEgMiyEA3DWH+P7g@mail.gmail.com>
Message-ID: <CAJF2gTT+pHSkF-mHa9Gq6fm5jmDqaoC5z0yEgMiyEA3DWH+P7g@mail.gmail.com>
Subject: Re: [next] riscv: Linux next-20220404 riscv defconfig builds failed.
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Guo Ren <guoren@linux.alibaba.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 6, 2022 at 9:13 AM Guo Ren <guoren@kernel.org> wrote:
>
> On Wed, Apr 6, 2022 at 12:15 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
> >
> > On Mon, 04 Apr 2022 22:17:24 PDT (-0700), guoren@kernel.org wrote:
> > > On Tue, Apr 5, 2022 at 12:57 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > >>
> > >> On Mon, Apr 04, 2022 at 03:28:41PM +0530, Naresh Kamboju wrote:
> > >> > Linux next-20220404 riscv defconfig builds failed.
> > >> >
> > >> > Regressions found on riscv:
> > >> >    - riscv-riscv-clang-14-defconfig
> > >> >    - riscv-riscv-gcc-10-defconfig
> > >> >    - riscv-riscv-clang-13-defconfig
> > >> >    - riscv-riscv-clang-12-defconfig
> > >> >    - riscv-riscv-clang-11-defconfig
> > >> >    - riscv-riscv-gcc-11-defconfig
> > >> >    - riscv-riscv-gcc-8-defconfig
> > >> >    - riscv-riscv-gcc-9-defconfig
> > >> >    - riscv-riscv-clang-nightly-defconfig
> > >> >
> > >> >
> > >> > arch/riscv/kernel/compat_signal.c:7:10: fatal error:
> > >> > linux/tracehook.h: No such file or directory
> > >> >   7 | #include <linux/tracehook.h>
> > >> >     |          ^~~~~~~~~~~~~~~~~~~
> > >> > compilation terminated.
> > >> > make[3]: *** [scripts/Makefile.build:289:
> > >> > arch/riscv/kernel/compat_signal.o] Error 1
> > >>
> > >> For what it's worth, I also see:
> > >>
> > >> $ make -skj"$(nproc)" ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- defconfig all
> > >> arch/riscv/kernel/compat_vdso/compat_vdso.lds.S:3:10: fatal error: ../vdso/vdso.lds.S: No such file or directory
> > >>     3 | #include <../vdso/vdso.lds.S>
> > >>       |          ^~~~~~~~~~~~~~~~~~~~
> > >> compilation terminated.
> > >> make[2]: *** [scripts/Makefile.build:462: arch/riscv/kernel/compat_vdso/compat_vdso.lds] Error 1
> > >> arch/riscv/kernel/compat_vdso/rt_sigreturn.S:3:10: fatal error: ../vdso/rt_sigreturn.S: No such file or directory
> > >>     3 | #include <../vdso/rt_sigreturn.S>
> > >>       |          ^~~~~~~~~~~~~~~~~~~~~~~~
> > >> compilation terminated.
> > >> arch/riscv/kernel/compat_vdso/note.S:3:10: fatal error: ../vdso/note.S: No such file or directory
> > >>     3 | #include <../vdso/note.S>
> > >>       |          ^~~~~~~~~~~~~~~~
> > >> compilation terminated.
> > >> arch/riscv/kernel/compat_vdso/getcpu.S:3:10: fatal error: ../vdso/getcpu.S: No such file or directory
> > >>     3 | #include <../vdso/getcpu.S>
> > >>       |          ^~~~~~~~~~~~~~~~~~
> > >> compilation terminated.
> > >> make[2]: *** [arch/riscv/kernel/compat_vdso/Makefile:43: arch/riscv/kernel/compat_vdso/rt_sigreturn.o] Error 1
> > >> make[2]: *** [arch/riscv/kernel/compat_vdso/Makefile:43: arch/riscv/kernel/compat_vdso/note.o] Error 1
> > >> make[2]: *** [arch/riscv/kernel/compat_vdso/Makefile:43: arch/riscv/kernel/compat_vdso/getcpu.o] Error 1
> > >> arch/riscv/kernel/compat_vdso/flush_icache.S:3:10: fatal error: ../vdso/flush_icache.S: No such file or directory
> > >>     3 | #include <../vdso/flush_icache.S>
> > >>       |          ^~~~~~~~~~~~~~~~~~~~~~~~
> > >> compilation terminated.
> > >> make[2]: *** [arch/riscv/kernel/compat_vdso/Makefile:43: arch/riscv/kernel/compat_vdso/flush_icache.o] Error 1
> > >>
> > >> I am guessing this code was never tested with $(srctree) == $(objtree).
> > > Thx for pointing it out:
> > > I always use:
> > > make -skj"$(nproc)" ARCH=riscv
> > > CROSS_COMPILE=riscv64-unknown-linux-gnu- EXTRA_CFLAGS+=-g
> > > O=../build-riscv/ defconfig all
> > >
> > > When I change to:
> > > make -skj"$(nproc)" ARCH=riscv
> > > CROSS_COMPILE=riscv64-unknown-linux-gnu- EXTRA_CFLAGS+=-g defconfig
> > > all
> > >
> > > I got your problem.
> >
> > Just to be clear: this one wasn't supposed to go in via the csky tree,
> > and had other build issues that were being found by the autobuilders
> > (which is why it hadn't gone in via the riscv tree).  I do in-tree
> > builds somewhat regularly so that probably would have caught it if
> > nothing else did, but my guess is that some other autobuilder would have
> > found it first (some of the earlier patches
> The problem and other build issues (arm64 & 5.18-rc1 conflict) all
> have been solved in v12:
> https://lore.kernel.org/linux-riscv/20220405071314.3225832-1-guoren@kernel.org/
>
> >
> > Guo: please stop pushing things to linux-next that break the builds
> > and/or aren't aimed at your tree.  This just makes things unnecessarly
> > complicated.  If you don't want to deal with the build issues that's OK,
> > just LMK when you send the patch sets out and I'll deal with them, but
If you could deal with build issues that would be very thankful. I
just hope these patch series could get into for-next earlier before
the next merge window.
So I utilized next-tree-20220404 to find out what problems with that
(of course these patches should be from your tree).

The autobuilder for next-tree is more strict, and now seems almost all
problems have been solved.

> > having linux-next's build break causes fallout for a lot of users.
> Yesterday, I made my
> https://github.com/c-sky/csky-linux/commits/linux-next with
> linux-5.18-rc1 tag commit version.
> So this only affected linux-next-20220404.
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
