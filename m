Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4E24F05B1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 21:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbiDBTJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 15:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiDBTJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 15:09:28 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F208E12A8DD;
        Sat,  2 Apr 2022 12:07:35 -0700 (PDT)
Received: from mail-wm1-f54.google.com ([209.85.128.54]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MC3H1-1niiuB0qkv-00CPnt; Sat, 02 Apr 2022 21:07:34 +0200
Received: by mail-wm1-f54.google.com with SMTP id q20so3573896wmq.1;
        Sat, 02 Apr 2022 12:07:34 -0700 (PDT)
X-Gm-Message-State: AOAM532WvDSooXWBhNNyCjvEapY+WnlGKEn1DBemeZgATB8czEOj0tbf
        5BP0b7UWbSV5IXQyBeqYHcHpTdKtN05SHuPcuQA=
X-Google-Smtp-Source: ABdhPJwIAkpxl+JZt9LjgRq9lJWnGHnJOqkbLJpfn319rdmgWy77pOsaUi8rkQeJc/4Nv+hf1X3LMml3uCdwMixVHak=
X-Received: by 2002:a7b:cd13:0:b0:38b:f39c:1181 with SMTP id
 f19-20020a7bcd13000000b0038bf39c1181mr13827152wmj.20.1648926453781; Sat, 02
 Apr 2022 12:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220321165049.35985-1-sven@svenpeter.dev> <20220321165049.35985-5-sven@svenpeter.dev>
 <CAK8P3a19F8K0MvZV_R6HrmmR+WBsDge+u6U3iEVEjZ74i6+nEg@mail.gmail.com> <f06576c8-76c6-41ae-874d-81ea0b5b5603@www.fastmail.com>
In-Reply-To: <f06576c8-76c6-41ae-874d-81ea0b5b5603@www.fastmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 2 Apr 2022 21:07:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3xioqJDb7hQ3dvxQyHPg2hgJbeJywEP+N4cDzpo=8VhQ@mail.gmail.com>
Message-ID: <CAK8P3a3xioqJDb7hQ3dvxQyHPg2hgJbeJywEP+N4cDzpo=8VhQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] soc: apple: Add SART driver
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:u5NOoiQ4rEi4dh4tfDGxLExnqqNZSURzhc/HD4eZvY96ATyEZlC
 foNU9lXJjj6QTWCgD3EVneljiwx196JRipv8X4NVhVfLK+Gb3IdwtCIiCgv6PcSjl8he9IP
 m3fNXVPT+NcSOzt8t1JjFqgGpfaWGWTmz78zOmgmTsdZA2LY9xgw9nrmnrHCf1yKaNON+rO
 HrKXMFTndMPv40EF+n9oQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R/NA65EZX+s=:i+QXtWZDna6xQuE85HNZAt
 f17BOhoLSXQPnpsy0dwCJ/yZCWaCW+77RNvtqRRgDUM0nNdM5LUG9N4nrTl6ZZUYjTMYRV9RL
 5AgbT/o1iDfm3Ax8hNFZ6et1OdP1g1bqDD3uenLZGs2msasK5ihumIsSJJI0Tvh2d5kXcdMZY
 ASzFG77Yqh/VFLFNPFmTPmu/rCQZXztI5hsJ0mlUHuWoRi0cAQI/41p7QCgam8Zrl8qH98rub
 7IP1bNLwMigmz7VwMhJxPRkrOu3bWGPWq6f3O0qlZmVfIkYXmqf9zzAK+Z+Vm+rQ95GXF3/jV
 eXBDLoTKbOOujaCfE9PkGRziJd/D3rgAcc1TcXkk2eLFkcH8VWsqAE8pOZ7/qFuVlHJvKtXkl
 4E/rny11gdYrHRXM/NjYARukeCGmMinWD/e/jgMWNtfBUGNI/ybyUs5z9aLYqVdenrkYhFPx7
 piE1GCrNwsgylxbAF52LfChJ4ydRDICyaLsq69iqo3dzlvHItUA5TvZUk82tbI+tygvjVTNjn
 hZbOwitVrtQMI8R+Rf9FaoZzqb40oL+MHU2LRXdeUylcoNLtaeYfmGpaPL7xTB8Kw1pa4Gjwf
 Ss2TGm2HHBV8QgNYbwBZOPHM/54iDWO0AD0pCCyI7D5NJvlaZ36n/DKvIgWeSCNPRmDgc6jz/
 sqDoNWNgFg0Kj1k/yTBbfJwWdbR4YGTIirkxw8Z+lLj3KeE93MS0wVPSqQIcryfZuKnLMinYz
 H6a5lVWj+D+0LMOC5hsQXLcIUYiL6Sekgb3XMnmb5MCaSKx9WoxfUJPPXYAClHw0PXYAE5p9L
 x6hzrOazIbGWOi3TF3BHkCyeU3QE16FDu62m5AEwCvPXSXnVIk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 2, 2022 at 2:38 PM Sven Peter <sven@svenpeter.dev> wrote:
> On Mon, Mar 21, 2022, at 18:07, Arnd Bergmann wrote:
> > On Mon, Mar 21, 2022 at 5:50 PM Sven Peter <sven@svenpeter.dev> wrote:
> >> The NVMe co-processor on the Apple M1 uses a DMA address filter called
> >> SART for some DMA transactions. This adds a simple driver used to
> >> configure the memory regions from which DMA transactions are allowed.
> >>
> >> Co-developed-by: Hector Martin <marcan@marcan.st>
> >> Signed-off-by: Hector Martin <marcan@marcan.st>
> >> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> >
> > Can you add some explanation about why this uses a custom interface
> > instead of hooking into the dma_map_ops?
>
> Sure.
> In a perfect world this would just be an IOMMU implementation but since
> SART can't create any real IOVA space using pagetables it doesn't fit
> inside that subsytem.
>
> In a slightly less perfect world I could just implement dma_map_ops here
> but that won't work either because not all DMA buffers of the NVMe
> device have to go through SART and those allocations happen
> inside the same device and would use the same dma_map_ops.
>
> The NVMe controller has two separate DMA filters:
>
>    - NVMMU, which must be set up for any command that uses PRPs and
>      ensures that the DMA transactions only touch the pages listed
>      inside the PRP structure. NVMMU itself is tightly coupled
>      to the NVMe controller: The list of allowed pages is configured
>      based on command's tag id and even commands that require no DMA
>      transactions must be listed inside NVMMU before they are started.
>    - SART, which must be set up for some shared memory buffers (e.g.
>      log messages from the NVMe firmware) and for some NVMe debug
>      commands that don't use PRPs.
>      SART is only loosely coupled to the NVMe controller and could
>      also be used together with other devices. It's also the only
>      thing that changed between M1 and M1 Pro/Max/Ultra and that's
>      why I decided to separate it from the NVMe driver.
>
> I'll add this explanation to the commit message.

Ok, thanks.

> >> +static void sart2_get_entry(struct apple_sart *sart, int index, u8 *flags,
> >> +                           phys_addr_t *paddr, size_t *size)
> >> +{
> >> +       u32 cfg = readl_relaxed(sart->regs + APPLE_SART2_CONFIG(index));
> >> +       u32 paddr_ = readl_relaxed(sart->regs + APPLE_SART2_PADDR(index));
> >
> > Why do you use the _relaxed() accessors here and elsewhere in the driver?
>
> This device itself doesn't do any DMA transactions so it needs no memory
> synchronization barriers. Only the consumer (i.e. rtkit and nvme) read/write
> from/to these buffers (multiple times) and they have the required barriers
> in place whenever they are used.
>
> These buffers so far are only allocated at probe time though so even using
> the normal writel/readl here won't hurt performance at all. I can just use
> those if you prefer or alternatively add a comment why _relaxed is fine here.
>
> This is a bit similar to the discussion for the pinctrl series last year [1].

I think it's better to only use the _relaxed version where it actually helps,
with a comment about it, and use the normal version elsewhere, in
particular in functions that you have copied from the normal nvme driver.
I had tried to compare some of your code with the other version and
was rather confused by that.

        Arnd
