Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02394D0D93
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 02:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344276AbiCHBi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240124AbiCHBi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:38:57 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA953B870
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 17:38:00 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id e188so2867655vkh.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 17:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ij/AkEfDv5c+gZ/Hw49jJ6Zfjg2iD1c1oULd+Hq/1sg=;
        b=GkRvfKDoJtb1D4SOy1dKZQJC+NQxREz5H54YAt/Qet4jq93U2YTSExX3fxLdZZTkEb
         ueEKR2Y2tmX+PmTuJBtXYEu1pYsmqMhiT7vQOjGurKZdREpR2DKf5uTmGGr3OQPE+1dS
         xlD5/GqJUZDoIcqn8vbA2C+YsVYSHRxAhLazGFjJ8D7jPIi6Om7/Sku7tUca6CQBNgGR
         qp3UejHbvyHb/n8NBpqrB1lDQnF7FtZKF28HkHP/VcL1HDh23McT4ZN8W/ypzIEi1tz2
         wK7rBgYho0ycGvUoOFsvL6nKwCvTGoPHRRk0mIIeRWKMZjxdYRMEU/JRuVqMvxrgTZhx
         sJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ij/AkEfDv5c+gZ/Hw49jJ6Zfjg2iD1c1oULd+Hq/1sg=;
        b=XPijq0IgHLPqw+NVLbrExoTbl4WqlxjgeLeiTyCVxiHo1mxbrYWqgdfE2n28yo/8vK
         5FafHVoBT1b+e/r/QSLn3ronrVBHNf56/EOMIZ6jEAS5Rps9Rif4x3F86NdS5nMScR9D
         kpiuDe0nC0EJ5Em2cHRSJ8aLdzFWhLKtIzrAquy3gPNpBEZUeC09svwX86vLMhzNNpVM
         85rZyNncG/aBXbomjiBG8wmz8UohXf1b0z0USWH/G9V+5Z64jr5g9l2IJMLROc0yNXXi
         hKIvgDYTBvq/th2x5MYHpFTlQw5SgSimMIWl+fn94PaCLGBC9I9Nps22GBzmcFOSntTC
         26WQ==
X-Gm-Message-State: AOAM5320kXnUUk3yrARsLvB/56FJcaV35oWlTV/YDDja4mIZesUFNFCY
        yiz+D451AHybVvp9mnYVTHRWsUw3ILLwOfK4Ftzaew==
X-Google-Smtp-Source: ABdhPJxkyrU3585uuiT7zyQCdk03t9k26tF94tQDKQRXGisHY5Tn6Esx5DqMG7IHgFWIVXvdaKtxH3x6RyAHM9TsL+U=
X-Received: by 2002:a05:6122:ca1:b0:330:b95b:e048 with SMTP id
 ba33-20020a0561220ca100b00330b95be048mr5804481vkb.39.1646703479658; Mon, 07
 Mar 2022 17:37:59 -0800 (PST)
MIME-Version: 1.0
References: <78615d08-1764-c895-f3b7-bfddfbcbdfb9@huawei.com>
 <87a6g8vp8k.wl-maz@kernel.org> <19d55cdf-9ef7-e4a3-5ae5-0970f0d7751b@huawei.com>
 <87v8yjyjc0.wl-maz@kernel.org> <87k0ey9122.wl-maz@kernel.org>
 <5f529b4e-1f6c-5a7d-236c-09ebe3a7db29@huawei.com> <1cbe7daa-8003-562b-06fa-5a50f7ee6ed2@huawei.com>
 <87a6e4tnkm.wl-maz@kernel.org> <452d97ed-459f-7936-99e4-600380608615@huawei.com>
 <87a6e1276p.wl-maz@kernel.org> <878rtl272y.wl-maz@kernel.org>
In-Reply-To: <878rtl272y.wl-maz@kernel.org>
From:   David Decotigny <ddecotig@google.com>
Date:   Mon, 7 Mar 2022 17:37:23 -0800
Message-ID: <CAG88wWYPxxi6m6B1gxyaPYbeQV3psK7QM1CnXN-E1P7_hRNTUA@mail.gmail.com>
Subject: Re: PCI MSI issue for maxcpus=1
To:     Marc Zyngier <maz@kernel.org>
Cc:     John Garry <john.garry@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        chenxiang <chenxiang66@hisilicon.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liuqi (BA)" <liuqi115@huawei.com>, wangxiongfeng2@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Marc! That solved the issue on our end as well.

On Mon, Mar 7, 2022 at 6:03 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 07 Mar 2022 14:01:02 +0000,
> Marc Zyngier <maz@kernel.org> wrote:
> >
> > Hi John,
> >
> > On Mon, 07 Mar 2022 13:48:11 +0000,
> > John Garry <john.garry@huawei.com> wrote:
> > >
> > > Hi Marc,
> > >
> > > >
> > > > diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> > > > index 2bdfce5edafd..97e9eb9aecc6 100644
> > > > --- a/kernel/irq/msi.c
> > > > +++ b/kernel/irq/msi.c
> > > > @@ -823,6 +823,19 @@ static int msi_init_virq(struct irq_domain *domain, int virq, unsigned int vflag
> > > >           if (!(vflags & VIRQ_ACTIVATE))
> > > >                   return 0;
> > > >   +       if (!(vflags & VIRQ_CAN_RESERVE)) {
> > > > +         /*
> > > > +          * If the interrupt is managed but no CPU is available
> > > > +          * to service it, shut it down until better times.
> > > > +          */
> > > > +         if (irqd_affinity_is_managed(irqd) &&
> > > > +             !cpumask_intersects(irq_data_get_affinity_mask(irqd),
> > > > +                                 cpu_online_mask)) {
> > > > +                 irqd_set_managed_shutdown(irqd);
> > > > +                 return 0;
> > > > +         }
> > > > + }
> > > > +
> > > >           ret = irq_domain_activate_irq(irqd, vflags & VIRQ_CAN_RESERVE);
> > > >           if (ret)
> > > >                   return ret;
> > > >
> > >
> > > Yeah, that seems to solve the issue. I will test it a bit more.
> >
> > Thanks. For the record, I have pushed a branch at [1]. The patch is
> > extremely similar, just moved up a tiny bit to avoid duplicating the
> > !VIRQ_CAN_RESERVE case.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/msi-shutdown-on-init
>
> --
> Without deviation from the norm, progress is not possible.
