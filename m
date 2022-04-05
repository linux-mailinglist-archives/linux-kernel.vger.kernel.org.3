Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FEE4F2286
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 07:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiDEFTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 01:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiDEFTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 01:19:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB02332;
        Mon,  4 Apr 2022 22:17:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F51A614E1;
        Tue,  5 Apr 2022 05:17:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADE1C340F3;
        Tue,  5 Apr 2022 05:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649135856;
        bh=F4BmQX2Y63BrfJkQle/Kee5eiX9lFVCLsQ1STIVzAGs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dZrT9tlHLkA6Z2fmx2EGIMkYJG+2GcdgeYAhBLf+3ghitO5FbdzFychci3qHoiPwS
         5gTLjVg3FYJ7gCLHZ+u7fhr4TRFlLVEPJcT741lvrjqY5hlaUVZcltjHyEKwyUHzef
         3HkAC+bGcaMs0lY9jYnK+i4K5jJTYWmnhDilVV6gnow/mdTTKQghuGkqM/+uyiN0w8
         TzEWtCiEqCSz3gNlKAvVp3QOHRdyVVBxQq5UnE2xGg5nB9+A011q9Gv9oYuQvQmulM
         cSD637H0Na5dWVPkv1qsWFfz+Uo933sppnOREKxqpvKWcu9Fb04TymS+pZqwDdkjy4
         /peyhOqR6nm8Q==
Received: by mail-vs1-f47.google.com with SMTP id i10so11367198vsr.6;
        Mon, 04 Apr 2022 22:17:36 -0700 (PDT)
X-Gm-Message-State: AOAM5312qCsmHqt5J4Yvj7OTifGsE4WuefyynPfRmAAsMaObvF7LSf5M
        jsPZKgHnzMKjy25pZmjDK/gxhR/hKLNHtvK6H4s=
X-Google-Smtp-Source: ABdhPJxwAHd5YmIGFxtQXjLGpWT1kmM7IBN8n/zhBH0Urpkbt1tUAG2ja7KTW5WzlcRcBYmbO9u1or/8w7wC2pBLezE=
X-Received: by 2002:a05:6102:dd1:b0:325:80a9:b5d7 with SMTP id
 e17-20020a0561020dd100b0032580a9b5d7mr514202vst.51.1649135855592; Mon, 04 Apr
 2022 22:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYu_ZHOeOPDiwzXGL6Re8aFYW3K+JSL2Dozw=VHwaUFxyQ@mail.gmail.com>
 <Yksjb9Mkq658k4YJ@dev-arch.thelio-3990X>
In-Reply-To: <Yksjb9Mkq658k4YJ@dev-arch.thelio-3990X>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 5 Apr 2022 13:17:24 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQkGZnwXrXsbx8drL0AicVpOMW=JmOcrieuvyEf91XPhg@mail.gmail.com>
Message-ID: <CAJF2gTQkGZnwXrXsbx8drL0AicVpOMW=JmOcrieuvyEf91XPhg@mail.gmail.com>
Subject: Re: [next] riscv: Linux next-20220404 riscv defconfig builds failed.
To:     Nathan Chancellor <nathan@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heiko Stuebner <heiko@sntech.de>,
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

On Tue, Apr 5, 2022 at 12:57 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Mon, Apr 04, 2022 at 03:28:41PM +0530, Naresh Kamboju wrote:
> > Linux next-20220404 riscv defconfig builds failed.
> >
> > Regressions found on riscv:
> >    - riscv-riscv-clang-14-defconfig
> >    - riscv-riscv-gcc-10-defconfig
> >    - riscv-riscv-clang-13-defconfig
> >    - riscv-riscv-clang-12-defconfig
> >    - riscv-riscv-clang-11-defconfig
> >    - riscv-riscv-gcc-11-defconfig
> >    - riscv-riscv-gcc-8-defconfig
> >    - riscv-riscv-gcc-9-defconfig
> >    - riscv-riscv-clang-nightly-defconfig
> >
> >
> > arch/riscv/kernel/compat_signal.c:7:10: fatal error:
> > linux/tracehook.h: No such file or directory
> >   7 | #include <linux/tracehook.h>
> >     |          ^~~~~~~~~~~~~~~~~~~
> > compilation terminated.
> > make[3]: *** [scripts/Makefile.build:289:
> > arch/riscv/kernel/compat_signal.o] Error 1
>
> For what it's worth, I also see:
>
> $ make -skj"$(nproc)" ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- defconfig all
> arch/riscv/kernel/compat_vdso/compat_vdso.lds.S:3:10: fatal error: ../vdso/vdso.lds.S: No such file or directory
>     3 | #include <../vdso/vdso.lds.S>
>       |          ^~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[2]: *** [scripts/Makefile.build:462: arch/riscv/kernel/compat_vdso/compat_vdso.lds] Error 1
> arch/riscv/kernel/compat_vdso/rt_sigreturn.S:3:10: fatal error: ../vdso/rt_sigreturn.S: No such file or directory
>     3 | #include <../vdso/rt_sigreturn.S>
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> arch/riscv/kernel/compat_vdso/note.S:3:10: fatal error: ../vdso/note.S: No such file or directory
>     3 | #include <../vdso/note.S>
>       |          ^~~~~~~~~~~~~~~~
> compilation terminated.
> arch/riscv/kernel/compat_vdso/getcpu.S:3:10: fatal error: ../vdso/getcpu.S: No such file or directory
>     3 | #include <../vdso/getcpu.S>
>       |          ^~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[2]: *** [arch/riscv/kernel/compat_vdso/Makefile:43: arch/riscv/kernel/compat_vdso/rt_sigreturn.o] Error 1
> make[2]: *** [arch/riscv/kernel/compat_vdso/Makefile:43: arch/riscv/kernel/compat_vdso/note.o] Error 1
> make[2]: *** [arch/riscv/kernel/compat_vdso/Makefile:43: arch/riscv/kernel/compat_vdso/getcpu.o] Error 1
> arch/riscv/kernel/compat_vdso/flush_icache.S:3:10: fatal error: ../vdso/flush_icache.S: No such file or directory
>     3 | #include <../vdso/flush_icache.S>
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[2]: *** [arch/riscv/kernel/compat_vdso/Makefile:43: arch/riscv/kernel/compat_vdso/flush_icache.o] Error 1
>
> I am guessing this code was never tested with $(srctree) == $(objtree).
Thx for pointing it out:
I always use:
make -skj"$(nproc)" ARCH=riscv
CROSS_COMPILE=riscv64-unknown-linux-gnu- EXTRA_CFLAGS+=-g
O=../build-riscv/ defconfig all

When I change to:
make -skj"$(nproc)" ARCH=riscv
CROSS_COMPILE=riscv64-unknown-linux-gnu- EXTRA_CFLAGS+=-g defconfig
all

I got your problem.

>
> Cheers,
> Nathan


--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
