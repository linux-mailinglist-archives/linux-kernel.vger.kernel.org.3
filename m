Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2721580A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 06:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiGZEuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 00:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiGZEux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 00:50:53 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90ACA453
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 21:50:50 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 26Q4oM5q016083
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 13:50:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 26Q4oM5q016083
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658811023;
        bh=bOZAcieAa1N62XoVyvfG8Oy27JGkm1s/9RXmx1fJRrE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YFXXmjnh4y69aiFbk1PaKHs8novfu+w/+HV72S6gaUA6ucdcfLLqRRRN1j0vtprQR
         hKjTZ/SMbOMtO9Y+nXZ4y4rVW/UHyJ7d4+sLxhd8Pad2lS6tpHKvoUDtDXEFs39soL
         yY2NjwgV3hSQQ+BAg8MqIHkNovH5apZUtorE4PnOZbYaRvkD0L02oko+OzmLoZ1NwU
         4SBRmoiSNOiuesnahy8+4JKI71/ZYaM0PsfQ3B6horB/06ZnjCeYlemWdp5DIA76qP
         Q4hLLvfwDir/ihC36vSTSKGgT/IV7DyZ9orjaO7tlSEvLf17EqwsZkHsZibHgAIX3w
         4y6XlJQGLYLcw==
X-Nifty-SrcIP: [209.85.221.42]
Received: by mail-wr1-f42.google.com with SMTP id d8so18455348wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 21:50:23 -0700 (PDT)
X-Gm-Message-State: AJIora+WOMvyFEUg8QFeeAPdZnW4JIj7Mg0TV0ETTeluDX5oy0y59+3g
        ESsdbks5rnAYTgz5M3WQrTf1hfGy+xTUXAhluiM=
X-Google-Smtp-Source: AGRyM1sO8PExZzNIZki1jcl13eLZDRM1AI4QIG7u52VwXSdJRXz/qSXJJkT3pU0lrlNFDIea9wgV568q9eiXejuFAdM=
X-Received: by 2002:adf:979b:0:b0:21d:868a:7f2f with SMTP id
 s27-20020adf979b000000b0021d868a7f2fmr9419101wrb.409.1658811021682; Mon, 25
 Jul 2022 21:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220725021902.625630-1-masahiroy@kernel.org> <20220725021902.625630-2-masahiroy@kernel.org>
 <CAKwvOdkWxZy-is5uxWEizgNM4UXB5E_=QSO3iEeVFdPFqv00EA@mail.gmail.com>
In-Reply-To: <CAKwvOdkWxZy-is5uxWEizgNM4UXB5E_=QSO3iEeVFdPFqv00EA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 26 Jul 2022 13:49:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNASAO7ZoNvPs-odJKb6Uy1ueP1GPWC4iEtJfBrKcsNJcLg@mail.gmail.com>
Message-ID: <CAK7LNASAO7ZoNvPs-odJKb6Uy1ueP1GPWC4iEtJfBrKcsNJcLg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] riscv/purgatory: Omit use of bin2c
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>,
        Borislav Petkov <bp@suse.de>, Helge Deller <deller@gmx.de>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 2:52 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, Jul 24, 2022 at 7:22 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > The .incbin assembler directive is much faster than bin2c + $(CC).
> >
> > Do similar refactoring as in commit 4c0f032d4963 ("s390/purgatory:
> > Omit use of bin2c").
> >
> > Please note the .quad directive matches to size_t in C (both 8 byte)
> > because the purgatory is compiled only for the 64-bit kernel.
> > (KEXEC_FILE depends on 64BIT).
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Seems fine.  Is the overall goal working towards removing scripts/bin2c?


Yes.
I want to remove bin2c.


> Acked-by: Nick Desaulniers <ndesaulniers@google.com>
>
> > ---
> >
> > Changes in v2:
> >   - Fix a typo (kexec_purgatroy_end -> kexec_purgatory_end)
> >
> >  arch/riscv/Kconfig                     |  1 -
> >  arch/riscv/purgatory/.gitignore        |  1 -
> >  arch/riscv/purgatory/Makefile          |  8 +-------
> >  arch/riscv/purgatory/kexec-purgatory.S | 14 ++++++++++++++
> >  scripts/remove-stale-files             |  2 ++
> >  5 files changed, 17 insertions(+), 9 deletions(-)
> >  create mode 100644 arch/riscv/purgatory/kexec-purgatory.S
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 32ffef9f6e5b..218c2f12b3ef 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -447,7 +447,6 @@ config KEXEC_FILE
> >
> >  config ARCH_HAS_KEXEC_PURGATORY
> >         def_bool KEXEC_FILE
> > -       select BUILD_BIN2C
> >         depends on CRYPTO=y
> >         depends on CRYPTO_SHA256=y
> >
> > diff --git a/arch/riscv/purgatory/.gitignore b/arch/riscv/purgatory/.gitignore
> > index 38d7d1bda4d7..6e4dfb024ad2 100644
> > --- a/arch/riscv/purgatory/.gitignore
> > +++ b/arch/riscv/purgatory/.gitignore
> > @@ -1,4 +1,3 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  purgatory.chk
> >  purgatory.ro
> > -kexec-purgatory.c
> > diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
> > index c2d14e2f345d..dd58e1d99397 100644
> > --- a/arch/riscv/purgatory/Makefile
> > +++ b/arch/riscv/purgatory/Makefile
> > @@ -84,12 +84,6 @@ $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
> >  $(obj)/purgatory.chk: $(obj)/purgatory.ro FORCE
> >                 $(call if_changed,ld)
> >
> > -targets += kexec-purgatory.c
> > -
> > -quiet_cmd_bin2c = BIN2C   $@
> > -      cmd_bin2c = $(objtree)/scripts/bin2c kexec_purgatory < $< > $@
> > -
> > -$(obj)/kexec-purgatory.c: $(obj)/purgatory.ro $(obj)/purgatory.chk FORCE
> > -       $(call if_changed,bin2c)
> > +$(obj)/kexec-purgatory.o: $(obj)/purgatory.ro $(obj)/purgatory.chk
> >
> >  obj-y += kexec-purgatory.o
> > diff --git a/arch/riscv/purgatory/kexec-purgatory.S b/arch/riscv/purgatory/kexec-purgatory.S
> > new file mode 100644
> > index 000000000000..32c53581b8f2
> > --- /dev/null
> > +++ b/arch/riscv/purgatory/kexec-purgatory.S
> > @@ -0,0 +1,14 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +       .section .rodata, "a"
> > +
> > +       .align  8
> > +kexec_purgatory:
> > +       .globl  kexec_purgatory
> > +       .incbin "arch/riscv/purgatory/purgatory.ro"
> > +.Lkexec_purgatory_end:
> > +
> > +       .align  8
> > +kexec_purgatory_size:
> > +       .globl  kexec_purgatory_size
> > +       .quad   .Lkexec_purgatory_end - kexec_purgatory
> > diff --git a/scripts/remove-stale-files b/scripts/remove-stale-files
> > index 7adab4618035..d75a52199a38 100755
> > --- a/scripts/remove-stale-files
> > +++ b/scripts/remove-stale-files
> > @@ -40,4 +40,6 @@ if [ -n "${building_out_of_srctree}" ]; then
> >         done
> >  fi
> >
> > +rm -f arch/riscv/purgatory/kexec-purgatory.c
> > +
> >  rm -f scripts/extract-cert
> > --
> > 2.34.1
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Best Regards
Masahiro Yamada
