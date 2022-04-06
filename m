Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CE84F575A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344397AbiDFIDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 04:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577417AbiDFIBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 04:01:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3D03878D5;
        Tue,  5 Apr 2022 18:13:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95224B8202A;
        Wed,  6 Apr 2022 01:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F295C385B5;
        Wed,  6 Apr 2022 01:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649207607;
        bh=K2W88sa0e40FhxFM51hz1PVnPS6fYU/JKW4DlHd0JHk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HYGAzAvDvERjww1332qf4HBWmEBr8lBkHk5nMmpuHlcrS5xNhnbKDRvGd28nZ+kpN
         TyR2NMK9JSTMkmDUMQaAIe7sJuDWPs3BEWWckbImQOQQVb12qZhWymF9E6XURIGl3a
         ywXDWYdzLFYuIqxnrYkVbVipI7/38HCnjQcchEcsY3kjjiFKEn/sLMMxn3BglHVeeM
         CTPK108iZ1bfDOO75pm6RvAA1YcwofguWk2pYis7TDML2vBzhBJ34KsSC3mLhVZZoL
         RvjsW2J22HTbg1jpz9AndAsh4y5a+5KueCNel9rddnbDEZXBMQY2wLAx8cB7K3Bdi8
         GCpVhnbxbQaPg==
Received: by mail-ua1-f41.google.com with SMTP id j9so949629uap.13;
        Tue, 05 Apr 2022 18:13:27 -0700 (PDT)
X-Gm-Message-State: AOAM531T555rIXPdxkj5Ghg328Wx6M2IqnznVf5Ai87HpmZwWR2EkB65
        opRePyXrYgbnWaYanlaPaQzk+dW17QcMl2RG2Vw=
X-Google-Smtp-Source: ABdhPJwdlBT6DWcyITpQFk0eYMxDLklydODShGdQh3Dhz3gy5pvAEE1D7qv3EMRUsxW3oJsG0Lv+XReYvs2gnjTTYBE=
X-Received: by 2002:a67:efc3:0:b0:325:4fcf:60bf with SMTP id
 s3-20020a67efc3000000b003254fcf60bfmr1892801vsp.51.1649207606157; Tue, 05 Apr
 2022 18:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAJF2gTQkGZnwXrXsbx8drL0AicVpOMW=JmOcrieuvyEf91XPhg@mail.gmail.com>
 <mhng-cfa7bfb9-bab8-423c-85ad-ecd407d6e806@palmer-ri-x1c9>
In-Reply-To: <mhng-cfa7bfb9-bab8-423c-85ad-ecd407d6e806@palmer-ri-x1c9>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 6 Apr 2022 09:13:15 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQgU=V+snWp7a8_txsX49BzAct1nkB18k-p4BZEd+s+eQ@mail.gmail.com>
Message-ID: <CAJF2gTQgU=V+snWp7a8_txsX49BzAct1nkB18k-p4BZEd+s+eQ@mail.gmail.com>
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

On Wed, Apr 6, 2022 at 12:15 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> On Mon, 04 Apr 2022 22:17:24 PDT (-0700), guoren@kernel.org wrote:
> > On Tue, Apr 5, 2022 at 12:57 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >>
> >> On Mon, Apr 04, 2022 at 03:28:41PM +0530, Naresh Kamboju wrote:
> >> > Linux next-20220404 riscv defconfig builds failed.
> >> >
> >> > Regressions found on riscv:
> >> >    - riscv-riscv-clang-14-defconfig
> >> >    - riscv-riscv-gcc-10-defconfig
> >> >    - riscv-riscv-clang-13-defconfig
> >> >    - riscv-riscv-clang-12-defconfig
> >> >    - riscv-riscv-clang-11-defconfig
> >> >    - riscv-riscv-gcc-11-defconfig
> >> >    - riscv-riscv-gcc-8-defconfig
> >> >    - riscv-riscv-gcc-9-defconfig
> >> >    - riscv-riscv-clang-nightly-defconfig
> >> >
> >> >
> >> > arch/riscv/kernel/compat_signal.c:7:10: fatal error:
> >> > linux/tracehook.h: No such file or directory
> >> >   7 | #include <linux/tracehook.h>
> >> >     |          ^~~~~~~~~~~~~~~~~~~
> >> > compilation terminated.
> >> > make[3]: *** [scripts/Makefile.build:289:
> >> > arch/riscv/kernel/compat_signal.o] Error 1
> >>
> >> For what it's worth, I also see:
> >>
> >> $ make -skj"$(nproc)" ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- defconfig all
> >> arch/riscv/kernel/compat_vdso/compat_vdso.lds.S:3:10: fatal error: ../vdso/vdso.lds.S: No such file or directory
> >>     3 | #include <../vdso/vdso.lds.S>
> >>       |          ^~~~~~~~~~~~~~~~~~~~
> >> compilation terminated.
> >> make[2]: *** [scripts/Makefile.build:462: arch/riscv/kernel/compat_vdso/compat_vdso.lds] Error 1
> >> arch/riscv/kernel/compat_vdso/rt_sigreturn.S:3:10: fatal error: ../vdso/rt_sigreturn.S: No such file or directory
> >>     3 | #include <../vdso/rt_sigreturn.S>
> >>       |          ^~~~~~~~~~~~~~~~~~~~~~~~
> >> compilation terminated.
> >> arch/riscv/kernel/compat_vdso/note.S:3:10: fatal error: ../vdso/note.S: No such file or directory
> >>     3 | #include <../vdso/note.S>
> >>       |          ^~~~~~~~~~~~~~~~
> >> compilation terminated.
> >> arch/riscv/kernel/compat_vdso/getcpu.S:3:10: fatal error: ../vdso/getcpu.S: No such file or directory
> >>     3 | #include <../vdso/getcpu.S>
> >>       |          ^~~~~~~~~~~~~~~~~~
> >> compilation terminated.
> >> make[2]: *** [arch/riscv/kernel/compat_vdso/Makefile:43: arch/riscv/kernel/compat_vdso/rt_sigreturn.o] Error 1
> >> make[2]: *** [arch/riscv/kernel/compat_vdso/Makefile:43: arch/riscv/kernel/compat_vdso/note.o] Error 1
> >> make[2]: *** [arch/riscv/kernel/compat_vdso/Makefile:43: arch/riscv/kernel/compat_vdso/getcpu.o] Error 1
> >> arch/riscv/kernel/compat_vdso/flush_icache.S:3:10: fatal error: ../vdso/flush_icache.S: No such file or directory
> >>     3 | #include <../vdso/flush_icache.S>
> >>       |          ^~~~~~~~~~~~~~~~~~~~~~~~
> >> compilation terminated.
> >> make[2]: *** [arch/riscv/kernel/compat_vdso/Makefile:43: arch/riscv/kernel/compat_vdso/flush_icache.o] Error 1
> >>
> >> I am guessing this code was never tested with $(srctree) == $(objtree).
> > Thx for pointing it out:
> > I always use:
> > make -skj"$(nproc)" ARCH=riscv
> > CROSS_COMPILE=riscv64-unknown-linux-gnu- EXTRA_CFLAGS+=-g
> > O=../build-riscv/ defconfig all
> >
> > When I change to:
> > make -skj"$(nproc)" ARCH=riscv
> > CROSS_COMPILE=riscv64-unknown-linux-gnu- EXTRA_CFLAGS+=-g defconfig
> > all
> >
> > I got your problem.
>
> Just to be clear: this one wasn't supposed to go in via the csky tree,
> and had other build issues that were being found by the autobuilders
> (which is why it hadn't gone in via the riscv tree).  I do in-tree
> builds somewhat regularly so that probably would have caught it if
> nothing else did, but my guess is that some other autobuilder would have
> found it first (some of the earlier patches
The problem and other build issues (arm64 & 5.18-rc1 conflict) all
have been solved in v12:
https://lore.kernel.org/linux-riscv/20220405071314.3225832-1-guoren@kernel.org/

>
> Guo: please stop pushing things to linux-next that break the builds
> and/or aren't aimed at your tree.  This just makes things unnecessarly
> complicated.  If you don't want to deal with the build issues that's OK,
> just LMK when you send the patch sets out and I'll deal with them, but
> having linux-next's build break causes fallout for a lot of users.
Yesterday, I made my
https://github.com/c-sky/csky-linux/commits/linux-next with
linux-5.18-rc1 tag commit version.
So this only affected linux-next-20220404.


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
