Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F268D4B9150
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbiBPTig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:38:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbiBPTif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:38:35 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0F1C1C8A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:38:22 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l67-20020a1c2546000000b00353951c3f62so2390334wml.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AboYQV2RRhiS2OKfRcBDf/ccoxDOeEWOpFppYBuvgvk=;
        b=ryR1LNxBvxTutflq6/ZAK/VSNEBUDY90SvMHGDbVxBNdR8XNrYjOnz6er4FgMSW+Ck
         tTyUsoxgRelVS98PGMem3pCBZbqflM+Q02eMM6fYZrTzPlCmIZ2AImyhVk4lT1+oJ1nm
         7DCM6yH3cX2c2DcifjzTmsNZ7kSVpYbQrC30Ei2HvLB/NvpAbSEfp4OrAYLaVhEtz7zm
         bLhkFqMpfQg0OL2l0bYnpAvFxInuahOtgLENmWanXEv6MQDY9jpVgSgRxMS8wj/9Fekm
         CoUQcgKuuDDwIBtdrOLm2MAtXGdgER0OwX5lg/7BQLpxvILm9gkkAyaSY3DE2zqQ23EP
         sMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AboYQV2RRhiS2OKfRcBDf/ccoxDOeEWOpFppYBuvgvk=;
        b=tsRJFsbM4n5f98rks98xfseo6oMQ9R+6i72I90rY8VLK8b6Y3mlPfz88qzUALVVx8H
         z9v5RzjXDA+RQT3piU1p2fPu/tvlIAF6z+5uZt81NZX0TLTuMoEv15Y1hx1S9bUzxAXn
         6bYR4WcTFaPv8C1g+swzmJWv8OTVa6KE/+Yz+q+m+AnH7Dm6Ym42IWATzLPD6lALn6nY
         x0NVqzU4CdSUvILMbu9C1xcfxnw42nzsMxh5Izb9UQrnootBbUYmL3xfDC/hKuEAXvjO
         9vmLEMyh9graV/lSUR7gEJQFqCf45AO3Yf1Z5xYZWBB/BpTCtouprqKfxw7+HtXKkXvC
         4xTA==
X-Gm-Message-State: AOAM532NrjzRRrU4LB0137bbRdVdNHTzc+Rx+q56ohuFwLO1pKWF7Kqz
        pifKOlUr6j7ZTXKdlev9S3s5DQ==
X-Google-Smtp-Source: ABdhPJy0s8CbGeNQcCY6w7+9P457Aw/4bTVPptVdV2BwSq/JHweN4+iYBukfoCWnlvuC4Z5NybVEtg==
X-Received: by 2002:a05:600c:384b:b0:37b:fda9:a5e2 with SMTP id s11-20020a05600c384b00b0037bfda9a5e2mr3051329wmr.62.1645040300881;
        Wed, 16 Feb 2022 11:38:20 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:6165:d98a:b553:c3c1? ([2a01:e34:ed2f:f020:6165:d98a:b553:c3c1])
        by smtp.googlemail.com with ESMTPSA id l9sm18850870wrt.29.2022.02.16.11.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 11:38:20 -0800 (PST)
Message-ID: <c5889d73-7acb-a564-b091-44e71ba5ddb3@linaro.org>
Date:   Wed, 16 Feb 2022 20:38:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 1/4] tools/lib/thermal: Add a thermal library
Content-Language: en-US
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20220214210446.255780-1-daniel.lezcano@linaro.org>
 <0be77e01c0dc91e227fcb7219cf89d9497b4be39.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <0be77e01c0dc91e227fcb7219cf89d9497b4be39.camel@linux.intel.com>
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

thanks for the review

On 16/02/2022 17:40, srinivas pandruvada wrote:
> On Mon, 2022-02-14 at 22:04 +0100, Daniel Lezcano wrote:
>> The thermal framework implements a netlink notification mechanism to
>> be used by the userspace to have a thermal configuration discovery,
>> trip point changes or violation, cooling device changes
>> notifications,
>> etc...
>>
>> This library provides a level of abstraction for the thermal netlink
>> notification allowing the userspace to connect to the notification
>> mechanism more easily. The library is callback oriented.
>>
> Some minor comments.
> May be better use some defines instead of returning "-1" for error
> conditions.

Do you suggest like an enum with different errors or just having -1 
replaced by eg. THERMAL_ERROR ?


[ ... ]

>> + * Low level netlink
>> + */
>> +extern int nl_subscribe_thermal(struct nl_sock *nl_sock, struct
>> nl_cb *nl_cb,
>> +                               const char *group);
>> +
> To complete API, don't we need nl_unsubscribe which calls
> nl_socket_drop_memberships()?
Ah, yes. I'll add it.

Thanks



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
