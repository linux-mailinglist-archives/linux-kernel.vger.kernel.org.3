Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CA0565ED9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 23:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiGDVUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 17:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiGDVUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 17:20:32 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3338E60DC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 14:20:31 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v16so3508612wrd.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 14:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1G3kQ03c4BPDrTBmmfi1btMJ4S3uttepLJ0Gb5HSKhQ=;
        b=O6PQJOWZOOL4CVv1RCr9+oLiOk2IJABvHhK0djfZyBbi67Fc4UmzmZI2ZLOFJBL63t
         4WV5qbPamLzlY1XoXyOuZ2rK1OLbof606sDor7OiaOYPKmJ36rBMo6vHwKL6p09DkDtJ
         Adqv20Y0PYAd40GAure7lseqxHr8nrVzQocPc7TkRsPBWeYXMoP9mVUycId6+r/jslOB
         65Ri09zAzR7RoDSBrEAFKqH65Ev7rvOPdMBCshKQlGPebMSyOQdKn9q9F9kBLJsNUoWP
         Ub5PN0vCt1nIAWB5fxI6NoR9rlZj+zF0fBxPj06/tHrEYIUzdAns8PGuaMj8kHNS3qcX
         X9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1G3kQ03c4BPDrTBmmfi1btMJ4S3uttepLJ0Gb5HSKhQ=;
        b=GoknUBG67A+AjGuLQK7lXTdHekjOvL9pC6rymrL38EMRmzMSPvBrUuSlplQAOgPHM7
         BgIwKMI6aptxt9L8L4FG5N0h3HV+VE2fawRxUvjP1YnL/Yj/Z8wNFj4OFIWUkBUk8qzA
         7JbDIBUG8YLactc1QQmsKTpsbYz6CVMaUaPLN7tZHLumi8G1wOZUEKenum5YNDiO1L6c
         9eJs/Fq32xxOAXs5+y2lFkpgA2i/pX5VyS6mjqXaqbG6X/xuMsbF3PsRxCAU8+Fnn6T/
         DzjynDaSaikW08NyZjS5RYRIlL8bToA/nY3q6u+izpvcHRa1ack0MQ1iXJSwm3COYHtu
         1WEw==
X-Gm-Message-State: AJIora+1hbjkcJCoXEuJyPwTlx5GXR6HPLnIkPNDK47caVdgX/Gae1xh
        2TYhurQ/P8bDbiL3hnkCnLlyBQ==
X-Google-Smtp-Source: AGRyM1veGEBn+rAlK6KWkAGO3tHowqRr2I5WKJt8gUlmoxtpqmtQGOsG3Cw8XqPFEUGquClCHwdSqQ==
X-Received: by 2002:a5d:430d:0:b0:210:2ce0:e2a9 with SMTP id h13-20020a5d430d000000b002102ce0e2a9mr28584984wrq.627.1656969629824;
        Mon, 04 Jul 2022 14:20:29 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d6106000000b00213ba0cab3asm31572511wrt.44.2022.07.04.14.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 14:20:29 -0700 (PDT)
Message-ID: <09eb3c89-9324-9d45-d7b9-b8711005fd20@linexp.org>
Date:   Mon, 4 Jul 2022 23:20:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 08/12] thermal/core: Add thermal_trip in thermal_zone
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, daniel.lezcano@linaro.org,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
 <20220703183059.4133659-9-daniel.lezcano@linexp.org>
 <e97e094cf99980f461ba798f7179ce1caea3cf87.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
In-Reply-To: <e97e094cf99980f461ba798f7179ce1caea3cf87.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Zhang,

thanks for reviewing the series

On 04/07/2022 16:11, Zhang Rui wrote:
> On Sun, 2022-07-03 at 20:30 +0200, Daniel Lezcano wrote:
>> The thermal trip points are properties of a thermal zone and the
>> different sub systems should be able to save them in the thermal zone
>> structure instead of having their own definition.
>>
>> Give the opportunity to the drivers to create a thermal zone with
>> thermal trips which will be accessible directly from the thermal core
>> framework.
>>
>> Cc: Alexandre Bailon <abailon@baylibre.com>
>> Cc: Kevin Hilman <khilman@baylibre.com>
>> Cc; Eduardo Valentin <eduval@amazon.com>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
>> ---
>>   drivers/thermal/thermal_core.h | 10 ++++++++++
>>   include/linux/thermal.h        |  1 +
>>   2 files changed, 11 insertions(+)
>>
>> diff --git a/drivers/thermal/thermal_core.h
>> b/drivers/thermal/thermal_core.h
>> index c991bb290512..84e341c1e0fc 100644
>> --- a/drivers/thermal/thermal_core.h
>> +++ b/drivers/thermal/thermal_core.h
>> @@ -113,6 +113,16 @@ int thermal_build_list_of_policies(char *buf);
>>   /* Helpers */
>>   void thermal_zone_set_trips(struct thermal_zone_device *tz);
>>   
>> +static inline struct thermal_trip *thermal_zone_get_trips(struct
>> thermal_zone *tz)
> 
> it should be struct thermal_zone_device?
> It seems that you fixed it in patch 9/12, and leave it broke here.

Right, I'll fix it

>> +{
>> +	return tz->trips;
>> +}
>> +
>> +static inline int thermal_zone_get_ntrips(struct thermal_zone *tz)
> 
> same problem as above.
> 
> thanks,
> rui
>> +{
>> +	return tz->ntrips;
>> +}
>> +
>>   /* sysfs I/F */
>>   int thermal_zone_create_device_groups(struct thermal_zone_device *,
>> int);
>>   void thermal_zone_destroy_device_groups(struct thermal_zone_device
>> *);
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index 3a57878a2a6c..3733e23b6359 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -179,6 +179,7 @@ struct thermal_zone_device {
>>   	struct thermal_zone_device_ops *ops;
>>   	struct thermal_zone_params *tzp;
>>   	struct thermal_governor *governor;
>> +	struct thermal_trip *trips;
>>   	void *governor_data;
>>   	struct list_head thermal_instances;
>>   	struct ida ida;
> 

