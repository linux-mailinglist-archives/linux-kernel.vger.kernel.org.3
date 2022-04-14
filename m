Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0694750077B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240496AbiDNHqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240816AbiDNHqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:46:11 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFFF60CC5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:42:03 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c10so5743152wrb.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wXL/FLXJjbsCX0S4WtQaLaMwmMlertvo/nGS0JKpv+g=;
        b=jZRSFCQHl8B8+IHjwqdy0iEeXh84zus7J1ebKC6Liq6Hw20IpG0YCsAZxl80iBfNZf
         eJdFDY8Y1rXA8LUW1maZ+RIM//Bv/IA+YowQvi10K2PMXpTLvVXNJ9XCuYJaI9A2n9Im
         4YL+Za/pehPUcfDVIH6tFFGcd+TKT6gWeLV2bnwvh3NMVOzIhEB1mniDjiMp/4v9fBaf
         Pe0FLIrukireUxeLZGye5dk+LgXeG8FcIuJMGiDmy9mNemQHHU8aCBGAgKlHQI3BVrZ5
         tKfeMClFZ0QFRce9P+yIgtkw/Ol+LT1wyliNzXHVVuKaitD5iOzM744UiP1Wnoj4LE5R
         RaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wXL/FLXJjbsCX0S4WtQaLaMwmMlertvo/nGS0JKpv+g=;
        b=uEpRJM/ydgl3Qi7Cqpd7EBJwvaSWwb53Nx5g3hGhlyPg2m/QNSs47RaJe3pwwETuey
         SDRfhDyHqGt9QedFqt7wCAKk3S5OvuEujrttdnGeDpQpHy8r9K4287PfkpCkjksGBBMr
         8nxG1xvnzCvXBEeBSS5HS/PgTeDk0U1OQoImSb7L+uAVQQNfU6RgQu9RMQEp+pyKaxne
         iyFjP8tII7HV0FOa+PPAIeqstzi55YmWaFDcTF4w78CaFqUhVRJFikoeys3fU+PThuvC
         mWdmro2fuuA3UvoPB9hVigXRtnfNARhXQkHDZy5mC00hKVKeH3ciUJ6/5ZEPzc6LXNpk
         HFQA==
X-Gm-Message-State: AOAM53346gGgQK5LmKbljFm6zwjokRY16Bo28kPBtS7sgSIxTU+R/LfK
        vAUzYCsx7DlwYtsSBorzQbHOKQ==
X-Google-Smtp-Source: ABdhPJz5AfWKmdXuoZrULNxOfDYOoVflfMymsZWBulEYwj8w6Php6ilkbuuiH6mMHLl/snQ46lPQqQ==
X-Received: by 2002:a05:6000:8b:b0:207:b80e:c711 with SMTP id m11-20020a056000008b00b00207b80ec711mr1074827wrx.178.1649922121839;
        Thu, 14 Apr 2022 00:42:01 -0700 (PDT)
Received: from [192.168.1.41] (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id e16-20020a05600c2dd000b0038ed449cbdbsm4643142wmh.3.2022.04.14.00.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 00:42:01 -0700 (PDT)
Message-ID: <df69e901-8e50-852f-84de-4158e97e653b@linaro.org>
Date:   Thu, 14 Apr 2022 09:42:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3] thermal: exynos: fix masking value for exynos7
 temp_error
Content-Language: en-US
To:     hypmean.kim@samsung.com, "bzolnier@gmail.com" <bzolnier@gmail.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220401002153.62648-1-hypmean.kim@samsung.com>
 <CGME20220401002131epcas2p320f8513a9bd1413af0ace6c20f2caba6@epcms2p6>
 <20220401002753epcms2p6cd5882f4909247461434f42e933591af@epcms2p6>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220401002753epcms2p6cd5882f4909247461434f42e933591af@epcms2p6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm unable to apply your patch, whatever the method:

git b4 20220401002753epcms2p6cd5882f4909247461434f42e933591af@epcms2p6

Applying: thermal: exynos: fix masking value for exynos7 temp_error
error: unrecognized input
Patch failed at 0001 thermal: exynos: fix masking value for exynos7 
temp_error
hint: Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".



On 01/04/2022 02:27, Sang Min Kim wrote:
> Modify mask value for the temp_error in the sanitize_temp_error() function.
>   
> sanitize_temp_error masks temp_error2 with EXYNOS_TMU_TEMP_MASK(0xff) value
> even in the case of EXYNOS7. In addition, when entering the if statement,
> both temp_error1 and 2 are masked with EXYNOS_TMU_TEMP_MASK(0xff).
> By modifying to use the previously declared local variable tmu_temp_mask,
> the mask value suitable for the SOC can be applied.
>   
> Fixes: aef27b658b43 ("thermal: exynos: use sanitize_temp_error() in exynos7_tmu_initialize()")
> Signed-off-by: sangmin kim <hypmean.kim@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   V2 -> V3: Modify the location of fixes tag and add reviewed tag
>   V1 -> V2: Add fixes tag
>   
>   drivers/thermal/samsung/exynos_tmu.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>   
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index f4ab4c5b4b62..08c63fe5566e 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -243,17 +243,17 @@ static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
>   
>           data->temp_error1 = trim_info & tmu_temp_mask;
>           data->temp_error2 = ((trim_info >> EXYNOS_TRIMINFO_85_SHIFT) &
> -                                EXYNOS_TMU_TEMP_MASK);
> +                                tmu_temp_mask);
>   
>           if (!data->temp_error1 ||
>               (data->min_efuse_value > data->temp_error1) ||
>               (data->temp_error1 > data->max_efuse_value))
> -                data->temp_error1 = data->efuse_value & EXYNOS_TMU_TEMP_MASK;
> +                data->temp_error1 = data->efuse_value & tmu_temp_mask;
>   
>           if (!data->temp_error2)
>                   data->temp_error2 =
>                           (data->efuse_value >> EXYNOS_TRIMINFO_85_SHIFT) &
> -                        EXYNOS_TMU_TEMP_MASK;
> +                        tmu_temp_mask;
>   }
>   
>   static int exynos_tmu_initialize(struct platform_device *pdev)
> --
> 2.9.5
>   
>   


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
