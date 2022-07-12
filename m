Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771B7572720
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiGLUTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbiGLUTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:19:39 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383FEC9126
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:19:38 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0ECB15C0118;
        Tue, 12 Jul 2022 16:19:35 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Tue, 12 Jul 2022 16:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1657657175; x=1657743575; bh=F3
        AZUElnNArrOZWRKy/0kdLhWMZvnNlZGE5enm+lgFE=; b=ESjT7O4AcP1QjP25il
        gFzmSEM+CtgysIiyxOieZvN5KY88kwFTZQLEivlU+r1NnBZ9HvAmetA9wqvxVp4t
        D6eiPISyyYv02IoyBfm3Y3FAXl1AqTvGfRdBLYh8kKB6vCLr0XI/BxA3zai1igWF
        BScvxEtRWLOQAohBpwLGOKm9qMKn3vSkAtXVXE1KlahBDT3EptpD5QiFdLci9FZn
        gLOIYxlXNHMQYkJyaRmhlxVkTYu4SpTxjWRGSjbUI4gzPcEnInclrUbeJ7EbC2O0
        UebP/H38YsMTulrI6CP6cUZfY01xQ+8Tzrek2jUUpO+Z0FH8o/thVsn/DZJoH6EF
        gTnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1657657175; x=1657743575; bh=F3AZUElnNArrOZWRKy/0kdLhWMZv
        nNlZGE5enm+lgFE=; b=zvkWu3Z8KV5srTErsbmqjKtN8VCvk0RhZR+l/28O8aMT
        L8RrR3Db/VgP+XtC69askvm5G0L8dnxRjF+AHw+duDuY1jhELcdvWmeYcACPL0Fk
        k74guSjpQa+C5FFocOLYaZ3CQrQ4LEHcy1+YkIeh1/ap7UKyZCdB5jv9QgCHx1lY
        O3Jf6n7j8jRbw/wmWytqV92S3o4w5FA6frXKdCKNfGy7yaTGR53BZx9xdy1COKT7
        UYaeHmRPOPZkJvE4t82rXuUkPjoohvqOFJ1U+xS3liBM6V4qbIfkeM8V2aBYQtJY
        TYSUeXQ1M+R1YIPonp3vRt9zJUhui/kl84l9GInqvg==
X-ME-Sender: <xms:VtfNYu3oE6bU_m6HFkNXpafhG671_kaE6aOpHg66OIoVvhUWucbJrg>
    <xme:VtfNYhE3MSKGPhY_kEALC3t8ggq1Gz0qsmIVSDUBaqeTrnW9SYlXHl04ljHXMYniw
    6j1WLXCIW17cj1xl6k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejhedgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfu
    vhgvnhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtf
    frrghtthgvrhhnpeelvefggeffheevtdeivefhkeehfeettdejteduveeiheevveeilefg
    hfeiveeiueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:VtfNYm4Qej-XsnL0K_fsog_09fhWaiSUw9HK6jBSj4-AwRHa0kWadA>
    <xmx:VtfNYv0-B4AEOnRqzwDTGp4bQ3XsoSdtC-nkrJlRowfXX_h1kr601w>
    <xmx:VtfNYhHkLLlcCu_-4IQCfiLeFpdOHaPOZDy3CMQGXYOgBTPMMk7VzQ>
    <xmx:V9fNYgAZDhi9pHtvgCG7xolP491xCPKBvILQ8FY-n4w8broFMhGoJg>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 74332A6007C; Tue, 12 Jul 2022 16:19:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-755-g3e1da8b93f-fm-20220708.002-g3e1da8b9
Mime-Version: 1.0
Message-Id: <17ea4f4d-a926-404d-8b78-3708d7df71a9@www.fastmail.com>
In-Reply-To: <acd89b38-89e1-f6d6-2f98-01d94d9984bb@somainline.org>
References: <20220712160919.740878-1-konrad.dybcio@somainline.org>
 <20220712160919.740878-2-konrad.dybcio@somainline.org>
 <87a69e16x1.wl-maz@kernel.org>
 <acd89b38-89e1-f6d6-2f98-01d94d9984bb@somainline.org>
Date:   Tue, 12 Jul 2022 22:17:48 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        "Marc Zyngier" <maz@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] irqchip/apple-aic: Add support for A7-A11 SoCs
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



On Tue, Jul 12, 2022, at 21:23, Konrad Dybcio wrote:
> On 12.07.2022 21:12, Marc Zyngier wrote:
>> Hi Konrad,
>> 
>> Please add a cover letter when sending more than a single patch.
>> 
>> On Tue, 12 Jul 2022 17:09:19 +0100,
>> Konrad Dybcio <konrad.dybcio@somainline.org> wrote:
>>>
>>> Add support for A7-A11 SoCs by if-ing out some features only present on
>>> A12 & newer (UNCORE2 registers) or M1 & newer (EL2 registers - the
>>> older SoCs don't implement EL2).
>>>
>>> Also, annotate IPI regs support (A11 and newer*) so that the driver can
>>> tell whether the SoC supports these (they are written to even if fast
>>> IPI is disabled, when the registers are there of course).
>>>
>>> *A11 is supposed to use this feature, but it is currently not working.
>>> That said, it is not yet necessary, especially with only one core up,
>>> and it works a-ok using the same featureset as earlier SoCs.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>> ---
>>>  drivers/irqchip/irq-apple-aic.c | 54 +++++++++++++++++++++++----------
>>>  1 file changed, 38 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
>>> index 12dd48727a15..36f4b52addc2 100644
>>> --- a/drivers/irqchip/irq-apple-aic.c
>>> +++ b/drivers/irqchip/irq-apple-aic.c
>>> @@ -245,7 +245,10 @@ struct aic_info {
>>>  	u32 die_stride;
>>>  
>>>  	/* Features */
>>> +	bool el2_regs;
>>>  	bool fast_ipi;
>>> +	bool ipi_regs;
>>> +	bool uncore2_regs;
>>>  };
>>>  
>>>  static const struct aic_info aic1_info = {
>>> @@ -261,7 +264,10 @@ static const struct aic_info aic1_fipi_info = {
>>>  	.event		= AIC_EVENT,
>>>  	.target_cpu	= AIC_TARGET_CPU,
>>>  
>>> +	.el2_regs	= true,
>>>  	.fast_ipi	= true,
>>> +	.ipi_regs	= true,
>>> +	.uncore2_regs	= true,
>>>  };
>>>  
>>>  static const struct aic_info aic2_info = {
>>> @@ -269,7 +275,10 @@ static const struct aic_info aic2_info = {
>>>  
>>>  	.irq_cfg	= AIC2_IRQ_CFG,
>>>  
>>> +	.el2_regs	= true,
>>>  	.fast_ipi	= true,
>>> +	.ipi_regs	= true,
>>> +	.uncore2_regs	= true,
>> 
>> So to sum it up, all recent cores have all the cool features, and the
>> older ones have none of them. Surely we can do better than adding 3
>> fields that have the same value. Turn 'fast_ipi' into something that
>> means 'full_fat', and key everything on that.
>> 
>> And if this is meant to evolve into a more differentiated set of
>> features, the usual idiom is to have a set of flags as part of an
>> unsigned long instead of a set of booleans.
> The latter would be true if a bootrom exploit or any equivalent means
> of booting Linux would be found for A12 (M1 is family with A14 for context).
>
> We can think of 4 feature levels, I think:
>
> A7-A10: 'nothing fancy'
> A11: fast_ipi (broken currently, need to investigate)
> A12: A11 + UNCORE2 regs
> M1+: A12 + EL2
>
> We *could* squash the A12-A14 case into M1, but then if a means of booting
> Linux appears, this would have to be untangled again..
>
>> 
>>>  };
>>>  
>>>  static const struct of_device_id aic_info_match[] = {
>>> @@ -452,6 +461,9 @@ static unsigned long aic_fiq_get_idx(struct irq_data *d)
>>>  
>>>  static void aic_fiq_set_mask(struct irq_data *d)
>>>  {
>>> +	if (!aic_irqc->info.el2_regs)
>>> +		return;
>> 
>> Why? AIC_TMR_EL02_PHYS is defined as the interrupt that fires in the
>> context of a guest. There is no guest here (no EL2 either), so what
>> you should have as interrupt number is AIC_TMR_EL0_{PHYS,VIRT}, and
>> this change becomes irrelevant (nothing to mask). Which is also what
>> happens when running an M1 under the m1n1 hypervisor.
> This func accesses impl-defined regs that are not present on earlier SoCs.
>
>> 
>>> +
>>>  	/* Only the guest timers have real mask bits, unfortunately. */
>>>  	switch (aic_fiq_get_idx(d)) {
>>>  	case AIC_TMR_EL02_PHYS:
>>> @@ -469,6 +481,9 @@ static void aic_fiq_set_mask(struct irq_data *d)
>>>  
>>>  static void aic_fiq_clear_mask(struct irq_data *d)
>>>  {
>>> +	if (!aic_irqc->info.el2_regs)
>>> +		return;
>>> +
>>>  	switch (aic_fiq_get_idx(d)) {
>>>  	case AIC_TMR_EL02_PHYS:
>>>  		sysreg_clear_set_s(SYS_IMP_APL_VM_TMR_FIQ_ENA_EL2, 0, VM_TMR_FIQ_ENABLE_P);
>>> @@ -524,12 +539,14 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
>>>  	 * we check for everything here, even things we don't support yet.
>>>  	 */
>>>  
>>> -	if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
>>> -		if (static_branch_likely(&use_fast_ipi)) {
>>> -			aic_handle_ipi(regs);
>>> -		} else {
>>> -			pr_err_ratelimited("Fast IPI fired. Acking.\n");
>>> -			write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
>>> +	if (aic_irqc->info.ipi_regs) {
>> 
>> This is probably the hottest path in the whole kernel. Do we want an
>> extra read here? Absolutely not. At the very least, this should be a
>> static key.
> Yeah, makes sense..
>
>
>> 
>>> +		if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
>>> +			if (static_branch_likely(&use_fast_ipi)) {
>>> +				aic_handle_ipi(regs);
>>> +			} else {
>>> +				pr_err_ratelimited("Fast IPI fired. Acking.\n");
>>> +				write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
>>> +			}
>>>  		}
>>>  	}
>>>  
>>> @@ -566,12 +583,14 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
>>>  					  AIC_FIQ_HWIRQ(irq));
>>>  	}
>>>  
>>> -	if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) == UPMCR0_IMODE_FIQ &&
>>> -			(read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & UPMSR_IACT)) {
>>> -		/* Same story with uncore PMCs */
>>> -		pr_err_ratelimited("Uncore PMC FIQ fired. Masking.\n");
>>> -		sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
>>> -				   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
>>> +	if (aic_irqc->info.uncore2_regs) {
>> 
>> Same thing.
>> 
>>> +		if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) == UPMCR0_IMODE_FIQ &&
>>> +				(read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & UPMSR_IACT)) {
>>> +			/* Same story with uncore PMCs */
>>> +			pr_err_ratelimited("Uncore PMC FIQ fired. Masking.\n");
>>> +			sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
>>> +					FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
>>> +		}
>>>  	}
>>>  }
>>>  
>>> @@ -676,7 +695,8 @@ static int aic_irq_domain_translate(struct irq_domain *id,
>>>  				break;
>>>  			case AIC_TMR_HV_PHYS:
>>>  			case AIC_TMR_HV_VIRT:
>>> -				return -ENOENT;
>>> +				if (aic_irqc->info.el2_regs)
>>> +					return -ENOENT;
>> 
>> See my comment above about the use of these interrupt numbers.
> `if (!is_kernel_in_hyp_mode()) {` always evaluates to true, since there's
> no EL2. Hence, accessing AIC_TMR_HV_{VIRT,PHYS} makes this return ENOENT,
> which means timer can't probe and that's no bueno.

Sounds like an issue with your device tree. There should be no reference to
AIC_TMR_HV_{VIRT,PHYS} in there.


Sven
