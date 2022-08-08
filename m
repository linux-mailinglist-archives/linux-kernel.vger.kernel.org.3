Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F4F58CDB6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243783AbiHHSfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243847AbiHHSfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:35:45 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9549319017;
        Mon,  8 Aug 2022 11:35:40 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 17so9284539plj.10;
        Mon, 08 Aug 2022 11:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=VRsJ5NxAJUTObRnu0STgTqrEsSyrkh56jQcFDpSdYLg=;
        b=FxxZjJ8oQvdsv9pJWERvXsha8LQFjHDMsfFjdIOUahPlkLe61mYqIA8+eATGUGhkfp
         LauqaUKQrN6ReajdXP9VkjL85Bl70x3aRHqIAzEYcSQ7AV4Ifp4xjjqIA6C5Gw07ceJn
         PQwXCRqZM6by5F8fH14G63p9BgW1+modF0hp2RldEfcS8bKQ0UluZsO5cuRLAZWCCmzT
         vR5GvVUX+fePlQvN0r1ts8KHNNXPcNpZYvS5MLKy1VNPklEsAWG+LImH6slT01GIoa9M
         NfUBWrSz9fNdsTn05uy3JIc5NzsX9u7thgunJP58rcDcHAUvD41+VO/Bxo/pWpPWCvu/
         SXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=VRsJ5NxAJUTObRnu0STgTqrEsSyrkh56jQcFDpSdYLg=;
        b=iI3P4JI/CmTGpTKHfqtlFuRVK8dWAVSBR7qWdmUkWOiJE5UwQE11b5VksH3m4LKnGr
         ab6sPpISDfdxMiC4U1By/8CZJ2yX9JkRwqCBL0qoOdqQi1nBFHwy3bsw5Z3myEXuRmHx
         dfpZcMN28TEOOf+UEqZSfbOiqpEEFerR3sAB+KitX8+kbk0/Y7p1Ekdq18aRlmZnEDa4
         F4BrfT5WzPloOp3x+jf1e0zYfOoZIdPXhbU+rS/8KGPfFYbDMAKAR6GuCS3ledttP93b
         yuLDCzNVHqzE9QqtgBIZlFjP/AVpWWUqitny/Q9iF/rLapSKViRV/+9aBel6bsnIZflY
         KU5A==
X-Gm-Message-State: ACgBeo2JLhMN8e7LfJvMHr5ojxLGWOpEWbpxSbSEz0Ojgax4j5FCzisF
        JzlO5mgoKnKfEitnr/MuksI=
X-Google-Smtp-Source: AA6agR5GSXzMaUAWWXG3gaZFLT4fp5ypBd72er4YLrFmBaZ0TRXWbThMmHTJABY0hk1InGVhYPm/SA==
X-Received: by 2002:a17:902:ced2:b0:16e:e19b:c5c9 with SMTP id d18-20020a170902ced200b0016ee19bc5c9mr20656422plg.136.1659983739031;
        Mon, 08 Aug 2022 11:35:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bf8-20020a170902b90800b001709e3c750dsm3797669plb.194.2022.08.08.11.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 11:35:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f8008f05-4e4d-e21f-2e40-e234930ee86e@roeck-us.net>
Date:   Mon, 8 Aug 2022 11:35:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/4] thermal/of: Return -ENODEV instead of -EINVAL if
 registration fails
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     michael@walle.cc, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
References: <20220808180915.446053-1-daniel.lezcano@linaro.org>
 <20220808180915.446053-2-daniel.lezcano@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220808180915.446053-2-daniel.lezcano@linaro.org>
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

On 8/8/22 11:09, Daniel Lezcano wrote:
> The previous version of the OF code was returning -ENODEV if no
> thermal zones description was found or if the lookup of the sensor in
> the thermal zones was not found.
> 
> The backend drivers are expecting this return value as an information
> about skipping the sensor initialization and considered as normal.
> 
> Fix the return value by replacing -EINVAL by -ENODEV
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/thermal_of.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 368eb58e97cf..4210c18ef7b2 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -329,7 +329,7 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
>   	np = of_find_node_by_name(NULL, "thermal-zones");
>   	if (!np) {
>   		pr_err("Unable to find thermal zones description\n");

I really don't like that error message: People will see it (and complain)
whenever a sensor registers and there is no thermal zone, even though that
is perfectly normal (see description above).

Guenter

> -		return ERR_PTR(-EINVAL);
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

