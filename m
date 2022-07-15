Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA56576249
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 14:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbiGOMxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 08:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiGOMxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 08:53:03 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A51D3F33E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 05:53:00 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u15so5584953lji.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 05:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mZ8/Kk8xqn/U5Zrjxerr6PVmFRoxppi1f5l4YXjH124=;
        b=AqgMnti/3ci4pZB3t5vOFhvdOOvdinp8nteW99bMUL9UoGZvBjS3zbYfpTZGZKJLC6
         VZyB9PWCeIxHFCd8EnynW2jwuaR6AINfnilHhLMeWpabF9KlsOeLzQwHPEWk6erlUohM
         LyMctbNiV6n5hxdAnLx+hjwGLMZtdzhEx4dI1UrFd/d6nIp6sd14Vg1d6BfEQmvO/GvW
         4u619HFQzdkg67mP+warBlyStHC1STHui9EjjwfZgUD8H7UY/i6hVmFobmMVVWBR3fTs
         1jZuOjKqkjQViwR7AsJA4+DKpvEYMdkYYNFLdBWkM8aRyIefRwY3keOaLcvdvX6hjzNJ
         0BLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mZ8/Kk8xqn/U5Zrjxerr6PVmFRoxppi1f5l4YXjH124=;
        b=Nm01d2e21nXjYOsSjxcLXTIitW57k4e8FNbE8QbzGIwdniKK2lFv4GAgsvMuWJVrIK
         Bhf1eZqJ5F78xrSkJrghYbQtHHY03u6XgQHF/GeWDfKJO5pPocwkeTgh6U18PMM8lOnX
         +n9yiYH28n4oqe1U1TMG6hLc7Pan0bb9kE5RiUgLI/GRiHugXSy5qtFyJVv6q5Q8IQ/s
         /wGnE82OdtXs/N+LpjagTKbzETGfYaadt6LVFXHt3J8nqYeBtPY9S+zY8vMz1Vcc10l1
         EmKWla8mA27j7HaacnUQVHt1TGUFclVx15rn8P6A0ZrhoIZYisdpN+R/NobYSxVxYh15
         Wtwg==
X-Gm-Message-State: AJIora8vG4ZCxHgjUH9tQ+jDjH0Jc1jSHwybAFPbfetfSAypgzxJwbHu
        TRIvDDErQ0M0HbR9s7JcOWudYEBsqrWQkkzQKPJhrA==
X-Google-Smtp-Source: AGRyM1vo/rZ1Y8lzetNZ+AEXkDVRwUd7xeNG74T76sfD0ny/1O6Thm61O68lCXsWodd4aqOLumM6j2Ru2wyrbbdXm0A=
X-Received: by 2002:a2e:83c9:0:b0:24d:a95d:7b7a with SMTP id
 s9-20020a2e83c9000000b0024da95d7b7amr6811554ljh.254.1657889578650; Fri, 15
 Jul 2022 05:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220714165550.8884-1-semen.protsenko@linaro.org>
 <CGME20220714165604eucas1p28f7d938581361401c97135e2725f8c7e@eucas1p2.samsung.com>
 <20220714165550.8884-6-semen.protsenko@linaro.org> <6cdbc7ec-0cf9-8854-d0e2-36aedda544e2@samsung.com>
In-Reply-To: <6cdbc7ec-0cf9-8854-d0e2-36aedda544e2@samsung.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 15 Jul 2022 15:52:47 +0300
Message-ID: <CAPLW+4=9LJzF0xmAPy-nw2CowaN++Li2MV=SK1zM4e1+1soLtQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] iommu/exynos: Add SysMMU v7 register set
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 at 10:28, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Hi Sam,
>
> On 14.07.2022 18:55, Sam Protsenko wrote:
> > SysMMU v7 might have different register layouts (VM capable or non-VM
> > capable). Virtual Machine registers (if present) implement multiple
> > translation domains. If VM registers are not present, the driver
> > shouldn't try to access those.
> >
> > Check which layout is implemented in current SysMMU module (by reading
> > the capability registers) and prepare the corresponding variant
> > structure for further usage.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>
> Looks fine.
>
> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> What about the fault related code in the exynos_sysmmu_irq()? Afair v7
> has a bit different layout of the status bits.
>

Hi Marek,

Fault handling is exactly what I'm going to look into next. The idea
behind this series was to make SysMMU minimally functional on my
board, so I can proceed with adding more features on top of that
further. Thanks for your patch you shared btw, I'll try to use it.
Vendor's downstream kernel's got the whole separate .c file for that,
will check if anything can be reused from there too. Good thing my
testing driver [2] also allows generating page faults, so I can at
least verify if the added code works properly.

Thanks!

[1] https://github.com/joe-skb7/linux/blob/iommu-exynos850-dev/drivers/iommu/samsung-iommu-fault.c
[2] https://github.com/joe-skb7/linux/blob/e850-96-mainline-iommu/drivers/iommu/samsung-iommu-test.c

> > ---
> > Changes in v3:
> >    - Merged "Check if SysMMU v7 has VM registers" patch into this patch
> >    - Reworked for using variant struct (instead of array)
> >
> > Changes in v2:
> >    - (none) This patch is new and added in v2
> >
> >   drivers/iommu/exynos-iommu.c | 50 +++++++++++++++++++++++++++++++++---
> >   1 file changed, 47 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> > index 6a0299fe1722..fc9ef3ff0057 100644
> > --- a/drivers/iommu/exynos-iommu.c
> > +++ b/drivers/iommu/exynos-iommu.c
> > @@ -135,6 +135,9 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
> >   #define CFG_SYSSEL  (1 << 22) /* System MMU 3.2 only */
> >   #define CFG_FLPDCACHE       (1 << 20) /* System MMU 3.2+ only */
> >
> > +#define CAPA0_CAPA1_EXIST            BIT(11)
> > +#define CAPA1_VCR_ENABLED            BIT(14)
> > +
> >   /* common registers */
> >   #define REG_MMU_CTRL                0x000
> >   #define REG_MMU_CFG         0x004
> > @@ -157,6 +160,10 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
> >   #define REG_V5_FAULT_AR_VA  0x070
> >   #define REG_V5_FAULT_AW_VA  0x080
> >
> > +/* v7.x registers */
> > +#define REG_V7_CAPA0         0x870
> > +#define REG_V7_CAPA1         0x874
> > +
> >   #define has_sysmmu(dev)             (dev_iommu_priv_get(dev) != NULL)
> >
> >   static struct device *dma_dev;
> > @@ -276,6 +283,9 @@ struct sysmmu_drvdata {
> >
> >       struct iommu_device iommu;      /* IOMMU core handle */
> >       const struct sysmmu_variant *variant; /* version specific data */
> > +
> > +     /* v7 fields */
> > +     bool has_vcr;                   /* virtual machine control register */
> >   };
> >
> >   #define SYSMMU_REG(data, reg) ((data)->sfrbase + (data)->variant->reg)
> > @@ -289,7 +299,7 @@ static const struct sysmmu_variant sysmmu_v1_variant = {
> >       .int_clear      = 0x1c,
> >   };
> >
> > -/* SysMMU v5 */
> > +/* SysMMU v5 and v7 (non-VM capable) */
> >   static const struct sysmmu_variant sysmmu_v5_variant = {
> >       .pt_base        = 0x0c,
> >       .flush_all      = 0x10,
> > @@ -301,6 +311,18 @@ static const struct sysmmu_variant sysmmu_v5_variant = {
> >       .int_clear      = 0x64,
> >   };
> >
> > +/* SysMMU v7: VM capable register set */
> > +static const struct sysmmu_variant sysmmu_v7_vm_variant = {
> > +     .pt_base        = 0x800c,
> > +     .flush_all      = 0x8010,
> > +     .flush_entry    = 0x8014,
> > +     .flush_range    = 0x8018,
> > +     .flush_start    = 0x8020,
> > +     .flush_end      = 0x8024,
> > +     .int_status     = 0x60,
> > +     .int_clear      = 0x64,
> > +};
> > +
> >   static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
> >   {
> >       return container_of(dom, struct exynos_iommu_domain, domain);
> > @@ -380,6 +402,20 @@ static void __sysmmu_disable_clocks(struct sysmmu_drvdata *data)
> >       clk_disable_unprepare(data->clk_master);
> >   }
> >
> > +static bool __sysmmu_has_capa1(struct sysmmu_drvdata *data)
> > +{
> > +     u32 capa0 = readl(data->sfrbase + REG_V7_CAPA0);
> > +
> > +     return capa0 & CAPA0_CAPA1_EXIST;
> > +}
> > +
> > +static void __sysmmu_get_vcr(struct sysmmu_drvdata *data)
> > +{
> > +     u32 capa1 = readl(data->sfrbase + REG_V7_CAPA1);
> > +
> > +     data->has_vcr = capa1 & CAPA1_VCR_ENABLED;
> > +}
> > +
> >   static void __sysmmu_get_version(struct sysmmu_drvdata *data)
> >   {
> >       u32 ver;
> > @@ -397,10 +433,18 @@ static void __sysmmu_get_version(struct sysmmu_drvdata *data)
> >       dev_dbg(data->sysmmu, "hardware version: %d.%d\n",
> >               MMU_MAJ_VER(data->version), MMU_MIN_VER(data->version));
> >
> > -     if (MMU_MAJ_VER(data->version) < 5)
> > +     if (MMU_MAJ_VER(data->version) < 5) {
> >               data->variant = &sysmmu_v1_variant;
> > -     else
> > +     } else if (MMU_MAJ_VER(data->version) < 7) {
> >               data->variant = &sysmmu_v5_variant;
> > +     } else {
> > +             if (__sysmmu_has_capa1(data))
> > +                     __sysmmu_get_vcr(data);
> > +             if (data->has_vcr)
> > +                     data->variant = &sysmmu_v7_vm_variant;
> > +             else
> > +                     data->variant = &sysmmu_v5_variant;
> > +     }
> >
> >       __sysmmu_disable_clocks(data);
> >   }
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
