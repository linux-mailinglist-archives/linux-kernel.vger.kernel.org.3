Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9854E58DA43
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 16:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243251AbiHIO0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 10:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbiHIOZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 10:25:59 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FA51158;
        Tue,  9 Aug 2022 07:25:58 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id f192so10917279pfa.9;
        Tue, 09 Aug 2022 07:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=FR1Du1uZaAJMKx1n6HJ660kjVkyvLUaZIPYG+cQScAo=;
        b=M5cG5nyXDy4Jzz1DLmidH5rsCpqvzhnbn3ci0k6RZFzr9gooSa0r8ZCxDTLCsc5MWq
         qFxzJlUJlAqV5NAAvUpwDS2CqUZf2uzYAk9vF/5UroWaD6WJK7SEDRyjRtMCS+As4aLE
         quXQ55y0mxLzqpWJnNHmCopHNWJUxO+CNLwAYpGJgFEHit9NDeKuWnvfUdpNPDVBnXAf
         o6EnjDE5SLjCDqpfA7NcNtZV1XsIG0E/TyIaNXFk8hqu7B4zccoLczuvKbN8TZSEgLGM
         q92YwFNwYr+6drpAFhIw4jQr9cn9vGzCsnYoXTxd0esvP1xRxasuZhXWzHdH2tdOKLYR
         HbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=FR1Du1uZaAJMKx1n6HJ660kjVkyvLUaZIPYG+cQScAo=;
        b=mmeSNvSeRsZFL1qPr5h7jo38PpX9KZH3Q5IQfc8QQFHxHlWfM48p0LuabTeCbGhnPw
         RG9jLRAx4Uo4irXKfgIEBQoaL7CvSkT/erG5H099xCiNnyrBkSqFe8Gn5w9/bIGYeMrG
         eTsga6Gq4V8S/rvGiwAR+ZdE5wHDdRgy+4T3X+BAdhuGYUOhZQZM6nn6AwfffTAXaEWY
         OWZB4J6s0S6Ssr8JCPk/l8vDqAlf+Bq7EYYab6Mk3B/kd0s43MdaU9teEJGxrvnRAD+R
         E9Loi/G5rfUKPKNhz4Y5oRMooRwC54vee3rnOmEAyRknsGjp3wdo8cU5Um38A6m9ZO4V
         helg==
X-Gm-Message-State: ACgBeo0wXO/vSpBGThXCVXVTEA7VJLQEI7XD9q5Rdn8LsjULi0/ATOuL
        xKktb7GeRFYC9myyowD2gUU=
X-Google-Smtp-Source: AA6agR7fyqgr+GmK41zM4BOS5aL53cb6E8JYmQPuCDqA3anYvzDXIn6ww+2EmrQEAP9rPaFd1r38qg==
X-Received: by 2002:a65:5789:0:b0:41a:4a7c:635d with SMTP id b9-20020a655789000000b0041a4a7c635dmr19049636pgr.60.1660055158113;
        Tue, 09 Aug 2022 07:25:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 22-20020a621616000000b0052f1e061b21sm5758194pfw.66.2022.08.09.07.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 07:25:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cebd483c-7550-3ce9-08ab-4c5457111c90@roeck-us.net>
Date:   Tue, 9 Aug 2022 07:25:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/4] thermal/of: Return -ENODEV instead of -EINVAL if
 registration fails
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     michael@walle.cc, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
References: <20220809085629.509116-1-daniel.lezcano@linaro.org>
 <20220809085629.509116-2-daniel.lezcano@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220809085629.509116-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/22 01:56, Daniel Lezcano wrote:
> The previous version of the OF code was returning -ENODEV if no
> thermal zones description was found or if the lookup of the sensor in
> the thermal zones was not found.
> 
> The backend drivers are expecting this return value as an information
> about skipping the sensor initialization and considered as normal.
> 
> Fix the return value by replacing -EINVAL by -ENODEV and remove the
> error message as this missing is not considered as an error.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Tested-by: Michael Walle <michael@walle.cc>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>    v2:
>     - Change the error message to a debug message
>     - Only show an error if the error is not -ENODEV
> ---
>   drivers/thermal/thermal_of.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 368eb58e97cf..3effc729be4b 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -328,8 +328,8 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
>   
>   	np = of_find_node_by_name(NULL, "thermal-zones");
>   	if (!np) {
> -		pr_err("Unable to find thermal zones description\n");
> -		return ERR_PTR(-EINVAL);
> +		pr_debug("No thermal zones description\n");
> +		return ERR_PTR(-ENODEV);
>   	}
>   
>   	/*
> @@ -368,7 +368,7 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
>   			}
>   		}
>   	}
> -	tz = ERR_PTR(-EINVAL);
> +	tz = ERR_PTR(-ENODEV);
>   out:
>   	of_node_put(np);
>   	return tz;
> @@ -642,7 +642,8 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
>   
>   	np = of_thermal_zone_find(sensor, id);
>   	if (IS_ERR(np)) {
> -		pr_err("Failed to find thermal zone for %pOFn id=%d\n", sensor, id);
> +		if (PTR_ERR(np) != -ENODEV)
> +			pr_err("Failed to find thermal zone for %pOFn id=%d\n", sensor, id);
>   		return ERR_CAST(np);
>   	}
>   

