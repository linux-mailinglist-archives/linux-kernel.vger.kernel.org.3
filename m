Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E855802CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 18:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236245AbiGYQgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 12:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbiGYQf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:35:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E351B1CFEC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:35:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bn9so5896983wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=31q2utBSsnk2x39WVe31RkGyMadtJlJYuR1YdJT4pXc=;
        b=MSaZJBSvWpSvy4L5Fg188Hmm2wB9JnuH7Nd/WC9YRxQ7YbNiKk15ziAt6n9WHhtdX6
         M2Rsa9oqxpIJtus6rGmmGSgWXWyylxFbD5v1tRlM2/6m1pi0T8NpkTKOno8dnW/G+TeJ
         wl1va5ditDu9LmnpZeGeabmMLCe2eIWxtOBGcfObwm5T+qIqf2e2Azbm1g+wyb9STsml
         NH+iAYxnLPHzE3RDzvh0gnPcsXLZQF8AzGn9wae8znKhJNQD1JGzvxcGyFuibyRHa2CF
         0i6cU7NlytFSOvAbrGdtrTPyXeifxMreyeB40wdCTSf7I3/5H768z/DMIPX73WJSW8JM
         bnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=31q2utBSsnk2x39WVe31RkGyMadtJlJYuR1YdJT4pXc=;
        b=qqFxcBXZo7jJhRJkoMjFC+MRwXOIgAZdvlOjsIkVSZwB10kpP/QGZJ/rRqmP/6TzMh
         N0Dc1XyTExgU57Lesz9TEU1h3v1x7D2EpEVOQgYg6JwWU3YZuwULa1XQhaJKHOE+We4e
         pMuq9LO7QPBEUYSA0LWs4K3DXleaCUUqjbWvZ3/PfJcYL2PuoHEsl/r9e1CPqWvIxvOV
         s1UU5eQZ7D5yEJ9iU6a6dn+jtK5uqCuuYrHrqVr/9sEZW7P9mO+ygI/PLqhoeWagL3Bj
         5jV3XQac6a+Jst15OVFDazVuqSVgScMGWWKKYS1arg8LpKblEeeOjLMhBs2OsmP23/4U
         F/mA==
X-Gm-Message-State: AJIora9G99n/YW6xTwgC6z97N1XjFqgmhbY1/vQFSYC+bcbiS5w0TEq9
        PjV3y3S3YgNCN0JcNHcJnsRq7Q==
X-Google-Smtp-Source: AGRyM1umkE+Alf6ZYxWq0oLgCfbbPiPYIRINPFWQUYEZiqj/WPI+KzU3dXTwuH3KqzDZJOC2Gmc8Mg==
X-Received: by 2002:a05:6000:16ce:b0:21e:8450:1b6a with SMTP id h14-20020a05600016ce00b0021e84501b6amr5001312wrf.372.1658766956418;
        Mon, 25 Jul 2022 09:35:56 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:1780:8e54:dd38:6668? ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.googlemail.com with ESMTPSA id az14-20020adfe18e000000b0021e529efa60sm6631059wrb.1.2022.07.25.09.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 09:35:56 -0700 (PDT)
Message-ID: <89e7974b-516c-bc37-6ca9-4bcc4e884089@linaro.org>
Date:   Mon, 25 Jul 2022 18:35:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 3/4] thermal/core: Build ascending ordered indexes for
 the trip points
Content-Language: en-US
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220718145038.1114379-1-daniel.lezcano@linaro.org>
 <20220718145038.1114379-3-daniel.lezcano@linaro.org>
 <CAJZ5v0hj0kMRNBqO_0SqsAAY8Rb8h2NrWOYogDLgGZnCtiTEwg@mail.gmail.com>
 <117c778a-4496-4d49-e73d-06fa3efa4d09@linaro.org>
 <CAJZ5v0gjfeyiS8rUoPpa3sMrofw1ZyQe=+P6pvPbeirs07F+Qw@mail.gmail.com>
 <8926eed7-436f-5f1a-7036-0e1520bd3a0b@linaro.org>
 <CAJZ5v0icAE1t4+VsEq71FiUjQXr1LJeokBiuGTxvsHByedfmhw@mail.gmail.com>
 <1ec4d34d-6700-0f99-81e3-1c7129a80246@linaro.org>
In-Reply-To: <1ec4d34d-6700-0f99-81e3-1c7129a80246@linaro.org>
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

On 25/07/2022 18:29, Daniel Lezcano wrote:
> 
> Hi Rafael,
> 
> On 22/07/2022 19:40, Rafael J. Wysocki wrote:
> 
> [ ... ]
> 
>> They can be made in the opposite direction, starting at the core
>> level.  Then, it would be clear where you were going.
>>
>>> I would like to
>>> keep the indexes trip array approach to fix the trip cross events which
>>> is broken right now and then go forward with the struct thermal_trip
>>> changes and the thermal-of cleanups I've sent last week.
>>>
>>> Does it sound reasonable ?
>>
>> I'm not convinced about the need to make the code more complicated if
>> the overall direction is to simplify it.
>>
>> I understand that you want to avoid regressing things, but you want to
>> make these changes eventually anyway, so why to you think that the
>> risk of regressing things would be smaller in the future, after making
>> the code more complicated than it is now?  Sounds counter-intuitive to
>> me.
> 
> Ok, I'll rework the core code for that.
> 
> Having the series [1] and the new version of [2] will have the trip 
> point partly reworked.
> 
> Thanks
>    -- Daniel

Adding missing pointers:

[1] 
https://lore.kernel.org/lkml/20220722200007.1839356-7-daniel.lezcano@linexp.org/T/

[2] 
https://lore.kernel.org/lkml/20220710212423.681301-1-daniel.lezcano@linexp.org/



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
