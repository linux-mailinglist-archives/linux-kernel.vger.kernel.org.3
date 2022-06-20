Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8AA5517F1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbiFTMBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240445AbiFTMBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:01:12 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB1126C4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:01:11 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id b7so11648283ljr.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RELZ48tdINLiJ7oRIphqtUqBQp/m2ZnJE4ag9EyIEdE=;
        b=BpFXMUKsQnMnHAlcOEOWAA0qdjsO/jqf16/HCSanER80jjZi+mADHa+M3iAl9OdDzB
         PvCauCAcYEqe/PBMTW9Ru1vq6rB87hX62bNBJovb4K4OjxtGmZxHiOHgYJssjM0eilVI
         rgymKsD63jcjZJkJUxpOzlAoXaLzoYJ0e39M1ak+C8xCn1LURS2uwhPuxkKUNQ4ra2/l
         IYZ69G/G9Ho43O5VlDQvL2CgPU9FeRV7JBkoNUJX8KJvoQwQXRvwjx4mCnVNam3Z+czr
         zuqMCoPUfzMa+fO3kVTfKrFCSTRJIL97kYepOxyO0FEq0iNR2qMIUnCaq2xsI6/I2zHg
         C9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RELZ48tdINLiJ7oRIphqtUqBQp/m2ZnJE4ag9EyIEdE=;
        b=2ZDq6gErFK8PeiVSsQH7oaqoYb4im01PiisnpDAIkKMlkbwTKhGtWoQ8BsjiqUypLC
         NKiYxk8uz6scrS7BROU/8BG15h7GflWfSqWbZ28SymF7WivTuG5yFVmy3kxzkj60tKk6
         +89ye1Rp1SoHr+tPgc+o5/bEb0BsmYsSNIoRTaUvX+6CRHVurJVnD5spXHnrdUdqLL1U
         aLkWetN7rjz1LAZHJ2wjRe4Bso9Ufy6hmGjDsPhsficwyVgJEzi3mGuK99OxAbfJEpGk
         4/pqyBlHTxbxzN1ztBzDBBjSm19zNVIKJS8oOUdB/r54EYC8oAHuaBIMMIJzFuZ6VDdo
         Wc8g==
X-Gm-Message-State: AJIora+xXP49rs5jrugyWIbJwgKbAYfyYnJ9gbAdLh1RdGtHg07QXqQZ
        RfzfiKOeOKGd/rC8APKn0OBIt0nvidldA4IWxwQeTg==
X-Google-Smtp-Source: AGRyM1t3kCfZUBu+7Zyuh/+Yx/Ni2dDy8M8FTpyJHfVBAHZt9He9PnoI3iyDCjZ4HkKWBvi6WdodL/FD0nSu3pws0c8=
X-Received: by 2002:a2e:a236:0:b0:259:c94:3144 with SMTP id
 i22-20020a2ea236000000b002590c943144mr11361200ljm.466.1655726469519; Mon, 20
 Jun 2022 05:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220619111115.6354-1-nikita.shubin@maquefel.me> <20220619111115.6354-2-nikita.shubin@maquefel.me>
In-Reply-To: <20220619111115.6354-2-nikita.shubin@maquefel.me>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Mon, 20 Jun 2022 17:30:58 +0530
Message-ID: <CAK9=C2X4TTCEjZya4wz-W6ndBaxzUpLBtzQAGJ4zphVM8NSgdg@mail.gmail.com>
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

On Sun, Jun 19, 2022 at 4:41 PM Nikita Shubin <nikita.shubin@maquefel.me> w=
rote:
>
> From: Nikita Shubin <n.shubin@yadro.com>
>
> Provide RISC-V SBI PMU id to distinguish different cores or SoCs via
> "devices/platform/riscv-pmu/id" sysfs entry.
>
> The identification is generated as string of marchid, mimpid, mvendorid
> in hex format separated by coma - "0x70032,0x70032,0x0".
>
> The CSRs are detailed in the RISC-V privileged spec [1].
> [1] https://github.com/riscv/riscv-isa-manual
>
> Inspired-by: Jo=C3=A3o M=C3=A1rio Domingos <joao.mario@tecnico.ulisboa.pt=
>
> Signed-off-by: Nikita Shubin <n.shubin@yadro.com>

The mvendorid, marchid, and mimpid can be useful to apps other than
perf tool.

I have tried to extend /proc/cpuinfo with this information which can be
parsed by perf tool:
https://lore.kernel.org/all/20220620115549.1529597-1-apatel@ventanamicro.co=
m/

Regards,
Anup

> ---
> v3->v4:
> - use string for pmuid
> - rename pmu_sbi_id_show to id_show
> - fix error print message in id_show
> - fix DEVICE_ATTR to use octal permissions
> ---
>  arch/riscv/kernel/sbi.c        |  3 +++
>  drivers/perf/riscv_pmu_sbi.c   | 41 ++++++++++++++++++++++++++++++++++
>  include/linux/perf/riscv_pmu.h |  1 +
>  3 files changed, 45 insertions(+)
>
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 775d3322b422..50dd9b6ecc9e 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -627,16 +627,19 @@ long sbi_get_mvendorid(void)
>  {
>         return __sbi_base_ecall(SBI_EXT_BASE_GET_MVENDORID);
>  }
> +EXPORT_SYMBOL(sbi_get_mvendorid);
>
>  long sbi_get_marchid(void)
>  {
>         return __sbi_base_ecall(SBI_EXT_BASE_GET_MARCHID);
>  }
> +EXPORT_SYMBOL(sbi_get_marchid);
>
>  long sbi_get_mimpid(void)
>  {
>         return __sbi_base_ecall(SBI_EXT_BASE_GET_MIMPID);
>  }
> +EXPORT_SYMBOL(sbi_get_mimpid);
>
>  static void sbi_send_cpumask_ipi(const struct cpumask *target)
>  {
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index dca3537a8dcc..be812f855617 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -693,6 +693,28 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu,=
 struct platform_device *pde
>         return 0;
>  }
>
> +static ssize_t id_show(struct device *dev,
> +                               struct device_attribute *attr, char *buf)
> +{
> +       int len;
> +       struct riscv_pmu *pmu =3D container_of(dev_get_drvdata(dev), stru=
ct riscv_pmu, pmu);
> +
> +       len =3D sprintf(buf, "%s\n", pmu->pmuid);
> +       if (len <=3D 0)
> +               dev_err(dev, "invalid sprintf len: %d\n", len);
> +
> +       return len;
> +}
> +
> +static DEVICE_ATTR(id, 0644, id_show, NULL);
> +
> +static struct attribute *pmu_sbi_attrs[] =3D {
> +       &dev_attr_id.attr,
> +       NULL
> +};
> +
> +ATTRIBUTE_GROUPS(pmu_sbi);
> +
>  static int pmu_sbi_device_probe(struct platform_device *pdev)
>  {
>         struct riscv_pmu *pmu =3D NULL;
> @@ -714,6 +736,14 @@ static int pmu_sbi_device_probe(struct platform_devi=
ce *pdev)
>         if (pmu_sbi_get_ctrinfo(num_counters))
>                 goto out_free;
>
> +       /* fill pmuid */
> +       pmu->pmuid =3D kasprintf(GFP_KERNEL, "0x%lx,0x%lx,0x%lx",
> +                              sbi_get_marchid(),
> +                              sbi_get_mimpid(),
> +                              sbi_get_mvendorid());
> +       if (!pmu->pmuid)
> +               goto out_free_pmuid;
> +
>         ret =3D pmu_sbi_setup_irqs(pmu, pdev);
>         if (ret < 0) {
>                 pr_info("Perf sampling/filtering is not supported as ssco=
f extension is not available\n");
> @@ -739,8 +769,19 @@ static int pmu_sbi_device_probe(struct platform_devi=
ce *pdev)
>                 return ret;
>         }
>
> +       ret =3D sysfs_create_group(&pdev->dev.kobj, &pmu_sbi_group);
> +       if (ret) {
> +               dev_err(&pdev->dev, "sysfs creation failed\n");
> +               return ret;
> +       }
> +
> +       pdev->dev.groups =3D pmu_sbi_groups;
> +       dev_set_drvdata(&pdev->dev, pmu);
> +
>         return 0;
>
> +out_free_pmuid:
> +       kfree(pmu->pmuid);
>  out_free:
>         kfree(pmu);
>         return ret;
> diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pm=
u.h
> index 46f9b6fe306e..cf3557b77fb8 100644
> --- a/include/linux/perf/riscv_pmu.h
> +++ b/include/linux/perf/riscv_pmu.h
> @@ -42,6 +42,7 @@ struct cpu_hw_events {
>  struct riscv_pmu {
>         struct pmu      pmu;
>         char            *name;
> +       char            *pmuid;
>
>         irqreturn_t     (*handle_irq)(int irq_num, void *dev);
>
> --
> 2.35.1
>
