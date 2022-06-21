Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA497552C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347517AbiFUHvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiFUHvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:51:43 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9A02458B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:51:42 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t25so20963597lfg.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C43G7OP5T13FTpq18dv8vek6Xm2VVX3iEQqYB+pBnxQ=;
        b=caTdju9eo2lIZz5cmdYtRpSaBf3lqPh+AZOlRsDlj2vIrqJLKOuk0aUohUKl/6l0HC
         C7ONtVUasQadYAxv+N9ef90NLTdgw4IBlAdq4ZhwprBiXzSkI/1oJZQF2XzaV9PbClRG
         Y2M2DShadLkoS+dQkHB2xLkNi+22EaX15TGWJ+xWrekHFfWvnl86018YL0xhewS3UQSc
         zA3m1b/p9hdmShlkvg5/BvK47KYJzLHRhigSLaCuq2Z+kWrRPGaazgkS6Vk1zoLbM2ua
         sy3nyYolFFGwYCKTI/6gd7aOpso1+C7xNZhXYQ+uD66vh9LioLZCV0Mq6edsWfuFZqzl
         wihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C43G7OP5T13FTpq18dv8vek6Xm2VVX3iEQqYB+pBnxQ=;
        b=GkHCMFF2mAjtKln0B7movDbFFRGgviyqbc40DbAHknUrBbY7I4T8zVo90hB/BTVqtn
         Ujy/tYX5QsDkZLpJ43lnkoyv4/hDb9Pnjd9I91w758/2wJAyV32DATOSW38i15W6EREU
         feRk9H85cfe/6tO6W8lSlcV10OJPwM47YXUWHxDI6+FEWsR+qYhWenK1Yhp2YUsy5Yji
         kW63oPyLYmBl+62OPTYcx6C5ahmICHfUMCYMRwI1hKXbIppr4e3ULzfgfS1Kbr/r7e9p
         ONp6fzbp2oXqbh34rmyfyj5OBWaTXcEBQnHwz0wD5gwog83K/qGNK1HOHVJ1CFuQTjhO
         lnAw==
X-Gm-Message-State: AJIora91RZ7/GS4WndARtU5cHN/gxmJRklt+IN1EwZD01agNHdWOvtc3
        i9FKnssP6VQ8cS7wdoUkYBgBbSGcIagrQit2SQwoQw==
X-Google-Smtp-Source: AGRyM1txURs3R58y/o69nTNlDWo9qFx554cdLekLz8IA3BceaY4qBwfW1KSZOthWW8ybIACOruUQRGTQvga+tuY580E=
X-Received: by 2002:ac2:484d:0:b0:47f:7ebf:336 with SMTP id
 13-20020ac2484d000000b0047f7ebf0336mr1232541lfy.130.1655797900889; Tue, 21
 Jun 2022 00:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220619111115.6354-1-nikita.shubin@maquefel.me>
 <20220619111115.6354-2-nikita.shubin@maquefel.me> <CAK9=C2X4TTCEjZya4wz-W6ndBaxzUpLBtzQAGJ4zphVM8NSgdg@mail.gmail.com>
 <20220620174006.1c86a456@redslave.neermore.group> <CAOnJCU+7_z1WN_Z6frQcUwzztVL4itbPSfmLUa_7Ob5xCtLo+Q@mail.gmail.com>
 <20220621104139.7c77e348@redslave.neermore.group>
In-Reply-To: <20220621104139.7c77e348@redslave.neermore.group>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Tue, 21 Jun 2022 13:21:11 +0530
Message-ID: <CAK9=C2UiPdB2+UU6aqh5Muf0cnu87k01f1iga6mUYKZgiceAKQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] RISC-V: Create unique identification for SoC PMU
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Atish Patra <atishp@atishpatra.org>, Will Deacon <will@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        =?UTF-8?B?Sm/Do28gTcOhcmlvIERvbWluZ29z?= 
        <joao.mario@tecnico.ulisboa.pt>, linux <linux@yadro.com>,
        Nikita Shubin <n.shubin@yadro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Tue, Jun 21, 2022 at 1:13 PM Nikita Shubin <nikita.shubin@maquefel.me> w=
rote:
>
> Hello Anup!
>
> On Mon, 20 Jun 2022 12:40:20 -0700
> Atish Patra <atishp@atishpatra.org> wrote:
>
> > On Mon, Jun 20, 2022 at 7:40 AM Nikita Shubin
> > <nikita.shubin@maquefel.me> wrote:
> > >
> > > On Mon, 20 Jun 2022 17:30:58 +0530
> > > Anup Patel <apatel@ventanamicro.com> wrote:
> > >
> > > > On Sun, Jun 19, 2022 at 4:41 PM Nikita Shubin
> > > > <nikita.shubin@maquefel.me> wrote:
> > > > >
> > > > > From: Nikita Shubin <n.shubin@yadro.com>
> > > > >
> > > > > Provide RISC-V SBI PMU id to distinguish different cores or
> > > > > SoCs via "devices/platform/riscv-pmu/id" sysfs entry.
> > > > >
> > > > > The identification is generated as string of marchid, mimpid,
> > > > > mvendorid in hex format separated by coma -
> > > > > "0x70032,0x70032,0x0".
> > > > >
> > > > > The CSRs are detailed in the RISC-V privileged spec [1].
> > > > > [1] https://github.com/riscv/riscv-isa-manual
> > > > >
> > > > > Inspired-by: Jo=C3=A3o M=C3=A1rio Domingos <joao.mario@tecnico.ul=
isboa.pt>
> > > > > Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
> > > >
> > > > The mvendorid, marchid, and mimpid can be useful to apps other
> > > > than perf tool.
> > > >
> > > > I have tried to extend /proc/cpuinfo with this information which
> > > > can be parsed by perf tool:
> > > > https://lore.kernel.org/all/20220620115549.1529597-1-apatel@ventana=
micro.com/
> > > >
> > >
> > > Atish, what do you think about this ?
> > >
> > > RISC-V perf can rely on "/proc/cpuinfo", in some similar manner like
> > > "tools/perf/arch/s390/util/header.c" does.
> > >
> >
> > Yes. We can expose these three values either in sysfs or procfs
> > (/proc/cpuinfo). For perf tool, it shouldn't matter as the header.c
> > will need to generate the unique cpuid
> > string from either.
> >
> > I am not sure if any other userspace tool prefers to parse sysfs
> > instead of cpuinfo.
>
> Okay - let's stick to /proc/cpuinfo.

Sounds good.

You might have to write /proc/cpuinfo parsing code in perf tool
header.c. Do you plan to send v4 of perf tool patches ??

Regards,
Anup

>
> >
> > > Can it create problems with pmu identification in case of
> > > hetergenous harts ?
> > >
> >
> > Does perf support hetergenous harts at all ? ARM64 code
> > (tool/perf/arch/arm64/util/header.c)
> > just breaks out of the loop after finding the first MIDR.
> >
> > > >
> > > > Regards,
> > > > Anup
> > > >
> > > > > ---
> > > > > v3->v4:
> > > > > - use string for pmuid
> > > > > - rename pmu_sbi_id_show to id_show
> > > > > - fix error print message in id_show
> > > > > - fix DEVICE_ATTR to use octal permissions
> > > > > ---
> > > > >  arch/riscv/kernel/sbi.c        |  3 +++
> > > > >  drivers/perf/riscv_pmu_sbi.c   | 41
> > > > > ++++++++++++++++++++++++++++++++++
> > > > > include/linux/perf/riscv_pmu.h | 1 + 3 files changed, 45
> > > > > insertions(+)
> > > > >
> > > > > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > > > > index 775d3322b422..50dd9b6ecc9e 100644
> > > > > --- a/arch/riscv/kernel/sbi.c
> > > > > +++ b/arch/riscv/kernel/sbi.c
> > > > > @@ -627,16 +627,19 @@ long sbi_get_mvendorid(void)
> > > > >  {
> > > > >         return __sbi_base_ecall(SBI_EXT_BASE_GET_MVENDORID);
> > > > >  }
> > > > > +EXPORT_SYMBOL(sbi_get_mvendorid);
> > > > >
> > > > >  long sbi_get_marchid(void)
> > > > >  {
> > > > >         return __sbi_base_ecall(SBI_EXT_BASE_GET_MARCHID);
> > > > >  }
> > > > > +EXPORT_SYMBOL(sbi_get_marchid);
> > > > >
> > > > >  long sbi_get_mimpid(void)
> > > > >  {
> > > > >         return __sbi_base_ecall(SBI_EXT_BASE_GET_MIMPID);
> > > > >  }
> > > > > +EXPORT_SYMBOL(sbi_get_mimpid);
> > > > >
> > > > >  static void sbi_send_cpumask_ipi(const struct cpumask *target)
> > > > >  {
> > > > > diff --git a/drivers/perf/riscv_pmu_sbi.c
> > > > > b/drivers/perf/riscv_pmu_sbi.c index dca3537a8dcc..be812f855617
> > > > > 100644 --- a/drivers/perf/riscv_pmu_sbi.c
> > > > > +++ b/drivers/perf/riscv_pmu_sbi.c
> > > > > @@ -693,6 +693,28 @@ static int pmu_sbi_setup_irqs(struct
> > > > > riscv_pmu *pmu, struct platform_device *pde return 0;
> > > > >  }
> > > > >
> > > > > +static ssize_t id_show(struct device *dev,
> > > > > +                               struct device_attribute *attr,
> > > > > char *buf) +{
> > > > > +       int len;
> > > > > +       struct riscv_pmu *pmu =3D
> > > > > container_of(dev_get_drvdata(dev), struct riscv_pmu, pmu); +
> > > > > +       len =3D sprintf(buf, "%s\n", pmu->pmuid);
> > > > > +       if (len <=3D 0)
> > > > > +               dev_err(dev, "invalid sprintf len: %d\n", len);
> > > > > +
> > > > > +       return len;
> > > > > +}
> > > > > +
> > > > > +static DEVICE_ATTR(id, 0644, id_show, NULL);
> > > > > +
> > > > > +static struct attribute *pmu_sbi_attrs[] =3D {
> > > > > +       &dev_attr_id.attr,
> > > > > +       NULL
> > > > > +};
> > > > > +
> > > > > +ATTRIBUTE_GROUPS(pmu_sbi);
> > > > > +
> > > > >  static int pmu_sbi_device_probe(struct platform_device *pdev)
> > > > >  {
> > > > >         struct riscv_pmu *pmu =3D NULL;
> > > > > @@ -714,6 +736,14 @@ static int pmu_sbi_device_probe(struct
> > > > > platform_device *pdev) if (pmu_sbi_get_ctrinfo(num_counters))
> > > > >                 goto out_free;
> > > > >
> > > > > +       /* fill pmuid */
> > > > > +       pmu->pmuid =3D kasprintf(GFP_KERNEL, "0x%lx,0x%lx,0x%lx",
> > > > > +                              sbi_get_marchid(),
> > > > > +                              sbi_get_mimpid(),
> > > > > +                              sbi_get_mvendorid());
> > > > > +       if (!pmu->pmuid)
> > > > > +               goto out_free_pmuid;
> > > > > +
> > > > >         ret =3D pmu_sbi_setup_irqs(pmu, pdev);
> > > > >         if (ret < 0) {
> > > > >                 pr_info("Perf sampling/filtering is not
> > > > > supported as sscof extension is not available\n"); @@ -739,8
> > > > > +769,19 @@ static int pmu_sbi_device_probe(struct
> > > > > platform_device *pdev) return ret; }
> > > > >
> > > > > +       ret =3D sysfs_create_group(&pdev->dev.kobj,
> > > > > &pmu_sbi_group);
> > > > > +       if (ret) {
> > > > > +               dev_err(&pdev->dev, "sysfs creation failed\n");
> > > > > +               return ret;
> > > > > +       }
> > > > > +
> > > > > +       pdev->dev.groups =3D pmu_sbi_groups;
> > > > > +       dev_set_drvdata(&pdev->dev, pmu);
> > > > > +
> > > > >         return 0;
> > > > >
> > > > > +out_free_pmuid:
> > > > > +       kfree(pmu->pmuid);
> > > > >  out_free:
> > > > >         kfree(pmu);
> > > > >         return ret;
> > > > > diff --git a/include/linux/perf/riscv_pmu.h
> > > > > b/include/linux/perf/riscv_pmu.h index
> > > > > 46f9b6fe306e..cf3557b77fb8 100644 ---
> > > > > a/include/linux/perf/riscv_pmu.h +++
> > > > > b/include/linux/perf/riscv_pmu.h @@ -42,6 +42,7 @@ struct
> > > > > cpu_hw_events { struct riscv_pmu {
> > > > >         struct pmu      pmu;
> > > > >         char            *name;
> > > > > +       char            *pmuid;
> > > > >
> > > > >         irqreturn_t     (*handle_irq)(int irq_num, void *dev);
> > > > >
> > > > > --
> > > > > 2.35.1
> > > > >
> > >
> >
> >
>
