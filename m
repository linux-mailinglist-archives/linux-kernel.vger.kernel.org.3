Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749E4583BA7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbiG1KCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbiG1KCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:02:18 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3AA4D4FF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 03:02:17 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d3so1386397pls.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 03:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QMSVS5co5DmQWtBsGYgUz11jaolJ6abD96Bm3WbXxQQ=;
        b=sYD71ADoWtX4BaIx2emIjxU1J4bV15HBdyGFVZKkDRrjpgFHGR0Fg3ijCNvH85DeKK
         fiWfBRl+dzTQSOAIIxRFAkQ3uTGREnlg6EIkMEWr2zxS97gUHOqjyda/LOq4HiKrrp5T
         WFxRaQFpWOaCFgPwdnByfOGgUn4voXe32Ro3byZdEYZXE95aUWybUySNNsfaueMXZXuR
         KxzUB1mUpsaO7DvMuUVKnxZIyHYWuTUOfMkI5r8lNLix/p8K888tQvS8aBfKEUD1G0/u
         22chg7Xjvv9M5cSL1EVJg5Fd/lC9FrW68PenrKDx6Xe285zXLo1OrfYqy8c3lWqKlTLn
         hQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QMSVS5co5DmQWtBsGYgUz11jaolJ6abD96Bm3WbXxQQ=;
        b=sGy6Q5Co1zlw6X43wRfAMQbrbVnM7+AQVy9WJAIMbOeVOlHTwHr1lwQ/F0nxVpjs5j
         OPsqdHfhNMbFPB6mUXCGj0PCiqZ2eDM+iK4h3X2BosVInvhYaLWEj6X5Hjwx/jAqHX7H
         OyH5f9Zbm7e6zHljTF2gENRgSMsnAnUpt5lzC3DKJoww4u6x/DCIQtUgHPaGOB+nWyTI
         YBdu/CDKCjo0tyZV1L3QZO7EUpzPelQqNanEmjNAFzfNhEWCEsbQoWcEilSz3ImbpHff
         FRgG5VWaegq2cvBepg9p25+xtOX7JraQEc4qT0TkMGSSXfNsbCQuPmvUWDkMikQyI4q7
         KfuQ==
X-Gm-Message-State: AJIora+OzCIRLYOmZNFAIbSWhzL/oS3xr1RbkccGDsqVIa8jHrQG3RLE
        aJG/TRbazjmg3q3oa/0l19O/aZan5sSHBg==
X-Google-Smtp-Source: AGRyM1uFrkLd9HUUAhgrHZkURycMBvtkxMTTtDK/WsVdopz6XAOnBSOEIzHbc+KdFdTGUgsdl+EIRg==
X-Received: by 2002:a17:902:9a07:b0:16d:3c0a:b9e7 with SMTP id v7-20020a1709029a0700b0016d3c0ab9e7mr25849014plp.149.1659002537073;
        Thu, 28 Jul 2022 03:02:17 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id v12-20020a1709029a0c00b0016c454598b5sm761271plp.167.2022.07.28.03.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 03:02:16 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:32:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Zeng Jingxiang <zengjx95@gmail.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeng Jingxiang <linuszeng@tencent.com>
Subject: Re: [PATCH v2] rtc: rtc-spear: set range max
Message-ID: <20220728100214.dta4feqm5zo25f4g@vireshk-i7>
References: <20220728100101.1906801-1-zengjx95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728100101.1906801-1-zengjx95@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-07-22, 18:01, Zeng Jingxiang wrote:
> From: Zeng Jingxiang <linuszeng@tencent.com>
> 
> In the commit f395e1d3b28d7c2c67b73bd467c4fb79523e1c65 
> ("rtc: spear: set range"), the value of 
> RTC_TIMESTAMP_END_9999 was incorrectly set to range_min.
> 390	config->rtc->range_min = RTC_TIMESTAMP_BEGIN_0000;
> 391	config->rtc->range_max = RTC_TIMESTAMP_END_9999;
> 
> Fixes: f395e1d3b28d ("rtc: spear: set range")
> Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

> ---
> 
> Change in v2:
> - Add fixes tag
> 
>  drivers/rtc/rtc-spear.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-spear.c b/drivers/rtc/rtc-spear.c
> index d4777b01ab22..736fe535cd45 100644
> --- a/drivers/rtc/rtc-spear.c
> +++ b/drivers/rtc/rtc-spear.c
> @@ -388,7 +388,7 @@ static int spear_rtc_probe(struct platform_device *pdev)
>  
>  	config->rtc->ops = &spear_rtc_ops;
>  	config->rtc->range_min = RTC_TIMESTAMP_BEGIN_0000;
> -	config->rtc->range_min = RTC_TIMESTAMP_END_9999;
> +	config->rtc->range_max = RTC_TIMESTAMP_END_9999;
>  
>  	status = devm_rtc_register_device(config->rtc);
>  	if (status)
> -- 
> 2.27.0

-- 
viresh
