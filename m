Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343504B3629
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 17:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbiBLQBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 11:01:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiBLQBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 11:01:13 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5963BB9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 08:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=+ZVBu0+pgU5WOFB3KOX6oQDUqUS9DuABscJXA+HoUno=; b=Yhr1S0H17buG4QnziENYKKrWrT
        eEq0vsvr3ELMp4XZQ+w4rI3c8W1Xmmd7WwRCRRyN7r+Kp2bTalCY+gf3mxx2zNZflHZ0VeOCODZ4O
        73YnLCHc3WEvuS4OE9M/2ImpVqtxQzuLC5REah+9vipj//IfuYeqzhk0DHPz4qdynd5kyPRmaGnB2
        Iryl31gS7/BA2UikPXUHg14UsJPEJeEYybIHXrlkcwPdGQHBDzFANDbLYXjzgfZWrH5u735+RtVN1
        7Q+hr8EoABhYK40Mxraz0zVhkNoI0Inlu6lvkYVeOEoxw0zNkpvfrnotMndX3BCHcq8cI9ZckYrxJ
        ghQoQcfw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIupY-009LX8-E4; Sat, 12 Feb 2022 16:01:00 +0000
Message-ID: <8ad7556a-cfdc-dae7-da58-89e973ca1179@infradead.org>
Date:   Sat, 12 Feb 2022 08:00:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] regmap: irq: cleanup comments
Content-Language: en-US
To:     trix@redhat.com, broonie@kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220212143144.2648689-1-trix@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220212143144.2648689-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/12/22 06:31, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Replace the second 'which' with 'the'.
> Change 'acknowleding' to 'acknowledging'.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/base/regmap/regmap-irq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
> index d5604f497296..81f6356f0589 100644
> --- a/drivers/base/regmap/regmap-irq.c
> +++ b/drivers/base/regmap/regmap-irq.c
> @@ -537,7 +537,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
>  
>  	/*
>  	 * Ignore masked IRQs and ack if we need to; we ack early so
> -	 * there is no race between handling and acknowleding the
> +	 * there is no race between handling and acknowledging the
>  	 * interrupt.  We assume that typically few of the interrupts
>  	 * will fire simultaneously so don't worry about overhead from
>  	 * doing a write per register.
> @@ -1082,7 +1082,7 @@ EXPORT_SYMBOL_GPL(devm_regmap_add_irq_chip);
>  /**
>   * devm_regmap_del_irq_chip() - Resource managed regmap_del_irq_chip()
>   *
> - * @dev: Device for which which resource was allocated.
> + * @dev: Device for which the resource was allocated.
>   * @irq: Primary IRQ for the device.
>   * @data: &regmap_irq_chip_data allocated by regmap_add_irq_chip().
>   *

-- 
~Randy
