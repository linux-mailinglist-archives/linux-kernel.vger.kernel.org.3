Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7444758E3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242527AbhLOMbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237629AbhLOMbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:31:33 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD74C061574;
        Wed, 15 Dec 2021 04:31:33 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so24676738otv.9;
        Wed, 15 Dec 2021 04:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0TSpLPQPFLItXTo3lZzCz10vs9V+Bflifn6PD2+rUjs=;
        b=e6pTCNptZTpRA0nZOl6upXu5TF1Mzu+p4NR1V7Ci1Oaar2kwCBdZ5C1Isc0/Z0WiFv
         b5V/37QeGdSfuPbJx8Y5HFnyig8kFObv0YP6hCktB23tTnbrnic8WmYn4pQXGKDNrzhz
         L+orZIsgDLd8ccFgWIH/AffKR9/oz6fg3xmAfyAUA9ibrJdKnynobfgyMXb/tw+8YlQQ
         mDub8RfAJzz7brZ7jEI7rqGaD9ZZ3P50iFS/hTvT4cm1I0tk3Gp5dHx8tHKVRMOUEvHq
         rCAk8A8sDW0QaLLMer5OkxkPI883qdQxWV+Mpam1lcMG0X1+5jp+gTHGzNhxTCuFLs3K
         kGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0TSpLPQPFLItXTo3lZzCz10vs9V+Bflifn6PD2+rUjs=;
        b=iBkBmr19H3JNExpou6cW1VMYdYey3OpuIPMaXab20iN8p2Cp7P3tM1VIsLRI16WG7r
         NUsZW5L5U1nZUwJDIR1bHfkeWU293n4/Spx915JNyWY30tXbbjwRrGdO4VkSOCgRC7oC
         JiC32/RaOIgA6v1HwsYpXuZ9Fa61ief73XSf3LO659BbIthEUk0+I3Vgg0gzQtMOpYvx
         vbmV/rRCMVqPCr+LmsEAiSwvEX4gVOxKtKjM1aE7rQAj8U3F7/cxCjIXfF4/tye/ah9G
         96at2YVw68wV2iK2DG61exipzsnxmHOa8S/FgqdU9fPseAqohmwWgOrpbg/OPQJJvBbv
         91JA==
X-Gm-Message-State: AOAM530+IxV+T1ABXOaETe+aeClBQn/781QOHSivye4ZLQlBSWnl+o8j
        H1rR+p3FfDvyEjvP+0YQnwmmh2aZM9M=
X-Google-Smtp-Source: ABdhPJyEF+97/XhrZAC0KV+lMOz4inQ2VncVYhhcmHk3f/XtFenVt3rCmmwJVKR5axwfwZcAClRL/w==
X-Received: by 2002:a05:6830:4391:: with SMTP id s17mr8400677otv.118.1639571492329;
        Wed, 15 Dec 2021 04:31:32 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bl33sm342599oib.47.2021.12.15.04.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 04:31:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] hwmon : (mr75203) fix macro typo
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arseny Demidov <arsdemal@gmail.com>
Cc:     Arseny Demidov <a.demidov@yadro.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211215113023.2945-1-a.demidov@yadro.com>
 <0baa6133-5903-ffd8-69a0-99fb9f69665d@roeck-us.net>
Message-ID: <06d7c6ee-2db5-f250-50f7-9a47e33a35b5@roeck-us.net>
Date:   Wed, 15 Dec 2021 04:31:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <0baa6133-5903-ffd8-69a0-99fb9f69665d@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/21 3:59 AM, Guenter Roeck wrote:
> On 12/15/21 3:30 AM, Arseny Demidov wrote:
>> In the file mr75203.c we have a macro named
>> POWER_DELAY_CYCLE_256, the correct value should be 0x100
>>
> 
> How do you know that ? Do you have access to the datasheet, or
> is it just an assumption based on the name of the define ?
> 

Also, how do you know that the value is wrong, not the name
of the define ?

Guenter

> Guenter
> 
>> Signed-off-by: Arseny Demidov <a.demidov@yadro.com>
>> ---
>>   drivers/hwmon/mr75203.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
>> index 868243dba1ee..1ba1e3145969 100644
>> --- a/drivers/hwmon/mr75203.c
>> +++ b/drivers/hwmon/mr75203.c
>> @@ -93,7 +93,7 @@
>>   #define VM_CH_REQ    BIT(21)
>>   #define IP_TMR            0x05
>> -#define POWER_DELAY_CYCLE_256    0x80
>> +#define POWER_DELAY_CYCLE_256    0x100
>>   #define POWER_DELAY_CYCLE_64    0x40
>>   #define PVT_POLL_DELAY_US    20
>>
> 

