Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6494BAB05
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343650AbiBQU3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:29:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiBQU26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:28:58 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72906C2E77
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 12:28:41 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2d68d519a33so43959877b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 12:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kxFkYvm9tIIjUWsVsqBpOME9azu2tqfxM47UznDGNb4=;
        b=bWOurTzTHJz806di/atiEj8pjODPVicf/05QEKTgSxjWkkgqYBOBKWocGE194FgVWJ
         3ATyJ9SRdVadXo7+rQ0klqKsHG9UGjNNCsXo6xd6ILLS8hWNnw3Sf2VSwqhYlq8vuiWi
         F+sj2KXUpBAHi1K5TMXSVxD7mUoaR1M5RMbeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kxFkYvm9tIIjUWsVsqBpOME9azu2tqfxM47UznDGNb4=;
        b=ubODZAP1wqL0QW0uSkQWsvoOlrsRmJhr5v3Zy0uzdForWSbmdssyRSy1CwH8Demz1R
         9aYa4UApMQQrLQN8HrRCYDouzIOp5fYyHoG91sq9W0gYTuBjfkB8jBBK1jdUR1kj8+no
         okmA9d0a+6JXkbTWcq3JZgVKzGLDGUwJlmfBvc+6uQ7Ri4XmqonZvEQ2wlnHfLNW4YFF
         rQ7QCXpsmAwMsD9ft+RWQJb9Sv1m26bBStEhdK1a1Fm2N1Er7MRUdsgPCxo2w3Q1fCdw
         mQQ0tsAhxJUvUKMNYa25lrIr6PPtLrLTU003nuBCDaJ2lchAGRbudoQIxFfLkAua5jjN
         n18w==
X-Gm-Message-State: AOAM530ywLu6NHarzk8XlkPc44e7j107RyFjV+0lpRQ2mUUmLwapXrmb
        t6Kufr8DHfYx7js90wwcglQwzOK/EloCueBC4aiC
X-Google-Smtp-Source: ABdhPJywqFMlv1rHeGIHOr2UvUF//R+9xDImcakKMCc+p074iF1vM58yl2P9+O8nIN8nvYIKubyzmh1JAepsyHFggs0=
X-Received: by 2002:a81:6307:0:b0:2d6:6aee:dc75 with SMTP id
 x7-20020a816307000000b002d66aeedc75mr4407933ywb.249.1645129720466; Thu, 17
 Feb 2022 12:28:40 -0800 (PST)
MIME-Version: 1.0
References: <20211225054647.1750577-1-atishp@rivosinc.com> <20211225054647.1750577-7-atishp@rivosinc.com>
 <CAAhSdy3gayK2rW5Kztje_V33S87dWw0fDuHOLJqKvNL=irNkOQ@mail.gmail.com>
 <CAPqJEFpVBp3bFd+bR-DwHKD=yFo4Sog5TCU8JLJFoGc-y_VteA@mail.gmail.com>
 <CAOnJCUK5MwF-T0TqGtZqmj+dEfV0gb7R82of0YgmWjBCmgh8VQ@mail.gmail.com> <CAPqJEFr5qn=Ut=Vm22-Z+1KmCLj7KL7uGDM5rmwVFDDBC2oR+g@mail.gmail.com>
In-Reply-To: <CAPqJEFr5qn=Ut=Vm22-Z+1KmCLj7KL7uGDM5rmwVFDDBC2oR+g@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 17 Feb 2022 12:28:29 -0800
Message-ID: <CAOnJCUJSCamnW1FxzCcg-NGojHxKPv096=P9QTpd4cC48fA0NQ@mail.gmail.com>
Subject: Re: [v5 6/9] RISC-V: Add perf platform driver based on SBI PMU extension
To:     Eric Lin <eric.lin@sifive.com>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Vincent Chen <vincent.chen@sifive.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 already

On Wed, Jan 26, 2022 at 5:32 AM Eric Lin <eric.lin@sifive.com> wrote:
>
> Hi Atish,
>
> On Wed, Jan 26, 2022 at 4:20 AM Atish Patra <atishp@atishpatra.org> wrote=
:
> >
> > On Tue, Jan 25, 2022 at 6:42 AM Eric Lin <eric.lin@sifive.com> wrote:
> > >
> > > Hi Atish,
> > >
> > > > On Sat, Dec 25, 2021 at 11:17 AM Atish Patra <atishp@atishpatra.org=
> wrote:
> > > > >
> > > > > From: Atish Patra <atish.patra@wdc.com>
> > > > >
> > > > > RISC-V SBI specification added a PMU extension that allows to con=
figure
> > > > > start/stop any pmu counter. The RISC-V perf can use most of the g=
eneric
> > > > > perf features except interrupt overflow and event filtering based=
 on
> > > > > privilege mode which will be added in future.
> > > > >
> > > > > It also allows to monitor a handful of firmware counters that can=
 provide
> > > > > insights into firmware activity during a performance analysis.
> > > > >
> > > > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > > > > ---
> > > > >  drivers/perf/Kconfig         |  10 +
> > > > >  drivers/perf/Makefile        |   1 +
> > > > >  drivers/perf/riscv_pmu.c     |   2 +
> > > > >  drivers/perf/riscv_pmu_sbi.c | 558 +++++++++++++++++++++++++++++=
++++++
> > > > >  4 files changed, 571 insertions(+)
> > > > >  create mode 100644 drivers/perf/riscv_pmu_sbi.c
> > > > >
> > > > > diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> > > > > index 6bd12663c8d3..b2b78bd34df4 100644
> > > > > --- a/drivers/perf/Kconfig
> > > > > +++ b/drivers/perf/Kconfig
> > > > > @@ -76,6 +76,16 @@ config RISCV_PMU_LEGACY
> > > > >           of cycle/instruction counter and doesn't support counte=
r overflow,
> > > > >           or programmable counters. It will be removed in future.
> > > > >
> > > > > +config RISCV_PMU_SBI
> > > > > +       depends on RISCV_PMU && RISCV_SBI
> > > > > +       bool "RISC-V PMU based on SBI PMU extension"
> > > > > +       default y
> > > > > +       help
> > > > > +         Say y if you want to use the CPU performance monitor
> > > > > +         using SBI PMU extension on RISC-V based systems. This o=
ption provides
> > > > > +         full perf feature support i.e. counter overflow, privil=
ege mode
> > > > > +         filtering, counter configuration.
> > > > > +
> > > > >  config ARM_PMU_ACPI
> > > > >         depends on ARM_PMU && ACPI
> > > > >         def_bool y
> > > > > diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> > > > > index e8aa666a9d28..7bcac4b5a983 100644
> > > > > --- a/drivers/perf/Makefile
> > > > > +++ b/drivers/perf/Makefile
> > > > > @@ -13,6 +13,7 @@ obj-$(CONFIG_QCOM_L3_PMU) +=3D qcom_l3_pmu.o
> > > > >  obj-$(CONFIG_RISCV_PMU) +=3D riscv_pmu.o
> > > > >  ifeq ($(CONFIG_RISCV_PMU), y)
> > > > >  obj-$(CONFIG_RISCV_PMU_LEGACY) +=3D riscv_pmu_legacy.o
> > > > > +obj-$(CONFIG_RISCV_PMU_SBI) +=3D riscv_pmu_sbi.o
> > > > >  endif
> > > > >  obj-$(CONFIG_THUNDERX2_PMU) +=3D thunderx2_pmu.o
> > > > >  obj-$(CONFIG_XGENE_PMU) +=3D xgene_pmu.o
> > > > > diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> > > > > index 83c3e8d085c7..970542a82c4a 100644
> > > > > --- a/drivers/perf/riscv_pmu.c
> > > > > +++ b/drivers/perf/riscv_pmu.c
> > > > > @@ -15,6 +15,8 @@
> > > > >  #include <linux/printk.h>
> > > > >  #include <linux/smp.h>
> > > > >
> > > > > +#include <asm/sbi.h>
> > > > > +
> > > > >  static unsigned long csr_read_num(int csr_num)
> > > > >  {
> > > > >  #define switchcase_csr_read(__csr_num, __val)          {\
> > > > > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pm=
u_sbi.c
> > > > > new file mode 100644
> > > > > index 000000000000..f078d423a89a
> > > > > --- /dev/null
> > > > > +++ b/drivers/perf/riscv_pmu_sbi.c
> > > > > @@ -0,0 +1,558 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * RISC-V performance counter support.
> > > > > + *
> > > > > + * Copyright (C) 2021 Western Digital Corporation or its affilia=
tes.
> > > > > + *
> > > > > + * This code is based on ARM perf event code which is in turn ba=
sed on
> > > > > + * sparc64 and x86 code.
> > > > > + */
> > > > > +
> > > >
> > > > Add here
> > > > #define pr_fmt(fmt) "riscv-pmu-sbi: " fmt
> > > >
> > > > > +#include <linux/mod_devicetable.h>
> > > > > +#include <linux/perf/riscv_pmu.h>
> > > > > +#include <linux/platform_device.h>
> > > > > +
> > > > > +#include <asm/sbi.h>
> > > > > +
> > > > > +union sbi_pmu_ctr_info {
> > > > > +       unsigned long value;
> > > > > +       struct {
> > > > > +               unsigned long csr:12;
> > > > > +               unsigned long width:6;
> > > > > +#if __riscv_xlen =3D=3D 32
> > > > > +               unsigned long reserved:13;
> > > > > +#else
> > > > > +               unsigned long reserved:45;
> > > > > +#endif
> > > > > +               unsigned long type:1;
> > > > > +       };
> > > > > +};
> > > > > +
> > > > > +/**
> > > > > + * RISC-V doesn't have hetergenous harts yet. This need to be pa=
rt of
> > > > > + * per_cpu in case of harts with different pmu counters
> > > > > + */
> > > > > +static union sbi_pmu_ctr_info *pmu_ctr_list;
> > > > > +
> > > > > +struct pmu_event_data {
> > > >
> > > > I suggest renaming pmu_event_data to sbi_pmu_event_data
> > > > for consistency.
> > > >
> > > > > +       union {
> > > > > +               union {
> > > > > +                       struct hw_gen_event {
> > > > > +                               uint32_t event_code:16;
> > > > > +                               uint32_t event_type:4;
> > > > > +                               uint32_t reserved:12;
> > > > > +                       } hw_gen_event;
> > > > > +                       struct hw_cache_event {
> > > > > +                               uint32_t result_id:1;
> > > > > +                               uint32_t op_id:2;
> > > > > +                               uint32_t cache_id:13;
> > > > > +                               uint32_t event_type:4;
> > > > > +                               uint32_t reserved:12;
> > > > > +                       } hw_cache_event;
> > > > > +               };
> > > > > +               uint32_t event_idx;
> > > > > +       };
> > > > > +};
> > > > > +
> > > > > +static const struct pmu_event_data pmu_hw_event_map[] =3D {
> > > > > +       [PERF_COUNT_HW_CPU_CYCLES]              =3D {.hw_gen_even=
t =3D {
> > > > > +                                                       SBI_PMU_H=
W_CPU_CYCLES,
> > > > > +                                                       SBI_PMU_E=
VENT_TYPE_HW, 0}},
> > > > > +       [PERF_COUNT_HW_INSTRUCTIONS]            =3D {.hw_gen_even=
t =3D {
> > > > > +                                                       SBI_PMU_H=
W_INSTRUCTIONS,
> > > > > +                                                       SBI_PMU_E=
VENT_TYPE_HW, 0}},
> > > > > +       [PERF_COUNT_HW_CACHE_REFERENCES]        =3D {.hw_gen_even=
t =3D {
> > > > > +                                                       SBI_PMU_H=
W_CACHE_REFERENCES,
> > > > > +                                                       SBI_PMU_E=
VENT_TYPE_HW, 0}},
> > > > > +       [PERF_COUNT_HW_CACHE_MISSES]            =3D {.hw_gen_even=
t =3D {
> > > > > +                                                       SBI_PMU_H=
W_CACHE_MISSES,
> > > > > +                                                       SBI_PMU_E=
VENT_TYPE_HW, 0}},
> > > > > +       [PERF_COUNT_HW_BRANCH_INSTRUCTIONS]     =3D {.hw_gen_even=
t =3D {
> > > > > +                                                       SBI_PMU_H=
W_BRANCH_INSTRUCTIONS,
> > > > > +                                                       SBI_PMU_E=
VENT_TYPE_HW, 0}},
> > > > > +       [PERF_COUNT_HW_BRANCH_MISSES]           =3D {.hw_gen_even=
t =3D {
> > > > > +                                                       SBI_PMU_H=
W_BRANCH_MISSES,
> > > > > +                                                       SBI_PMU_E=
VENT_TYPE_HW, 0}},
> > > > > +       [PERF_COUNT_HW_BUS_CYCLES]              =3D {.hw_gen_even=
t =3D {
> > > > > +                                                       SBI_PMU_H=
W_BUS_CYCLES,
> > > > > +                                                       SBI_PMU_E=
VENT_TYPE_HW, 0}},
> > > > > +       [PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =3D {.hw_gen_even=
t =3D {
> > > > > +                                                       SBI_PMU_H=
W_STALLED_CYCLES_FRONTEND,
> > > > > +                                                       SBI_PMU_E=
VENT_TYPE_HW, 0}},
> > > > > +       [PERF_COUNT_HW_STALLED_CYCLES_BACKEND]  =3D {.hw_gen_even=
t =3D {
> > > > > +                                                       SBI_PMU_H=
W_STALLED_CYCLES_BACKEND,
> > > > > +                                                       SBI_PMU_E=
VENT_TYPE_HW, 0}},
> > > > > +       [PERF_COUNT_HW_REF_CPU_CYCLES]          =3D {.hw_gen_even=
t =3D {
> > > > > +                                                       SBI_PMU_H=
W_REF_CPU_CYCLES,
> > > > > +                                                       SBI_PMU_E=
VENT_TYPE_HW, 0}},
> > > > > +};
> > > > > +
> > > > > +#define C(x) PERF_COUNT_HW_CACHE_##x
> > > > > +static const struct pmu_event_data pmu_cache_event_map[PERF_COUN=
T_HW_CACHE_MAX]
> > > > > +[PERF_COUNT_HW_CACHE_OP_MAX]
> > > > > +[PERF_COUNT_HW_CACHE_RESULT_MAX] =3D {
> > > > > +       [C(L1D)] =3D {
> > > > > +               [C(OP_READ)] =3D {
> > > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =
=3D {C(RESULT_ACCESS),
> > > > > +                                       C(OP_READ), C(L1D), SBI_P=
MU_EVENT_TYPE_CACHE, 0}},
> > > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D=
 {C(RESULT_MISS),
> > > > > +                                       C(OP_READ), C(L1D), SBI_P=
MU_EVENT_TYPE_CACHE, 0}},
> > > > > +               },
> > > > > +               [C(OP_WRITE)] =3D {
> > > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =
=3D {C(RESULT_ACCESS),
> > > > > +                                       C(OP_WRITE), C(L1D), SBI_=
PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D=
 {C(RESULT_MISS),
> > > > > +                                       C(OP_WRITE), C(L1D), SBI_=
PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +               },
> > > > > +               [C(OP_PREFETCH)] =3D {
> > > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =
=3D {C(RESULT_ACCESS),
> > > > > +                                       C(OP_PREFETCH), C(L1D), S=
BI_PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D=
 {C(RESULT_MISS),
> > > > > +                                       C(OP_PREFETCH), C(L1D), S=
BI_PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +               },
> > > > > +       },
> > > > > +       [C(L1I)] =3D {
> > > > > +               [C(OP_READ)] =3D {
> > > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =
=3D {C(RESULT_ACCESS),
> > > > > +                                       C(OP_READ), C(L1I), SBI_P=
MU_EVENT_TYPE_CACHE, 0}},
> > > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D=
 {C(RESULT_MISS), C(OP_READ),
> > > > > +                                       C(L1I), SBI_PMU_EVENT_TYP=
E_CACHE, 0}},
> > > > > +               },
> > > > > +               [C(OP_WRITE)] =3D {
> > > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =
=3D {C(RESULT_ACCESS),
> > > > > +                                       C(OP_WRITE), C(L1I), SBI_=
PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D=
 {C(RESULT_MISS),
> > > > > +                                       C(OP_WRITE), C(L1I), SBI_=
PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +               },
> > > > > +               [C(OP_PREFETCH)] =3D {
> > > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =
=3D {C(RESULT_ACCESS),
> > > > > +                                       C(OP_PREFETCH), C(L1I), S=
BI_PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D=
 {C(RESULT_MISS),
> > > > > +                                       C(OP_PREFETCH), C(L1I), S=
BI_PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +               },
> > > > > +       },
> > > > > +       [C(LL)] =3D {
> > > > > +               [C(OP_READ)] =3D {
> > > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =
=3D {C(RESULT_ACCESS),
> > > > > +                                       C(OP_READ), C(LL), SBI_PM=
U_EVENT_TYPE_CACHE, 0}},
> > > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D=
 {C(RESULT_MISS),
> > > > > +                                       C(OP_READ), C(LL), SBI_PM=
U_EVENT_TYPE_CACHE, 0}},
> > > > > +               },
> > > > > +               [C(OP_WRITE)] =3D {
> > > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =
=3D {C(RESULT_ACCESS),
> > > > > +                                       C(OP_WRITE), C(LL), SBI_P=
MU_EVENT_TYPE_CACHE, 0}},
> > > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D=
 {C(RESULT_MISS),
> > > > > +                                       C(OP_WRITE), C(LL), SBI_P=
MU_EVENT_TYPE_CACHE, 0}},
> > > > > +               },
> > > > > +               [C(OP_PREFETCH)] =3D {
> > > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =
=3D {C(RESULT_ACCESS),
> > > > > +                                       C(OP_PREFETCH), C(LL), SB=
I_PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D=
 {C(RESULT_MISS),
> > > > > +                                       C(OP_PREFETCH), C(LL), SB=
I_PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +               },
> > > > > +       },
> > > > > +       [C(DTLB)] =3D {
> > > > > +               [C(OP_READ)] =3D {
> > > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =
=3D {C(RESULT_ACCESS),
> > > > > +                                       C(OP_READ), C(DTLB), SBI_=
PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D=
 {C(RESULT_MISS),
> > > > > +                                       C(OP_READ), C(DTLB), SBI_=
PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +               },
> > > > > +               [C(OP_WRITE)] =3D {
> > > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =
=3D {C(RESULT_ACCESS),
> > > > > +                                       C(OP_WRITE), C(DTLB), SBI=
_PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D=
 {C(RESULT_MISS),
> > > > > +                                       C(OP_WRITE), C(DTLB), SBI=
_PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +               },
> > > > > +               [C(OP_PREFETCH)] =3D {
> > > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =
=3D {C(RESULT_ACCESS),
> > > > > +                                       C(OP_PREFETCH), C(DTLB), =
SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D=
 {C(RESULT_MISS),
> > > > > +                                       C(OP_PREFETCH), C(DTLB), =
SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +               },
> > > > > +       },
> > > > > +       [C(ITLB)] =3D {
> > > > > +               [C(OP_READ)] =3D {
> > > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =
=3D {C(RESULT_ACCESS),
> > > > > +                                       C(OP_READ), C(ITLB), SBI_=
PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D=
 {C(RESULT_MISS),
> > > > > +                                       C(OP_READ), C(ITLB), SBI_=
PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +               },
> > > > > +               [C(OP_WRITE)] =3D {
> > > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =
=3D {C(RESULT_ACCESS),
> > > > > +                                       C(OP_WRITE), C(ITLB), SBI=
_PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D=
 {C(RESULT_MISS),
> > > > > +                                       C(OP_WRITE), C(ITLB), SBI=
_PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +               },
> > > > > +               [C(OP_PREFETCH)] =3D {
> > > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =
=3D {C(RESULT_ACCESS),
> > > > > +                                       C(OP_PREFETCH), C(ITLB), =
SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D=
 {C(RESULT_MISS),
> > > > > +                                       C(OP_PREFETCH), C(ITLB), =
SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +               },
> > > > > +       },
> > > > > +       [C(BPU)] =3D {
> > > > > +               [C(OP_READ)] =3D {
> > > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =
=3D {C(RESULT_ACCESS),
> > > > > +                                       C(OP_READ), C(BPU), SBI_P=
MU_EVENT_TYPE_CACHE, 0}},
> > > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D=
 {C(RESULT_MISS),
> > > > > +                                       C(OP_READ), C(BPU), SBI_P=
MU_EVENT_TYPE_CACHE, 0}},
> > > > > +               },
> > > > > +               [C(OP_WRITE)] =3D {
> > > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =
=3D {C(RESULT_ACCESS),
> > > > > +                                       C(OP_WRITE), C(BPU), SBI_=
PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D=
 {C(RESULT_MISS),
> > > > > +                                       C(OP_WRITE), C(BPU), SBI_=
PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +               },
> > > > > +               [C(OP_PREFETCH)] =3D {
> > > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =
=3D {C(RESULT_ACCESS),
> > > > > +                                       C(OP_PREFETCH), C(BPU), S=
BI_PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D=
 {C(RESULT_MISS),
> > > > > +                                       C(OP_PREFETCH), C(BPU), S=
BI_PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +               },
> > > > > +       },
> > > > > +       [C(NODE)] =3D {
> > > > > +               [C(OP_READ)] =3D {
> > > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =
=3D {C(RESULT_ACCESS),
> > > > > +                                       C(OP_READ), C(NODE), SBI_=
PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D=
 {C(RESULT_MISS),
> > > > > +                                       C(OP_READ), C(NODE), SBI_=
PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +               },
> > > > > +               [C(OP_WRITE)] =3D {
> > > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =
=3D {C(RESULT_ACCESS),
> > > > > +                                       C(OP_WRITE), C(NODE), SBI=
_PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D=
 {C(RESULT_MISS),
> > > > > +                                       C(OP_WRITE), C(NODE), SBI=
_PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +               },
> > > > > +               [C(OP_PREFETCH)] =3D {
> > > > > +                       [C(RESULT_ACCESS)] =3D {.hw_cache_event =
=3D {C(RESULT_ACCESS),
> > > > > +                                       C(OP_PREFETCH), C(NODE), =
SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +                       [C(RESULT_MISS)] =3D {.hw_cache_event =3D=
 {C(RESULT_MISS),
> > > > > +                                       C(OP_PREFETCH), C(NODE), =
SBI_PMU_EVENT_TYPE_CACHE, 0}},
> > > > > +               },
> > > > > +       },
> > > > > +};
> > > > > +
> > >
> > > Currently, when the user uses the perf list command as below:
> > > # perf list
> > > List of pre-defined events (to be used in -e):
> > >
> > >   branch-instructions OR branches         [Hardware event]
> > >   branch-misses                                      [Hardware event]
> > >   bus-cycles                                            [Hardware eve=
nt]
> > >   cache-misses                                       [Hardware event]
> > >   cache-references                                 [Hardware event]
> > >   cpu-cycles OR cycles                          [Hardware event]
> > >   instructions                                          [Hardware eve=
nt]
> > >   ref-cycles                                             [Hardware ev=
ent]
> > >   stalled-cycles-backend OR idle-cycles-backend      [Hardware event]
> > >   stalled-cycles-frontend OR idle-cycles-frontend    [Hardware event]
> > > ....
> > >   L1-dcache-load-misses                            [Hardware cache ev=
ent]
> > >   L1-dcache-loads                                       [Hardware cac=
he event]
> > >   L1-dcache-prefetch-misses                      [Hardware cache even=
t]
> > >   L1-dcache-prefetches                              [Hardware cache e=
vent]
> > >   L1-dcache-store-misses                           [Hardware cache ev=
ent]
> > >   L1-dcache-stores                                     [Hardware cach=
e event]
> > >   L1-icache-load-misses                             [Hardware cache e=
vent]
> > >   L1-icache-loads                                       [Hardware cac=
he event]
> > >   L1-icache-prefetch-misses                       [Hardware cache eve=
nt]
> > >   L1-icache-prefetches                               [Hardware cache =
event]
> > > ...
> > >
> > > it will show all standard hardware and cache events on the perf list.
> > > As I understand, the spec didn't define whether the vendor should
> > > support all standard hardware and cache events.
> > > Vendors may not support all of the standard hardware and cache events=
.
> > > So, if the user uses the unsupported hardware
> > > events, it will show <not counted> as a result, which will make the
> > > user get confused.
> > >
> > > May I ask if there is a way for the vendor to dynamically configure
> > > supported events or disable unsupported events?
> > >
> >
> > These are standard perf events that are enabled in perf. For vendor
> > specific raw events,
> > you can tweak the perf tool to do that. Here is the series from Jo=C3=
=A3o
> > M=C3=A1rio to enable those on unmatched.
> >
> > https://lore.kernel.org/all/20211109102555.16381-1-joao.mario@tecnico.u=
lisboa.pt/
> >
>
> Thanks for the information.
>
> For standard hardware and cache events, they are all enabled and
> hardcore in the pmu driver.
> And current implementation will make the perf list command show all
> the standard hardware and cache events.
>
> But vendors may not support all of standard hardware and cache events.
> When the user uses a perf list command, the perf tool queries pmu
> driver whether standard hardware and cache events
> are supported and shown on the list. If the user uses a platform not
> supported events on the list,
> it will show <not counted> as a result, which makes the user get confused=
.
>
> As I understand, we can use HW_OP_UNSUPPORTED flag to make it
> unsupported as below and the perf list won't show this event
> But it still needs to be hardcore in the driver.
>
> @@ -72,9 +75,7 @@ static const struct pmu_event_data pmu_hw_event_map[] =
=3D {
> ....
> -       [PERF_COUNT_HW_CACHE_REFERENCES]        =3D {.hw_gen_event =3D {
> -
> SBI_PMU_HW_CACHE_REFERENCES,
> -
> SBI_PMU_EVENT_TYPE_HW, 0}},
> +       [PERF_COUNT_HW_CACHE_REFERENCES]        =3D {.event_idx =3D
> HW_OP_UNSUPPORTED},
>
> I'm wondering if there is a way for the vendor to dynamically
> configure or disable unsupported standard hardware and cache events?
>

I guess we can have vendor specific mappings mechanism instead of a global =
one.
Jo=C3=A3o already added the support to provide vendor specific details in
the driver. We can extend that
to provide vendor specific mapping. The driver code will only use the
default global one in case
a vendor specific is not available.

As this is an improvement on top of the series, I would like to get
this series merged first so that baseline
code is available upstream. We can have a followup series to address
your request.

If you have some free cycles, please feel free to send the patches.

> Thanks,
> Eric Lin
>
> > > Thanks,
> > > Eric Lin
> > >
> > > > > +static int pmu_sbi_ctr_get_width(int idx)
> > > > > +{
> > > > > +       return pmu_ctr_list[idx].width;
> > > > > +}
> > > > > +
> > > > > +static int pmu_sbi_ctr_get_idx(struct perf_event *event)
> > > > > +{
> > > > > +       struct hw_perf_event *hwc =3D &event->hw;
> > > > > +       struct riscv_pmu *rvpmu =3D to_riscv_pmu(event->pmu);
> > > > > +       struct cpu_hw_events *cpuc =3D this_cpu_ptr(rvpmu->hw_eve=
nts);
> > > > > +       struct sbiret ret;
> > > > > +       int idx;
> > > > > +       uint64_t cbase =3D 0;
> > > > > +       uint64_t cmask =3D GENMASK_ULL(rvpmu->num_counters - 1, 0=
);
> > > > > +       unsigned long cflags =3D 0;
> > > > > +
> > > > > +       if (event->attr.exclude_kernel)
> > > > > +               cflags |=3D SBI_PMU_CFG_FLAG_SET_SINH;
> > > > > +       else if (event->attr.exclude_user)
> > > > > +               cflags |=3D SBI_PMU_CFG_FLAG_SET_UINH;
> > > > > +
> > > > > +       /* retrieve the available counter index */
> > > > > +       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MA=
TCH, cbase, cmask,
> > > > > +                       cflags, hwc->event_base, hwc->config, 0);
> > > > > +       if (ret.error) {
> > > > > +               pr_debug("Not able to find a counter for event %l=
x config %llx\n",
> > > > > +                       hwc->event_base, hwc->config);
> > > > > +               return sbi_err_map_linux_errno(ret.error);
> > > > > +       }
> > > > > +
> > > > > +       idx =3D ret.value;
> > > > > +       if (idx >=3D rvpmu->num_counters || !pmu_ctr_list[idx].va=
lue)
> > > > > +               return -ENOENT;
> > > > > +
> > > > > +       /* Additional sanity check for the counter id */
> > > > > +       if (!test_and_set_bit(idx, cpuc->used_event_ctrs))
> > > > > +               return idx;
> > > > > +       else
> > > > > +               return -ENOENT;
> > > > > +}
> > > > > +
> > > > > +static void pmu_sbi_ctr_clear_idx(struct perf_event *event)
> > > > > +{
> > > > > +
> > > > > +       struct hw_perf_event *hwc =3D &event->hw;
> > > > > +       struct riscv_pmu *rvpmu =3D to_riscv_pmu(event->pmu);
> > > > > +       struct cpu_hw_events *cpuc =3D this_cpu_ptr(rvpmu->hw_eve=
nts);
> > > > > +       int idx =3D hwc->idx;
> > > > > +
> > > > > +       clear_bit(idx, cpuc->used_event_ctrs);
> > > > > +}
> > > > > +
> > > > > +static int pmu_event_find_cache(u64 config)
> > > > > +{
> > > > > +       unsigned int cache_type, cache_op, cache_result, ret;
> > > > > +
> > > > > +       cache_type =3D (config >>  0) & 0xff;
> > > > > +       if (cache_type >=3D PERF_COUNT_HW_CACHE_MAX)
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       cache_op =3D (config >>  8) & 0xff;
> > > > > +       if (cache_op >=3D PERF_COUNT_HW_CACHE_OP_MAX)
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       cache_result =3D (config >> 16) & 0xff;
> > > > > +       if (cache_result >=3D PERF_COUNT_HW_CACHE_RESULT_MAX)
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       ret =3D pmu_cache_event_map[cache_type][cache_op][cache_r=
esult].event_idx;
> > > > > +
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > > +static bool pmu_sbi_is_fw_event(struct perf_event *event)
> > > > > +{
> > > > > +       u32 type =3D event->attr.type;
> > > > > +       u64 config =3D event->attr.config;
> > > > > +
> > > > > +       if ((type =3D=3D PERF_TYPE_RAW) && ((config >> 63) =3D=3D=
 1))
> > > > > +               return true;
> > > > > +       else
> > > > > +               return false;
> > > > > +}
> > > > > +
> > > > > +static int pmu_sbi_event_map(struct perf_event *event, u64 *econ=
fig)
> > > > > +{
> > > > > +       u32 type =3D event->attr.type;
> > > > > +       u64 config =3D event->attr.config;
> > > > > +       int bSoftware;
> > > > > +       u64 raw_config_val;
> > > > > +       int ret;
> > > > > +
> > > > > +       switch (type) {
> > > > > +       case PERF_TYPE_HARDWARE:
> > > > > +               if (config >=3D PERF_COUNT_HW_MAX)
> > > > > +                       return -EINVAL;
> > > > > +               ret =3D pmu_hw_event_map[event->attr.config].even=
t_idx;
> > > > > +               break;
> > > > > +       case PERF_TYPE_HW_CACHE:
> > > > > +               ret =3D pmu_event_find_cache(config);
> > > > > +               break;
> > > > > +       case PERF_TYPE_RAW:
> > > > > +               /*
> > > > > +                * As per SBI specification, the upper 16 bits mu=
st be unused for
> > > > > +                * a raw event. Use the MSB (63b) to distinguish =
between hardware
> > > > > +                * raw event and firmware events.
> > > > > +                */
> > > > > +               bSoftware =3D config >> 63;
> > > > > +               raw_config_val =3D config & RISCV_PMU_RAW_EVENT_M=
ASK;
> > > > > +               if (bSoftware) {
> > > > > +                       if (raw_config_val < SBI_PMU_FW_MAX)
> > > > > +                               ret =3D (raw_config_val & 0xFFFF)=
 |
> > > > > +                                     (SBI_PMU_EVENT_TYPE_FW << 1=
6);
> > > > > +                       else
> > > > > +                               return -EINVAL;
> > > > > +               } else {
> > > > > +                       ret =3D RISCV_PMU_RAW_EVENT_IDX;
> > > > > +                       *econfig =3D raw_config_val;
> > > > > +               }
> > > > > +               break;
> > > > > +       default:
> > > > > +               ret =3D -EINVAL;
> > > > > +               break;
> > > > > +       }
> > > > > +
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > > +static u64 pmu_sbi_ctr_read(struct perf_event *event)
> > > > > +{
> > > > > +       struct hw_perf_event *hwc =3D &event->hw;
> > > > > +       int idx =3D hwc->idx;
> > > > > +       struct sbiret ret;
> > > > > +       union sbi_pmu_ctr_info info;
> > > > > +       u64 val =3D 0;
> > > > > +
> > > > > +       if (pmu_sbi_is_fw_event(event)) {
> > > > > +               ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTE=
R_FW_READ,
> > > > > +                               hwc->idx, 0, 0, 0, 0, 0);
> > > > > +               if (!ret.error)
> > > > > +                       val =3D ret.value;
> > > > > +       } else {
> > > > > +               info =3D pmu_ctr_list[idx];
> > > > > +               val =3D riscv_pmu_ctr_read_csr(info.csr);
> > > > > +               if (IS_ENABLED(CONFIG_32BIT))
> > > > > +                       val =3D ((u64)riscv_pmu_ctr_read_csr(info=
.csr + 0x80)) << 31 | val;
> > > > > +       }
> > > > > +
> > > > > +       return val;
> > > > > +}
> > > > > +
> > > > > +static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival=
)
> > > > > +{
> > > > > +       struct sbiret ret;
> > > > > +       struct hw_perf_event *hwc =3D &event->hw;
> > > > > +       unsigned long flag =3D SBI_PMU_START_FLAG_SET_INIT_VALUE;
> > > > > +
> > > > > +       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START,=
 hwc->idx,
> > > > > +                       1, flag, ival, ival >> 32, 0);
> > > > > +       if (ret.error && (ret.error !=3D SBI_ERR_ALREADY_STARTED)=
)
> > > > > +               pr_err("Starting counter idx %d failed with error=
 %d\n",
> > > > > +                       hwc->idx, sbi_err_map_linux_errno(ret.err=
or));
> > > > > +}
> > > > > +
> > > > > +static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned =
long flag)
> > > > > +{
> > > > > +       struct sbiret ret;
> > > > > +       struct hw_perf_event *hwc =3D &event->hw;
> > > > > +
> > > > > +       //disable IRQ
> > > > > +       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, =
hwc->idx, 1, flag, 0, 0, 0);
> > > > > +       if (ret.error && (ret.error !=3D SBI_ERR_ALREADY_STOPPED)=
 &&
> > > > > +               flag !=3D SBI_PMU_STOP_FLAG_RESET)
> > > > > +               pr_err("Stopping counter idx %d failed with error=
 %d\n",
> > > > > +                       hwc->idx, sbi_err_map_linux_errno(ret.err=
or));
> > > > > +}
> > > > > +
> > > > > +static int pmu_sbi_find_num_ctrs(void)
> > > > > +{
> > > > > +       struct sbiret ret;
> > > > > +
> > > > > +       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_NUM_COUNTERS, =
0, 0, 0, 0, 0, 0);
> > > > > +       if (!ret.error)
> > > > > +               return ret.value;
> > > > > +       else
> > > > > +               return sbi_err_map_linux_errno(ret.error);
> > > > > +}
> > > > > +
> > > > > +static int pmu_sbi_get_ctrinfo(int nctr)
> > > > > +{
> > > > > +       struct sbiret ret;
> > > > > +       int i, num_hw_ctr =3D 0, num_fw_ctr =3D 0;
> > > > > +       union sbi_pmu_ctr_info cinfo;
> > > > > +
> > > > > +       pmu_ctr_list =3D kcalloc(nctr, sizeof(*pmu_ctr_list), GFP=
_KERNEL);
> > > > > +       if (!pmu_ctr_list)
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       for (i =3D 0; i <=3D nctr; i++) {
> > > > > +               ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTE=
R_GET_INFO, i, 0, 0, 0, 0, 0);
> > > > > +               if (ret.error)
> > > > > +                       /* The logical counter ids are not expect=
ed to be contiguous */
> > > > > +                       continue;
> > > > > +               cinfo.value =3D ret.value;
> > > > > +               if (cinfo.type =3D=3D SBI_PMU_CTR_TYPE_FW)
> > > > > +                       num_fw_ctr++;
> > > > > +               else
> > > > > +                       num_hw_ctr++;
> > > > > +               pmu_ctr_list[i].value =3D cinfo.value;
> > > > > +       }
> > > > > +
> > > > > +       pr_info("There are %d firmware & %d hardware counters ava=
ilable\n",
> > > > > +               num_fw_ctr, num_hw_ctr);
> > > >
> > > > Replace this with:
> > > > pr_info("%d firmware and %d hardware counters\n", num_fw_ctr, num_h=
w_ctr);
> > > >
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_n=
ode *node)
> > > > > +{
> > > > > +       struct riscv_pmu *pmu =3D hlist_entry_safe(node, struct r=
iscv_pmu, node);
> > > > > +
> > > > > +       /* Enable the access for TIME csr only from the user mode=
 now */
> > > > > +       csr_write(CSR_SCOUNTEREN, 0x2);
> > > > > +
> > > > > +       /* Stop all the counters so that they can be enabled from=
 perf */
> > > > > +       sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
> > > > > +                 0, GENMASK_ULL(pmu->num_counters - 1, 0), 0, 0,=
 0, 0);
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node=
 *node)
> > > > > +{
> > > > > +       /* Disable all counters access for user mode now */
> > > > > +       csr_write(CSR_SCOUNTEREN, 0x0);
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static int pmu_sbi_device_probe(struct platform_device *pdev)
> > > > > +{
> > > > > +       struct riscv_pmu *pmu =3D NULL;
> > > > > +       int num_counters;
> > > > > +       int ret;
> > > > > +
> > > > > +       pr_info("SBI PMU extension is available\n");
> > > > > +       /* Notify legacy implementation that SBI pmu is available=
*/
> > > > > +       riscv_pmu_legacy_init(true);
> > > > > +       pmu =3D riscv_pmu_alloc();
> > > > > +       if (!pmu)
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       num_counters =3D pmu_sbi_find_num_ctrs();
> > > > > +       if (num_counters < 0) {
> > > > > +               pr_err("SBI PMU extension doesn't provide any cou=
nters\n");
> > > > > +               return -ENODEV;
> > > > > +       }
> > > > > +
> > > > > +       /* cache all the information about counters now */
> > > > > +       if (pmu_sbi_get_ctrinfo(num_counters))
> > > > > +               return -ENODEV;
> > > > > +
> > > > > +       pmu->num_counters =3D num_counters;
> > > > > +       pmu->ctr_start =3D pmu_sbi_ctr_start;
> > > > > +       pmu->ctr_stop =3D pmu_sbi_ctr_stop;
> > > > > +       pmu->event_map =3D pmu_sbi_event_map;
> > > > > +       pmu->ctr_get_idx =3D pmu_sbi_ctr_get_idx;
> > > > > +       pmu->ctr_get_width =3D pmu_sbi_ctr_get_width;
> > > > > +       pmu->ctr_clear_idx =3D pmu_sbi_ctr_clear_idx;
> > > > > +       pmu->ctr_read =3D pmu_sbi_ctr_read;
> > > > > +
> > > > > +       ret =3D cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STAR=
TING, &pmu->node);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > > +
> > > > > +       ret =3D perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW=
);
> > > > > +       if (ret) {
> > > > > +               cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_S=
TARTING, &pmu->node);
> > > > > +               return ret;
> > > > > +       }
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static struct platform_driver pmu_sbi_driver =3D {
> > > > > +       .probe          =3D pmu_sbi_device_probe,
> > > > > +       .driver         =3D {
> > > > > +               .name   =3D RISCV_PMU_PDEV_NAME,
> > > > > +       },
> > > > > +};
> > > > > +
> > > > > +static int __init pmu_sbi_devinit(void)
> > > > > +{
> > > > > +       int ret;
> > > > > +       struct platform_device *pdev;
> > > > > +
> > > > > +       if (((sbi_major_version() =3D=3D 0) && (sbi_minor_version=
() < 3)) ||
> > > >
> > > > Compare SBI version using sbi_spec_version and sbi_mk_version()
> > > >
> > > > sbi_mk_version() is added by Linux SRST patch.
> > > >
> > > > > +               sbi_probe_extension(SBI_EXT_PMU) <=3D 0) {
> > > > > +               return 0;
> > > > > +       }
> > > > > +
> > > > > +       ret =3D cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_START=
ING,
> > > > > +                                     "perf/riscv/pmu:starting",
> > > > > +                                     pmu_sbi_starting_cpu, pmu_s=
bi_dying_cpu);
> > > > > +       if (ret) {
> > > > > +               pr_err("CPU hotplug notifier for RISC-V PMU could=
 not be registered: %d\n",
> > > > > +                      ret);
> > > >
> > > > Drop the "RISC-V PMU" in the pr_err().
> > > >
> > > > > +               return ret;
> > > > > +       }
> > > > > +
> > > > > +       ret =3D platform_driver_register(&pmu_sbi_driver);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > > +
> > > > > +       pdev =3D platform_device_register_simple(RISCV_PMU_PDEV_N=
AME, -1, NULL, 0);
> > > > > +       if (IS_ERR(pdev)) {
> > > > > +               platform_driver_unregister(&pmu_sbi_driver);
> > > > > +               return PTR_ERR(pdev);
> > > > > +       }
> > > > > +
> > > > > +       return ret;
> > > > > +}
> > > > > +device_initcall(pmu_sbi_devinit)
> > > > > --
> > > > > 2.33.1
> > > > >
> > > >
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> >
> >
> > --
> > Regards,
> > Atish



--=20
Regards,
Atish
