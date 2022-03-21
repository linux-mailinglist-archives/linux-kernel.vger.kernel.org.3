Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CBF4E2ED3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351656AbiCURJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351654AbiCURJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:09:28 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A552F8;
        Mon, 21 Mar 2022 10:07:57 -0700 (PDT)
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MSbt9-1ndGR02oqP-00T07C; Mon, 21 Mar 2022 18:07:55 +0100
Received: by mail-wr1-f42.google.com with SMTP id d7so21610844wrb.7;
        Mon, 21 Mar 2022 10:07:55 -0700 (PDT)
X-Gm-Message-State: AOAM530Snn7mRkkpctF+LpS90s7LeHbz30lfIZ4FZZxTFUwol7tnVg58
        bHnzmqNzE0/+Dveul3/Ot1iG3FycOzbgR0+h/9g=
X-Google-Smtp-Source: ABdhPJx6MHhqkAvOy0JZEms7/OkO2Fr4RTDieOC7Br0m0C9w79kl+lSWh1wtvyZJHGHM/grNNQMAlhnKIL9hf8+TURs=
X-Received: by 2002:adf:d081:0:b0:1ef:9378:b7cc with SMTP id
 y1-20020adfd081000000b001ef9378b7ccmr19427005wrh.407.1647882475232; Mon, 21
 Mar 2022 10:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220321165049.35985-1-sven@svenpeter.dev> <20220321165049.35985-5-sven@svenpeter.dev>
In-Reply-To: <20220321165049.35985-5-sven@svenpeter.dev>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 21 Mar 2022 18:07:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a19F8K0MvZV_R6HrmmR+WBsDge+u6U3iEVEjZ74i6+nEg@mail.gmail.com>
Message-ID: <CAK8P3a19F8K0MvZV_R6HrmmR+WBsDge+u6U3iEVEjZ74i6+nEg@mail.gmail.com>
Subject: Re: [PATCH 4/9] soc: apple: Add SART driver
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:q5BtAledRVWOwb12peWFD64mD6TL3wWyH9xDsyfIIV9oifZoBJ5
 +YWka3f7S5flNCgOgsbIpODSelqxonx2YXw6EhJVzambp81yKuuRBNwEmbyrUQ3S7EgRWoc
 fjcy132t2Fu639p9xw6CGTbbrSUswOVfovoYl+FoiqxkvUlUe9ZkGd73LelxdRNejMi+6tb
 D/wFSei9UhGFf1p7mhYrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CUU2eM2P2UM=:Uc3Aq6KgG2+BBJEVZ7/neh
 A4ww1yyUAEfv28JufsJCm4CNOOoIhBCHM/7N5YBLODAON0fWoq9sUwk2f8FTP1WMQrHliMjJV
 +5UfC+T7+g/EZaVkKESsEH7sG4MJCBHxnJ5O8FhBlnLHu8eG52qZ1cWZCMxJ0d7EixouugINe
 1RMGxq19jvQylhbFugI+3neraGKdGRiP21hOJf2SeW+Ir6PSJrT8Yf0WiZc33FJFEnjL38UDO
 ArROh88U1mJPqTDdiEJSWzGH3u91rbGTiUpnJ7JyUYgYtx293fe7rRSivXaqkFgM4eF9zCKCm
 Peu2C2PjLhDucsBpxpULwkRah8LL7Ty97IhPsB/m6urNq4XNJl7qeSln7PK0EIy0HP96Ri73P
 NEMhQT3JBvDqtr09dLrqsHIehzbR/fce/N5Szp396Pa5Aow82sbyFfJb+Bbxe1DEuH7cDzHQ3
 zQX4VGhGhZihmfah91P4wpKlHO6xxD25nRXTIPKKEkRRlYZ2560JdXLlde6yKu0ksVQCU4XLs
 +Z1ffObwEarfQFlTpQemiUT1cLudgzZrztLV/QZGRCj4JXFzjJI3YOapifg1okq7buS3VxMtw
 x08DAgWuRSQyr807Mug3P6SIhlJhCnAOO7ubndlq4NyFdhX/oQj1ksse2KcFgvAxoLXdPBkQ0
 WAoPeLPvWbH6w4zGHgsck+kJqYjZ1d4Ess7iw/P5/FfF4607TwsfsRwsL87Xt/NiGR84utO4g
 oaPedri/YxNe+KL6c2bctpA7oYMzhbNe+cMVsQHTnr+DDoF60VUKkG/B7jPTxHudoS05dAxlr
 1+1wHak6DSPMRfFnS9KRcckK902C3z9zL5mdL/KjjEZekWySYU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 5:50 PM Sven Peter <sven@svenpeter.dev> wrote:
>
> The NVMe co-processor on the Apple M1 uses a DMA address filter called
> SART for some DMA transactions. This adds a simple driver used to
> configure the memory regions from which DMA transactions are allowed.
>
> Co-developed-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

Can you add some explanation about why this uses a custom interface
instead of hooking into the dma_map_ops?

> +static void sart2_get_entry(struct apple_sart *sart, int index, u8 *flags,
> +                           phys_addr_t *paddr, size_t *size)
> +{
> +       u32 cfg = readl_relaxed(sart->regs + APPLE_SART2_CONFIG(index));
> +       u32 paddr_ = readl_relaxed(sart->regs + APPLE_SART2_PADDR(index));

Why do you use the _relaxed() accessors here and elsewhere in the driver?

> +struct apple_sart *apple_sart_get(struct device *dev)
> +{
> +       struct device_node *sart_node;
> +       struct platform_device *sart_pdev;
> +       struct apple_sart *sart;
> +
> +       sart_node = of_parse_phandle(dev->of_node, "apple,sart", 0);
> +       if (!sart_node)
> +               return ERR_PTR(ENODEV);

The error pointers need to take negative values, like 'ERR_PTR(-ENODEV)',
here and everywhere else in the driver.

       Arnd
