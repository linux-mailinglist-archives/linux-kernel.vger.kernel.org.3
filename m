Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B811E5665E0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiGEJKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiGEJKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:10:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A375310B5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 02:10:35 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d16so10267255wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 02:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=m1A3BKjmMvA2HhWBa1hBKOqUGdUagM4EyV69eqLC85I=;
        b=lez3ifha+f6Rrr2kqrkJPNagj9VuUYOcQxtfKM5Y4ZNeAd6EkbaLAKM/Wbzg0a4ygX
         57zsFX+r5JBezTl1TzKJMtjJTA5Oo9kAjGYphOWnLi18ZL27scIcYVB4U/U38kgKEmqq
         gk9g5o5nmHGVyD8DXjZWNyqXG6U2/+j6Lc92SsFZ2sTjFxv2xgrdIFmqzDZxA/yF6NKI
         GNUsV7wQAkaMXOm5/cXI3S/vnXreUpHCve+wOLJpJ5AeZEZaPD7JExzAJXj7xw15HvMb
         z4klM0hf8PxVjZpQwrmgkqnGnRXdTU50bYGyqxjctGbC/zvfDV5mi5iUPSH1voy4wNn1
         +Jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m1A3BKjmMvA2HhWBa1hBKOqUGdUagM4EyV69eqLC85I=;
        b=MAW+ybNDP0Pq0RyTuDKZAjOiL+XrKFk/GDb7CQ+0k0tnGUxmpOOnil6G5uo1sLhXfc
         109WtJJPo4a1F60wv1ED5dNMnGwzqapMeMDx4rJKYDFoedi89PreAGl8XQtPF5ztvBDx
         yNqAp/oyrx0WccwGOe/cbjAj0jUkMYYrUfWaCX5+H0C5VvmLt1RbHa36uv4UqXrOKSrP
         sFO9pGLnai/4acmyrPRBUfJuvCBe4Rkm33TA0d9tspepNzFO4uCT7df43tsS2ly4zY0u
         nl12QNC0W9zoTKqTJLf2XdFVVwFT1dZo4wT/1XqSJ4WbNyWwRJS4FyLx5JPaE3R2KsN0
         zzhg==
X-Gm-Message-State: AJIora8TrR0Mr6/mz0ZzXrp18qrUAKOjika50J9p8d4uAMcrTCmk38/S
        mNvDq+u2a3Wr+E9Bk3IV23v7EQ==
X-Google-Smtp-Source: AGRyM1ub3m2eRAqQZK2SlJMJ3NmN5z/14L7w6P6uMsrbJrSaaIrj5LVZ69QvQQvaVrQt37N9Vpk9cg==
X-Received: by 2002:adf:f38f:0:b0:21d:66b5:21c with SMTP id m15-20020adff38f000000b0021d66b5021cmr10869255wro.144.1657012234184;
        Tue, 05 Jul 2022 02:10:34 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id b8-20020a05600c4e0800b003974cb37a94sm19032745wmq.22.2022.07.05.02.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 02:10:33 -0700 (PDT)
Message-ID: <be1e6e75-45e0-2c73-bace-4499b7b1af68@linaro.org>
Date:   Tue, 5 Jul 2022 11:10:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/4] Documentation: EM: Switch to micro-Watts scale
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     amitk@kernel.org, rui.zhang@intel.com, viresh.kumar@linaro.org,
        rafael@kernel.org, dietmar.eggemann@arm.com, nm@ti.com,
        sboyd@kernel.org, sudeep.holla@arm.com, cristian.marussi@arm.com,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20220622145802.13032-1-lukasz.luba@arm.com>
 <20220622145802.13032-3-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220622145802.13032-3-lukasz.luba@arm.com>
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

On 22/06/2022 16:58, Lukasz Luba wrote:
> The EM now uses the micro-Watts scale for the power values. Update
> related documentation to reflect that fact.
> 
> Fix also a problematic sentence in the doc "to:" which triggers test
> scripts complaining about wrong email address.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   Documentation/power/energy-model.rst | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
> index feb257b7f350..ef341be2882b 100644
> --- a/Documentation/power/energy-model.rst
> +++ b/Documentation/power/energy-model.rst
> @@ -20,20 +20,20 @@ possible source of information on its own, the EM framework intervenes as an
>   abstraction layer which standardizes the format of power cost tables in the
>   kernel, hence enabling to avoid redundant work.
>   
> -The power values might be expressed in milli-Watts or in an 'abstract scale'.
> +The power values might be expressed in micro-Watts or in an 'abstract scale'.
>   Multiple subsystems might use the EM and it is up to the system integrator to
>   check that the requirements for the power value scale types are met. An example
>   can be found in the Energy-Aware Scheduler documentation
>   Documentation/scheduler/sched-energy.rst. For some subsystems like thermal or
>   powercap power values expressed in an 'abstract scale' might cause issues.
>   These subsystems are more interested in estimation of power used in the past,
> -thus the real milli-Watts might be needed. An example of these requirements can
> +thus the real micro-Watts might be needed. An example of these requirements can
>   be found in the Intelligent Power Allocation in
>   Documentation/driver-api/thermal/power_allocator.rst.
>   Kernel subsystems might implement automatic detection to check whether EM
>   registered devices have inconsistent scale (based on EM internal flag).
>   Important thing to keep in mind is that when the power values are expressed in
> -an 'abstract scale' deriving real energy in milli-Joules would not be possible.
> +an 'abstract scale' deriving real energy in micro-Joules would not be possible.
>   
>   The figure below depicts an example of drivers (Arm-specific here, but the
>   approach is applicable to any architecture) providing power costs to the EM
> @@ -98,7 +98,7 @@ Drivers are expected to register performance domains into the EM framework by
>   calling the following API::
>   
>     int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
> -		struct em_data_callback *cb, cpumask_t *cpus, bool milliwatts);
> +		struct em_data_callback *cb, cpumask_t *cpus, bool microwatts);
>   
>   Drivers must provide a callback function returning <frequency, power> tuples
>   for each performance state. The callback function provided by the driver is free
> @@ -106,10 +106,10 @@ to fetch data from any relevant location (DT, firmware, ...), and by any mean
>   deemed necessary. Only for CPU devices, drivers must specify the CPUs of the
>   performance domains using cpumask. For other devices than CPUs the last
>   argument must be set to NULL.
> -The last argument 'milliwatts' is important to set with correct value. Kernel
> +The last argument 'microwatts' is important to set with correct value. Kernel
>   subsystems which use EM might rely on this flag to check if all EM devices use
>   the same scale. If there are different scales, these subsystems might decide
> -to: return warning/error, stop working or panic.
> +to return warning/error, stop working or panic.
>   See Section 3. for an example of driver implementing this
>   callback, or Section 2.4 for further documentation on this API
>   
> @@ -137,7 +137,7 @@ The .get_cost() allows to provide the 'cost' values which reflect the
>   efficiency of the CPUs. This would allow to provide EAS information which
>   has different relation than what would be forced by the EM internal
>   formulas calculating 'cost' values. To register an EM for such platform, the
> -driver must set the flag 'milliwatts' to 0, provide .get_power() callback
> +driver must set the flag 'microwatts' to 0, provide .get_power() callback
>   and provide .get_cost() callback. The EM framework would handle such platform
>   properly during registration. A flag EM_PERF_DOMAIN_ARTIFICIAL is set for such
>   platform. Special care should be taken by other frameworks which are using EM


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
