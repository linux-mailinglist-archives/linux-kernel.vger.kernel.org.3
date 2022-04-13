Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B7E4FF696
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbiDMMVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiDMMVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:21:31 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3083C5881F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:19:09 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id c7so2410012wrd.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ptB7Et3S8M5pQI4f73IBKmqdfhVlV4XPQTx3bIRJiBE=;
        b=AJI/9cjHAbde8bnYgwv9cRDJd6s56GsTEXVvU2OeQIbopkNK21mIiIwZycpgttLCRc
         Qow/SmpiPY27f+UMHiQj7vRv5Nk1/TEtYvCiy50MGeS/Zvv0P8f/w9Tl+xoldF7sZzRp
         oBHPG9q8DeAw2wfqcIvA5Wuo9Zz7pzZfGv1TamGeruF0ErHrYgAO7K0+lyQ0PfdscCjH
         otFGWP/5MMr5zn1zQ9ADOaGTARx0e8+MbNzLRJ1RqCRlNUeanGuU6+yjNZ/m97/q0BUq
         sS5Fv6UaK6K2SQGOxdZjKyjxxaxZMgRNSRJe/o0ObAlOfqGnPO9xzcmzDKqoSXuUZ69M
         Q2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ptB7Et3S8M5pQI4f73IBKmqdfhVlV4XPQTx3bIRJiBE=;
        b=C2bYzyjj1sJSRyPxIz4kajN4UNFaJTFTSylcaK9JezQcWde7M1mPwVHoGIBZgzH6i8
         2hTkhN3o2cMOIXkDVwinJomNEsVao+m7sAThxWnbJqigWCLYeWQKO/bncXLjUP4KGH74
         FnFmh708YagKqu6eaRkcAeGVZp68IF/5GkfSEaX50gbTe+X2yQuybmJ9nxkFNp9Nioaq
         y9POJaiOatasPoG0BzYlQZpmSCL3IqLO7qmeyfwNVGgohe0rZU4WkjpwB3z1d7dvxnar
         qZTQ+5G4lyUhd5eB24lAc6i9DYTwPKyu1c0PL5NMn/bIBqfo/1V7F55W6WZi8QiRPBeG
         UaIQ==
X-Gm-Message-State: AOAM5339w6jZ0OP1iwnmxOC91WDk6hOgnJM/ZKLn0t7mAZ7b/f1b5aSh
        s3g6XTp1QuYbZYuk3YtFO71Rtg==
X-Google-Smtp-Source: ABdhPJzVn/G30Zt8LoTwhk87/vIhyLjeY8nXgf5kmYO8ZH8Yly/kTmDhMgV9bYk/7ILiqX+rfD8p0g==
X-Received: by 2002:a05:6000:178c:b0:204:648:b4c4 with SMTP id e12-20020a056000178c00b002040648b4c4mr31444922wrg.219.1649852347667;
        Wed, 13 Apr 2022 05:19:07 -0700 (PDT)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id f9-20020a05600c154900b0038cb98076d6sm2650963wmg.10.2022.04.13.05.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 05:19:07 -0700 (PDT)
Message-ID: <d2a0b92d-88a0-ebde-df1a-d2b059ec129d@linaro.org>
Date:   Wed, 13 Apr 2022 13:19:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RESEND PATCH 1/3] nvmem: bcm-ocotp: mark ACPI device ID table as
 maybe unused
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
References: <20220413113809.243288-1-krzysztof.kozlowski@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220413113809.243288-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/04/2022 12:38, Krzysztof Kozlowski wrote:
> From: Krzysztof Kozlowski <krzk@kernel.org>
> 
> "bcm_otpc_acpi_ids" is used with ACPI_PTR, so a build with !CONFIG_ACPI
> has a warning:
> 
>    drivers/nvmem/bcm-ocotp.c:247:36: error:
>      ‘bcm_otpc_acpi_ids’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied all thanks,

--srini
> ---
>   drivers/nvmem/bcm-ocotp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/bcm-ocotp.c b/drivers/nvmem/bcm-ocotp.c
> index a8097511582a..dfea96c52463 100644
> --- a/drivers/nvmem/bcm-ocotp.c
> +++ b/drivers/nvmem/bcm-ocotp.c
> @@ -244,7 +244,7 @@ static const struct of_device_id bcm_otpc_dt_ids[] = {
>   };
>   MODULE_DEVICE_TABLE(of, bcm_otpc_dt_ids);
>   
> -static const struct acpi_device_id bcm_otpc_acpi_ids[] = {
> +static const struct acpi_device_id bcm_otpc_acpi_ids[] __maybe_unused = {
>   	{ .id = "BRCM0700", .driver_data = (kernel_ulong_t)&otp_map },
>   	{ .id = "BRCM0701", .driver_data = (kernel_ulong_t)&otp_map_v2 },
>   	{ /* sentinel */ }
