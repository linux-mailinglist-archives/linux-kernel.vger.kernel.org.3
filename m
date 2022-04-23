Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8172A50C79C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 07:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbiDWFYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 01:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiDWFYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 01:24:37 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E78F5A584
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 22:21:40 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso9217660wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 22:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sbU8RRqvuKwLWG8J3BfpPsUyUgY2ByjD6sNT/NW9Qas=;
        b=B6wZBHSzUPdCcDLRt1WF1wSVUZ6IaPZJKGzRkGxcMgrYRTCyx7oSwk7DfdsA3pIH0/
         3L/eQ8eCefAuJK0ZDUAcwKkxBObXj+j74XX2+U401kaeQ8NEUVwctEUF0ORbQx01jUtF
         lWQ+vcl0M/AV6JkP/osjzHeMq8XbkJX5EMKF0NUF4yrSw+6jnZbRZ090GCI3c0teQ1pW
         sp8FdQOPq969THiLOqq0bUDuzvxKY5guY3vvvPNRUzi1QBR+2pfwyt/kAvH9k0BZjNwO
         9qoFuOcNsY9/WEXcJwGkVg9bb9iW458LYRNr4pr9LIhMCmUeBudX6sG/Kphcpldtz6hY
         rsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sbU8RRqvuKwLWG8J3BfpPsUyUgY2ByjD6sNT/NW9Qas=;
        b=S7bZ0U/Bj2ZuycypDNVcG9XRNwWUaBK+Dhx8BMIIpeiITVWf698YDaXEhIKjR032sh
         g64WP6YEK/fBClUoMeu13/u46/WroC2LmEDuh/xJLwZQDxbiHgVEbsQSxNWb8aC2Vtb+
         Gwd2wvIz+5VhffV3dZnn9ghZXWXFxSJK6YPFjRPtrKfQhR1jxigyPTf/dTdrWeM2w/Dn
         yCs1oKJQdBZA6yz/L+KPE5zFVQzELdhrSAVnje5KlWz04HUMxV5R+0yKAq7egcZBj7Se
         G9rUT1REkuZj5KCWptgynGjExx9S+Hp4XnnRrMDai8fPZOP3FRe75IWGRzUyxtIAsMLd
         FQ3Q==
X-Gm-Message-State: AOAM531owkdaVEdsbkjmyg81iVWMyRkJMWKJyCp8GLb8vCpPE8qoZFb2
        YfMOhRB1JfxUY5RKsG94WKqtp405TeNT2h0XeLtNuQ==
X-Google-Smtp-Source: ABdhPJxnpi9iklJash3oBnOjkGhS8EaN+Bz6xw+hWOgd0DstcjPeFSZjE122Tq7X7+gHuxZSEmIi2G1jabwClBKyMmI=
X-Received: by 2002:a05:600c:1d15:b0:393:e534:eb93 with SMTP id
 l21-20020a05600c1d1500b00393e534eb93mr816388wms.137.1650691298392; Fri, 22
 Apr 2022 22:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220420112408.155561-1-apatel@ventanamicro.com>
 <3fa5215b-84c3-5e4c-cb53-6c05d05e4350@canonical.com> <CAOnJCUJrN4frY_OdQzO-yr5CrDLvj=ge9KY2d=XnGvAF-uQNvQ@mail.gmail.com>
 <CAOnJCUK5q0k1qKD0fM4NtbP6KAGcaBBknkCKLBXxcC=EPGVu1Q@mail.gmail.com>
In-Reply-To: <CAOnJCUK5q0k1qKD0fM4NtbP6KAGcaBBknkCKLBXxcC=EPGVu1Q@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 23 Apr 2022 10:51:26 +0530
Message-ID: <CAAhSdy3gO6a47fsO=UEp=k6KtMjzuNG_9pGnOky5LwGBmwL4rw@mail.gmail.com>
Subject: Re: [PATCH v3] RISC-V: Increase range and default value of NR_CPUS
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Alistair

On Sat, Apr 23, 2022 at 7:19 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Fri, Apr 22, 2022 at 5:16 PM Atish Patra <atishp@atishpatra.org> wrote=
:
> >
> > On Thu, Apr 21, 2022 at 12:05 AM Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> > >
> > >
> > >
> > > On 4/20/22 13:24, Anup Patel wrote:
> > > > Currently, the range and default value of NR_CPUS is too restrictiv=
e
> > > > for high-end RISC-V systems with large number of HARTs. The latest
> > > > QEMU virt machine supports upto 512 CPUs so the current NR_CPUS is
> > > > restrictive for QEMU as well. Other major architectures (such as
> > > > ARM64, x86_64, MIPS, etc) have a much higher range and default
> > > > value of NR_CPUS.
> > > >
> > > > This patch increases NR_CPUS range to 2-512 and default value to
> > > > XLEN (i.e. 32 for RV32 and 64 for RV64).
> > > >
> > > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > >
> >
> > This works upto 207 harts in upstream Qemu + OpenSBI. Beyond that,
> > firmware size becomes > 2MB and PMP protection
> > kicks in for the kernel boot address (0x80200000)
> >
>
> Just wanted to clarify that this is as per the current configuration
> in OpenSBI. The boot address
> is configured to be 0x80000000 for the generic platform. Thus, it can
> support a maximum of 207 harts.
>
> If anybody wishes to boot more than that, the boot address should be
> changed to a valid DRAM address such that
> it doesn't step on kernel/DT or other resident boot loaders (e.g. U-Boot)=
.
>
> It should be changed per platform (if supporting more than 128 harts)
> rather than changing
> to a common address for all platforms.

The OpenSBI limit of 128 harts was carefully chosen considering the
fact that QEMU by default loads OpenSBI at start of DRAM and kernel
at 2M (for RV64) or 4M (for RV32) offset. This means for RV64 if
OpenSBI is loaded at the start of DRAM then we only have 2M space
for OpenSBI hence the 128 harts limit.

To use more than 128 harts with OpenSBI, we will have to load it
somewhere else (probably in the middle of DRAM) but this will be a
platform specific choice. If a separate LOADER booting stage (e.g.
U-Boot SPL) is available on a platform then it can load OpenSBI
at desired platform specific location.

Overall, this is indeed a platform configuration issue. We will continue
to optimize OpenSBI to support more harts with less RAM usage but
this is a separate topic.

Regards,
Anup

>
> > Here is the OpenSBI boot prints for 256 harts with some hacks around
> > sanitize_domain to disable sbi_domain_check_addr
> >
> > Platform Name             : riscv-virtio,qemu
> > Platform Features         : medeleg
> > Platform HART Count       : 208
> > Platform IPI Device       : aclint-mswi
> > Platform Timer Device     : aclint-mtimer @ 10000000Hz
> > Platform Console Device   : uart8250
> > Platform HSM Device       : ---
> > Platform Reboot Device    : sifive_test
> > Platform Shutdown Device  : sifive_test
> > Firmware Base             : 0x80000000
> > Firmware Size             : 2052 KB ---------->>> Firmware size is
> > greater than 2MB where
> > Runtime SBI Version       : 0.3
> >
> > Domain0 Name              : root
> > Domain0 Boot HART         : 122
> > Domain0 HARTs             :
> > 0*,1*,2*,3*,4*,5*,6*,7*,8*,9*,10*,11*,12*,13*,14*,15*,16*,17*,18*,19*,2=
0*,21*,22*,23*,24*,25*,26*,27*,28*,29*,30*,31*,32*,33*,34*,35*,36*,37*,38*,=
39*,40*,41*,42*,43*,44*,45*,46*,47*,48*,49*,50*,51*,52*,53*,54*,55*,56*,57*=
,58*,59*,60*,61*,62*,63*,64*,65*,66*,67*,68*,69*,70*,71*,72*,73*,74*,75*,76=
*,77*,78*,79*,80*,81*,82*,83*,84*,85*,86*,87*,88*,89*,90*,91*,92*,93*,94*,9=
5*,96*,97*,98*,99*,100*,101*,102*,103*,104*,105*,106*,107*,108*,109*,110*,1=
11*,112*,113*,114*,115*,116*,117*,118*,119*,120*,121*,122*,123*,124*,125*,1=
26*,127*,128*,129*,130*,131*,132*,133*,134*,135*,136*,137*,138*,139*,140*,1=
41*,142*,143*,144*,145*,146*,147*,148*,149*,150*,151*,152*,153*,154*,155*,1=
56*,157*,158*,159*,160*,161*,162*,163*,164*,165*,166*,167*,168*,169*,170*,1=
71*,172*,173*,174*,175*,176*,177*,178*,179*,180*,181*,182*,183*,184*,185*,1=
86*,187*,188*,189*,190*,191*,192*,193*,194*,195*,196*,197*,198*,199*,200*,2=
01*,202*,203*,204*,205*,206*,207*
> > Domain0 Region00          : 0x0000000002000000-0x000000000200ffff (I)
> > Domain0 Region01          : 0x0000000080000000-0x00000000803fffff ()
> > Domain0 Region02          : 0x0000000000000000-0xffffffffffffffff (R,W,=
X)
> > Domain0 Next Address      : 0x0000000080200000
> > Domain0 Next Arg1         : 0x00000000bf000000
> > Domain0 Next Mode         : S-mode
> > Domain0 SysReset          : yes
> >
> > Boot HART ID              : 122
> > Boot HART Domain          : root
> > Boot HART ISA             : rv64imafdcsuh
> > Boot HART Features        : scounteren,mcounteren,time
> > Boot HART PMP Count       : 16
> > Boot HART PMP Granularity : 4
> > Boot HART PMP Address Bits: 54
> > Boot HART MHPM Count      : 0
> > Boot HART MIDELEG         : 0x0000000000001666
> > Boot HART MEDELEG         : 0x0000000000f0b509
> >
> >
> > > Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > >
> > > > ---
> > > > Changes since v2:
> > > >   - Rebased on Linux-5.18-rc3
> > > >   - Use a different range when SBI v0.1 is enabled
> > > > Changes since v1:
> > > >   - Updated NR_CPUS range to 2-512 which reflects maximum number of
> > > >     CPUs supported by QEMU virt machine.
> > > > ---
> > > >   arch/riscv/Kconfig | 9 ++++++---
> > > >   1 file changed, 6 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > index 00fd9c548f26..1823f281069f 100644
> > > > --- a/arch/riscv/Kconfig
> > > > +++ b/arch/riscv/Kconfig
> > > > @@ -275,10 +275,13 @@ config SMP
> > > >         If you don't know what to do here, say N.
> > > >
> > > >   config NR_CPUS
> > > > -     int "Maximum number of CPUs (2-32)"
> > > > -     range 2 32
> > > > +     int "Maximum number of CPUs (2-512)"
> > > >       depends on SMP
> > > > -     default "8"
> > > > +     range 2 512 if !SBI_V01
> > > > +     range 2 32 if SBI_V01 && 32BIT
> > > > +     range 2 64 if SBI_V01 && 64BIT
> > > > +     default "32" if 32BIT
> > > > +     default "64" if 64BIT
> > > >
> > > >   config HOTPLUG_CPU
> > > >       bool "Support for hot-pluggable CPUs"
> >
> >
> >
> > --
> > Regards,
> > Atish
>
>
>
> --
> Regards,
> Atish
