Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833E24B152B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245675AbiBJSWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:22:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245664AbiBJSWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:22:51 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAF8234;
        Thu, 10 Feb 2022 10:22:52 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id o128-20020a4a4486000000b003181707ed40so7338363ooa.11;
        Thu, 10 Feb 2022 10:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rlpzDS4DMDM2qeg+Lx8XGgI5VF7EtkOZlnUhsr48EwQ=;
        b=NqWwLYWCH2MwNw09InnSWLwLFY2F67WXuQ1mGpuY7JtfWRi05/+52SlrG9GtI0s9NF
         J3RYjKI/DMVoQDIUjGXiUWgIXBRIj+wgpJocb+PYFZ7dPMzMgqu8DvPP9EmWdZqmKPSd
         0gTzAI9gK4JSQ18lDCJY6rMnQNi1kf5ijHJ/turHstoRrbGztnkFwAoxIiuqOvD4DFfd
         3h4sz4sVXPP+mPRsoWSu7NBKnFzTkShvptcj8QOWDGAOnYByQ+EyYGoYB69pPWXPqZCb
         fL0Xu/UhnYeYaBopiPyEBjv8Gvxs37JaYLW9fvSxSl4uCrvRza2wfoQrc5Tp+3yNKH9E
         lbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rlpzDS4DMDM2qeg+Lx8XGgI5VF7EtkOZlnUhsr48EwQ=;
        b=T2lOEHp7Fu8PWyKjM8+3zwk3jVGosYU1NLEISJg1jxSQPYRqUKR3U6DNpfbh9pNLZi
         3mkrIW/CCFjtOCZYtYrNdZawFcO14s1iUPr3pzPP026SRuwDTanKgMmBROHKeuF4Zh0+
         O77Mco86TOPdGQ4T/fwfU3ihO+xlTASDCbYqjrFvVWRpGbNbjZzZm+dWraIJL0+HOLZw
         fOTrbQyO1xnMX4rq6fnr8fBIajTrnptbREF/Jg8XJ8IlbM7KVaT4qgV+Hpk+WEDzpCwM
         WuZ28rf3/iXZ5A9AW+otSohjQVKXzAwg6V/+LW+kK25KlUh6SgHApoZG9uRyE7ld4BJc
         agww==
X-Gm-Message-State: AOAM5317UVdNAndJc4uiZkEzS0RK6vKgA5dzIildA/w3AL3CBF2GKj+9
        33Sf0SN5JhsX0AuxYgECwSs=
X-Google-Smtp-Source: ABdhPJzwwyD46JsCpBgNnpo4xZ4GgqNDixPi6NBohhlD4GOxHwaz/+pRIpK3k9DDFNdh0On3duEtSg==
X-Received: by 2002:a05:6870:e2c4:: with SMTP id w4mr1187906oad.122.1644517371377;
        Thu, 10 Feb 2022 10:22:51 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w20sm7893577otu.12.2022.02.10.10.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 10:22:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <56caa997-1f14-2253-72ec-1b0ed614f11a@roeck-us.net>
Date:   Thu, 10 Feb 2022 10:22:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: linux-next: build warning after merge of the hwmon-staging tree
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alistair Francis <alistair@alistair23.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220210185123.4d39766c@canb.auug.org.au>
 <YgTRu7iLgJMymeT5@google.com>
 <af550a8a-9fd8-9292-4179-4d7b74fdacfc@roeck-us.net>
 <YgVUawb2IFoiuqU/@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YgVUawb2IFoiuqU/@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/22 10:07, Lee Jones wrote:
> On Thu, 10 Feb 2022, Guenter Roeck wrote:
> 
>> Hi Lee,
>>
>> On 2/10/22 00:50, Lee Jones wrote:
>>> On Thu, 10 Feb 2022, Stephen Rothwell wrote:
>>>
>>>> Hi all,
>>>>
>>>> After merging the hwmon-staging tree, today's linux-next build (htmldocs)
>>>> produced this warning:
>>>>
>>>> Documentation/hwmon/sy7636a-hwmon.rst:4: WARNING: Title underline too short.
>>>>
>>>> Kernel driver sy7636a-hwmon
>>>> =========================
>>>>
>>>> Introduced by commit
>>>>
>>>>     de34a4053250 ("hwmon: sy7636a: Add temperature driver for sy7636a")
>>>
>>> Oh wow, that's new (to me), and a little petty, no?
>>>
>>> Would you like me to apply this patch to my branch Guenter?
>>>
>>
>> It would be great if you can do that since you already wrote it.
>>
>>> I can either send out a new PR, or let it wallow.
>>>
>> Wallow is fine with me; that can go in through your branch.
>>
>> Actually, I wonder if I should just drop your immutable branch from
>> my tree and let it go in through your tree. The hwmon patch has my Acked-by:
>> already, and there are no further dependencies, so it isn't really necessary
>> for both of us to carry it. What do you think ?
> 
> That's your call to make. :)
> 
> The patch is going in, either way.
> 

Sounds good. I'll drop it.

Thanks,
Guenter

