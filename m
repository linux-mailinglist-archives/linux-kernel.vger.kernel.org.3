Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7B04F021A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 15:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355510AbiDBNhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 09:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiDBNhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 09:37:12 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FE713F57;
        Sat,  2 Apr 2022 06:35:19 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 61EF45C0134;
        Sat,  2 Apr 2022 09:35:19 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Sat, 02 Apr 2022 09:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=0tD+0tun3p6CjlrcJ0VNPNyM5zYY5w
        Fw6kG0yYLKG6I=; b=WKcIWrMxlFdI1VWmXmKxOJy/rhhElFVYIP28BhV+9aFSsI
        PsG97E2ABOdsxA6D4fGlrSgblYbNGRnAf0ovPxza32kqYwUVJbVqPjbTl9aJicM/
        b4Auz24Y3ojukkWHcYn4ITEQFIQxoLpm5FcUpFplF8VW0p94HripoV6siiNn+zFX
        MtOewyjBoILfsA1HQ905pggQ/CBvoBoXvvf8bbZa6iGyIzLtheiCxHAr6rLeyxD1
        wtAI9QZwp7qD78HLSz2WqqvhDKuzq65AnUxj1EfPLrLRvI+HqRMSOPTgfT6q/PUO
        t9+T98NCPVqZj85qJ+bG1p37oirquSSOoUXxC6Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=0tD+0tun3p6CjlrcJ
        0VNPNyM5zYY5wFw6kG0yYLKG6I=; b=Fm82a0lcoZYxfd/YbTsQNSMkM2TSS6XjY
        D+5695QbzIBFpISgtqEL9pkZla7GMFZm19gezahRu7P0LOImlds1h4nJVu2AiYMz
        arBusfjUn/BwhzcoORdtHNR9F+gczwV4UNHcDgwVGB1dv0xh+LnBp7RjvoEfRPcm
        HMNZcJHSmFfRKDPMpcdX1xP+BLNQKRm/Xxf4wT5BRN6hFv1m2Hdbh4sAAwGZR5Pu
        wwFEWTdLjnx7wttRcpiLN4xrMgYm6+Pw65sOXoP0mFoe/rXv4kthKIwEZETg12EQ
        SC7KZfG50LF0O1yVUxQ9W8JMXKhfdL2WnMUZriLrXLOkoFWNaSVbg==
X-ME-Sender: <xms:F1FIYh9UrXkcPQmGy5xrFGkG6mGjdqmAfTDrIprgUvbxJAZyDVMbmA>
    <xme:F1FIYlvH6j7UASCyB-Sp_9kwjATVnXQoDAZDicoWMzFggdk61I2eEeX8pMD8Y7349
    19zSbujO_cu5d3f650>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeikedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:F1FIYvD7VmJjzbbcazZBBP8eHUDXeTnIWmncDhq51nerMkdhkgby8w>
    <xmx:F1FIYldRhqvtEWbdvTLkMOwa1WwCUdTbcEb8-UwClcVO3aE-HGVX8A>
    <xmx:F1FIYmOQvF8n7JqYCIVjERAWCz1775ZBXk3MwcpIS8cMuiaAg5-2DA>
    <xmx:F1FIYnEBROVYZBfxUKN0D2kOE-BORds7q4o4jPvTPuLZlQsOVag-HQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1CE5427402C7; Sat,  2 Apr 2022 09:35:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-382-g88b93171a9-fm-20220330.001-g88b93171
Mime-Version: 1.0
Message-Id: <7876eb84-9803-48dc-ab6b-27d49858e27a@www.fastmail.com>
In-Reply-To: <CAK8P3a27-eWP=krGQOp29krcc7bVME9=MbN6B3Rs7Q4Ran_VFw@mail.gmail.com>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-7-sven@svenpeter.dev>
 <CAK8P3a27-eWP=krGQOp29krcc7bVME9=MbN6B3Rs7Q4Ran_VFw@mail.gmail.com>
Date:   Sat, 02 Apr 2022 15:34:55 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Keith Busch" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Marc Zyngier" <maz@kernel.org>, DTML <devicetree@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/9] nvme-apple: Add initial Apple SoC NVMe driver
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



On Tue, Mar 22, 2022, at 14:38, Arnd Bergmann wrote:
> On Mon, Mar 21, 2022 at 5:50 PM Sven Peter <sven@svenpeter.dev> wrote:
>
>> +static int apple_nvme_sart_dma_setup(void *cookie, struct apple_rtkit_shmem *bfr,
>> +                                    dma_addr_t iova, size_t size)
>> +{
>> +       struct apple_nvme *anv = cookie;
>> +       int ret;
>> +
>> +       if (iova)
>> +               return -EINVAL;
>> +
>> +       bfr->buffer = dma_alloc_coherent(anv->dev, size, &iova, GFP_KERNEL);
>> +       if (!bfr->buffer)
>> +               return -ENOMEM;
>
> You pass 'iova' as an argument, but then replace it with the address
> returned by dma_alloc_coherent(). Can you remove the function
> argument?

Yup, will remove it.

>
>> +static void apple_nvmmu_inval(struct apple_nvme_queue *q, unsigned int tag)
>> +{
>> +       struct apple_nvme *anv = queue_to_apple_nvme(q);
>> +
>> +       writel(tag, anv->mmio_nvme + APPLE_NVMMU_TCB_INVAL);
>> +       if (readl_relaxed(anv->mmio_nvme + APPLE_NVMMU_TCB_STAT))
>> +               dev_warn(anv->dev, "NVMMU TCB invalidation failed\n");
>> +}
>
> I don't like to see the _relaxed() accessors used without an explanation
> about why that helps. Please use the non-relaxed version, or make sure
> it's obvious here why you use it.

Ok, I'll either use the non-relaxed ones or add a comment whenever I use
the relaxed version. In this case here there's no write to any DMA buffers
that needs to be visible to the device. That writel there could actually
be a writel_relaxed as well. There just used to be a write to a buffer
above (which is another good reason to always comment when using the
non-relaxed ones, maybe then I would've noticed then and updated it).


>
>> +bad_sgl:
>> +       WARN(DO_ONCE(apple_nvme_print_sgl, iod->sg, iod->nents),
>> +            "Invalid SGL for payload:%d nents:%d\n", blk_rq_payload_bytes(req),
>> +            iod->nents);
>
> I think you mean WARN_ONCE() here?

This is taken from pci.c which used to use WARN_ONCE but was replaced in
d08774738446e77734777adcf5d1045237b4475a with this construction here.
The commit message mentions

    The WARN_ONCE macro returns true if the condition is true, not if the
    warn was raised, so we're printing the scatter list every time it's
    invalid. This is excessive and makes debugging harder, so this patch
    prints it just once.


>
>> +       writel_relaxed(0, anv->mmio_coproc + APPLE_ANS_COPROC_CPU_CONTROL);
>> +       (void)readl_relaxed(anv->mmio_coproc + APPLE_ANS_COPROC_CPU_CONTROL);
>
> What is the purpose of the readl_relaxed() here? It looks like you are
> trying to flush
> the write to the hardware, but then again
>
>   a) on Apple hardware, the registers are mapped using PROT_DEVICE_nGnRnE,
>       so MMIO writes are never posted
>
>   b) the read is "_relaxed", so there is no barrier, and the result is
> unused, so
>       it would appear that the CPU can just keep executing code anyway.
>
> Since this is all the initialization path, I can't imagine what the
> relaxation of
> the barriers helps with.

Agreed, I've actually tried replacing all non-relaxed ones with the normal
accessors (even those inside the hot path) and didn't see any performance
difference.
I can use the normal ones here and I'll consider using the non-relaxed ones
in the hot path together with a comment why they are safe in those places.

>
>> +static int apple_nvme_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
>> +{
>> +       *val = readl_relaxed(ctrl_to_apple_nvme(ctrl)->mmio_nvme + off);
>> +       return 0;
>> +}
>> +
>> +static int apple_nvme_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
>> +{
>> +       writel_relaxed(val, ctrl_to_apple_nvme(ctrl)->mmio_nvme + off);
>> +       return 0;
>> +}
>
> If you have generic register access functions, don't make them use
> _relaxed internally. If there are instances that need to be _relaxed,
> add another version of the accessor that spells this out in the caller.

Ok, there are used internally by the nvme core and can't do any kind of DMA
right now but I agree that it's better to use the non-relaxed ones here
to prevent surprises in the future.


Sven
