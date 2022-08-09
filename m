Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5978358E205
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 23:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiHIVqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 17:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiHIVpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 17:45:50 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E2A4AD5D
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 14:45:49 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v3so15793075wrp.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 14:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=5geUTWjaaOcBVhWxz5YB+FFbf6115VxYj5loGEcSOU8=;
        b=x4fQxmWEZCRBZn3qEbFM/+uOtmYZ2uAh11sMqgrnKo/G/Ulw+RAwW6WAnfR/oqPPGG
         oLU/z1i/dN4JbEZENr/AyLI1zM5YMv4kCyUl3WVqtL6/sUGK6HkMltPF5mo3r9nGBpm4
         Dp2BGyd4UI1+HC/EUPIppso+nWPufJnE+OmkXmQ3J3uudHzP4KYI6L9vdN/07FPhEOjl
         NlcohzxolgNyRL0PMhaPJ0AJj5aaBYx99HzNfnYzAYIXmhQ4PRioxOLLZXygGjxFa5NO
         +Z9xbQ4dJRRlbmKBeHdnac9TVo3DH/++tYfeiAnJFlkEfSm2nHUGLHj3p/nb8vMMtiKF
         qQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=5geUTWjaaOcBVhWxz5YB+FFbf6115VxYj5loGEcSOU8=;
        b=g+Teb7OoarNrra6sg8JMA/cPivtG6bMlRxJXeSAU0d+V05oVZBmxoPK2Q8HLk+cuf8
         g6VWpeR2j5eYyKBEEz7kXH5jfxPzLidrW7DQI8mGJeURYC9oWXZ6jRnIUUWGhJ8PjsON
         cSw9WXw1j8/mM86qelRuQtxNpVhbtXx3xUhR2zjAE2WuFTK/xsgJV8vP9ZYMduF/Q7oy
         cvCQ3+McZ2yCnqL9HEiv39nPKe+EC6aEou3iO4Kwgg6/RcDF1jQyHzyKL/8a48Ji9Xh+
         Vzs8ts5JYmt+QkOdmVDAt++Vf5NDJw8GbNcGG2L6bLjhyJP1HWS0hVRZ4FGfuZVmGIsq
         9sAw==
X-Gm-Message-State: ACgBeo0lWZYbw7dqbkaGwrqm2+O84XKohlUDtaI8bR5WrU1DatnptIOL
        DHGNZiL7nc2Zn+3Q8zFdEsdNHbNnCbli4A==
X-Google-Smtp-Source: AA6agR6OYLekP1zwiTGxrgEF3gblfROb0Z0rtoZ9bUCWDXigJhZIB445MsB04r1kNXnyAdrIUUYbGw==
X-Received: by 2002:a05:6000:1a89:b0:222:c186:ca8a with SMTP id f9-20020a0560001a8900b00222c186ca8amr9723969wry.333.1660081548061;
        Tue, 09 Aug 2022 14:45:48 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id z19-20020a05600c0a1300b003a539792542sm227280wmp.7.2022.08.09.14.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 14:45:47 -0700 (PDT)
Message-ID: <1ef26db5-6e2b-ce27-f9ad-34ff8f4055cb@linaro.org>
Date:   Tue, 9 Aug 2022 23:45:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 23/26] thermal/drivers/acerhdf: Use generic
 thermal_zone_get_trip() function
Content-Language: en-US
To:     =?UTF-8?Q?Peter_K=c3=a4stle?= <peter@piie.net>, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "open list:ACER ASPIRE ONE TEMPERATURE AND FAN DRIVER" 
        <platform-driver-x86@vger.kernel.org>
References: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
 <20220805145729.2491611-24-daniel.lezcano@linaro.org>
 <fdaba367-c657-0d85-7244-918b99569337@piie.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <fdaba367-c657-0d85-7244-918b99569337@piie.net>
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

On 08/08/2022 21:34, Peter Kästle wrote:
> Hello,
> 
> some comments.  Please merge if those are considered.  Thanks.
> 
> 
> On 05.08.22 16:57, Daniel Lezcano wrote:
>> The thermal framework gives the possibility to register the trip
>> points with the thermal zone. When that is done, no get_trip_* ops are
>> needed and they can be removed.
>>
>> Convert ops content logic into generic trip points and register them 
>> with the
>> thermal zone.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Acked-by: Peter Kästle <peter@piie.net>

Thanks for reviewing the patch

[ ... ]

>>       if (kernelmode && prev_interval != interval) {
>>           if (interval > ACERHDF_MAX_INTERVAL) {
>>               pr_err("interval too high, set to %d\n",
> 
> I don't know the current behavior of the thermal layer well enough.
> Is it ensured, that those new trips[0].temperature / trips[0].hysteresis 
> values are taken into account?

I don't have this platform so it is hard to test. All the device tree 
based sensors are using now those generic trip points and that works.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
