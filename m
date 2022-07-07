Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3855697D1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 04:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbiGGCLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 22:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiGGCLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 22:11:33 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760952F013
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 19:11:31 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 3760C320014C;
        Wed,  6 Jul 2022 22:11:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 06 Jul 2022 22:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1657159887; x=1657246287; bh=Oqjo7bte1PnK+DaOS4Pw+4uzHzG8
        H+vyhDqlF6sLUXU=; b=jNedMEQdn3OAOPkBqKQgVB50yYJJlF49ciekBr04fdy4
        4T+sJoQCUFY5dEj8/8go2nuWOHibfv3jiM2IdGDDskvR+g3jd32+J8i/iiDipJ8h
        LLtIIM0bsmLg9RCmKMMqkMbFs3LCisOMztECRR5H4gCPSgR0wJ6w/D5a6Sx007Kw
        xBpM5PEteepeGfN2z8XdRp9mfA8t7yL9DLU1Pw9C1ZXrV43tWFg4phBLwtjrlg1Y
        Wdg5HaqzIRtCNAVcCLBS6Og1QiWseyWES4QqW3Yi2dma8uGti0PTaE3LN7ZoObOZ
        rSSvXxSS9mBLcuhXAlhkM0BjQU9WqRCuod6RQOIGiQ==
X-ME-Sender: <xms:z0DGYk4CArNTJy9hZ086z0pnX3f6MbA51YjT0Fs6ubKLZ-OEz6xVNw>
    <xme:z0DGYl4ryxEEZb79GeTO2wTogOvpA0mav1q05JcBdg34yhP6YrGyNzB9cUIBtMyit
    4A2Um4hQEnbBH9aVPI>
X-ME-Received: <xmr:z0DGYjdDgJLlDIJLXQGU2xnlfmXxHRrKx56twGXlB3MrqERf-DF76RQhx1VJ64Be8CGh6dtjhgRbnnj8zxtpOPl0Nl53GeWrTeo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeigedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeu
    heeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:z0DGYpJ0l4od_6M_8G6SIiEBq11i9AvufHtSFqlz35rRo6QvogxLSw>
    <xmx:z0DGYoKSE2RZQMQOArKh056lOol1w127UQA7FMZtnlQl0-cocHanAw>
    <xmx:z0DGYqzJtH54cOkoTdpaWcNkRYKK3As3RuY_82PWGnXNNVjxBDnzTA>
    <xmx:z0DGYizwh5TT_rtTRJkHSGE3WyfIZWnhdly8jAuoASaOnVsuTCFuCA>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Jul 2022 22:11:24 -0400 (EDT)
Date:   Thu, 7 Jul 2022 12:11:33 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: mac: Remove forward declaration for
 mac_nmi_handler()
In-Reply-To: <fa48394ecba7c29a2da354d13c1017b37237f25b.1657114783.git.geert@linux-m68k.org>
Message-ID: <181e93f-9830-75db-a088-6cbff0de27da@linux-m68k.org>
References: <fa48394ecba7c29a2da354d13c1017b37237f25b.1657114783.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2022, Geert Uytterhoeven wrote:

> Move mac_nmi_handler() before its caller, so its forward declaration can
> be dropped.  While at it, make the function static, and absorb the
> variable in_nmi, which is only used inside the function.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: Finn Thain <fthain@linux-m68k.org>

BTW, this code needs the race condition fixed but I think that would 
require CONFIG_ADVANCED && CONFIG_RMW_INSNS, and arch/m68k/Kconfig.cpu 
advises against it. There is some discussion of Amiga and Atari in 
relation to RMW and it's claimed "it is also said to destabilize other 
machines" which may be true but doesn't help much.

> ---
> To be queued in the m68k tree for v5.20.
> 
>  arch/m68k/mac/macints.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/m68k/mac/macints.c b/arch/m68k/mac/macints.c
> index e3575388cd05a8cc..883e48230f87a187 100644
> --- a/arch/m68k/mac/macints.c
> +++ b/arch/m68k/mac/macints.c
> @@ -129,8 +129,6 @@
>  
>  extern void show_registers(struct pt_regs *);
>  
> -irqreturn_t mac_nmi_handler(int, void *);
> -
>  static unsigned int mac_irq_startup(struct irq_data *);
>  static void mac_irq_shutdown(struct irq_data *);
>  
> @@ -142,6 +140,21 @@ static struct irq_chip mac_irq_chip = {
>  	.irq_shutdown	= mac_irq_shutdown,
>  };
>  
> +static irqreturn_t mac_nmi_handler(int irq, void *dev_id)
> +{
> +	static volatile int in_nmi;
> +
> +	if (in_nmi)
> +		return IRQ_HANDLED;
> +	in_nmi = 1;
> +
> +	pr_info("Non-Maskable Interrupt\n");
> +	show_registers(get_irq_regs());
> +
> +	in_nmi = 0;
> +	return IRQ_HANDLED;
> +}
> +
>  void __init mac_init_IRQ(void)
>  {
>  	m68k_setup_irq_controller(&mac_irq_chip, handle_simple_irq, IRQ_USER,
> @@ -254,18 +267,3 @@ static void mac_irq_shutdown(struct irq_data *data)
>  	else
>  		mac_irq_disable(data);
>  }
> -
> -static volatile int in_nmi;
> -
> -irqreturn_t mac_nmi_handler(int irq, void *dev_id)
> -{
> -	if (in_nmi)
> -		return IRQ_HANDLED;
> -	in_nmi = 1;
> -
> -	pr_info("Non-Maskable Interrupt\n");
> -	show_registers(get_irq_regs());
> -
> -	in_nmi = 0;
> -	return IRQ_HANDLED;
> -}
> 
