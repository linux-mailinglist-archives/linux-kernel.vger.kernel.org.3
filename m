Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1A14B60DA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 03:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbiBOCQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 21:16:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiBOCQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 21:16:47 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F6A6428;
        Mon, 14 Feb 2022 18:16:37 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 38EEB5C018B;
        Mon, 14 Feb 2022 21:16:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 14 Feb 2022 21:16:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=eQac06sYh75uQX
        SUNrbiPFwKSLNFR1iz5je/JUb/0oE=; b=fdl5R1D0d3oUT1RbwGOjHPzptXn0Y7
        PWcataQyXaJeMTQ2zZnaKRxNeOsyaaHikql7N0VP5ocS+Guqi1EppOaV+jWxh7xC
        DnyAA9goGhl4A1yweNizJ8vDI1Uz6uqIH/HnG5JFMZHLQbgIXsNNWX+PIwNE0tot
        WT0AfS9TtuvjF/lQBGphzuKAD6D+/rTQSqTiAPXHphOhgDP3w21+xUD7eIItCYyV
        T6dL/FNWQkl68tcu+K5B5KPvJM1v8Puq2S6ySvz3mcGpFDOYHdl27zPkkzGJ9Z38
        7ndB5zQ+2VaIdZnOHDhi77wNUl4Yyfwx1ze1yhaM4MoJ05SYXvBqcbAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=eQac06sYh75uQXSUNrbiPFwKSLNFR1iz5je/JUb/0
        oE=; b=POX7Lir5gpv+yCgxFtwpW06xEThY0wb3K00uR5UeJFbPAaJNC1ZeUb94x
        nBtjiSpvJb0bitkx+YAMnZWBdtTFNZyW3SOqYu0HtC+hSqzctqjyHDws+w0TWr1i
        wDWQMo7cpE4Q9YvccMg28rmBkt2Y0H6nvzJZC5lgmPVuLpRZiIejjhzlWPuUefjR
        0ZlD6N9ivXSOwAo18n7lJ0aa9C9VQL9FSFU5bESIlKGaYHv0aCeLLSsnUfRXVDf/
        WzJ5jsjvcgfKtLvxvGt7AE/m1B8HNFpFjgNL8Q21kfZ7NVfq0GONRQKxkIvtF1T8
        +yZZzc14vi7UrU9VjOiSNwJZH7cXQ==
X-ME-Sender: <xms:BA0LYvdaxq2NUDg3GfRzUlZi-lGtPmNCSC58DUYbqWAEvezKmZaAwA>
    <xme:BA0LYlPB2Ih6ZLQLUyiIy0S7xZKeHmKjsjN0emKXev6N5U9QKvYT_is2IsvuZupFd
    kScmskFS8bO74eKfg>
X-ME-Received: <xmr:BA0LYog63ytXNYAISxa4dba9HL9twCmUCwIwc1M-m28QhZBVLay6LAIdIsHFXYRsYowuDYoPwznOSIi4GWT45JW3MzaJ0gXAzzGOGYcujk5u7MtQ_SS8tftRFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeefgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefgveffteelheffjeeukedvkedviedtheevgeefkeehueeiieeuteeu
    gfettdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:BA0LYg-I5WbIFNNYrNZPez0xUfdqxwlJB8AAeOSpDDNRgOdojo-Y_A>
    <xmx:BA0LYrssELT5U-XWY8-izQ6-aZZd26bPLa5MUjtICmSaNmkZfdRfLA>
    <xmx:BA0LYvGpXRrZG-pHO1QFpeHrTbYoY_iL8QjBJouvUxIOVcnm0Bv1wQ>
    <xmx:BQ0LYlIjCyvHZJTDeSBgooO9PtCyO7W0Zstprs8xEBa_IPBQHrnC0A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Feb 2022 21:16:36 -0500 (EST)
Subject: Re: [PATCH] of/irq: Use interrupts-extended to find parent
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220214051318.2273-1-samuel@sholland.org>
 <87o8394ura.wl-maz@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <c109aeb3-225e-3750-4b86-cef227d11ab5@sholland.org>
Date:   Mon, 14 Feb 2022 20:16:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87o8394ura.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/14/22 4:17 AM, Marc Zyngier wrote:
> On Mon, 14 Feb 2022 05:13:17 +0000,
> Samuel Holland <samuel@sholland.org> wrote:
>>
>> Some OF irqchips, such as the RISC-V PLIC, use interrupts-extended to
>> specify their parent domain(s). That binding does not allow using the
>> interrupt-parent property in the irqchip node, which prevents
>> of_irq_init from properly detecting the irqchip hierarchy.
> 
> Is this because there is more than a single interrupt parent?

If you're asking why the PLIC binding specifies interrupts-extended, yes, that's
because there is a separate RISC-V INTC instance for each CPU, so the PLIC has
as many parent domains as there are CPUs.

>> If no interrupt-parent property is present in the enclosing bus or root
>> node, then desc->interrupt_parent will be NULL for both the per-CPU
>> RISC-V INTCs (the actual root domains) and the RISC-V PLIC. Similarly,
>> if the bus or root node specifies `interrupt-parent = <&plic>`, then
>> of_irq_init will hit the `desc->interrupt_parent == np` check, and again
>> all parents will be NULL. So things happen to work today for some boards
>> due to Makefile ordering.
>>
>> However, things break when another irqchip ("foo") is stacked on top of
>> the PLIC. The bus/root node will have `interrupt-parent = <&foo>`,
>> since that is what all of the other peripherals need. When of_irq_init
>> runs, it will try to find the PLIC's parent domain. But because
>> of_irq_find_parent ignores interrupts-extended, it will fall back to
>> using the interrupt-parent property of the PLIC's parent node (i.e. the
>> bus or root node), and see "foo" as the PLIC's parent domain. But this
>> is wrong, because "foo" is actually the PLIC's child domain!
> 
> Let me see if I parsed this correctly. You have:
> 
>              int-parent        int-extended
> 	foo -----------> PLIC --------------> root-irqchip
> 
> Is that correct?

Yes.

>>
>> So of_irq_init wrongly attempts to init the stacked irqchip before the
>> PLIC. This fails and breaks boot.
>>
>> Fix this by having of_irq_find_parent return the first node referenced
>> by interrupts-extended when that property is present. Even if the
>> property references multiple different IRQ domains, this will still work
>> reliably in of_irq_init as long as all referenced domains are the same
>> distance away from some root domain (e.g. the RISC-V INTCs referenced by
>> the PLIC's interrupts-extended are always all root domains).
> 
> I'm a bit worried that the distance assumption may not always hold.
> Maybe it isn't something we need to deal with right now, but a comment
> wouldn't hurt to make this assumption clear.

OK, I will add a comment to v2.

Regards,
Samuel

>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>>  drivers/of/irq.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
>> index 2b07677a386b..0c20e22b91f5 100644
>> --- a/drivers/of/irq.c
>> +++ b/drivers/of/irq.c
>> @@ -60,7 +60,8 @@ struct device_node *of_irq_find_parent(struct device_node *child)
>>  		return NULL;
>>  
>>  	do {
>> -		if (of_property_read_u32(child, "interrupt-parent", &parent)) {
>> +		if (of_property_read_u32(child, "interrupt-parent", &parent) &&
>> +		    of_property_read_u32(child, "interrupts-extended", &parent)) {
>>  			p = of_get_parent(child);
>>  		} else	{
>>  			if (of_irq_workarounds & OF_IMAP_NO_PHANDLE)
> 
> With the comment added:
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> 
> 	M.
> 

