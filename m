Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBF459B607
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 20:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiHUSgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 14:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiHUSgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 14:36:09 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F129A192A3;
        Sun, 21 Aug 2022 11:36:03 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id l1so11980842lfk.8;
        Sun, 21 Aug 2022 11:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=sWYRCKPzZNUJ326QE37gGcrO9oc82QKCR1L4KO18yAo=;
        b=pOc6suRiQkBz2Vp98NTIR54smqmqCQJ5g05e+LES9vIwk1/jawZb1PuCuAoj0lSTFk
         wHgDbIzMlZkhq3q2THxA6Xc6We3lp6zHweD0ddVT6a4XbybOK+4c6m6WyTVJzJEsrhtS
         +X+JeUCxO2xOpz+rtHvWnXpS3MkybRQcJPnJQS1/Cs92NbM0If8DZGB1ikvt9yVtRKfU
         XQW6GYfNSdGORrwf8KUHWK62fEvKP+Ew2b2Tg/QAX8RFMtVKdvH7nol7cmBJafWSeUrw
         FM4pgbBI8xxuR/PFnCZxjrfjmns9kj+12hDIl/rpxyzbgJYj81fUZPeAL4STVZMC4Srb
         Rm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=sWYRCKPzZNUJ326QE37gGcrO9oc82QKCR1L4KO18yAo=;
        b=ttlW8dfe+qhvgq/waCPFjR3rKhAJmx1TQLpDqnpwo/T6AgUKeD6isfdQ+3iS7SF/uR
         +at5ditzJ5Gkqu0LJqgT3RPHHwmXWYOxBjYPdqWXUu+QZ14EA/nmqg/TSI/gqTy79eOU
         +oWeHkuwewqOcuskyI1qZElXoHsoYxFh9F9EO15khwJDYzXmpKCLanOJlo0QKrl+fZgS
         sxqX5919LRj1kKNPxkACn02V8yxd1mIw+Zrmyp6dbChu4uPWiSKY8O/uXByWfg8LpIcn
         RqkiIenAOw3b+18IG/VU+86Ic3AZSs+5U+jtrvVN/Efqo/nFBflxaDkK7rgULbUpjrxT
         CqOQ==
X-Gm-Message-State: ACgBeo0PW172GGIv76egqt2Q16kAL+nY+nEStmlvswHdB4FpVk8htk8Z
        U1dcozFaEauPmoVqIOqO+nNW2JkecneLyQ==
X-Google-Smtp-Source: AA6agR5uMdLClrtMrGoVxtRJ7XAYtoRKdZwhTJ+dBE6NThLMmCjqZTmatid5GB4/oxWUGTmcMF06FA==
X-Received: by 2002:a05:6512:110e:b0:48f:b9bf:8f4a with SMTP id l14-20020a056512110e00b0048fb9bf8f4amr6134901lfg.676.1661106962233;
        Sun, 21 Aug 2022 11:36:02 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id x6-20020a056512078600b00492348c5ccesm792461lfr.281.2022.08.21.11.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 11:36:01 -0700 (PDT)
Date:   Sun, 21 Aug 2022 21:35:59 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     tglx@linutronix.de, maz@kernel.org, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/mips-gic: Fix typo in irq-mips-gic.c
Message-ID: <20220821183559.pnduerff7nq76sfj@mobilestation>
References: <20220811151657.10242-1-dengshaomin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811151657.10242-1-dengshaomin@cdjrlc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 11:16:57AM -0400, Shaomin Deng wrote:
> Remove the rebundant word "the" in comments.

Right. Thanks.
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> 
> Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
> ---
>  drivers/irqchip/irq-mips-gic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
> index ff89b36267dd..53daac318ccd 100644
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c
> @@ -490,7 +490,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
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
