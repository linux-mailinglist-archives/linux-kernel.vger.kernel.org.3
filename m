Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C77855CB7E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbiF0N6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbiF0N6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:58:38 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A80F4E;
        Mon, 27 Jun 2022 06:58:32 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A63C15C0109;
        Mon, 27 Jun 2022 09:58:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 27 Jun 2022 09:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656338311; x=
        1656424711; bh=hKk81T7RobklmmovRS3N+SbKo48ebDOgEA3PM2L02Aw=; b=G
        /5nqwB+rCu/vZiFvDOZG82q61JNCGumjdQD0c6es9nilPHqsMCvzlLDrd9C2+TZ0
        N02eOh6MB024t+jkV7A5EIOwxUakkdrECCzo4uPYtKA5hZftZnTIkT/9hYs6LW4V
        hqEPrjFVd9r85ZrwQyZ5Wp/OVDcMlCT6tbQiFdTTIez74FSRS8Xbxh7XWaj98EUM
        fbrwqe00JdabyL8tK+PXfzkoZcMgkHG9C74Ih0a/qmxWqGuLXts4ROBfFH/uCsLh
        IN2Lp1yKxdBQ/wtcn3lY/cgyxbe5b0bx51pU2zW20i38lcJnC2kljuyw5IBcvbZ8
        0o9QHrcC0UbW4n33CD7ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656338311; x=
        1656424711; bh=hKk81T7RobklmmovRS3N+SbKo48ebDOgEA3PM2L02Aw=; b=T
        EX9yNIM2Qg7Q4BkuhSpMaW0hspqe6QSx/QFnY/Y03ljI2WiljSAJ7Q+hw+f614x3
        5I+mbTsPBKR0rKGjeJwD4NhE0fBwLEByZIWOxww/oIY+qEhDSespVcZap8g/GlmN
        gYEwDuqknCtozEyfVQDeS+9dQRhE3Px5FzScJiOc7Bci/QY8fqzCf7mmmls1tooX
        nngFup9d13dZHn2BJPikiqPRSLUJTp/TkXfAdpWUXMjA/JtSYXCfvmZv/fSRqhAE
        eP+RTCXWSAMfeMVCgFhc1X30dDhlGJm8y03MpY0RHfX50x2BdqsJQzXZLMc0aigI
        V3cfHKRiHhDP8tabJeKog==
X-ME-Sender: <xms:h7e5YpFcBbYb_pGsbhLNW1Z4SDZYYsCaNNg-AUe4i74dZGN_McUNww>
    <xme:h7e5YuXLFK27G7F6GRwxPxmQCH4Nvc7ouVybAONJeNbH1k-Be6LJfctKD0lwMrV9R
    nlxzpkSDAMDU5h5iQ>
X-ME-Received: <xmr:h7e5YrLmhuWMNWR22ClP7xjYPbLqi5c8pdnWOo8rHUxIZ07CFrpgdZKzbNWt_UabUwt4OhuCPHSHjZ1Mx4n7Bx-Wpi9qRCZ5nF6gwSErW6lFQ4zIdGPvTrIrug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeghedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeefhfdvffegudefueeggfeutefgfefgleegleffuedvtdejkedu
    leeukeeftefggfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehs
    rghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:h7e5YvGRrzr_Fc7Yjg94w42X6pZWGeq8EAgGI2Gv7vHGOLbue7h8WQ>
    <xmx:h7e5YvVtT34jSscKPG1k_WcD8jfGS6GBNvJTuHeyjTRWXMx7Mmr4IA>
    <xmx:h7e5YqOLXnk-r1Z_2NIYpkiRHdoQcbAeW-81bYYBmphU0s8mGJ9G_Q>
    <xmx:h7e5YoWQVqjzl0Ag7oQh5FJO7ijNSg5pGbqsuPd0gBZtR5CdNVCI8A>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jun 2022 09:58:30 -0400 (EDT)
Subject: Re: [PATCH v1 3/3] irqchip/sifive-plic: Fix T-HEAD PLIC edge trigger
 handling
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-renesas-soc@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20220627051257.38543-1-samuel@sholland.org>
 <20220627051257.38543-4-samuel@sholland.org> <87edza36sz.wl-maz@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <bfeab4a3-11c4-b463-0bfc-a537fc133c24@sholland.org>
Date:   Mon, 27 Jun 2022 08:58:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87edza36sz.wl-maz@kernel.org>
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

On 6/27/22 2:27 AM, Marc Zyngier wrote:
> On Mon, 27 Jun 2022 06:12:57 +0100,
> Samuel Holland <samuel@sholland.org> wrote:
>>
>> The T-HEAD PLIC ignores additional edges seen while an edge-triggered
>> interrupt is being handled. Because of this behavior, the driver needs
>> to complete edge-triggered interrupts in the .irq_ack callback before
>> handling them, instead of in the .irq_eoi callback afterward. Otherwise,
>> it could miss some interrupts.
>>
>> Co-developed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>> Changes in v1:
>>  - Use a flag for enabling the changes instead of a variant ID
>>  - Use handle_edge_irq instead of handle_fasteoi_ack_irq
>>  - Do not set the handler name, as RISC-V selects GENERIC_IRQ_SHOW_LEVEL
> 
> Where is the Renesas handling gone? Can you, at the very least work,
> with Lad instead of proposing an alternative series that ignores the
> goal of the first one, however good it is (and it is admittedly
> better)?

Sorry, I have reached out to them, and will not send anything more until I hear
back. I thought it was clear that RZ/Five support becomes a trivial patch on top
of this, but I did not include it because there was some unresolved discussion
over what the compatible string should be.

>>
>>  drivers/irqchip/irq-sifive-plic.c | 76 +++++++++++++++++++++++++++++--
>>  1 file changed, 71 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
>> index 90515865af08..462a93b4b088 100644
>> --- a/drivers/irqchip/irq-sifive-plic.c
>> +++ b/drivers/irqchip/irq-sifive-plic.c
>> @@ -69,6 +69,7 @@ struct plic_priv {
>>  	struct cpumask lmask;
>>  	struct irq_domain *irqdomain;
>>  	void __iomem *regs;
>> +	bool needs_edge_handling;
>>  };
>>  
>>  struct plic_handler {
>> @@ -86,6 +87,9 @@ static int plic_parent_irq __ro_after_init;
>>  static bool plic_cpuhp_setup_done __ro_after_init;
>>  static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
>>  
>> +static struct irq_chip plic_edge_chip;
>> +static struct irq_chip plic_chip;
>> +
>>  static void __plic_toggle(void __iomem *enable_base, int hwirq, int enable)
>>  {
>>  	u32 __iomem *reg = enable_base + (hwirq / 32) * sizeof(u32);
>> @@ -181,6 +185,40 @@ static void plic_irq_eoi(struct irq_data *d)
>>  	}
>>  }
>>  
>> +static int plic_irq_set_type(struct irq_data *d, unsigned int flow_type)
>> +{
>> +	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
>> +
>> +	if (!priv->needs_edge_handling)
>> +		return IRQ_SET_MASK_OK_NOCOPY;
>> +
>> +	switch (flow_type) {
>> +	case IRQ_TYPE_EDGE_RISING:
>> +		irq_set_chip_handler_name_locked(d, &plic_edge_chip,
>> +						 handle_edge_irq, NULL);
>> +		break;
>> +	case IRQ_TYPE_LEVEL_HIGH:
>> +		irq_set_chip_handler_name_locked(d, &plic_chip,
>> +						 handle_fasteoi_irq, NULL);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return IRQ_SET_MASK_OK;
>> +}
>> +
>> +static struct irq_chip plic_edge_chip = {
>> +	.name			= "PLIC",
>> +	.irq_ack		= plic_irq_eoi,
>> +	.irq_mask		= plic_irq_mask,
>> +	.irq_unmask		= plic_irq_unmask,
>> +#ifdef CONFIG_SMP
>> +	.irq_set_affinity	= plic_set_affinity,
>> +#endif
>> +	.irq_set_type		= plic_irq_set_type,
>> +};
>> +
>>  static struct irq_chip plic_chip = {
>>  	.name			= "PLIC",
>>  	.irq_mask		= plic_irq_mask,
>> @@ -189,8 +227,22 @@ static struct irq_chip plic_chip = {
>>  #ifdef CONFIG_SMP
>>  	.irq_set_affinity	= plic_set_affinity,
>>  #endif
>> +	.irq_set_type		= plic_irq_set_type,
>>  };
>>  
>> +static int plic_irq_domain_translate(struct irq_domain *d,
>> +				     struct irq_fwspec *fwspec,
>> +				     unsigned long *hwirq,
>> +				     unsigned int *type)
>> +{
>> +	struct plic_priv *priv = d->host_data;
>> +
>> +	if (priv->needs_edge_handling)
>> +		return irq_domain_translate_twocell(d, fwspec, hwirq, type);
>> +	else
>> +		return irq_domain_translate_onecell(d, fwspec, hwirq, type);
>> +}
>> +
>>  static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
>>  			      irq_hw_number_t hwirq)
>>  {
>> @@ -211,7 +263,7 @@ static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>>  	unsigned int type;
>>  	struct irq_fwspec *fwspec = arg;
>>  
>> -	ret = irq_domain_translate_onecell(domain, fwspec, &hwirq, &type);
>> +	ret = plic_irq_domain_translate(domain, fwspec, &hwirq, &type);
>>  	if (ret)
>>  		return ret;
>>  
>> @@ -225,7 +277,7 @@ static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>>  }
>>  
>>  static const struct irq_domain_ops plic_irqdomain_ops = {
>> -	.translate	= irq_domain_translate_onecell,
>> +	.translate	= plic_irq_domain_translate,
>>  	.alloc		= plic_irq_domain_alloc,
>>  	.free		= irq_domain_free_irqs_top,
>>  };
>> @@ -286,8 +338,9 @@ static int plic_starting_cpu(unsigned int cpu)
>>  	return 0;
>>  }
>>  
>> -static int __init plic_init(struct device_node *node,
>> -		struct device_node *parent)
>> +static int __init __plic_init(struct device_node *node,
>> +			      struct device_node *parent,
>> +			      bool needs_edge_handling)
>>  {
>>  	int error = 0, nr_contexts, nr_handlers = 0, i;
>>  	u32 nr_irqs;
>> @@ -298,6 +351,8 @@ static int __init plic_init(struct device_node *node,
>>  	if (!priv)
>>  		return -ENOMEM;
>>  
>> +	priv->needs_edge_handling = needs_edge_handling;
>> +
>>  	priv->regs = of_iomap(node, 0);
>>  	if (WARN_ON(!priv->regs)) {
>>  		error = -EIO;
>> @@ -415,6 +470,17 @@ static int __init plic_init(struct device_node *node,
>>  	return error;
>>  }
>>  
>> +static int __init plic_init(struct device_node *node,
>> +			    struct device_node *parent)
>> +{
>> +	return __plic_init(node, parent, false);
>> +}
>>  IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
>>  IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
>> -IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_init); /* for firmware driver */
>> +
>> +static int __init plic_edge_init(struct device_node *node,
>> +				     struct device_node *parent)
>> +{
>> +	return __plic_init(node, parent, true);
>> +}
>> +IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_edge_init);
> 
> No. You are breaking existing platforms with established DTs. You must
> at least be able to run a new kernel with an old DT. Ideally the
> opposite too, but it is hard to retrofit this.

Thankfully, there are no established DTs for this platform. Upstreaming for
Allwinner D1 (the only documented user of this compatible) has been blocked by
its non-coherent DMA, which is just now getting resolved, including with other
major binding changes[1].

If you are referring more generally to DTs "in the wild", those all use
#interrupt-cells = <2> already, albeit with a stacked interrupt controller on
top that turned out not to be necessary[2].

Regards,
Samuel

[1]: https://lore.kernel.org/linux-riscv/20220619203212.3604485-2-heiko@sntech.de/
[2]:
https://github.com/smaeul/linux/blob/riscv/d1-wip/arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi
