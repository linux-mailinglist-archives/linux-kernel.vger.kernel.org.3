Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E245771AA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 23:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiGPV4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 17:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiGPV4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 17:56:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF4518E33
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 14:56:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bk26so11671100wrb.11
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 14:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CJncK78wbfqDZVqtUKyt+uW6TZ/j/FgGTteV5vTEeUw=;
        b=MFN/8cZqcYQpmQ1Hfca/mczdZRS0VgEtbMXV7DI9+m1m6TQ8T75F95XAhnyWALpVuS
         wKIJRvW5lfzfhFvuKhiWY7nR9bswiLEzUY/j2PLxMcSBxk9ex8f8PUvK44E3gQJc4vev
         83+YucwZ9fNKsDhkrolBugc3uzItyk6LA/caVf3hPT8FAM74hyNSvn5TaYn368VmLsP/
         Tc2ecfzJ/yj/Z4SWpRtK03MkSh4+YWf4wflKbx5Ys5YYkQWfucYTJRL0SzVpxxe34/hc
         v0JDI3f4wAIQgKZJoJVlR8fZWuelCIcGfc58bDWlxMWQwQKc3sD1U0aqTet5Qup0/n5e
         xTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CJncK78wbfqDZVqtUKyt+uW6TZ/j/FgGTteV5vTEeUw=;
        b=Pb/Axs4LHop5YUCEC8hp2KlbCcYWY+KdFwRMLYXTWN/v6jpP8ZffS+zx4Ws9pk2Co7
         WYt7AQ8HtdZ0KYoI/2R5qvLaPg13y/Hj0dA3TKyQgEj9SKObVE0cADwFNvj8On+YF6NN
         Oo76iVa21xoF9i2y8cVLkTeprZwOaIZ04NeRgcBNyBK54EBlCnKgbJyNJjgMuj1HP/aj
         beIKqVn+kb4zBGwt/NPdgH2oEZUu7/sDGoEOO8+0fcqrBhiinoBiEz//MwEnEW3iRGUd
         DFKnLZ1zFN1sKXWvw0pGCSuvQqiWDeRtWVOWZxoYYAfZGE8mtZmJinX+h/8/p5YSIoBD
         wAGQ==
X-Gm-Message-State: AJIora94LvfE2EGYMOkQeW3av8hkeOfJqKaB36n2PEs9wyFecJyI9Aya
        9FwMY6SrLxx/svz7gk9+MX/6tg==
X-Google-Smtp-Source: AGRyM1v1GUn6WKcAtS7l3Zt/0ErVJMYDW8X1mg/A8gTQi6wYkbagQ8l5i7utwqeBZ6N6fmtFEbbjWA==
X-Received: by 2002:a5d:55cd:0:b0:21d:6d9d:2c4e with SMTP id i13-20020a5d55cd000000b0021d6d9d2c4emr17385633wrw.544.1658008609568;
        Sat, 16 Jul 2022 14:56:49 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:6a38:5652:1b0c:da5e? ([2a05:6e02:1041:c10:6a38:5652:1b0c:da5e])
        by smtp.googlemail.com with ESMTPSA id l19-20020a5d5273000000b0021d60994b0asm6824957wrc.100.2022.07.16.14.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jul 2022 14:56:49 -0700 (PDT)
Message-ID: <7053e141-671a-4c80-5f9e-78fffd32d5f2@linaro.org>
Date:   Sat, 16 Jul 2022 23:56:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 00/12] thermal OF rework
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linexp.org>, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com
References: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 10/07/2022 14:34, Daniel Lezcano wrote:
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
>   - v5:
>      - Remove extra of_node_put() reported by lkp
> 
>   - V4:
>      - Added of_node_put(trips)
>      - Changed naming 'ntrips' -> 'num_trips'
>      - Updated documentation for added and renamed fields in the thermal
>        zone structure
>      - Fixed bad parameter type 'thermal_zone' -> 'thermal_zone_device'
>      - Clarified there is more cleanups coming in the changelog
>      - Put 'trips' and 'num_trips' fields all together
>      - Made git-bisect safe the series

If there is no more comments, I'll pick this series





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
