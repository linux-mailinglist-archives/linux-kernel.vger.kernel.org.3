Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6AF4DE7A5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 12:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242822AbiCSLlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 07:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237574AbiCSLlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 07:41:05 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B86199EDA
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 04:39:45 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id c15so14247214ljr.9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 04:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y5rb/Yqi5NN7XZ/MmiRVeK5TPw9M1I0RZCaA66Lu/5w=;
        b=KAPBlkaGiCLm9fcSwqKhNljOouS1ZmsBfDXkobBg2aZkvyDAqe8q+MXw+oNH5r+VY8
         3PQZAK48cKbABd9QS5gKUCURdcgo/lnSbHky5A5WTjTcylzSAQwzHM1E3CoGNyW4H4/Z
         laOJCo8vmhbk0lQa6l6Le4b72IbETDg9kr60QlgfXcEKoxdcxzJ6NWK5GmuMfjzNHVDw
         4QO06SbphYbjVAc+wglXcHVEQhuiu6y05BShmHMBvdVy9muQsZ9ZL2x86maRI8hONtVP
         2PbTrD3ckJRvwXWlZIKgywjJiIQy2QBq6ivPPezlX+ItzMcs6RtMABkG78DodSnj+w+I
         p56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y5rb/Yqi5NN7XZ/MmiRVeK5TPw9M1I0RZCaA66Lu/5w=;
        b=makLR3RinEaL5Qi7Rry92lYm/sowwvkJAS1qikMELtS0kriZzYNLJBgLBTB4scJG4/
         WMeTiC4OEkbkS7wGKyzF92yRJZW6Q/DoFYy35RB9y30CgyafJi/GQZagkDMW3VgTbp/j
         QNhD6wzy7pZbkrWSb3ON74t595h7BfqHzfNLxYhn4rC7P7ndexT0rZni8RDb4b5wKX04
         6GkL6KMN+tK9Yv7b5eWWQOSA4xvh1wuBtf57/9chTYSwbhIRJyNJ9gvoCGvDaab80IH5
         nNgafyVH5Ctkt581CQM9Ta+EQiIBAPv5fvmQ1p4M9P1hDkjmeQ9vkkna+5jAyCWzIZcs
         RoGA==
X-Gm-Message-State: AOAM530uhBHwYib0mtPK6xIDDcQFJOw4B9/jCR3n+In4yH+9fnhXfueN
        XPum4CRkIMqj8imv7Ad4ln4tQRbhWKbrcSEpDFqE/w==
X-Google-Smtp-Source: ABdhPJzROACa86AklSBYVBypFM4Wj7ORn2S6CpOACIDdXjNIhVDWVaICxTHt7pGEUv8kGzRGnNVXg/ZQKN8a8lgOiUE=
X-Received: by 2002:a05:651c:2123:b0:247:e3b1:da81 with SMTP id
 a35-20020a05651c212300b00247e3b1da81mr9197167ljq.34.1647689983405; Sat, 19
 Mar 2022 04:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220317035542.272547-1-apatel@ventanamicro.com>
 <f1079093-54db-bd20-3342-b06d069c5d1f@codethink.co.uk> <CAK8P3a0Gt7TOT2zpNw7YNR=MNLBWVAADL5dBgY15ZL8sDW20HQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0Gt7TOT2zpNw7YNR=MNLBWVAADL5dBgY15ZL8sDW20HQ@mail.gmail.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Sat, 19 Mar 2022 17:09:31 +0530
Message-ID: <CAK9=C2XGgfEZ890DgKmPXKw7=1BjnP-2L+_bpx+efX_rnw=_Nw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Increase range and default value of NR_CPUS
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 8:44 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Mar 18, 2022 at 3:46 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> >
> > On 17/03/2022 03:55, Anup Patel wrote:
> > > Currently, the range and default value of NR_CPUS is too restrictive
> > > for high-end RISC-V systems with large number of HARTs. The latest
> > > QEMU virt machine supports upto 512 CPUs so the current NR_CPUS is
> > > restrictive for QEMU as well.
>
> If qemu allows 512, what is the reason for limiting the kernel to 256?

There is no particular reason. I will change this to 2-512 range to match
the maximum number of CPUs supported by the QEMU virt machine.

>
> > > Other major architectures (such as
> > > ARM64, x86_64, MIPS, etc) have a much higher range and default
> > > value of NR_CPUS.
> >
> > What's the memory overhead for increasing this?
>
> It's supposed to be very small, I would expect three main sources of overhead:
>
> - cpumask_t variables, those grow once you go beyond the size of
>    an unsigned long (32 or 64 bits), so with the default just on the limit, this
>    makes no difference.
>    Note that you can run out of stack space with NR_CPUS values if
>    CONFIG_CPUMASK_OFFSTACK is disabled. Should not be
>    a problem for 512 or below.

Yes, the rationale is to have default NR_CPUS such that size of
cpumask_t does not change for RV32 and RV64.

>
> - percpu variables: these are dynamically allocated based on the number of
>   CPUs at boot time, so they should not have any real impact.
>
> - NR_CPUS sized arrays, these are sometimes used in place of
>   percpu data. This is only a problem if the array members individually
>   are more than a few bytes. There are not too many of these in the kernel,
>   as using those is discouraged.

Separately, we are also trying to replace NR_CPUS sized arrays.

Regards,
Anup
