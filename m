Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7E658CF22
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244342AbiHHUbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbiHHUbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:31:22 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8E2101CF
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 13:31:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a11so5332021wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 13:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=MubSuBJ55Yor4lGrHEqbMJ79aaqMV5qcbEpjGX8/hEg=;
        b=o5NvaAIlqMRDnCT7EydZylzFd6imx21dOgzQpWut83+uDBbcaWKujB0WWLNa48Hsza
         Hhm2SYBpbSdXx00g5K7J5oOwfuKX7CeYf1I/j3irJzBJluNNPu9fml+recqWh9YDBUsD
         r+beYwBV6Z5vxuh2o1IvGl+Sp1OzoOnd81njbUlNVck3vJ77Ij9Ioct6Q2gzwed0Q67f
         h+1l5+9RPmBGA/BUMRFbKBQ6F/KRK2VhQO/0nOSLXgq41ItYtMDd7GLQtd5tra7A+W4x
         haky8V7B1rbLz/FrnwJh9lLvI5fND5ge2dI9WVORhF9zntlNciJQWhaBDlluv7Aubq6u
         Qr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=MubSuBJ55Yor4lGrHEqbMJ79aaqMV5qcbEpjGX8/hEg=;
        b=IAPGcGsmaU3PbpNeLL5BJP9hSIO7kLSLIw1pLSK2UDMnbfff8Lz7YNgN0h0pf0U99m
         ZaMP9A0LBuKS64LOPkL9b3fJb/8PxhrWi/LXL5VubGHif4uuemmJPnl2u8mM/O2dIn2u
         ZOyC5znNd3QYAnGhuq5e7oncyjp1eTdF7yrRtj6GqXYG1iIC1MutQW1tfmG1wxB7PPD0
         qZ/lW2riKmDgDuS/m+e2TdWpax1R7uey4ykUvnZAg0eiJV3slC4DRuaZKo7uGX/LDgIG
         SFJKHxpeQNXMVHykjAYbcGT1loUAuOKpBUKzIQJGgoxb2tYBRY8HmofkbiwAQdyPpALN
         EkdA==
X-Gm-Message-State: ACgBeo3xDC4lp9a5ZMFLs4bt8r9mkQQL51cL8O/PUUODKzNRPY2C/0XO
        gD2IrTknTG/hEnM07YvMpfQTHw==
X-Google-Smtp-Source: AA6agR797Y47l7dV9X/bio/z/588billFLDJlV1CmWbYaylTxUUtSCvRDQAGIjpm17+tJE5SSe8oOg==
X-Received: by 2002:a05:600c:3b02:b0:3a5:2460:f059 with SMTP id m2-20020a05600c3b0200b003a52460f059mr8907497wms.129.1659990680315;
        Mon, 08 Aug 2022 13:31:20 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id q21-20020a1cf315000000b003a317ee3036sm14262576wmq.2.2022.08.08.13.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 13:31:19 -0700 (PDT)
Message-ID: <bbd09ad6-db85-5981-a5c1-1dabca1f1b66@linaro.org>
Date:   Mon, 8 Aug 2022 22:31:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/4] thermal/of: Return -ENODEV instead of -EINVAL if
 registration fails
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, rafael@kernel.org
Cc:     michael@walle.cc, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
References: <20220808180915.446053-1-daniel.lezcano@linaro.org>
 <20220808180915.446053-2-daniel.lezcano@linaro.org>
 <f8008f05-4e4d-e21f-2e40-e234930ee86e@roeck-us.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <f8008f05-4e4d-e21f-2e40-e234930ee86e@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2022 20:35, Guenter Roeck wrote:
> On 8/8/22 11:09, Daniel Lezcano wrote:
>> The previous version of the OF code was returning -ENODEV if no
>> thermal zones description was found or if the lookup of the sensor in
>> the thermal zones was not found.
>>
>> The backend drivers are expecting this return value as an information
>> about skipping the sensor initialization and considered as normal.
>>
>> Fix the return value by replacing -EINVAL by -ENODEV
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/thermal/thermal_of.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
>> index 368eb58e97cf..4210c18ef7b2 100644
>> --- a/drivers/thermal/thermal_of.c
>> +++ b/drivers/thermal/thermal_of.c
>> @@ -329,7 +329,7 @@ static struct device_node 
>> *of_thermal_zone_find(struct device_node *sensor, int
>>       np = of_find_node_by_name(NULL, "thermal-zones");
>>       if (!np) {
>>           pr_err("Unable to find thermal zones description\n");
> 
> I really don't like that error message: People will see it (and complain)
> whenever a sensor registers and there is no thermal zone, even though that
> is perfectly normal (see description above).
> 

I agree, I'll change the message to:

	pr_info("No thermal zones description\n");

sounds good ?

>> -        return ERR_PTR(-EINVAL);
>> +        return ERR_PTR(-ENODEV);
>>       }
>>       /*
>> @@ -368,7 +368,7 @@ static struct device_node 
>> *of_thermal_zone_find(struct device_node *sensor, int
>>               }
>>           }
>>       }
>> -    tz = ERR_PTR(-EINVAL);
>> +    tz = ERR_PTR(-ENODEV);
>>   out:
>>       of_node_put(np);
>>       return tz;
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
