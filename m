Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642224F0185
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 14:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348149AbiDBMlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 08:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242548AbiDBMlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 08:41:06 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33DF26AEF;
        Sat,  2 Apr 2022 05:39:14 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 54B4A5C0129;
        Sat,  2 Apr 2022 08:39:12 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Sat, 02 Apr 2022 08:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=u7tWzaeG9q7EeREjNH0P5Mbr6pgNn9
        5OF+B4H7SRUOE=; b=UT0+rk0lXNuQoTvbi0pImZ8b43Z0WCpLDfjSe17Byvnnsk
        tBeaVzUsWWcCWRzd6FOn4pqKKfIKwAgEUeGOEBCArTEgSMk8pAnnlUjw2eY+pwDt
        6P2I599MU1ZnXl+LKKMq0VwMQi2gG9YACI/lwqVH2JohOCxnkgvonBCo21O4+Gu8
        zN/P1tYvac0OAebETRKN/tjTAyW0j6pv3ZoHBbpeemRuABtJJCXmVjzS5Dl0MLoH
        PnSN34TVnNsC1AltDMY9fg84FpIHlEuQg9d2SK8gfhFk820XWcXliy9jOqxT+b+w
        VbPkhQBdVOu4LhV+7VGsDSahEoTNOzHPzkQATRMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=u7tWzaeG9q7EeREjN
        H0P5Mbr6pgNn95OF+B4H7SRUOE=; b=VTdARnV0/cPFjERx+YVfG+Ru7eNNxRGFz
        u3mwHBuz3woUvr4P5e0bwWoesO/T4bn3siX7IMwT0eqH38j2MTGFUn8P8VCNIUy5
        L23hOfXMgc2mg2y6rCqCr77V9tuXvpziy5rTj5/H8iAVOcyQGmgySSjAIZvIprhb
        yaz36obb8MS2KkACjdHzfELdUGWU/mK0sZNvjbeZ36JJo1719OJixJoxKR9Kekr/
        L9W5QvT548GM5yMPRc2F5UQD+C9rurzCTDpOQemdM+oPssVL+8ovfjIZish4qx4s
        aEQ7O7su/krijPGZTRFwrFgiyrc5rbkpfGOzZtCWR/JIvw+aNEpZA==
X-ME-Sender: <xms:70NIYmpcKYH-axR56EbJe5br5ZjeqJOYkd-_MTyl9QhjM-V7myP27w>
    <xme:70NIYkqxUY3OVQO8u-awRXQq3rv6JXC1WvrNYBRk7A5YA4a1SAixfBia53pyVGvAU
    ftfe6Nt8D4BgTtogmE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeikedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeevvdegveduvdevvdfgleefgeeivdegheeiuedtleevvdeiveevleejfeev
    tdelheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdgu
    vghv
X-ME-Proxy: <xmx:70NIYrNQqSTGWLyTIuz3fQJ7AGMstYBmU4kRF6DIX9UZ9CzTrvkMrQ>
    <xmx:70NIYl6af54_Q2xQlLtQIzwhBPYFI7wZgiRHRosIN-A65Bjmyms6lQ>
    <xmx:70NIYl7y8C_leOc0IXhe-PwrxUC8CD4EB_nbM0xVNZxl0-nEZqn1Gw>
    <xmx:8ENIYizYELFsfYIsf7CL2Ijd1riUdWYXc-tJoAS98EUdCZq04sywUg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DEDB427402C7; Sat,  2 Apr 2022 08:39:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-382-g88b93171a9-fm-20220330.001-g88b93171
Mime-Version: 1.0
Message-Id: <f06576c8-76c6-41ae-874d-81ea0b5b5603@www.fastmail.com>
In-Reply-To: <CAK8P3a19F8K0MvZV_R6HrmmR+WBsDge+u6U3iEVEjZ74i6+nEg@mail.gmail.com>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-5-sven@svenpeter.dev>
 <CAK8P3a19F8K0MvZV_R6HrmmR+WBsDge+u6U3iEVEjZ74i6+nEg@mail.gmail.com>
Date:   Sat, 02 Apr 2022 14:38:07 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Keith Busch" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "Marc Zyngier" <maz@kernel.org>, DTML <devicetree@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/9] soc: apple: Add SART driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the review!

On Mon, Mar 21, 2022, at 18:07, Arnd Bergmann wrote:
> On Mon, Mar 21, 2022 at 5:50 PM Sven Peter <sven@svenpeter.dev> wrote:
>>
>> The NVMe co-processor on the Apple M1 uses a DMA address filter called
>> SART for some DMA transactions. This adds a simple driver used to
>> configure the memory regions from which DMA transactions are allowed.
>>
>> Co-developed-by: Hector Martin <marcan@marcan.st>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>
> Can you add some explanation about why this uses a custom interface
> instead of hooking into the dma_map_ops?

Sure.
In a perfect world this would just be an IOMMU implementation but since
SART can't create any real IOVA space using pagetables it doesn't fit
inside that subsytem.

In a slightly less perfect world I could just implement dma_map_ops here
but that won't work either because not all DMA buffers of the NVMe
device have to go through SART and those allocations happen
inside the same device and would use the same dma_map_ops.

The NVMe controller has two separate DMA filters:

   - NVMMU, which must be set up for any command that uses PRPs and
     ensures that the DMA transactions only touch the pages listed
     inside the PRP structure. NVMMU itself is tightly coupled
     to the NVMe controller: The list of allowed pages is configured
     based on command's tag id and even commands that require no DMA
     transactions must be listed inside NVMMU before they are started.
   - SART, which must be set up for some shared memory buffers (e.g.
     log messages from the NVMe firmware) and for some NVMe debug
     commands that don't use PRPs.
     SART is only loosely coupled to the NVMe controller and could
     also be used together with other devices. It's also the only
     thing that changed between M1 and M1 Pro/Max/Ultra and that's
     why I decided to separate it from the NVMe driver.

I'll add this explanation to the commit message.

>
>> +static void sart2_get_entry(struct apple_sart *sart, int index, u8 *flags,
>> +                           phys_addr_t *paddr, size_t *size)
>> +{
>> +       u32 cfg = readl_relaxed(sart->regs + APPLE_SART2_CONFIG(index));
>> +       u32 paddr_ = readl_relaxed(sart->regs + APPLE_SART2_PADDR(index));
>
> Why do you use the _relaxed() accessors here and elsewhere in the driver?

This device itself doesn't do any DMA transactions so it needs no memory
synchronization barriers. Only the consumer (i.e. rtkit and nvme) read/write
from/to these buffers (multiple times) and they have the required barriers
in place whenever they are used.

These buffers so far are only allocated at probe time though so even using
the normal writel/readl here won't hurt performance at all. I can just use
those if you prefer or alternatively add a comment why _relaxed is fine here.

This is a bit similar to the discussion for the pinctrl series last year [1].

>
>> +struct apple_sart *apple_sart_get(struct device *dev)
>> +{
>> +       struct device_node *sart_node;
>> +       struct platform_device *sart_pdev;
>> +       struct apple_sart *sart;
>> +
>> +       sart_node = of_parse_phandle(dev->of_node, "apple,sart", 0);
>> +       if (!sart_node)
>> +               return ERR_PTR(ENODEV);
>
> The error pointers need to take negative values, like 'ERR_PTR(-ENODEV)',
> here and everywhere else in the driver.

Ouch, that's my second bug of that kind in the past days. I'll fix it here
and check the other patches in this series as well.


Thanks,


Sven


[1] https://lore.kernel.org/lkml/87sfz8zdzb.wl-maz@kernel.org/
