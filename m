Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641F84B5E63
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 00:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiBNXnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 18:43:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiBNXnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 18:43:33 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3F28D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:43:25 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id s10so15780085wrb.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=J6UtsCOG/MOHUeoOG1yb2cxuVFsLjCztE8jNAjI7YmE=;
        b=R9RitRklkNR91LTOMUmI6VdWT+ceCQ76Hbfh/914xLnzjqaCOAK5Mwd1gLlMA3UMyT
         9UlCUUqJndIo/HBJujLAP8+b8Zkp2cNLQwAarfd558JsJjssTBYEMP6wSKmQP7Z5lvfd
         PkZoy/A3E3HUY4bLNhPWGRsuwsFeVLTanRhZekWkReAb7hQS8J8I5lz3XEmVj6FVC5wh
         XUFPx2xExCAcaReRbl/Lc6YETtJ3dtyLx59Hvj2RsdK0QGqcmFrH0PVVKdfU23XJcuw2
         l7QJw0V3kLTtFh+6QF8so8yMB58v7zMp1df1qx8wkSHy4RRN3tcuUmYHGoRspXYvdgWS
         aNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J6UtsCOG/MOHUeoOG1yb2cxuVFsLjCztE8jNAjI7YmE=;
        b=Uf8UpHEcIOEiGkDFpYTvNtZrtiSzPu1+3qzfwa+7nWmktR/oHqIly0E8p2ESmrGP0e
         4ER6PTL8vGFbALlrZcWEdma4MtRF7KLx/fbv+LvpTv+DBUORj3HOPTA5hnjJZ7CwoyMX
         Xg82mxS/+Pnp3oFCy5a/ffE5NDY/fhLy7B+zHD90oB4jrj8zb0VO0qoj2PfrORheUEV+
         WtLYYxnC6zdsZiGjGV++ob5LZ8XZDQTicCcH0wih1egDQM1T0db4HOBRpbjCTHS0DL7y
         Db0lYnl9JCcOpuv473brXk8lUB0CW2/T+CR5aj2qfdSR2MbDwPQqz5CmVkv7XfP9oufY
         uatg==
X-Gm-Message-State: AOAM532DcPqZtOmr4Hczr3cEURWVJWwWIgh2KpYQOx5uE/R2fOtQWzbQ
        Z4Z8hGv79uBaEU0g/P2wSyS1VA==
X-Google-Smtp-Source: ABdhPJwC0lcPFtT2usy6dc08+jDdHyf10KCX/MdPeMXIriK2I+D1B5tk/4NjH3eUFD7TilvAYK0Kug==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr934723wrn.441.1644882203509;
        Mon, 14 Feb 2022 15:43:23 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:758e:84ee:c9c7:9bfb? ([2a01:e34:ed2f:f020:758e:84ee:c9c7:9bfb])
        by smtp.googlemail.com with ESMTPSA id y6sm5470608wrd.30.2022.02.14.15.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 15:43:22 -0800 (PST)
Message-ID: <f249be05-74ef-6aeb-a561-462c3a76a194@linaro.org>
Date:   Tue, 15 Feb 2022 00:43:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 4/4] tools/thermal: Add thermal daemon skeleton
Content-Language: en-US
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
References: <20220214210446.255780-1-daniel.lezcano@linaro.org>
 <20220214210446.255780-4-daniel.lezcano@linaro.org>
 <50025eeb1826c929342e9f600b5c2d91eed6d2ed.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <50025eeb1826c929342e9f600b5c2d91eed6d2ed.camel@linux.intel.com>
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


Hi Srinivas,

On 14/02/2022 23:34, srinivas pandruvada wrote:
> On Mon, 2022-02-14 at 22:04 +0100, Daniel Lezcano wrote:
>> This change provides a simple daemon skeleton. It provides an example
>> of how to use the thermal library.
>>
>> The goal of this skeleton is to give a base brick for anyone
>> interested in writing its own thermal engine.
>>
>> In the future, it will evolve with more features.
>>
>  From the code, doesn't seam to have a function to daemonize.

Yes, it does, see below. If the stdout output is set, then it won't 
daemonize.


> So may be not call a daemon if that is true. mainloop() is just an
> infinite loop polling netlink messages.
> 
> Also thermald will confuse with the standard thermald distributed with
> every distro. May be thermal_control_sample as this a sample for future
> development.

Does thermal-engine fine ?

>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

[ ... ]

>>   tools/thermal/thermald/thermald.c | 275

[ ... ]

>> +       if (!(options.logopt & TO_STDOUT) && daemon(0, 0))
>> +               return 1;

[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
