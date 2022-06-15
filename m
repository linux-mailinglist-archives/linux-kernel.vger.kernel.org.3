Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D718A54C668
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348553AbiFOKoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348428AbiFOKnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:43:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6814D9EF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:43:51 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m24so14756608wrb.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CFylUOlVtQDlx55PEHRrX05zrzK1yc2bhHxx/T3f6Z8=;
        b=PIMDjKJsYqfZ/MR+nIeXqfEbPhyPUEGwCQsm2aotfcuPAZq6NmTU4aZkr/FnQ2RtaC
         bLG0ePy5JoUOkpK0Hgyb6hria385dOG0ajyrpmHm7n411b8jCNi6ADtRahHAUTZtj84n
         0bJ2T9Qwkedt4a80F6o6sJ2jRiX7Wyuw5dD1sSWy4CxR7ILPNA8ThGbLL8+ZbPyAW/fu
         2qvoXa5KLE3jbm5MaH3Lluj0vPVMs2/mhslVP7iV4FjbdNBSxJ3zROnog6TqyVrQSPnG
         0JkqsuCJlOIHX5FqYBne+NkgeIYqDbRKBmBqIMHKQ9Fir1D2NDivmY+jU+4FSRKyivep
         vOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CFylUOlVtQDlx55PEHRrX05zrzK1yc2bhHxx/T3f6Z8=;
        b=PbOGJ953xK2BEVsfm9qD609Z5OgX0jr125f6fmzlVlKmUgi21P1q8wG/lLhXk53RSw
         0EIh2wUfZP51XLrRKmbfKeDjyigRrDHJos7PTbTj+SecBsFfxx1OtaPvWJ/ZYoyNjTKw
         lM0f3PpYPiJQOQxDaM4t3xuqzz7csAcg09ZBMBX+6cHqvlfSDPt3S+3Q7qdfBF8GY8aI
         gsdyAjX3YArfCUnvQKod+0bMzhn4jHdRSyPldli6SZ9oqcfUhCcnv7BXdoruDXkybmqT
         YonBdbqzJQ+asj9h7EdKhgdU/Lxnl8+Jp1xlSCckt3fA51k5TvFyZn3WJUAO5eCAGwsB
         rVHg==
X-Gm-Message-State: AJIora8gvQUDmUlk1Re+ViDxJrZah01/fxIWGziHJ9mnwumw+klC3R4f
        AIFWcv7EuvqDRF+bvOFXjz+HMQMifdC0bj3u
X-Google-Smtp-Source: AGRyM1smox36WFgJH+GSvQeBUMdLufHU5UiXHoLYWTrtDiU8P2L0iHq5w0nIj35jNFBsQlGgf0DzVQ==
X-Received: by 2002:a5d:4a4c:0:b0:210:28d4:58a1 with SMTP id v12-20020a5d4a4c000000b0021028d458a1mr9594042wrs.339.1655289830384;
        Wed, 15 Jun 2022 03:43:50 -0700 (PDT)
Received: from [10.205.160.53] ([95.83.233.54])
        by smtp.gmail.com with ESMTPSA id l12-20020a5d674c000000b002185d79dc7fsm14269528wrw.75.2022.06.15.03.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 03:43:49 -0700 (PDT)
Message-ID: <aa7254a0-c7ce-3092-2da6-020ffef80142@conchuod.ie>
Date:   Wed, 15 Jun 2022 11:42:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] [Re-PATCH] arch: arm: mach-pxa: Add missing of_node_put
 in irq.c
Content-Language: en-US
To:     heliang <windhl@126.com>, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220615103332.3963303-1-windhl@126.com>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <20220615103332.3963303-1-windhl@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/06/2022 11:33, heliang wrote:
> [PATCH] [Re-PATCH] arch: arm: mach-pxa: Add missing of_node_put in irq.c

You mean [PATCH v2]? Pass -v N arg to format-patch & it'll do it
for you.

> In pxa_dt_irq_init(), of_find_matching_node() will return a node
> pointer with refcount incremented. We should use of_node_put in
> fail path or when it is not used anymore. This goto-label patch
> style is advised by Daniel.
> 
> Signed-off-by: heliang <windhl@126.com>

On all these patches, is "heliang" your (full) real name?
See:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1

> ---

It's helpful to put a changelog here too for what changed since v1

>   arch/arm/mach-pxa/irq.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
> index 96f33ef1d9ea..338356b9f37c 100644
> --- a/arch/arm/mach-pxa/irq.c
> +++ b/arch/arm/mach-pxa/irq.c
> @@ -247,13 +247,13 @@ void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int))
>   				   &pxa_internal_irq_nr);
>   	if (ret) {
>   		pr_err("Not found marvell,intc-nr-irqs property\n");
> -		return;
> +		goto out_put;
>   	}
>   
>   	ret = of_address_to_resource(node, 0, &res);
>   	if (ret < 0) {
>   		pr_err("No registers defined for node\n");
> -		return;
> +		goto out_put;
>   	}
>   	pxa_irq_base = io_p2v(res.start);
>   
> @@ -263,9 +263,12 @@ void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int))
>   	ret = irq_alloc_descs(-1, 0, pxa_internal_irq_nr, 0);
>   	if (ret < 0) {
>   		pr_err("Failed to allocate IRQ numbers\n");
> -		return;
> +		goto out_put;
>   	}
>   
>   	pxa_init_irq_common(node, pxa_internal_irq_nr, fn);
> +	
> +out_put:
> +	of_node_put(node);	
>   }
>   #endif /* CONFIG_OF */
