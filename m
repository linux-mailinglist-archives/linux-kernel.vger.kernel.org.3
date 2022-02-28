Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBE74C6C14
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbiB1MWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiB1MWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:22:12 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB4370861
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:21:33 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id j22so15088008wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zUvIRVJi/ZgllM3Ppyfeb+eG2zPiG6PJ8f5vmqOU/74=;
        b=Nfz1Rop9HBjK5ByYGawUYVeS1YoLoQqHb/px7OrCme6n2GJ63C0vxpcr62MG32vohL
         3iwfHGGel2r/w4I82v/iWv+nKgI1sn/noLCa5Ok6d227vCjh4hqExtS1aUlk4MQw3xDl
         /O8HS+WjxvCvfvB17e/QWy8SxQzyudQZLPC/mAHSzBIw1W+cb7/Sw+uwTaZThCrjuCBf
         FENURFeaj84q4YCwZLMJttk+Zt3sMQ5rK611mQzHAVbv4urPNZnPgBUiwor1++rFOFyB
         CFPr572dMr8+5bWP8A0t/ox+ZvXRDNWsXeogROtNFzVhRPewuG8Y86845CLr4R/XDcO6
         4oFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zUvIRVJi/ZgllM3Ppyfeb+eG2zPiG6PJ8f5vmqOU/74=;
        b=j8+Xnjw72q5AFiGDCOzrVJdwkncwf7g4GJgrtchqcOoCWevHzt4nblPNUjj8j2NeKI
         fF7tdr3Z/euthdbjC/f6qgQB3jTtngrXcHu1pHekDyBozt/NSnXv5uE/woCyANN+a+S3
         XmbArybpQM+ng64HbZVEx0t7WJtASC6VsurgHRYBg1CganULzNasUzSQ/8q87/8ZaN/S
         wfj8tymPbHmwHA68iSPzo4+JVT0H4A7+AFzen48Ad8gKotVWGVO1Z7MxNefQri28VYwC
         c1mkFuhwWiICmR2pC6+KHRgu3ZnA8NQlidSC7NgBbeOVMibkayKL+ZGoMW0sq/9MR5QG
         XB5Q==
X-Gm-Message-State: AOAM532fbpSnrxz2Oz8NpzmtQN8BJdO+JMFkVL7uSfW9Ouggs8iHFNjN
        BmSQeyzSB6azZL1iLlEzhbA19Q==
X-Google-Smtp-Source: ABdhPJwVyT2YPEWD2Yo08X8WeWnnWFuFbH42LA+0nXQyBNJMcm/X0KGQbgBV+am+JgWsQsAZSVOZ+w==
X-Received: by 2002:adf:f00e:0:b0:1ed:e1d2:f10c with SMTP id j14-20020adff00e000000b001ede1d2f10cmr15734487wro.181.1646050892112;
        Mon, 28 Feb 2022 04:21:32 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:7f2b:6650:2756:a131? ([2a01:e34:ed2f:f020:7f2b:6650:2756:a131])
        by smtp.googlemail.com with ESMTPSA id a17-20020a5d5091000000b001edb61b2687sm14710938wrt.63.2022.02.28.04.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 04:21:31 -0800 (PST)
Message-ID: <793819e8-1e6e-385c-d94b-c117ab3110b0@linaro.org>
Date:   Mon, 28 Feb 2022 13:21:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Testing the thermal genetlink API
Content-Language: en-US
To:     Nicolas Cavallari <nicolas.cavallari@green-communications.fr>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220228110351.20518-1-nicolas.cavallari@green-communications.fr>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220228110351.20518-1-nicolas.cavallari@green-communications.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Nicolas,

thanks for using the netlink and giving those feedbacks even you are 
unhappy with them.

On 28/02/2022 12:03, Nicolas Cavallari wrote:
> I've played a bit with the thermal netlink interface and it wasn't pleasant:
> 
> 1. The way attributes are used is painful.  Instead of using arrays of
>     nested structs-like, it flattens them into a big nested attr where
>     you have to guess when an entry starts and when it ends.
>     libnl provides no helper for this case:
> 
>     [{nla_type=TZ|F_NESTED},
> 	[{nla_type=TZ_ID}, 1]
> 	[{nla_type=TZ_NAME}, "name1"]
> 	[{nla_type=TZ_ID}, 2]
> 	[{nla_type=TZ_NAME}, "name2"]
> 	[{nla_type=TZ_ID}, 3]
> 	[{nla_type=TZ_NAME}, "name3"]
> 	[{nla_type=TZ_ID}, 4]
> 	[{nla_type=TZ_NAME}, "name4"]
>     ]
> 
> 2. The genl_cmd types are not unique between multicast events and
>     command replies.  If you send genl_cmd=3 (CMD_TZ_GET_TEMP) and you
>     get a genl_cmd=3 reply, you cannot know if it is a CMD_TZ_GET_TEMP
>     response or a EVENT_TZ_DISABLE because both have genl_cmd=3, but
>     completely different semantics.
> 3. The API is heavy.  Getting the complete information about all thermal
>     zones requires 1 + 6 * thermal_zones netlink requests, each of them
>     only returning few information.  You need most of them to merely
>     translate the event's TZ_ID/TZ_TRIP_ID/CDEV_ID to names.

That is part of the discovery and it should happen only once when you 
get the thermal information.

> 4. THERMAL_GENL_CMD_TZ_GET_TRIP cause an oops if the thermal zone driver
>     does not have a get_trip_hyst callback.
>     This concerns all drivers, short of two.  A patch follows.

Great, thanks for the fix.

> For the record, I couldn't find any open source program using this API.
> It's also not enabled in all distributions.

The netlink support is very recent. A library has been posted [1] and 
hopefully it can helps you to get rid of all the complexity.

Thanks for testing

   -- D.

[1] 
https://lore.kernel.org/all/20220218125334.995447-1-daniel.lezcano@linaro.org/


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
