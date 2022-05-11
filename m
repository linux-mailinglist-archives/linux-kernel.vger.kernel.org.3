Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B10523024
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiEKKCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239385AbiEKKBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:01:01 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218FDDF3B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:00:57 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id EA6415C003F;
        Wed, 11 May 2022 06:00:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 11 May 2022 06:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1652263254; x=
        1652349654; bh=CTXGRB6J4UHHbNMGL8dlUECvcdCemTh+syQxorNFVlw=; b=W
        Tlf7lfchZr6MIQCALPkhb0QuqeQ/GU5qWpPfBypfWy+w4/QAI8stDg1tuSzosU+q
        fN9dXyZxORZn6YOdmr88sSN+5dMMg4TfdhwHodMEOfqMuhQjnpvURuBcFoStEH6s
        DmLfiTqvgemtlRTSp0Ou+UzX0sTj2oOncK/uH8CEJTBxRzfffQn+UayzVSKV3h8O
        YE+EJFTI95Nzo7yEG6v281RvWxEug8YRmOuXwHLpjv1O3qTbGUoCcERi3pxg3Af1
        nhWB8qPxQzFSJg0E5O70OVE+sFLPfrobZKSE/dTwHb8gAg7jf7pWoxLVSR2C7beE
        MZU3FmCKdtZELS/0iBwhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1652263254; x=1652349654; bh=CTXGRB6J4UHHb
        NMGL8dlUECvcdCemTh+syQxorNFVlw=; b=xJh9VccWyAyxpC4q4eFJF0IqR3yUH
        Q1DgGClFBKUHJiYl+E2bcJktxP0X5LNDielnCaZMZIZj/N761NnGJHmeT6wPVP9p
        frt+4gg1E0kHtCEXZVG7CHSb+MqnYEyDcju0EtqJlJd68LIDaaDOOt1/v7YqwWS5
        M7rVSsxxTfGQp7T4y0Ar7VnB5V9wxh5ahplumivLSRfHWbu2RqW7Anul10HQ/cO7
        L9tw3N02N8zWPyc70ElZWK+oMcXaq2xj979KFlcYmG5uqGnSojHmtZ5VpSOILrDS
        xlI8Vt1GFV+Xqh1R1buatRzA6T8KVO4hy3tR2mAE3qPgPShNu4ycbaEbg==
X-ME-Sender: <xms:VYl7YqFf9oeWr8ePgcHY9WDYJ4gVwbYw20wR6Cj6_uU8eImCR1uEyA>
    <xme:VYl7YrV5M0wsUxkC_mTI5w8wmuQL8k83y3WcCg0DTk7G2VHMVPWMNX2B5hzdNk6mX
    7aRwZ8ZK3xy4ViP7g>
X-ME-Received: <xmr:VYl7YkLIf9GvKYmjI3rX4UoQJI5C3MRweS67MgCS-w6PjjaRJmxPehvK_Dw6tfyfRgIoEj5-zoLLLyor2STlHyQpVYx8G-A7Zl6uHf99YI_jqgdJ8RPx2UWd8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgeehgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepieetvdfhjefhvdejgfeguedtgeetjeffgfevtdejudekgfeukedt
    tddvgeeftdfgnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:VYl7YkH8Dh-U1u4uJWySu0DaMwYIEh7lYzpV9oM8A8ZikyDL68Mbvw>
    <xmx:VYl7YgWSM9bVnI2kXiPyi1FqoTnAAxaa8dATNrw44dag6Dny71TKmA>
    <xmx:VYl7YnNGqPyPgyZxc8T1cCghtvJq1l3w8F1BXoDqQXXrOiRmIMI66w>
    <xmx:Vol7Yht8YJOmetYn8KxVwAVLbBHq-geXImqAfk1mKLOevLO4UazNfw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 May 2022 06:00:52 -0400 (EDT)
Subject: Re: [PATCH 5/5] irqchip/sifive-plic: Separate the enable and mask
 operations
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Wei Xu <xuwei5@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20220509034333.60017-1-samuel@sholland.org>
 <20220509034333.60017-6-samuel@sholland.org> <87a6bp7ke2.wl-maz@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <2b063917-17c8-0add-fadf-5aa42532fbbf@sholland.org>
Date:   Wed, 11 May 2022 05:00:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87a6bp7ke2.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 5:27 AM, Marc Zyngier wrote:
> On Mon, 09 May 2022 04:43:33 +0100,
> Samuel Holland <samuel@sholland.org> wrote:
>>
>> The PLIC has two per-IRQ checks before sending an IRQ to a hart context.
>> First, it checks that the IRQ's priority is nonzero. Then, it checks
>> that the enable bit is set for that combination of IRQ and context.
>>
>> Currently, the PLIC driver sets both the priority value and the enable
>> bit in its (un)mask operations. However, modifying the enable bit is
>> problematic for two reasons:
>>   1) The enable bits are packed, so changes are not atomic and require
>>      taking a spinlock.
>>   2) The following requirememnt from the PLIC spec, which explains the
>>      racy (un)mask operations in plic_irq_eoi():
>>
>>        If the completion ID does not match an interrupt source
>>        that is currently enabled for the target, the completion
>>        is silently ignored.
>>
>> Both of these problems are solved by using the priority value to mask
>> IRQs. Each IRQ has a separate priority register, so writing the priority
>> value is atomic. And since the enable bit remains set while an IRQ is
>> masked, the EOI operation works normally. The enable bits are still used
>> to control the IRQ's affinity.
> 
> This is pretty neat.
> 
> My only concern is around whether implementations do when changing
> priority of enabled interrupts. The PLIC architecture is conveniently
> silent on the subject, but that's certainly something that can result
> in total crap with the ARM GICs, for example, because an
> implementation is free to apply this priority change on an already
> pending interrupt, or not. But the kernel really wants the interrupt
> to be masked once it tells the HW to do so.

I think this can be expected based on this comment from the PLIC spec, which is
the only place using the word "mask":

"The PLIC will mask all PLIC interrupts of a priority less than or equal to
threshold. For example, a`threshold` value of zero permits all interrupts with
non-zero priority."

> Could anyone please check the RTL for some common implementations?

The C9xx PLIC explicitly checks for priority 0 in each gateway:

https://github.com/T-head-Semi/openc906/blob/main/C906_RTL_FACTORY/gen_rtl/plic/rtl/plic_int_kid.v#L152

and also continuously updates the IRQ outputs based on comparing the arbitrated
highest priority interrupt with the target's threshold:

https://github.com/T-head-Semi/openc906/blob/main/C906_RTL_FACTORY/gen_rtl/plic/rtl/plic_arb_ctrl.v#L295


Other implementations appear to do something similar, continuously computing the
highest priority interrupt, and comparing that to the target threshold:

https://github.com/chipsalliance/rocket-chip/blob/master/src/main/scala/devices/tilelink/Plic.scala#L187
https://github.com/lowRISC/rv_plic/blob/master/rtl/rv_plic_target.sv#L92
https://github.com/lowRISC/opentitan/blob/master/hw/ip_templates/rv_plic/rtl/rv_plic_target.sv.tpl#L58
https://github.com/pulp-platform/rv_plic/blob/master/rtl/rv_plic_target.sv#L92
https://github.com/RoaLogic/plic/blob/master/rtl/verilog/core/plic_target.sv#L126
https://github.com/qemu/qemu/blob/master/hw/intc/sifive_plic.c#L96

Those are the implementations I could find. Others may know about non-public
implementations.

Regards,
Samuel

> A way to avoid the above trouble (should it exist) would be to
> disable the interrupt when changing the priority, and then reenable
> it. You'd still get the simpler EOI, which is what you really want.
> 
> Thanks,
> 
> 	M.
> 

