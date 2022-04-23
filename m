Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EE150C5A8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 02:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiDWAUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 20:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiDWAT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 20:19:59 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D51B5A143
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 17:17:03 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2f16645872fso100966837b3.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 17:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MoSOk7aiSsrTsFED04ppyU9PqkK13gebDi+J9ftgEjs=;
        b=ZOQ5EjKoIj6frB25e/g+fvJ1PDdhmnKNWUV6ChlD92WFm3A3X/bhOBJx6Y0lGxzAxX
         bC55qm14OQ6BI71mEOhg/9I481wslmOus55fjNPH+2cN9lvEOg7rwSW30zZvpXhoB3sS
         8kB6MY6EjYEDHMbp+1MaRQMa2z1AfztCpS99k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MoSOk7aiSsrTsFED04ppyU9PqkK13gebDi+J9ftgEjs=;
        b=COAHU6eXzoSyXt6uF2JxJZumpy4T+f45MnE/yKrRXBhnUWuZYqUsy7X929CIMNnTgA
         mixNvtW/7o+Rey23qGyKTSb5/2PORUKHWMpmesnR9ssM1AeRPFVoDbWATJgsijgowA9K
         YAYj+oiFdmKad/cxNaEsqLAIRZqncwNqLd3fnmn9pGWxQ6rLzNC0X8l/3NO8IAuDWE97
         afHPhsN5MYP6hdt628wv+ZpGTbdU/vs/IHRNNqxyDmo4yDPXm4Bx0/iHr01/AocfH3Nc
         4wfrKuTlUwM+gmeE6rAsXudEk9ft49e75ecHNejelA108wUL6r+IhijpgRGxhpOCVKbv
         WXLQ==
X-Gm-Message-State: AOAM5329/dYob+CezqMjrpAaGhexk7lB0uWjmFLQHslC0NM1SZnIN246
        Pd3d6dT/yaK7qVs59OqmexOpYi+yCWlWWJstjFu0
X-Google-Smtp-Source: ABdhPJw9bzlBvX7MnRZTUkY+yabryAq+Aj4BLIPm1GIu7cklg4UTowuZEcE85B6lKf5JpX4IRCuMrhLOUP2TYJYMQ2A=
X-Received: by 2002:a81:1f84:0:b0:2f4:d37b:a25f with SMTP id
 f126-20020a811f84000000b002f4d37ba25fmr7567853ywf.443.1650673022196; Fri, 22
 Apr 2022 17:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220420112408.155561-1-apatel@ventanamicro.com> <3fa5215b-84c3-5e4c-cb53-6c05d05e4350@canonical.com>
In-Reply-To: <3fa5215b-84c3-5e4c-cb53-6c05d05e4350@canonical.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 22 Apr 2022 17:16:51 -0700
Message-ID: <CAOnJCUJrN4frY_OdQzO-yr5CrDLvj=ge9KY2d=XnGvAF-uQNvQ@mail.gmail.com>
Subject: Re: [PATCH v3] RISC-V: Increase range and default value of NR_CPUS
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 12:05 AM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
>
>
> On 4/20/22 13:24, Anup Patel wrote:
> > Currently, the range and default value of NR_CPUS is too restrictive
> > for high-end RISC-V systems with large number of HARTs. The latest
> > QEMU virt machine supports upto 512 CPUs so the current NR_CPUS is
> > restrictive for QEMU as well. Other major architectures (such as
> > ARM64, x86_64, MIPS, etc) have a much higher range and default
> > value of NR_CPUS.
> >
> > This patch increases NR_CPUS range to 2-512 and default value to
> > XLEN (i.e. 32 for RV32 and 64 for RV64).
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>

This works upto 207 harts in upstream Qemu + OpenSBI. Beyond that,
firmware size becomes > 2MB and PMP protection
kicks in for the kernel boot address (0x80200000)

Here is the OpenSBI boot prints for 256 harts with some hacks around
sanitize_domain to disable sbi_domain_check_addr

Platform Name             : riscv-virtio,qemu
Platform Features         : medeleg
Platform HART Count       : 208
Platform IPI Device       : aclint-mswi
Platform Timer Device     : aclint-mtimer @ 10000000Hz
Platform Console Device   : uart8250
Platform HSM Device       : ---
Platform Reboot Device    : sifive_test
Platform Shutdown Device  : sifive_test
Firmware Base             : 0x80000000
Firmware Size             : 2052 KB ---------->>> Firmware size is
greater than 2MB where
Runtime SBI Version       : 0.3

Domain0 Name              : root
Domain0 Boot HART         : 122
Domain0 HARTs             :
0*,1*,2*,3*,4*,5*,6*,7*,8*,9*,10*,11*,12*,13*,14*,15*,16*,17*,18*,19*,20*,2=
1*,22*,23*,24*,25*,26*,27*,28*,29*,30*,31*,32*,33*,34*,35*,36*,37*,38*,39*,=
40*,41*,42*,43*,44*,45*,46*,47*,48*,49*,50*,51*,52*,53*,54*,55*,56*,57*,58*=
,59*,60*,61*,62*,63*,64*,65*,66*,67*,68*,69*,70*,71*,72*,73*,74*,75*,76*,77=
*,78*,79*,80*,81*,82*,83*,84*,85*,86*,87*,88*,89*,90*,91*,92*,93*,94*,95*,9=
6*,97*,98*,99*,100*,101*,102*,103*,104*,105*,106*,107*,108*,109*,110*,111*,=
112*,113*,114*,115*,116*,117*,118*,119*,120*,121*,122*,123*,124*,125*,126*,=
127*,128*,129*,130*,131*,132*,133*,134*,135*,136*,137*,138*,139*,140*,141*,=
142*,143*,144*,145*,146*,147*,148*,149*,150*,151*,152*,153*,154*,155*,156*,=
157*,158*,159*,160*,161*,162*,163*,164*,165*,166*,167*,168*,169*,170*,171*,=
172*,173*,174*,175*,176*,177*,178*,179*,180*,181*,182*,183*,184*,185*,186*,=
187*,188*,189*,190*,191*,192*,193*,194*,195*,196*,197*,198*,199*,200*,201*,=
202*,203*,204*,205*,206*,207*
Domain0 Region00          : 0x0000000002000000-0x000000000200ffff (I)
Domain0 Region01          : 0x0000000080000000-0x00000000803fffff ()
Domain0 Region02          : 0x0000000000000000-0xffffffffffffffff (R,W,X)
Domain0 Next Address      : 0x0000000080200000
Domain0 Next Arg1         : 0x00000000bf000000
Domain0 Next Mode         : S-mode
Domain0 SysReset          : yes

Boot HART ID              : 122
Boot HART Domain          : root
Boot HART ISA             : rv64imafdcsuh
Boot HART Features        : scounteren,mcounteren,time
Boot HART PMP Count       : 16
Boot HART PMP Granularity : 4
Boot HART PMP Address Bits: 54
Boot HART MHPM Count      : 0
Boot HART MIDELEG         : 0x0000000000001666
Boot HART MEDELEG         : 0x0000000000f0b509


> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> > ---
> > Changes since v2:
> >   - Rebased on Linux-5.18-rc3
> >   - Use a different range when SBI v0.1 is enabled
> > Changes since v1:
> >   - Updated NR_CPUS range to 2-512 which reflects maximum number of
> >     CPUs supported by QEMU virt machine.
> > ---
> >   arch/riscv/Kconfig | 9 ++++++---
> >   1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 00fd9c548f26..1823f281069f 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -275,10 +275,13 @@ config SMP
> >         If you don't know what to do here, say N.
> >
> >   config NR_CPUS
> > -     int "Maximum number of CPUs (2-32)"
> > -     range 2 32
> > +     int "Maximum number of CPUs (2-512)"
> >       depends on SMP
> > -     default "8"
> > +     range 2 512 if !SBI_V01
> > +     range 2 32 if SBI_V01 && 32BIT
> > +     range 2 64 if SBI_V01 && 64BIT
> > +     default "32" if 32BIT
> > +     default "64" if 64BIT
> >
> >   config HOTPLUG_CPU
> >       bool "Support for hot-pluggable CPUs"



--=20
Regards,
Atish
