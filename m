Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1276957857F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbiGROc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbiGROce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:32:34 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A16623157
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:32:31 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h17so17388102wrx.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+oIZvUc7KLTZV54ucVUZOCZ07lzjTyHDr3kQM7WCFuU=;
        b=z2uVDjUAaatUdkjrpAzIZl4A5tH46jGYaymAHqbE17uTOSI3vGoj3g8TCXtaKmAlSz
         ekXKmv73ENyKMAeJlTW/OTnokKmjYAVwkp1ljAbLCGeOQM2pFXQ4rA4I2S6PZpV4a04P
         e9KEi4ZJmJ274MwMC2q/bj59Rlz1jMYZb9SYeISN5PdssXDhCkqjxwM+3jnU4aAuNTCR
         rsYNX9ub2Eb0lqQRaehyXl9MMrpUx3ORuRVKSjRLiaT9hzljB3nXagzYIphgxseo4jug
         O3+BKMra32JWvuTArmzjeGD3+21PA7KfwHR8VOH/NHujAUysTIYGyTtFZgxZzL/R2CkA
         T4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+oIZvUc7KLTZV54ucVUZOCZ07lzjTyHDr3kQM7WCFuU=;
        b=MsfY/7iruEpKX7Qz2ZMfj9TQsQ0697LqyTMAHwuvRcWpuFkngSDWVOKWpQS4LJzG4u
         OAc8UDNuxyL8L7i1jSQGijZuwZflHerojnlrvMCJ+mUgwp3/GKtKUW8GEr2ERJiM81Em
         DBH7bh+C8vkMF4kwrLkuWu8n1hCVdgcADrln5kMHNdwfaVlhmx47UFiARQSO4mNIGrcG
         yc8Ar43hy/T4M2PIy0eEADq3UPWM+jrsoin9hkTRNO2GxNuwlwSJVajkOUy0i+vpMl0Z
         iqzVgShquWzcFyBSuXisGfsywqBoUgXyDG7NfTfN6WsbFF35KgY/1qkaCj7pBRIlLgN8
         yoIA==
X-Gm-Message-State: AJIora8PjFU4wEhg8cIqOdGSE8EhLmSm10PLhZ160bhDgd8WAMlg6mhk
        eN5nUEWZ02gQEnh9wsworJVekw==
X-Google-Smtp-Source: AGRyM1sCRv3oioroEQ8pJ8k3RNEmGNzpl4tMeoMiDvoDgXeZO1GV8U++X8MoVjzH/PIQbyQBVxHDyA==
X-Received: by 2002:adf:d0c7:0:b0:21d:764b:12d5 with SMTP id z7-20020adfd0c7000000b0021d764b12d5mr23582331wrh.516.1658154749822;
        Mon, 18 Jul 2022 07:32:29 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:496e:2d41:fd5a:4e5e? ([2a05:6e02:1041:c10:496e:2d41:fd5a:4e5e])
        by smtp.googlemail.com with ESMTPSA id a16-20020adfdd10000000b0021d6e917442sm13038842wrm.72.2022.07.18.07.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 07:32:29 -0700 (PDT)
Message-ID: <387c126a-0106-2227-4b4a-db284965b6ca@linaro.org>
Date:   Mon, 18 Jul 2022 16:32:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 3/4] thermal/core: Build ascending ordered indexes for
 the trip points
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, amitk@kernel.org, lukasz.luba@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220715210911.714479-1-daniel.lezcano@linaro.org>
 <20220715210911.714479-3-daniel.lezcano@linaro.org>
 <6d08939a167870ff7c1c83bb254fda5939f1d648.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <6d08939a167870ff7c1c83bb254fda5939f1d648.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2022 07:28, Zhang Rui wrote:
> On Fri, 2022-07-15 at 23:09 +0200, Daniel Lezcano wrote:
>> By convention the trips points are declared in the ascending
>> temperature order. However, no specification for the device tree,
>> ACPI
>> or documentation tells the trip points must be ordered this way.
>>
>> In the other hand, we need those to be ordered to browse them at the
>> thermal events. But if we assume they are ordered and change the code
>> based on this assumption, any platform with shuffled trip points
>> description will be broken (if they exist).
>>
>> Instead of taking the risk of breaking the existing platforms, use an
>> array of temperature ordered trip identifiers and make it available
>> for the code needing to browse the trip points in an ordered way.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

[ ... ]

>> +static void sort_trips_indexes(struct thermal_zone_device *tz)
>> +{
>> +       int i, j;
>> +
>> +       for (i = 0; i < tz->trips; i++)
>> +               tz->trips_indexes[i] = i;
>> +
>> +       for (i = 0; i < tz->trips; i++) {
>> +               for (j = i + 1; j < tz->trips; j++) {
>> +                       int t1, t2;
>> +
>> +                       tz->ops->get_trip_temp(tz, tz-
>>> trips_indexes[i], &t1);
> 
> This line can be moved to the upper loop.
> 
>> +                       tz->ops->get_trip_temp(tz, tz-
>>> trips_indexes[j], &t2);


Actually, we can not move the line up because of the swap below

>> +                       if (t1 > t2)
>> +                               swap(tz->trips_indexes[i], tz-
>>> trips_indexes[j]);
>> +               }
>> +       }
>> +}




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
