Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96125B07A6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiIGO4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiIGOzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:55:45 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46451A2841;
        Wed,  7 Sep 2022 07:55:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bq23so22858252lfb.7;
        Wed, 07 Sep 2022 07:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=bS9XWRHxlvCbchNOjXWqC5HdNhAgYLYntcgyPEdzLyg=;
        b=T6KW4iTPkBvzkp/G0l4Vm9GySDlc8a2nycwFdMCiGze9f830StRgywzypiu2Lxbk0G
         U6U1UNvZxv8pfHPFD/mIvlWdboRt+XVd21Nmm2fD6Eqm3fBzgEtJDclI9hlntmr+Hb5G
         W3LJidMyUChQZ9gor0VE11u/zrRIy04t++oJ1NGfp62rYrgNGQq9Kij+69jFgskfGoi7
         k9IV3O+H/bp/6webGHOBUCnfsNb15EKJW9YiQDlSngV5cYeqKHpXZ2UfWpV8QNHc9Qtj
         w05cZclR/2PYs6G1n/4yr+PYWeXtRaViJv7lUEzRNf0jbNp/2b/k91jmqo4Wac1PqBRm
         9xZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=bS9XWRHxlvCbchNOjXWqC5HdNhAgYLYntcgyPEdzLyg=;
        b=dYzpUiClsD/l/TZAtvJQt2lN3G2v53b578ZOtoYKj7hiqqxjDuVQut2/b3SA5XrIzW
         ysM9Ax69338J4HBXRedt1lq7U23zE0L1Ti9nJG7BNF6Mz5mEf/hTo1GwOk5j5vBPZNii
         jN5wF8dk2/yz47hK2ee/qHc4TIpmvARSfftsQL1W3bntdjsxO07JcdTrKpfFkqbTnp8y
         NRoLZx5dHcJ4m3Keda2LduGXExjyxhnmKLwfltyn0JowXIjqHwIDTYTLbd0aNHuzKe+6
         nfEirFHTlCBDb2gkwmeGgtC6wSKFcIoXdhGkZYcWenbsYCciSU/g7uxR3kaR9tCucH8J
         mCmw==
X-Gm-Message-State: ACgBeo31QY8o9ERk1TWbCygDitLB+kweSE3l7C+vhCNciOsZYaHOW9VK
        Iemm3l8n87cNzqZkOeGP/Dc=
X-Google-Smtp-Source: AA6agR4ESyrsMZ2Xixi8o8Ysak8zawSB94JsSeYjrsDCaYrn7mY192jTBluOtbxx8AccvCkzmm27nw==
X-Received: by 2002:a05:6512:398c:b0:497:a0ad:c677 with SMTP id j12-20020a056512398c00b00497a0adc677mr1300774lfu.534.1662562514986;
        Wed, 07 Sep 2022 07:55:14 -0700 (PDT)
Received: from mobilestation (89-109-51-230.dynamic.mts-nn.ru. [89.109.51.230])
        by smtp.gmail.com with ESMTPSA id s2-20020a056512214200b0048b969ac5cdsm2548079lfr.5.2022.09.07.07.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 07:55:14 -0700 (PDT)
Date:   Wed, 7 Sep 2022 17:55:12 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     maz@kernel.org, tsbogend@alpha.franken.de, tglx@linutronix.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/mips-gic: Fix comment typo
Message-ID: <20220907145512.yz27qxgdvzsjvrxg@mobilestation>
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

Thanks.
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

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
>  	 * array in gic_all_vpes_irq_cpu_online() in sync.
>  	 */
>  	switch (intr) {
> -- 
> 2.35.1
> 
