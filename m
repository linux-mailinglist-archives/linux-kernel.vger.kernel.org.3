Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC765802C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 18:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbiGYQeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 12:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236186AbiGYQeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:34:07 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8191A80F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:34:06 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso9758186wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1O/8Z+0FTImQ7fUUXDyXrX7k/yISSmS9A01yiX1R2Gc=;
        b=SnH9vvJkYswfs8xHSJuHla7KIa1w3rDQ0LMx7L0uY3Ui/FJyQIS8F+eiONK2aU/TOo
         tJG389TWyMGWP+fiPI3uXTZfIlWbnedMN/49f5VR2bdzSnlh6+1JBc2M+8NRqL9WlHbw
         Dv56nvToAQFofcKHa6ZuuBXeSheRECt1nv7QAnKJsWBxotyTNLHBnLWVWdDt9dLGuSuB
         hVthXZLRVdeOO8F8bwqhwHTct2TND4fcB/PtBJ2AWf4r9AxRdvoFWztT9bC8Lo75vXWD
         sRBdCFWP3I/cAcUf0hKtzb0BAWh1spPRHymB58WdvNt9sAphafykDhH6+w2Tplev4yMQ
         mJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1O/8Z+0FTImQ7fUUXDyXrX7k/yISSmS9A01yiX1R2Gc=;
        b=2JRIN6v9PSj8+nQ24aWOxCSozVG2y9OgZ61MIh+lXAkeoFDzj93aiZSmDsRHXh1PkB
         UK42ND/5ao38eIL7FPOsEIf1pLylm8DRzhUSr7Q/AQZjSSlvlzrvYzKf2wssI0SBOxRJ
         FdJL7+JA1rtXK6Pmn3JDnpXCyXghOMvTlZtTAWfsthx4McWd+ROuRXcf+G72CkhbAnkE
         H+hdUHhYisIb22w0aeSYxNuf7+jovfrFvUwphalDo1/m6Ig+ylZ3ipjM99BKTuP/Q8Gw
         OzswzUQRpNTljU98PGyNq2YOO/VyYFEf1Ph49Y6aZSLkcbrB+noG+Q6HGUsHa3BP7gbb
         +8xg==
X-Gm-Message-State: AJIora9bb2XUJx3/jHTmxoOQZO1hLT4ivDNGIvDHVXypDpRFrWXpPD7L
        +XSulTjpdDfWak7mHnXNmApjXw==
X-Google-Smtp-Source: AGRyM1vkoaTuricTMgjgkSLToecTEKq23q5cywQr8v8cMsuJprFjkAuUkl4GQbyy/SaOMSin8iFicg==
X-Received: by 2002:a05:600c:3d88:b0:3a3:63ad:c592 with SMTP id bi8-20020a05600c3d8800b003a363adc592mr2948258wmb.71.1658766844974;
        Mon, 25 Jul 2022 09:34:04 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:1780:8e54:dd38:6668? ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.googlemail.com with ESMTPSA id c17-20020a5d5291000000b0021b956da1dcsm7581256wrv.113.2022.07.25.09.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 09:34:04 -0700 (PDT)
Message-ID: <1aa3ae56-84ae-8a96-7a52-3181c47dcb07@linaro.org>
Date:   Mon, 25 Jul 2022 18:34:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 00/12] thermal OF rework
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linexp.org>, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com
References: <20220722200007.1839356-1-daniel.lezcano@linexp.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220722200007.1839356-1-daniel.lezcano@linexp.org>
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


Hi Rafael,

On 22/07/2022 21:59, Daniel Lezcano wrote:
> The thermal framework initialization with the device tree appears to
> be complicated and hard to make it to evolve.
> 
> It contains duplication of almost the same thermal generic structures
> and has an assymetric initialization making hard any kind of serious
> changes for more complex features. One of them is the multiple sensors
> support per thermal zone.
> 
> In order to set the scene for the aforementioned feature with generic
> code, we need to cleanup and rework the device tree initialization.
> 
> However this rework is not obvious because of the multiple components
> entering in the composition of a thermal zone and being initialized at
> different moments. For instance, a cooling device can be initialized
> before a sensor, so the thermal zones must exist before the cooling
> device as well as the sensor. This asynchronous initialization forces
> the thermal zone to be created with fake ops because they are
> mandotory and build a list of cooling devices which is used to lookup
> afterwards when the cooling device driver is registering itself.
> 
> As there could be a large number of changes, this first series provide
> some steps forward for a simpler device tree initialization.
> 
> More series for cleanup and code duplication removal will follow.
> 
> Changelog:
> 
>   - v6:
>      - Folded patches 8, 9, 10
>      - Removed thermal_zone_get_trips() and thermal_zone_get_num_trips()
>      - Moved tz->ntrips => tz->num_trips changes into patch 11 to fix the
>        git bisecting
> 

I believe all the comments were addressed, is it fine if I merge this 
series ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
