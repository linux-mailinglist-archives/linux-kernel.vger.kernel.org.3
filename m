Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB5C4A3361
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 03:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353831AbiA3CvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 21:51:01 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:46047 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240673AbiA3Cu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 21:50:58 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 1C8DB3200F9C;
        Sat, 29 Jan 2022 21:50:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 29 Jan 2022 21:50:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=M/oKfxWweBksHL
        qGbrQQV1iOXRgcdwMf8Ir4g8ZQd74=; b=l8gQO6Ui3rytddIrgmkc3qFDtlrOLo
        z2uI8DPrBKCAZc8wwCIBB0Lko41R6NDSjX3bh3PABb8yLvf6u7eyPBC18gtEJD8h
        1tvnVfUlunMVVz5OOo28QqMLnzdLvQgTF4OP3kpqIy5GC2VH/Itcdeu9gyeRbIas
        NTu8v8wxz3tRuzGrQzqxCjWbnEqDnysYl+6pTx2VYC+H+xWCe3Eg7Zgs2xA4H0t5
        DozcZpwZD5CNSZI9kjtOjaEm8U0/U6ga6sjw5PKF+RjIi6S6PFmbivj1/jvMyKJP
        q7fqD02xCchWm7uwfX606s5YcVXCl6utdImZl/j++yyyYwUHcW8rn4Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=M/oKfxWweBksHLqGbrQQV1iOXRgcdwMf8Ir4g8ZQd
        74=; b=DpkNz4lvM4zrtbcc/vlddQ40KjRVANBsuP42MD/2q7pa+3hyUmQ4AT9tn
        n7lcMylAvoP/SHeYgSkExw8s1xK2oPbmyd+9p2kJZL8CKtkUHo0vlVRsO/G1ozzF
        3ywgXkxajHxBxrRTAVE0zbXCSxEAdGUkBoQuDE8GkIVplaZLZ7hvvkeMW6JMOwQx
        rvUR6LCoFXGtfO2liJjAcALgwftUiGCug05WaaPpNGjorkgwUcbPgAoG+jaY/fJX
        RXj0AJ+gqne9/bjnvvMa9qBpukHmrKxLgTQDH549kqm8uIHkMjR6MHx3ll665mEZ
        RVD88930E1kVTHdEWkvMltcVw7wNA==
X-ME-Sender: <xms:DP31YUeblmLIBFiL4MjOZvINBJuB5-16psgTpDJ3kAoJSCPbWdmvuw>
    <xme:DP31YWMDDEkjH5ks5jcrNDBD4N1ryW8VoNCEX3HuyutHmyqvcZI7a4qVAXQepkjay
    aUZaRwdKqO5hf1pGg>
X-ME-Received: <xmr:DP31YVi7zNXJBtgmwB8ub6t03R8uRr33vFPx4GGw2TPGT_21PmKAAiPh7qEgsfC4FjJccwCi3lvbWue5h1oosijO8Ww5T-bZK51vL61JyjbC751PMYwmKLVffQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfeekgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeetteffjeefhfegtdduledutdegudffleduueeftddvlefgieffveef
    hfdukeegvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:DP31YZ9AgEK4zNsJ_HxuGRDelprVW1yN8Efel_DbPrdbDNGRSibgiQ>
    <xmx:DP31YQsigjuBROKMNDiP2n1MuDoZ2SHud0YH3TMHkE6K96BjC3UkbA>
    <xmx:DP31YQH9CK5ELyaWeZZEmSfZuzUetq6tzDSE0PR5l7GqKjVzO0S3Jg>
    <xmx:DP31YV8sWT_mxM6fLaIhjiOfHpNclkIF0NxkQXsLBKzsoxTa6P64MA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Jan 2022 21:50:51 -0500 (EST)
Subject: Re: [PATCH V6 2/2] irqchip/sifive-plic: Fixup thead,c900-plic dt
 parse in opensbi
To:     Guo Ren <guoren@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Anup Patel <anup@brainfault.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
References: <20220129162726.1154501-1-guoren@kernel.org>
 <20220129162726.1154501-3-guoren@kernel.org> <87r18qxui9.wl-maz@kernel.org>
 <CAJF2gTTYN0bxnnMtP9L1KvaH0h6ny+Lr3+fC7GP-YWnwjAYd4A@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <35b1838d-ef80-1816-46f6-9cba7afc813e@sholland.org>
Date:   Sat, 29 Jan 2022 20:50:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAJF2gTTYN0bxnnMtP9L1KvaH0h6ny+Lr3+fC7GP-YWnwjAYd4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/22 8:08 PM, Guo Ren wrote:
> On Sun, Jan 30, 2022 at 2:32 AM Marc Zyngier <maz@kernel.org> wrote:
>>
>> On Sat, 29 Jan 2022 16:27:26 +0000,
>> guoren@kernel.org wrote:
>>>
>>> From: Guo Ren <guoren@linux.alibaba.com>
>>>
>>> The thead,c900-plic has been used in opensbi to distinguish
>>> PLIC [1]. Although PLICs have the same behaviors in Linux,
>>> they are different hardware with some custom initializing in
>>> firmware(opensbi).
>>>
>>> [1]: https://github.com/riscv-software-src/opensbi/commit/78c2b19218bd62653b9fb31623a42ced45f38ea6
>>>
>>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>>> Cc: Anup Patel <anup@brainfault.org>
>>> Cc: Marc Zyngier <maz@kernel.org>
>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>>> Cc: Samuel Holland <samuel@sholland.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> ---
>>>  drivers/irqchip/irq-sifive-plic.c | 25 +++++++++++++++++++++++--
>>>  1 file changed, 23 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
>>> index 259065d271ef..245655928076 100644
>>> --- a/drivers/irqchip/irq-sifive-plic.c
>>> +++ b/drivers/irqchip/irq-sifive-plic.c
>>> @@ -172,7 +172,7 @@ static void plic_irq_eoi(struct irq_data *d)
>>>       }
>>>  }
>>>
>>> -static struct irq_chip plic_chip = {
>>> +static struct irq_chip sifive_plic_chip = {
>>>       .name           = "SiFive PLIC",
>>>       .irq_mask       = plic_irq_mask,
>>>       .irq_unmask     = plic_irq_unmask,
>>> @@ -182,12 +182,24 @@ static struct irq_chip plic_chip = {
>>>  #endif
>>>  };
>>>
>>> +static struct irq_chip thead_plic_chip = {
>>> +     .name           = "T-Head PLIC",
>>> +     .irq_mask       = plic_irq_mask,
>>> +     .irq_unmask     = plic_irq_unmask,
>>> +     .irq_eoi        = plic_irq_eoi,
>>> +#ifdef CONFIG_SMP
>>> +     .irq_set_affinity = plic_set_affinity,
>>> +#endif
>>> +};
>>
>> For pure entertainment, let's compare the two structures:
>>
>> static struct irq_chip plic_chip = {
>>         .name           = "SiFive PLIC",
>>         .irq_mask       = plic_irq_mask,
>>         .irq_unmask     = plic_irq_unmask,
>>         .irq_eoi        = plic_irq_eoi,
>> #ifdef CONFIG_SMP
>>         .irq_set_affinity = plic_set_affinity,
>> #endif
>> };
>>
>> Oh wait: a string. Must be really important. Not.
> No, pls see below comment.
> 
>>
>>> +
>>> +static struct irq_chip *def_plic_chip = &sifive_plic_chip;
>>> +
>>>  static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
>>>                             irq_hw_number_t hwirq)
>>>  {
>>>       struct plic_priv *priv = d->host_data;
>>>
>>> -     irq_domain_set_info(d, irq, hwirq, &plic_chip, d->host_data,
>>> +     irq_domain_set_info(d, irq, hwirq, def_plic_chip, d->host_data,
>>>                           handle_fasteoi_irq, NULL, NULL);
>>>       irq_set_noprobe(irq);
>>>       irq_set_affinity(irq, &priv->lmask);
>>> @@ -396,5 +408,14 @@ static int __init plic_init(struct device_node *node,
>>>       return error;
>>>  }
>>>
>>> +static int __init thead_c900_plic_init(struct device_node *node,
>>> +             struct device_node *parent)
>>> +{
>>> +     def_plic_chip = &thead_plic_chip;
>>> +
>>> +     return plic_init(node, parent);
>>> +}
>>> +
>>>  IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
>>>  IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
>>> +IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", thead_c900_plic_init);
>>
>> Sorry, but I can't see any point to this patch.
> You didn't see the link I've put in the patch. In that opensbi patch:
> 
>                 intc: interrupt-controller@10000000 {
>                         #interrupt-cells = <1>;
> -                       compatible = "riscv,plic0";
> +                       compatible = "allwinner,sun20i-d1-plic",
> +                                    "thead,c900-plic";
> 
> +#define THEAD_PLIC_CTRL_REG 0x1ffffc
> +
> +static void thead_plic_plat_init(struct plic_data *pd)
> +{
> +       writel_relaxed(BIT(0), (void *)pd->addr + THEAD_PLIC_CTRL_REG);
> +}
> +
>  static const struct fdt_match irqchip_plic_match[] = {
>         { .compatible = "riscv,plic0" },
>         { .compatible = "sifive,plic-1.0.0" },
> +       { .compatible = "thead,c900-plic",
> +         .data = thead_plic_plat_init },
>         { },
>  };
> 
> We've changed the compatible name for thead,c900-plic, and there is no
> riscv,plic0 / sifive,plic-1.0.0 in dts. Without the patch, the newest
> opensbi + newest Linux would be broken in the Allwinner D1 dev board.

Yes, some patch is still necessary, because the hardware is indeed incompatible
with riscv,plic0. However, this driver does not care about the difference. So
all you need to do is hook up the existing code to the new compatible:

+IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_init);

Regards,
Samuel
