Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18D657D5F0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbiGUV3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiGUV32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:29:28 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663E692866
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:29:27 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bk26so4031711wrb.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6oH1cbsgdhss1AP+uXvA73Emr1xdn7+57VPz7hhNcGA=;
        b=s0GBanfP7lbAXVi3iLcl7ktDLDo0k3btMRsYXHocefuYBAC1t/SO9a+e5mmhcfkopx
         ZT1czPzKmKfckcSKlAPR1GQcZJFDcnLgU8Lpglpjp3O9t4WnhqqIxPUKjWFT5Wo0xy3o
         1HOVVDZxyObl4fZ1swmtK+1p7fY+O+1+BvIqXxhIGDQPlVPk7wLpcvV43HM/k3CLSq/C
         Jz7RgIyRrqglFU7Wo39wk5hYv0pcOHbaQ7aTV7seA9lPjn9fBQPVFgJPMOZSsPhl5ke4
         IpdX7ymgEAUWlShczDJvA75JQSQctEVPvjvqZ212EvFA3nIN2pBaRfzp2FhrEx7AM6YO
         9AfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6oH1cbsgdhss1AP+uXvA73Emr1xdn7+57VPz7hhNcGA=;
        b=ac/f080K9mlFRtSpjABMgp+tY80wxBqVg6EYJc/vAIavybZO4yqoxg4tfholn5fUUQ
         YHmZ/m8baep+ma33zRLO+T7DD+CctkdqHnPzbaKGQJCL57XPmivVH9XEisuB8Ldzyt0p
         pQgIII7CF9JdRW950zAQi4fM7PuVJklgyZr5GQVG1MempITDGu1pAI6VtBjH6J54GLDY
         LpOfiJgf2b1yEbRzTNXZDcSZc3dfdhoYLIlbLQelH17dt/l5E53lyzZZqC7WDfdgTQnr
         FDf8Cc+InQxKAxcCFyyRi/87fcLIdDdMOsZFaw+uevC/ZdK8LaqdBGr0dZJdOzMimjY7
         PKnQ==
X-Gm-Message-State: AJIora8g0kWGdVOyEbdL9ebolxPsiYnhAunAZcFcffsgXud3lqtS9MY/
        OiRBDQ2DbRX4Qx3Ar2nL9yX+rTyN4zn0ug==
X-Google-Smtp-Source: AGRyM1ubN1oF93oWLpytkvZB9NDpE35SXL8MNDkxJ6e+iQD1oXNc+GcrMRpSYNM5N9If6MlDZIBayA==
X-Received: by 2002:adf:e283:0:b0:21e:26fe:14f3 with SMTP id v3-20020adfe283000000b0021e26fe14f3mr275882wri.98.1658438965814;
        Thu, 21 Jul 2022 14:29:25 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:a2a9:428c:224b:c919? ([2a05:6e02:1041:c10:a2a9:428c:224b:c919])
        by smtp.gmail.com with ESMTPSA id x10-20020adfec0a000000b0021d6c7a9f50sm3021298wrn.41.2022.07.21.14.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 14:29:25 -0700 (PDT)
Message-ID: <5e9f6d35-08ff-4949-67b0-a2feaab79814@linexp.org>
Date:   Thu, 21 Jul 2022 23:29:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 11/12] thermal/of: Use thermal trips stored in the
 thermal zone
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>
References: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
 <20220710123512.1714714-13-daniel.lezcano@linexp.org>
 <CAJZ5v0hTQBXbKNurR0p8_MWmcW-EtezUg1oSNLVEYEAdzpeyBA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
In-Reply-To: <CAJZ5v0hTQBXbKNurR0p8_MWmcW-EtezUg1oSNLVEYEAdzpeyBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2022 20:26, Rafael J. Wysocki wrote:
> On Sun, Jul 10, 2022 at 2:35 PM Daniel Lezcano
> <daniel.lezcano@linexp.org> wrote:
>> Now that we have the thermal trip stored in the thermal zone in a
>> generic way, we can rely on them and remove one indirection we found
>> in the thermal_of code and do one more step forward the removal of the
>> duplicated structures.
>>
>> Cc: Alexandre Bailon <abailon@baylibre.com>
>> Cc: Kevin Hilman <khilman@baylibre.com>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
>> ---
>>   drivers/thermal/thermal_of.c | 53 +++++++++++-------------------------
>>   1 file changed, 16 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
>> index e187461dd396..601552c55d0b 100644
>> --- a/drivers/thermal/thermal_of.c
>> +++ b/drivers/thermal/thermal_of.c
>> @@ -118,12 +118,7 @@ static int of_thermal_set_trips(struct thermal_zone_device *tz,
>>    */
>>   int of_thermal_get_ntrips(struct thermal_zone_device *tz)
>>   {
>> -       struct __thermal_zone *data = tz->devdata;
>> -
>> -       if (!data || IS_ERR(data))
>> -               return -ENODEV;
>> -
>> -       return data->ntrips;
>> +       return tz->ntrips;
> Hasn't this been renamed to num_trips?

Right, it is changed in patch 12/12


