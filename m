Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5771F56B7B0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbiGHKtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237844AbiGHKtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:49:00 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C3784EF3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 03:48:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v16so18549197wrd.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 03:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OsTNTRG4KqNreOuBGVU/o2FbeooZXP6/5uwnACxatIE=;
        b=fTIjqwYLOEpjJ2EB5ggdyU0lpmkAigKUr9FmF+CyyRCY/VmMp7Sen7JfcUE4B1rTw9
         hEELkjmrElKmNX7am2tlWE4AW3+p+QoPfDCe9nQ63QUj9gb4rNmK/0CRS/Fo8/ZgsOYP
         0PsemLXZUvNuIQzBgBaSfKAVTnjiauP5Tueb5tdYDItZVgQT6x6AI8caFQBnfvDrOm6O
         D1JKOFtOyj6yfsaubTBMjwaZp4/13aaoo2eE7Tc6HLFoNbxIPTzFKAloii3RkeoPpY4Q
         1yc03f3A3NlGRXwb6IXLUtjHnam5PbI22TwNsgxxV5rZyA/mGFxPfovzt6zQlLaK75i9
         MLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OsTNTRG4KqNreOuBGVU/o2FbeooZXP6/5uwnACxatIE=;
        b=oQdW2SmyZM/4vzu2Ekih+7wspqZg28exVzWIg1SUeDd8yQS0H1UP1eYa35zRcoXjVV
         WsbcKR8qaDixhzjMbhNEeKxMBY3jyKSVdnEUge6TcKXE/z5Zc9/cGxUmf9Rl8Ez/vCgt
         5n9v11RaCk2n/o9Qz5D4DW9vzzv/PcjlP/fy89ZBBGa1QNU2uxVaXE2M+Vez5Ze5RoqN
         Fjf67DWEaPYQENOMJ4kcHRQHMnW2WuTQ4J+A0d7JHV7DLB3SspFvaqzsjmx7JC7BLZEr
         Fc37ETrDs7KvM0DrXfO/kOFRQjdHxk6mtfYHVeFh1M3HiqzK69Mua9c1DhUaSXRtwFBr
         of1Q==
X-Gm-Message-State: AJIora8R8uFiuJUTVBfpfrwx36skb076dMixvrjJdzOAcqUWMOf4OWBp
        OC1yq7eKC2aM0Guv9MTh9ShWbw==
X-Google-Smtp-Source: AGRyM1umTikns98Puhtn+l/ypO6m7oa7DrFAI530U1ATKgKertdqJUB4WFHUYrQwAvR+2RiE1CKrgw==
X-Received: by 2002:a05:6000:1683:b0:21b:93b0:898f with SMTP id y3-20020a056000168300b0021b93b0898fmr2680833wrd.662.1657277336196;
        Fri, 08 Jul 2022 03:48:56 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id r41-20020a05600c322900b003a032c88877sm1636072wmp.15.2022.07.08.03.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 03:48:55 -0700 (PDT)
Message-ID: <5f3aae11-f881-78e8-f90e-80b485e252f3@linaro.org>
Date:   Fri, 8 Jul 2022 12:48:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] thermal/core: Fix thermal trip cross point
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, Amit Kucheria <amitk@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220707214513.1133506-1-daniel.lezcano@linaro.org>
 <20220707214513.1133506-3-daniel.lezcano@linaro.org>
 <6f8d449906a42ba11698d3c0ae9740b83f918f42.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <6f8d449906a42ba11698d3c0ae9740b83f918f42.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2022 05:56, Zhang Rui wrote:

[ ... ]

>> +	if (tz->last_temperature < trip_temp && tz->temperature >=
>> trip_temp &&
>> +	    trip != tz->prev_trip) {
>> +		thermal_notify_tz_trip_up(tz->id, trip, tz-
>>> temperature);
>> +		tz->prev_trip = trip;
>> +		
>> +	} else if (tz->last_temperature >= trip_low_temp && tz-
>>> temperature < trip_low_temp &&
>> +	    trip == tz->prev_trip) {
>> +		thermal_notify_tz_trip_down(tz->id, trip, tz-
>>> temperature);
>> +		tz->prev_trip = trip - 1;
> 
> Say, let's assume hysteresis is Zero,
> When the temperature increases and we do thermal_notify_tz_trip_up()
> for trip 0 and trip 1, tz->prev_trip is set to 1 in this case.
> And then the temperature drops below trip 0, we don't have chance to do
> thermal_notify_tz_trip_down() for trip 0, because we always handle the
> trips in ascending order, and tz->prev_trip is 1 when we do
> handle_thermal_trip(0).
Well actually you are right, I reproduced the scenario with temperature 
emulation. I'll investigate how to handle this case.

Thanks for spotting this



<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
