Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DB35ABFAA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 18:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiICQEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 12:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiICQEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 12:04:11 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1207543C9
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 09:04:09 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id k22so5092991ljg.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 09:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=L8GMbRKuQ9DT2VE5i0gWP/9BXKg4sL+fluq++DQyW+c=;
        b=KF83nBzgcSkc/eohDbcMVm5JXXxt19mkmcMUbY9dxURmUWxt/detrHb0XufHNEJmOM
         UUoQU2qf8VrSKqEsSB3Wt99uHnkTFZl/pVhs5eTpebBommPoERFs1t5CdbOH4tYkUvuy
         LHNHuVWT7z6g4fPwh01Uav64zqJe2dvjg+LOXhn5Sl/4vDu/VB6z38uH8SqjAMV2G8OY
         Zokt9rb1vVizWrrp+DFVf/TWOuvtltB9riIQhlA38b3IrHQwvJGxaZSbVTzT3nQUIySa
         O1ADU9OPBkIS2BaEud24dQGAbcWZ52PFqvlZMqyOQoWM9sT0xWLMHPfEevuXVp2p7Ok+
         ULhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=L8GMbRKuQ9DT2VE5i0gWP/9BXKg4sL+fluq++DQyW+c=;
        b=ylzuyBIwkJnO0+1E2SLT4ERTDK5Y9kwThmbtZbIeiQXccm71xhrkbXiCYFa0h36/PQ
         QKW95ebBivvEcB3cK92SdGceM/d/Ka1rFQBUdt3e82zH01ZVKD9GNHPGyERlxKhhEi4/
         GHgYrt0SkV6y1RmQPkstgzUhkps/SJ/4H5DphY5I0w+ryM+6zDmF5+m4wcIcQu2I3GDM
         qBJ+jfX0bD8DL5QJgHP6+K6JzzXx+PYAGJLdacf7uZqDiZrsgpbHlwVmUyAK1z+mqiy3
         NHcmaLe5goDYZ1I0ByOgMz5ZVadngBYkc00bTZOocDyPz5cdh9TBUSBMtp7GcX20Gp9Y
         GrkQ==
X-Gm-Message-State: ACgBeo2X10c+NTiLtSHgIR+POVXCQX+Mvd4lnQDSPrySHzq/HuurbYa8
        S9JbGKC6aRqJNNRLvTILMmGutoNOG9JUQZWa+s0/XE4CiQz0tQ==
X-Google-Smtp-Source: AA6agR6DAkGpMzDwe6apYm3JX3aQOgsbMIf5DPR85Q8YOdtO7X3YSFpsIEJenniS61oEntoGQMrkRuxHKNAoc5GNkSA=
X-Received: by 2002:a05:651c:b2c:b0:261:d82f:75b8 with SMTP id
 b44-20020a05651c0b2c00b00261d82f75b8mr11584677ljr.266.1662221048166; Sat, 03
 Sep 2022 09:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220830044642.566769-1-apatel@ventanamicro.com>
 <20220830044642.566769-4-apatel@ventanamicro.com> <13199249.VsHLxoZxqI@diego>
In-Reply-To: <13199249.VsHLxoZxqI@diego>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Sat, 3 Sep 2022 21:33:57 +0530
Message-ID: <CAK9=C2XR+3bezgSAYsr08rZq=B9VLR0Aef3icBQRi9-FNyB8kQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] RISC-V: Implement arch specific PMEM APIs
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 9:08 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi Anup,
>
> Am Dienstag, 30. August 2022, 06:46:41 CEST schrieb Anup Patel:
> > The NVDIMM PMEM driver expects arch specific APIs for cache maintenance
> > and if arch does not provide these APIs then NVDIMM PMEM driver will
> > always use MEMREMAP_WT to map persistent memory which in-turn maps as
> > UC memory type defined by the RISC-V Svpbmt specification.
> >
> > Now that the Svpbmt and Zicbom support is available in RISC-V kernel,
> > we implement PMEM APIs using ALT_CMO_OP() macros so that the NVDIMM
> > PMEM driver can use MEMREMAP_WB to map persistent memory.
>
> Zicbom is detected at runtime, though that kconfig setting changes the
> behaviour for the memremap-type at compile-time. So what happens on
> systems not using zicbom (or another cmo-variant) ?

On a system without Zicbom (or some other cmo-variant), the PMEM read
will always work but PMEM writes will not be reliable.

Currently, the generic PMEM driver has no provision to allow arch code to
disable cacheable mapping at boot-time.

Maybe we can add WARN_ONCE() for the case when arch_xyz_pmem()
is called on a system not having Zicbom ?

Regards,
Anup

>
>
> Heiko
>
> > Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  arch/riscv/Kconfig     |  1 +
> >  arch/riscv/mm/Makefile |  1 +
> >  arch/riscv/mm/pmem.c   | 21 +++++++++++++++++++++
> >  3 files changed, 23 insertions(+)
> >  create mode 100644 arch/riscv/mm/pmem.c
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 0ebd8da388d8..37d6370d29c3 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -25,6 +25,7 @@ config RISCV
> >       select ARCH_HAS_GIGANTIC_PAGE
> >       select ARCH_HAS_KCOV
> >       select ARCH_HAS_MMIOWB
> > +     select ARCH_HAS_PMEM_API
> >       select ARCH_HAS_PTE_SPECIAL
> >       select ARCH_HAS_SET_DIRECT_MAP if MMU
> >       select ARCH_HAS_SET_MEMORY if MMU
> > diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> > index d76aabf4b94d..3b368e547f83 100644
> > --- a/arch/riscv/mm/Makefile
> > +++ b/arch/riscv/mm/Makefile
> > @@ -31,3 +31,4 @@ endif
> >
> >  obj-$(CONFIG_DEBUG_VIRTUAL) +=3D physaddr.o
> >  obj-$(CONFIG_RISCV_DMA_NONCOHERENT) +=3D dma-noncoherent.o
> > +obj-$(CONFIG_ARCH_HAS_PMEM_API) +=3D pmem.o
> > diff --git a/arch/riscv/mm/pmem.c b/arch/riscv/mm/pmem.c
> > new file mode 100644
> > index 000000000000..089df92ae876
> > --- /dev/null
> > +++ b/arch/riscv/mm/pmem.c
> > @@ -0,0 +1,21 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2022 Ventana Micro Systems Inc.
> > + */
> > +
> > +#include <linux/export.h>
> > +#include <linux/libnvdimm.h>
> > +
> > +#include <asm/cacheflush.h>
> > +
> > +void arch_wb_cache_pmem(void *addr, size_t size)
> > +{
> > +     ALT_CMO_OP(clean, addr, size, riscv_cbom_block_size);
> > +}
> > +EXPORT_SYMBOL_GPL(arch_wb_cache_pmem);
> > +
> > +void arch_invalidate_pmem(void *addr, size_t size)
> > +{
> > +     ALT_CMO_OP(inval, addr, size, riscv_cbom_block_size);
> > +}
> > +EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
> >
>
>
>
>
