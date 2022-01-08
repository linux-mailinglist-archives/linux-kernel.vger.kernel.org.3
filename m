Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4D24883E6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 15:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiAHODy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 09:03:54 -0500
Received: from marcansoft.com ([212.63.210.85]:51878 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbiAHODw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 09:03:52 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 16E9F41AC8;
        Sat,  8 Jan 2022 14:03:49 +0000 (UTC)
Message-ID: <f331a03d-3e57-5add-3aa7-f511b3ca370d@marcan.st>
Date:   Sat, 8 Jan 2022 23:03:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH] irqchip/apple-aic: Drop unused ipi_hwirq field
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
References: <20220108140118.3378937-1-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20220108140118.3378937-1-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/01/08 23:01, Marc Zyngier wrote:
> This field was never used, remove it.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/irq-apple-aic.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
> index a5927382172a..3683c71a4d27 100644
> --- a/drivers/irqchip/irq-apple-aic.c
> +++ b/drivers/irqchip/irq-apple-aic.c
> @@ -172,7 +172,6 @@ struct aic_irq_chip {
>  		cpumask_t aff;
>  	} *fiq_aff[AIC_NR_FIQ];
>  	int nr_hw;
> -	int ipi_hwirq;
>  };
>  
>  static DEFINE_PER_CPU(uint32_t, aic_fiq_unmasked);

Thanks!

Acked-by: Hector Martin <marcan@marcan.st>

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
