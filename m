Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32979552FA6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347189AbiFUKYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiFUKX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:23:58 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BD928726
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 03:23:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 7E1F641E41;
        Tue, 21 Jun 2022 10:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1655807036; bh=or2jYBTvHc5DC00QfKzgpoKQ0q2+qSrljcosOMp58s0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=nNp6hEF5OMRy6s8WXZshEwtAOMi+5ztEyZCTyFxJoNg7qV3PsXc9xDZ4OvF8Etvss
         I6dWT4ArvPtiLu0qobyMWnvsu49cj8lv1RwqsAeEIdtT6kJCl01z/TKXzYS2CcALak
         6v/1vAzkzm3nbZgtBYitB2hfRORXC4WSe1fEYSd+LlDC9zMfu0Xnn9EW4wzpnkVRfj
         UTxiVXYbXMFxdLtxlibCJEB4X79tbEqN3OVm+WVXpyb5rIPqMYHD9EfPesVxgf5GxM
         PyK/Yso6z62NCxd1Vaycxj2Ch5oGTpd6/NcoesEWjr/2aSDuUGNH4ELq9zRDe/5Ze8
         cT4Mly7yoVuMQ==
Message-ID: <6644a632-9f63-b2a7-15fb-92e7c7613e1b@marcan.st>
Date:   Tue, 21 Jun 2022 19:23:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH -next] irqchip/apple-aic: Make symbol 'use_fast_ipi'
 static
Content-Language: es-ES
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Sven Peter <sven@svenpeter.dev>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
References: <20220618072824.562350-1-weiyongjun1@huawei.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20220618072824.562350-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2022 16.28, Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> drivers/irqchip/irq-apple-aic.c:231:1: warning:
>  symbol 'use_fast_ipi' was not declared. Should it be static?
> 
> This symbol is not used outside of irq-apple-aic.c, so marks it static.
> 
> Fixes: 2cf68211664a ("irqchip/apple-aic: Add Fast IPI support")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/irqchip/irq-apple-aic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
> index 5ac83185ff47..1c2813ad8bbe 100644
> --- a/drivers/irqchip/irq-apple-aic.c
> +++ b/drivers/irqchip/irq-apple-aic.c
> @@ -228,7 +228,7 @@
>  #define AIC_TMR_EL02_PHYS	AIC_TMR_GUEST_PHYS
>  #define AIC_TMR_EL02_VIRT	AIC_TMR_GUEST_VIRT
>  
> -DEFINE_STATIC_KEY_TRUE(use_fast_ipi);
> +static DEFINE_STATIC_KEY_TRUE(use_fast_ipi);
>  
>  struct aic_info {
>  	int version;
> 
> 

Reviewed-by: Hector Martin <marcan@marcan.st>

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
