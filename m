Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289FA5A37E7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 15:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiH0NUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 09:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiH0NUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 09:20:16 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53C0726BB;
        Sat, 27 Aug 2022 06:20:14 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id n24so3920909ljc.13;
        Sat, 27 Aug 2022 06:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=f7tUYcOnTSQ6ehz47fSrJPerbj7591RmFAoZlu//qIU=;
        b=CMdaxjr5k48RIPG/4Z2eG8tCeGbiks757257PgoO5M8lP8UKsf+LeqrZqKW12xyBXl
         RbSPCKwDh8Bh8KtswPcgFodMJxat4uxBxcS7695zKkZShVp38AatT8Omi5apGbuABqRH
         zb74G2kYGwnW7vOk1sAgpibbraVd7nJNJNfqmDdN850sfHMHQOa9qcmf80XKT5ZxxxoG
         RHlTCeZZu42ZJd9Zxp54Xd/51v40Q/inSQ+15ufRkMvU4CNQUW61+tNSo59XM5Azfxqc
         JAhqhIXkGO/IbzxH4dIVp1PYBd79ZbnrBH3mlzYqY8036ZCEKnvLkncgQJ2xmMMaOGLi
         0lvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=f7tUYcOnTSQ6ehz47fSrJPerbj7591RmFAoZlu//qIU=;
        b=oOMCMN5kPQPbO6i8hyVAYIp7bx+8Ij8w+TpcL35w/8qH72tQUjIjV65bpvjLsxiguv
         dhBHIYmEOCnPSDj4om2RQzLm0aRKBLpLS9hLrycEnPK8qszZtfynRXp0miwvd6LH1gV2
         pQlJ6j/1BbrntKbSMPHR4pqa08C1KCoX7kdgfzrPcxKITFCBlS6zBj7aCexDWRy84YPE
         58OFkgBEkU8hDUSm3ag5HsYXbL/K4i2q/TgRio+hvgCsPF4G2tM30xfBsBwOtWjrChF8
         d6hom6kRdPyJcrvLngvmXxbOnDJzPCC9BXtHTO95KDXCGSpOOgqj9KZqYgulO0J0ToOi
         q4iQ==
X-Gm-Message-State: ACgBeo0YXheqyYqfcFU9bwXhQUGCyESln4QUS1NnSVsqOIbIQTJfdljE
        ZBmUoiigVENJvUiScWYBA77cLs9Ga+Q=
X-Google-Smtp-Source: AA6agR7j1geMvHuxRq9Te6y1twd15DEbaIksazpuOVvPdRtk4ELKgwAy3Qj7FWPKYShB4MpXLgfriQ==
X-Received: by 2002:a05:651c:49c:b0:261:ccdd:779d with SMTP id s28-20020a05651c049c00b00261ccdd779dmr3327211ljc.383.1661606412405;
        Sat, 27 Aug 2022 06:20:12 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id t30-20020a05651c205e00b00261e50a2534sm760122ljo.33.2022.08.27.06.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 06:20:11 -0700 (PDT)
Date:   Sat, 27 Aug 2022 16:20:08 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     maz@kernel.org, tsbogend@alpha.franken.de, tglx@linutronix.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/mips-gic: Fix comment typo
Message-ID: <20220827132008.wb2kw2hs5rwfo23j@mobilestation>
References: <20220802200106.5060-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802200106.5060-1-wangborong@cdjrlc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 04:01:06AM +0800, Jason Wang wrote:
> The double `the' is duplicated in the comment, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/irqchip/irq-mips-gic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
> index 1ba0f1555c80..1a6a7a672ad7 100644
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c
> @@ -494,7 +494,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
>  	map = GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin;
>  
>  	/*

> -	 * If adding support for more per-cpu interrupts, keep the the
> +	 * If adding support for more per-cpu interrupts, keep the

Thanks!

Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

>  	 * array in gic_all_vpes_irq_cpu_online() in sync.
>  	 */
>  	switch (intr) {
> -- 
> 2.35.1
> 
