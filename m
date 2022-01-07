Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52B6487EC3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 23:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiAGWHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 17:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiAGWHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 17:07:52 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4851C06173F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 14:07:51 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a5so9610156wrh.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 14:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cWkdJMcjc1NqLSEp8693DqYqekE889IyVMB4055e5S8=;
        b=J+DiQRaps5T4HtDY/Mqw3TFP/vjPCqu6rvpsgg1pWVfweJZ2XTaPfoJNJSrf91u4Yn
         yFH5Gkh6H6RabJj7vj6uUFTj7Ihkf/S2JuldgiyARtwOhddLh0RkqPLjHfbHSm3eOCcx
         aYie2KVpSFpa4NmgmjpBcRdjmnMyVvGuG0YSZB6U5RXcf0sW4f3WqAhaebTXu6uxB7Y8
         /2rnqMOWYwjTDbmp9QukfpnU6sj6T/TRyC91m2zhtWRrIPEMA4VU7RsSUovxftGdMm+u
         asflqKEgd+b4maCEQ8UM2otLFuMbC410no/m9ULDYLryn20OtIg30MrAChYPQK0y8mSD
         Xz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cWkdJMcjc1NqLSEp8693DqYqekE889IyVMB4055e5S8=;
        b=AF57pd6YLLfipeDTBNNaEZhOkgBuTyBxJvR+jhGkQJjxIZGcLYZGM/1GdGYVRvxk5F
         D0aZuK670qCUKy9TxweVSKxpEdYKBt+CrNEAFa0Pi52T4nZZZsgRfd60S1j4XKlZJnk/
         Rs1pcGCO0CF6TweMWWn+W6nPh03RAGNq3rwe5yrUHC+ReEJnDX4DWroi+iC3HVp4ZSxL
         u8txscxn29ErEBA2kwnSs6BE/CGA5vVLVruQkrNQSx5vpXwY3xod5SGsjOBgJEZhfXCU
         VukYELHJdZPnQhSBQGvLxb4YV6gkdt17XSHqemK2XkwJLsSXQ9gIov/dgfyhvLVXnMrX
         HbBQ==
X-Gm-Message-State: AOAM5317Xex/OGBUZOgk9NzlhA9yO9O2WAbElJtnotvX8/rNVsh4n2XO
        l7vshgS+DffJru2GOhKdJePfMQ==
X-Google-Smtp-Source: ABdhPJz5FUIX9NI1tI9NJydj1K6qi0+C7X1rD+70goNR48JdvHVnob19+nmnj7N7wIPoUcWZRN+ZRQ==
X-Received: by 2002:a5d:6c6b:: with SMTP id r11mr53610204wrz.548.1641593270165;
        Fri, 07 Jan 2022 14:07:50 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:75e4:1cf:8890:e76? ([2a01:e34:ed2f:f020:75e4:1cf:8890:e76])
        by smtp.googlemail.com with ESMTPSA id m5sm8895818wml.14.2022.01.07.14.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 14:07:49 -0800 (PST)
Subject: Re: [PATCH v5 6/6] qcom/soc/drivers: Add DTPM description for sdm845
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     rjw@rjwysocki.net, lukasz.luba@arm.com, robh@kernel.org,
        heiko@sntech.de, arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        Andy Gross <agross@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
 <20211218130014.4037640-7-daniel.lezcano@linaro.org>
 <YdiUOh8FtPRktlUM@ripper>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8e2fa6b6-4f95-9381-4d7e-810afe98fcea@linaro.org>
Date:   Fri, 7 Jan 2022 23:07:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YdiUOh8FtPRktlUM@ripper>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Bjorn,

On 07/01/2022 20:27, Bjorn Andersson wrote:

[ ... ]

>> +#include <linux/dtpm.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +
>> +static struct dtpm_node __initdata sdm845_hierarchy[] = {
>> +	[0]{ .name = "sdm845" },
> 
> Why is the index signifiant here?
> Doesn't this imply risk that we forget one element, which will be
> thereby implicitly be left initialized as {} and hence denote
> termination of the list?

Yes, that is possible. The other annotation is also possible. The index
helps to refer from the .parent field.

That said nothing forces to use the index, so it is a matter of taste.

>> +	[1]{ .name = "package",
>> +	     .parent = &sdm845_hierarchy[0] },
>> +	[2]{ .name = "/cpus/cpu@0",
>> +	     .type = DTPM_NODE_DT,
>> +	     .parent = &sdm845_hierarchy[1] },
>> +	[3]{ .name = "/cpus/cpu@100",
>> +	     .type = DTPM_NODE_DT,
>> +	     .parent = &sdm845_hierarchy[1] },
>> +	[4]{ .name = "/cpus/cpu@200",
>> +	     .type = DTPM_NODE_DT,
>> +	     .parent = &sdm845_hierarchy[1] },
>> +	[5]{ .name = "/cpus/cpu@300",
>> +	     .type = DTPM_NODE_DT,
>> +	     .parent = &sdm845_hierarchy[1] },
>> +	[6]{ .name = "/cpus/cpu@400",
>> +	     .type = DTPM_NODE_DT,
>> +	     .parent = &sdm845_hierarchy[1] },
>> +	[7]{ .name = "/cpus/cpu@500",
>> +	     .type = DTPM_NODE_DT,
>> +	     .parent = &sdm845_hierarchy[1] },
>> +	[8]{ .name = "/cpus/cpu@600",
>> +	     .type = DTPM_NODE_DT,
>> +	     .parent = &sdm845_hierarchy[1] },
>> +	[9]{ .name = "/cpus/cpu@700",
>> +	     .type = DTPM_NODE_DT,
>> +	     .parent = &sdm845_hierarchy[1] },
>> +	[10]{ .name = "/soc@0/gpu@5000000",
> 
> It worries me that we encode the textual structure of the dts in the
> kernel. E.g. for quite a while this was "/soc/gpu@5000000", so if this
> landed a year ago this driver would have prevented us from correcting
> the dts.

Why ? The change should be reflected in the driver also, no ?

> Another concern is that not all busses in the system are capable of
> 36-bit wide addresses, so it's plausible that we might one day have to
> create a more accurate representation of the address space. Maybe not on
> SDM845, but this would force us to be inconsistent.

Sorry, I'm missing the point :/

If a change is done in the DT, the code using the description must be
changed accordingly, no?


> Regards,
> Bjorn
> 
>> +	     .type = DTPM_NODE_DT,
>> +	     .parent = &sdm845_hierarchy[1] },
>> +	[11]{ },
>> +};
>> +
>> +static struct of_device_id __initdata sdm845_dtpm_match_table[] = {
>> +        { .compatible = "qcom,sdm845", .data = sdm845_hierarchy },
>> +        {},
>> +};
>> +
>> +static int __init sdm845_dtpm_init(void)
>> +{
>> +	return dtpm_create_hierarchy(sdm845_dtpm_match_table);
>> +}
>> +late_initcall(sdm845_dtpm_init);
>> +
>> +MODULE_DESCRIPTION("Qualcomm DTPM driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:dtpm");
>> +MODULE_AUTHOR("Daniel Lezcano <daniel.lezcano@kernel.org");
>> +
>> -- 
>> 2.25.1
>>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
