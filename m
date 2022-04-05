Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CF34F4A42
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454563AbiDEWiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457347AbiDEQDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:07 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C5825E9E;
        Tue,  5 Apr 2022 08:37:27 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 4F6E23201464;
        Tue,  5 Apr 2022 11:37:25 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Tue, 05 Apr 2022 11:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=f7SyYZI4nz+qs5qaMDg1riUJfz1XkX
        CuG6WXTU/lNCQ=; b=abLQr7Ocox7EC2QOocUVper/aOyFWncLbJ1SWNpn1FgdoE
        oFjH6XS6gAddBS5s3IaBrxIUWW+yGYgKFJiYiEb0PK8Fd8bZ62aLn+EoMPkvkHFG
        ZFNXxQWyE4j94LuxavQmpSANyzqQoQw+c/ZRF094grUvUCzHhDgJEmGW5N/C54Nr
        ZZX9/J+C8pc8b22K9aCU44ziKFWg8Aw1DoRnXI86Mxa+lSmPuorMtDjvJv5CCuR7
        VWlU1dP0LXpSdrWH/EgO/Q6Yt/n2GSdGRGiK63mExuRceE8IF901tSfv/R5k8VJR
        +7S5uBKQJHhihPJ+FK9pLvK6dQsZSM5M4iIfNwmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=f7SyYZI4nz+qs5qaM
        Dg1riUJfz1XkXCuG6WXTU/lNCQ=; b=UeVodiwW8PmkEP9EPOHfnWy0CCe0guLPF
        DliOMGO4FfQEz5RrQA9EawpvoUPmY2N4p1Y7hJAhXalO7KNhhjB9hrJzTKQryP13
        BRhjKbc0Uhhae7wmBkB/+Fo7rz7Ekz5+cWeXOJ2KBQmidkgdtNAzXIEa6cnKj6gi
        1EN0qK4VrO/0tTJM7IeFT5mRwIXqQwwJkuHJmIas+yyVgxcHUzTSCTmXCcaRx7xy
        knHKVCSSxf1IVkwBMTOVVhwIstsUlpUzQYMKKD+SXnSMXkbA1MutFKYiEFW1SG3r
        df+ISBqWong8Pjrx9tT1G5Yr/ia7zrmk+U01T4XEeMRJI4FDcDf9Q==
X-ME-Sender: <xms:NGJMYuWXQtktSsSAuTYUMvwDdFEcA4yhQ5MCW9aLDi_bY1KklAMTYw>
    <xme:NGJMYqmG5DoOWovS2HoBGsG8au43ep38U8M7cgPQyXj_NmRISXaRrhDPFjZDxNxP6
    K3qcSG8OEmA2TXnJjU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudejgedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:NGJMYiaEdQ36azdMNu80CJVWjwDac80cJld0O7o-VJOtCoxYhEXbmg>
    <xmx:NGJMYlXUrltHCyl4_r8omNuAFmQQCjGgnOEUbp-oRMi_Dtg2ztDlvQ>
    <xmx:NGJMYomK1MwE0auNSM1PEA2y1xulMXcEXFvzKgQvi9xnwS18Q8u7NQ>
    <xmx:NGJMYhfRhmFqCvgyg5ojCGq54Zi4dy_aoLsD-vlMZVtN_tKRMHVfEg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1381327407F6; Tue,  5 Apr 2022 11:37:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-385-g3a17909f9e-fm-20220404.001-g3a17909f
Mime-Version: 1.0
Message-Id: <c5c0db06-2d82-4e5a-b9e4-89e0b7c9230c@www.fastmail.com>
In-Reply-To: <YksHoQvDqXOK70EX@robh.at.kernel.org>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-5-sven@svenpeter.dev>
 <CAK8P3a19F8K0MvZV_R6HrmmR+WBsDge+u6U3iEVEjZ74i6+nEg@mail.gmail.com>
 <f06576c8-76c6-41ae-874d-81ea0b5b5603@www.fastmail.com>
 <CAK8P3a3xioqJDb7hQ3dvxQyHPg2hgJbeJywEP+N4cDzpo=8VhQ@mail.gmail.com>
 <YksHoQvDqXOK70EX@robh.at.kernel.org>
Date:   Tue, 05 Apr 2022 17:37:03 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Rob Herring" <robh@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Keith Busch" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "Marc Zyngier" <maz@kernel.org>, DTML <devicetree@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/9] soc: apple: Add SART driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 4, 2022, at 16:58, Rob Herring wrote:
> On Sat, Apr 02, 2022 at 09:07:17PM +0200, Arnd Bergmann wrote:
>> On Sat, Apr 2, 2022 at 2:38 PM Sven Peter <sven@svenpeter.dev> wrote:
>> > On Mon, Mar 21, 2022, at 18:07, Arnd Bergmann wrote:
>> > > On Mon, Mar 21, 2022 at 5:50 PM Sven Peter <sven@svenpeter.dev> wrote:
>> > >> The NVMe co-processor on the Apple M1 uses a DMA address filter called
>> > >> SART for some DMA transactions. This adds a simple driver used to
>> > >> configure the memory regions from which DMA transactions are allowed.
>> > >>
>> > >> Co-developed-by: Hector Martin <marcan@marcan.st>
>> > >> Signed-off-by: Hector Martin <marcan@marcan.st>
>> > >> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>> > >
>> > > Can you add some explanation about why this uses a custom interface
>> > > instead of hooking into the dma_map_ops?
>> >
>> > Sure.
>> > In a perfect world this would just be an IOMMU implementation but since
>> > SART can't create any real IOVA space using pagetables it doesn't fit
>> > inside that subsytem.
>> >
>> > In a slightly less perfect world I could just implement dma_map_ops here
>> > but that won't work either because not all DMA buffers of the NVMe
>> > device have to go through SART and those allocations happen
>> > inside the same device and would use the same dma_map_ops.
>> >
>> > The NVMe controller has two separate DMA filters:
>> >
>> >    - NVMMU, which must be set up for any command that uses PRPs and
>> >      ensures that the DMA transactions only touch the pages listed
>> >      inside the PRP structure. NVMMU itself is tightly coupled
>> >      to the NVMe controller: The list of allowed pages is configured
>> >      based on command's tag id and even commands that require no DMA
>> >      transactions must be listed inside NVMMU before they are started.
>> >    - SART, which must be set up for some shared memory buffers (e.g.
>> >      log messages from the NVMe firmware) and for some NVMe debug
>> >      commands that don't use PRPs.
>> >      SART is only loosely coupled to the NVMe controller and could
>> >      also be used together with other devices. It's also the only
>> >      thing that changed between M1 and M1 Pro/Max/Ultra and that's
>> >      why I decided to separate it from the NVMe driver.
>> >
>> > I'll add this explanation to the commit message.
>> 
>> Ok, thanks.
>> 
>> > >> +static void sart2_get_entry(struct apple_sart *sart, int index, u8 *flags,
>> > >> +                           phys_addr_t *paddr, size_t *size)
>> > >> +{
>> > >> +       u32 cfg = readl_relaxed(sart->regs + APPLE_SART2_CONFIG(index));
>> > >> +       u32 paddr_ = readl_relaxed(sart->regs + APPLE_SART2_PADDR(index));
>> > >
>> > > Why do you use the _relaxed() accessors here and elsewhere in the driver?
>> >
>> > This device itself doesn't do any DMA transactions so it needs no memory
>> > synchronization barriers. Only the consumer (i.e. rtkit and nvme) read/write
>> > from/to these buffers (multiple times) and they have the required barriers
>> > in place whenever they are used.
>> >
>> > These buffers so far are only allocated at probe time though so even using
>> > the normal writel/readl here won't hurt performance at all. I can just use
>> > those if you prefer or alternatively add a comment why _relaxed is fine here.
>> >
>> > This is a bit similar to the discussion for the pinctrl series last year [1].
>> 
>> I think it's better to only use the _relaxed version where it actually helps,
>> with a comment about it, and use the normal version elsewhere, in
>> particular in functions that you have copied from the normal nvme driver.
>> I had tried to compare some of your code with the other version and
>> was rather confused by that.
>
> Oh good, I tell folks the opposite (and others do too). We don't accept 
> random explicit barriers without explanation, but implicit ones are 
> okay? The resulting code on arm32 is also pretty horrible with the L2x0 
> and OMAP sync hooks not that that matters here.
>
> I don't really care too much which way we go, but we should document one 
> rule and follow that.

I don't have a strong opinion either. Arnd's approach is currently documented
in Documentation/driver-api/device-io.rst fwiw:

  On architectures that require an expensive barrier for serializing against
  DMA, these "relaxed" versions of the MMIO accessors only serialize against
  each other, but contain a less expensive barrier operation. A device driver
  might use these in a particularly performance sensitive fast path, with a
  comment that explains why the usage in a specific location is safe without
  the extra barriers.


Sven
