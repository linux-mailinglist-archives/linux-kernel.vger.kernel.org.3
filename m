Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827654CB47E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiCCBqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 20:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiCCBqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:46:36 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52921B6E05;
        Wed,  2 Mar 2022 17:45:51 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 195so3203265pgc.6;
        Wed, 02 Mar 2022 17:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MVq/KO9mQWlEmONgPovYPC/moYBrzhnqRKihrSUsxEo=;
        b=hT2Fv8FE8LK02M/6QA3BdeUGZ+jx0aLo2Uik3V43G6XjXi5Cc3z12JcGlxpX+ur/kx
         sczZjugHdlq4vzoGrTHhpFR6nfALFrr2OI9XBnL60RiCt9y9IlPhe0QyYXZ8JYzYYi9D
         7hLefG3+1FuXVyXXGmkh/vgBL84yi0/ctcKa7Ga65/PjejnXncSACw5ZQlep/whKBJni
         eT05yX5PEpqh4GdeSVTmrn1+CkwmDwItRt86kQUuHzMKmcNWM8qr6oX26KQywDSfVlLV
         +j6YKTI8iGAogmo5Icyc+w0YbCgmdjO7LjUgRHeuVH5R356E56kKKCv89TQ4YjjlHHR7
         V9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MVq/KO9mQWlEmONgPovYPC/moYBrzhnqRKihrSUsxEo=;
        b=vyDI+3aGhpqdNDCA5y6H5Y5ky45N57vzXs5OxKBHhfoRRuYeBoFCOQMrsrBCHcvnQO
         t/iQqvNYrHtNDnhqM3UUebs2i4m2YgAtpCs8g6DYqpVUXbaZw4+QUCIOP1caGDySPdjf
         SeeNNKx3wujpsQAHlrXCVVGJvyXLQZITrP47nFtxePuwSgE096eJAVS6yWUeHArsw0Wj
         5U7JIC+yBF6pHGp1Q3wQ1VPLqUglNpTFFSTnsUS1Q2yP3xLARLACVvUUDyvxodVtbQ5n
         OVUkgxdycXkt6i0j1XerwIId6aFhSAAXVCMua1U6TPg6aereS8vxQtCBPlurn5hf9UQ+
         oEUQ==
X-Gm-Message-State: AOAM5319NPples6plCgHzdld8PLhstzK9KvtCz8H40HmwVAGWRXOaJ8S
        IUKTi2JaoDXOviVlbExmeXIGPlxPDdI=
X-Google-Smtp-Source: ABdhPJz2U9aougeJ28hd1mINGlvO3AuWOCzIAcb/ITPV9mTAfFiFXToyIfAWgd/ZwwK7dq5BRjiy3Q==
X-Received: by 2002:a63:4cf:0:b0:363:c42:c135 with SMTP id 198-20020a6304cf000000b003630c42c135mr28266340pge.82.1646271950809;
        Wed, 02 Mar 2022 17:45:50 -0800 (PST)
Received: from [10.100.0.6] ([194.5.48.183])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7888e000000b004e5c2c0b9dcsm457175pfe.30.2022.03.02.17.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 17:45:50 -0800 (PST)
Subject: Re: [PATCH] platform: x86: huawei-wmi: check the return value of
 device_create_file()
To:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220225130448.27063-1-baijiaju1990@gmail.com>
 <54dafc1d-bc72-8cb0-a539-4fdfc068cb5a@redhat.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <bd3a5715-bb6c-2e2f-7de9-5bc719b13c15@gmail.com>
Date:   Thu, 3 Mar 2022 09:45:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <54dafc1d-bc72-8cb0-a539-4fdfc068cb5a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Thanks for the advice!
I will send a V2 patch.


Best wishes,
Jia-Ju Bai


On 2022/3/2 22:31, Hans de Goede wrote:
> Hi,
>
> On 2/25/22 14:04, Jia-Ju Bai wrote:
>> The function device_create_file() in huawei_wmi_battery_add() can fail,
>> so its return value should be checked.
>>
>> Fixes: 355a070b09ab ("platform/x86: huawei-wmi: Add battery charging thresholds")
>> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> Please run check-patch.pl your patches before submitting them.
>
>
>> ---
>>   drivers/platform/x86/huawei-wmi.c | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
>> index a2d846c4a7ee..2ffd3840f3e8 100644
>> --- a/drivers/platform/x86/huawei-wmi.c
>> +++ b/drivers/platform/x86/huawei-wmi.c
>> @@ -470,10 +470,19 @@ static DEVICE_ATTR_RW(charge_control_thresholds);
>>   
>>   static int huawei_wmi_battery_add(struct power_supply *battery)
>>   {
>> -	device_create_file(&battery->dev, &dev_attr_charge_control_start_threshold);
>> -	device_create_file(&battery->dev, &dev_attr_charge_control_end_threshold);
>> +	int err = 0;
> There needs to be an empty line here,
>> +	err = device_create_file(&battery->dev,
>> +						&dev_attr_charge_control_start_threshold);
> Why the weird continuation of the call on another line? Please make this a single line.
>
>> +	if (err)
>> +		return err;
> Empty line here.
>
>> +	err = device_create_file(&battery->dev,
>> +						&dev_attr_charge_control_end_threshold);
> Please make this a single line.
>
>> +	if (err) {
>> +		device_remove_file(&battery->dev,
>> +						&dev_attr_charge_control_start_threshold);
>> +	}
> No need for {} here.
>
>>   
>> -	return 0;
>> +	return err;
>>   }
>>   
>>   static int huawei_wmi_battery_remove(struct power_supply *battery)
> Regards,
>
> Hans
>

