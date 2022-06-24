Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254B455A35B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiFXVMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 17:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiFXVMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 17:12:38 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5A985D3D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:12:36 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id s10so4095795ljh.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lTrnV2rYrJ8o1ODTyvarmJaUuIaEeYOS8mDXp4Te+J8=;
        b=gqdFAOJKjz24yjspPoQKSsNC0qU2rR1PtdJr0cZoHm+rxal4DzzoHFC6cvpxNm/Sp2
         eUtx2k4m2GCfJfnBLdSuC9NOpcU9veEdmoe7yVdh0B+NAxR07VzEaz7ZM9j8F3OPgEHc
         Bscm4zF88tcIMFPucw+edYQorIrsGltV2jpXXjuJNEqkZpy/B2Tjey6+B8PromDgr7jC
         SUte450LzO87e6yP9aJSrkQdLavayq8S5e2Z6seL5cZsbr5h+HJQiAsdGtKPAGzDHhUX
         parFNLrRFCNcSTVvxcBwOXfojdOpe3urd7pORk/iqtpIUdpgy3pnE4DZDl7iRldWS8CJ
         zIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lTrnV2rYrJ8o1ODTyvarmJaUuIaEeYOS8mDXp4Te+J8=;
        b=zkmKI8JAYZD+U4cJvQN0PxXIkFrnY/xMBQMoJWaa5TAZGcjPxHyxbV1wxHHhqMCWMj
         +diMjZ2Gom0UfZqrEex1PgBYfBWfGe5idMW1pf99gj6st1NXp3HzNaq1t3epiPrm+N0N
         fTcaYSg0aK6kWzDSvBMAezL69x/F9OiZsHCSr23OZpYmEre+vKaHXBELrh+Ai8aivgVy
         dFJK7Z3scTR9ajEycyeGXY+M8mfRyiuE+WgBgOftZxfnzrgE4wSk4DoJRPeEH5tHt/Hz
         Et9yYSsGr8lGOJnW6lPZL4NMAKak2RYcqcwir9tE2n+b0cZZhesBErFyWu7am1+aDFdF
         ATEA==
X-Gm-Message-State: AJIora96UwUpZF+SRsC3ES/k8lFtegsA2J7aVzZ58uhyYBMaZF01efSr
        n/lziPnyUa+5dLNz3mmkGuo=
X-Google-Smtp-Source: AGRyM1uqvHm9gGmDsqawX0ijWysHczgVnJIJmqxEsPP+wDSnmUpOkwsdpsLYi44eFEUtxbqnjkbc+A==
X-Received: by 2002:a2e:87c7:0:b0:25a:9605:a2b8 with SMTP id v7-20020a2e87c7000000b0025a9605a2b8mr439209ljj.148.1656105154752;
        Fri, 24 Jun 2022 14:12:34 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id p28-20020a056512139c00b00478ebc6be69sm517368lfa.261.2022.06.24.14.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 14:12:30 -0700 (PDT)
Date:   Sat, 25 Jun 2022 00:12:27 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        soc@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 1/2] bus: bt1-apb: Don't print error on
 -EPROBE_DEFER
Message-ID: <20220624211227.667ejjix3gboj6mt@mobilestation>
References: <20220624211015.7351-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624211015.7351-1-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, wrong version ID. I'll resend it.

-Sergey

On Sat, Jun 25, 2022 at 12:10:13AM +0300, Serge Semin wrote:
> The Baikal-T1 APB bus driver correctly handles the deferred probe
> situation, but still pollutes the system log with a misleading error
> message. Let's fix that by using the dev_err_probe() method to print the
> log message in case of the clocks/resets request errors.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Link: https://lore.kernel.org/lkml/20220610080103.10689-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v2:
> - Use the dev_err_probe() return value as the return status of the
>   corresponding method. (@Philipp)
> 
> Link: https://lore.kernel.org/lkml/20220610104030.28399-1-Sergey.Semin@baikalelectronics.ru
> Changelog v3:
> - Just resend.
> - Rebase onto the kernel v5.19-rcX.
> ---
>  drivers/bus/bt1-apb.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
> index b25ff941e7c7..63b1b4a76671 100644
> --- a/drivers/bus/bt1-apb.c
> +++ b/drivers/bus/bt1-apb.c
> @@ -175,10 +175,9 @@ static int bt1_apb_request_rst(struct bt1_apb *apb)
>  	int ret;
>  
>  	apb->prst = devm_reset_control_get_optional_exclusive(apb->dev, "prst");
> -	if (IS_ERR(apb->prst)) {
> -		dev_warn(apb->dev, "Couldn't get reset control line\n");
> -		return PTR_ERR(apb->prst);
> -	}
> +	if (IS_ERR(apb->prst))
> +		return dev_err_probe(apb->dev, PTR_ERR(apb->prst),
> +				     "Couldn't get reset control line\n");
>  
>  	ret = reset_control_deassert(apb->prst);
>  	if (ret)
> @@ -199,10 +198,9 @@ static int bt1_apb_request_clk(struct bt1_apb *apb)
>  	int ret;
>  
>  	apb->pclk = devm_clk_get(apb->dev, "pclk");
> -	if (IS_ERR(apb->pclk)) {
> -		dev_err(apb->dev, "Couldn't get APB clock descriptor\n");
> -		return PTR_ERR(apb->pclk);
> -	}
> +	if (IS_ERR(apb->pclk))
> +		return dev_err_probe(apb->dev, PTR_ERR(apb->pclk),
> +				     "Couldn't get APB clock descriptor\n");
>  
>  	ret = clk_prepare_enable(apb->pclk);
>  	if (ret) {
> -- 
> 2.35.1
> 
