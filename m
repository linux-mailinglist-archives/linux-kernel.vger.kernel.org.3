Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589904D5184
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245704AbiCJTBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242913AbiCJTBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:01:03 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308B99A9BD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:00:01 -0800 (PST)
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MRTEr-1npiKQ1wQf-00NRtZ for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022
 19:59:59 +0100
Received: by mail-wr1-f44.google.com with SMTP id u10so9436514wra.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 10:59:59 -0800 (PST)
X-Gm-Message-State: AOAM533mPJVv5+N1gbW7Vb3zZmx5dCOEMBW3v6BBLLSWRzSgnpEzx5i6
        eGZtIEwXECuR+ctlvxBbz6pSPx/oCDtaIvBjJhI=
X-Google-Smtp-Source: ABdhPJxh5kzO7+X7Vulcp10MK8TD08/mOPwAsExT9yMBy8UwuYQtg/z/TIajyux1R/KV23QdMmF2QvZcOqDpSmj7JN8=
X-Received: by 2002:adf:d081:0:b0:1ef:9378:b7cc with SMTP id
 y1-20020adfd081000000b001ef9378b7ccmr4862760wrh.407.1646938798999; Thu, 10
 Mar 2022 10:59:58 -0800 (PST)
MIME-Version: 1.0
References: <20220310170845.17614-1-palmer@rivosinc.com>
In-Reply-To: <20220310170845.17614-1-palmer@rivosinc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 10 Mar 2022 19:59:42 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0gqTNX7zNneE6NX1aXvnO77oY2nYyGK4KbwEYdFS8F9Q@mail.gmail.com>
Message-ID: <CAK8P3a0gqTNX7zNneE6NX1aXvnO77oY2nYyGK4KbwEYdFS8F9Q@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Add CONFIG_{NON,}PORTABLE
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:IN/uyDCtlkper4n/czHzJ2jzEMcY9p04syIa1qhxi4+2anYm/JU
 DsbQwGVyRkG/a9kFVSlXW/8+u6c9msWsyEDFs6KawoE7szSRLkmFfbRbZXoRrzRRIYtKgkt
 0U+yD+LIMsObvvT0Z5fhFY4upMZqP2Lx67gjAmShnoEyMKqdVrJP1mwyQkdAhaPbXt0e28U
 e4LguDaa3YFdKRZkr43yg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0i4xzWgO//U=:3YW/TBNpMHP0oC9q3f54fY
 bhR/cYnP1MX+R6JzVs+Ys9ntREeThnkTo0dBKhm1h+z0fEStN/A3Iznj7Yp1/ORDcAOMciSVC
 bS/MTkAhCf4xkIlSQjsjYl9iby2P5YbV5gpRTthc+eAN69GqgM0NfzEqzGutzyS+8ViQVACzT
 5yPOwJ+Xy5bJSYm22N4KjWJ1VKi4POwa6DhVMlaqlsutpTJZfgxNvatCOm7yd69Vgz6N9yLKE
 HEun4CoCPTobODUOcZlWBsXcoWmtZuFWCO/OzBfDzFdKVBoRibV6tqDy8k9jeDwKh3n3JQUCh
 qeBZwbEjiZddM/WlbM8c9kg0rwarGQdZCzkeoJx3Dc38zCQysCL4WxfL4YE/jLoD/I4X50KgA
 fRRhTNn9eDv34j44ryI1TyPaIPuew5XFm6HDtL0yvTw5cSGSge7XT0oVrGXsdV8wdjyoAT+9q
 dm/AfiHP1JbkB9TX1v+AibAwHJpFRH7AUHdS8cNxygWs+XjqqbweNrEgwrluUNQ2+NdCtrNqy
 lkfzk6sgjiyvA+4eSBDwU002jdz4JdG6S5Y5h6W06T6F26t8hq/mLoTadnqXKPEwY/esE1Gql
 npzs3DHTyv0Prltz+cBUewzSM1V94NkD5UPWDWiMfABOeHJY2HydyCULJdUcF7etPu04IY1de
 4EJswt7uwk651SNVWcfUg4E3tjD/fhqk38DyJTpmT3fxNxIyt3Y/hwGjY4ZnLKXMG5JY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 6:08 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> The RISC-V port has collected a handful of options that are
> fundamentally non-portable.  To prevent users from shooting themselves
> in the foot, hide them all behind a config entry that explicitly calls
> out that non-portable binaries may be produced.
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> ---
> This came up in the context of the no-M patch:
> https://lore.kernel.org/lkml/CAK8P3a3mzax-OiaxBcxM_RgKNsd6N8HW0odRmw38u2jKE5aYaQ@mail.gmail.com/
>
> I'm not sure I strictly need both PORTABLE and NONPORTABLE, but it's the
> only way I could come up with to force things like EFI.  I'll poke
> around Kconfig a bit more, but I figured this is going to lead to a
> discussion so it'd be better to just send this crusty version so we at
> least have something concrete to talk about.
>
> I've only given this a smoke test (ie, defconfig looks OK).  I'll go
> through all the configs if folks think this is the right way to go -- I
> figure it's better to have the discussion on a more focused patch than
> on that M patch, as this is really an orthogonal issue.
>
> I'm not really sure what the right option is here: I'm not selecting
> things like errata and basic drivers, but I could buy the argument that
> disabling those results in non-portable systems.  I am selecting EFI,
> that might not be strictly required now but it's the direction we're
> going so I figure we might as well start now.  I've also hidden 32BIT
> behind this, I could see that going either way but my guess is that
> users of 32-bit systems won't care about portable binaries.

These are all things I would have suggested as well, sounds good.

>  I'm also
> not sure if this should be tied to something like EMBEDDED or EXPERT.

CONFIG_EMBEDDED is weird, it's better to avoid interacting with
it, because it tends to not do what one expects. Hiding it behind
CONFIG_EXPERT would make sense, but it's also a rather strong
guard, so it's probably better to leave it the way you have it.

> My biggest worry with this is that users might get the feeling that
> current kernels will be compatible with new hardware, that's just not
> how RISC-V works.  I tried to write the help text indicating that, I'm
> not sure I like how it reads so I'll almost certainly take another shot
> at it (though suggestions are, of course, welcome).
>
> I'm also a bit worried that vendors might get the feeling we're not
> going to support systems that need modifications to these portablity
> requirements.  That's also not the case, as there's really no way for
> vendors to make sure their systems continue to run portable kernels
> aside from just releasing them publicly so we can test them.
> ---
>  arch/riscv/Kconfig | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 5adcbd9b5e88..de0916d7aca7 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -9,6 +9,7 @@ config 64BIT
>
>  config 32BIT
>         bool
> +       depends on NONPORTABLE

This 'depends on is in the wrong place, you need to move it below
ARCH_RV32I, or possibly rework that "Base ISA" choice statement
into something else.

>  config RISCV
>         def_bool y
> @@ -485,6 +486,7 @@ config STACKPROTECTOR_PER_TASK
>
>  config PHYS_RAM_BASE_FIXED
>         bool "Explicitly specified physical RAM address"
> +       depends on NONPORTABLE
>         default n
>
>  config PHYS_RAM_BASE
> @@ -498,7 +500,7 @@ config PHYS_RAM_BASE
>
>  config XIP_KERNEL
>         bool "Kernel Execute-In-Place from ROM"
> -       depends on MMU && SPARSEMEM
> +       depends on MMU && SPARSEMEM && NONPORTABLE
>         # This prevents XIP from being enabled by all{yes,mod}config, which
>         # fail to build since XIP doesn't support large kernels.
>         depends on !COMPILE_TEST
> @@ -538,9 +540,31 @@ endmenu
>
>  config BUILTIN_DTB
>         bool
> -       depends on OF
> +       depends on OF && NONPORTABLE
>         default y if XIP_KERNEL
>
> +config NONPORTABLE
> +       bool "Allow configurations that result in non-portable kernels"
> +       help
> +         RISC-V kernel binaries are compatibile between all known systems

typo: compatible

> +         whenever possible, but there are some use cases that can only be
> +         satisfied by configurations that result in kernel binaries that are
> +         not portable between systems.
> +
> +         Selecting N does not guarntee kernels will be portable to all knows

typo: guarantee

> +         systems.  Selecting any of the options guarded by NONPORTABLE will
> +         result in kernel binaries that are unlikely to be portable between
> +         systems.
> +
> +         If unsure, say N.
> +
> +config PORTABLE
> +       bool
> +       default !NONPORTABLE
> +       select EFI
> +       select OF
> +       select MMU

A nice trick I would use here is to make PORTABLE/NONPORTABLE
into a 'choice' statement that defaults to PORTABLE. That way, both
allnoconfig and allmodconfig/allyesconfig end up testing the portable case.

Ideally both allnoconfig and allmodconfig would be able to boot the
same (virtual) machine, but getting to that point likely requires addressing
further issues.

If someone can come up with a better naming system, the
portable/nonportable choice could even be integrated into the
"Base ISA" choice, giving the user a list of the possible targets,
like:

choice
      prompt "System type"
      default ARCH_RV64I

config ARCH_RV64I
       bool "Generic portable RV64GC system"
       select 64BIT
       select EFI
       select OF
       select MMU

config ARCH_RV64I_NONPORTABLE
        bool "Custom RV64I machine, nonportable"
        select 64BIT
        select MMU

config ARCH_RV32I_NONPORTABLE
        bool "Custom RV64I machine, nonportable"
        select 64BIT
        select MMU

config ARCH_RV64_NOMMU
        bool "Custom RV64I machine without MMU"
        select 64BIT

endchoice

Not sure if that is more or less confusing than what you have
here, just putting it out there as another way to handle the
top-level platform selection.

         Arnd
