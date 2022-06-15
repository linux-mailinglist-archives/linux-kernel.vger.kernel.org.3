Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0268454CC5A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347937AbiFOPOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348048AbiFOPOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:14:11 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52183D49F;
        Wed, 15 Jun 2022 08:14:06 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso2412115pjl.3;
        Wed, 15 Jun 2022 08:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=229k0H7+DqhsAhRk93hVZYEBRmmZnz3+/5RyN+IPbPI=;
        b=kmh3vcPZCWY8TTdiC61fExQWPZo7Q4Y0TqDlpco5tywtiA37asijIIDV4gANod8InT
         +GHK2ydF3fByguGcKSXjjGP0GWPCKdFwsLxfhP/YgBNFZQtfiS8itMAbYptOs1nfhmIe
         zAiTQu/TcwMunzLlK4TxKYz1SdF3QWKdOn6QL9KCZZbK3UVlUPcD9yEy+tdePHyG6kQx
         fcBKXJ3Vjf/V5XgLFus51f5Oh0LGQcf5U/2sMOz/x+Mf35apf+EIaNwOT63PYBJgMTbl
         l3y+mLfHQF+o4oGoFpNq6SNXJYv6vgy2oLuYA/tv0TaZDwhn918SWMSvfwrfLMYzCI4x
         dp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=229k0H7+DqhsAhRk93hVZYEBRmmZnz3+/5RyN+IPbPI=;
        b=V+Igt54BGm+YSwYvkJ8baADavgi1sPV0KJ7h82RYy7whJNGBfBjEx3MdeY06yYRobt
         4Q38/kaJ3NLZsMAUjeH8g56LXn2IiAIqbfGWuQub/ZxIIh7dGn7BJCwtMngPrqVqgfba
         jh0v6j3HBlXvQVY6VTeEv5g0kxarwopZc4VqPcfw9pvrdgUBKmqgZUtHVjWORMaet2qP
         g0xZtciU2UpRMjzZx/SxXi59vntA04i9NCaeA97tcnXj1yefK7BxOIqTi8xOY9EXgm4z
         mvMJ4e5J/PkOobvHByGdsgpSjTjzxKMSlMUzgzGaH6PnKI9TdDoXDWKSwgR4i5mllBkM
         /SBw==
X-Gm-Message-State: AJIora/t80jjNtFDCPkT26CNZ92X2WQet/qjm28pmZ+MejkiAjSEKQUm
        XV5Xza6QEMsEhmbYPORjdWM=
X-Google-Smtp-Source: AGRyM1vJ3naFZfmk3ClOpBcHOahyw6FRg6E8vkK6CgrdHq9iXf/i5LYT6rfJs8zXg1qCcSAouBQ9BQ==
X-Received: by 2002:a17:90b:4a4e:b0:1e6:6757:d085 with SMTP id lb14-20020a17090b4a4e00b001e66757d085mr10820894pjb.207.1655306045645;
        Wed, 15 Jun 2022 08:14:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z14-20020a1709027e8e00b001676dac529asm9382635pla.146.2022.06.15.08.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 08:14:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <81aafa3b-5ec9-38d8-acdd-6449a4746622@roeck-us.net>
Date:   Wed, 15 Jun 2022 08:14:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] hwmon: (occ) remove NULL check before kvfree
Content-Language: en-US
To:     Dongliang Mu <dzm91@hust.edu.cn>, Jean Delvare <jdelvare@suse.com>,
        Eddie James <eajames@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Pekka Enberg <penberg@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220614133025.146745-1-dzm91@hust.edu.cn>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220614133025.146745-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/22 06:30, Dongliang Mu wrote:
> From: Dongliang Mu <mudongliangabcd@gmail.com>
> 
> kvfree can handle NULL pointer as its argument.
> According to coccinelle isnullfree check, remove NULL check
> before kvfree operation.
> 
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>

Actually, it turns out that I already got the same patch
and that it is already applied.

Thanks,
Guenter

> ---
> v1->v2: modify the commit title and signature
>   drivers/hwmon/occ/p9_sbe.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
> index 42fc7b97bb34..01405ae2f9bd 100644
> --- a/drivers/hwmon/occ/p9_sbe.c
> +++ b/drivers/hwmon/occ/p9_sbe.c
> @@ -55,8 +55,7 @@ static bool p9_sbe_occ_save_ffdc(struct p9_sbe_occ *ctx, const void *resp,
>   	mutex_lock(&ctx->sbe_error_lock);
>   	if (!ctx->sbe_error) {
>   		if (resp_len > ctx->ffdc_size) {
> -			if (ctx->ffdc)
> -				kvfree(ctx->ffdc);
> +			kvfree(ctx->ffdc);
>   			ctx->ffdc = kvmalloc(resp_len, GFP_KERNEL);
>   			if (!ctx->ffdc) {
>   				ctx->ffdc_len = 0;
> @@ -171,8 +170,7 @@ static int p9_sbe_occ_remove(struct platform_device *pdev)
>   	ctx->sbe = NULL;
>   	occ_shutdown(occ);
>   
> -	if (ctx->ffdc)
> -		kvfree(ctx->ffdc);
> +	kvfree(ctx->ffdc);
>   
>   	return 0;
>   }

