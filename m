Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3395A75BA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 07:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiHaFcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 01:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHaFb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 01:31:56 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F475B8F39;
        Tue, 30 Aug 2022 22:31:55 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id l65so3051868pfl.8;
        Tue, 30 Aug 2022 22:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc;
        bh=FRflWrMNawXJ/jnTbly8KS5+2Wtkwv/oBFXIxZOFzZg=;
        b=oORJZDG6V585Lyn/qoh6/dA4zcmifG4iTUvcrspGpZIYK4/LlXbaF8wmFm800VQKG8
         NkmcDtqegQbxZr0UMuFD5oYwFOn+DwP3ow67fkvfn0tyvYP/eVYRRunBAhg7tZiUbhmv
         2X/SzwIPJCx085OmOHt3m1mxIfRdgOwsXENYhjlISDrSBc2FQ2bAi4tEs97MwD+bBjCk
         maDNjOObq37aPkQo+TvAvzRfCfE0WEMiSdL8xtplM9ZUj3hltGu9e7UA+v7h2LXrEgk9
         5PzDeG1CDNwvMEMZmy1YVzQAQZXckV162wlrmHZpp/bS95AlOPG2+hjhDd6PSr/SSu43
         5+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc;
        bh=FRflWrMNawXJ/jnTbly8KS5+2Wtkwv/oBFXIxZOFzZg=;
        b=4+ZStVQ7c9czoKu9nOf8RUY40qwlrf6hPMJhGCArxyto/0sEgHInzhJWfOSZuOw7wN
         k6hy7ZniAZk7WY1QFvk52QNHRqgwMOVGERJeAch3XshrJa72GOXKkA1LRDD5Zy7vnxOI
         3oFKy5iZ2zMFO0DJGUCXzu/ooweBTqvqmvccqwEtWAIPZOUZZv5hjV8I2jqp1fUa29iY
         iVZrNFQ3x7HAsPYqZR9TTp9pU5hSMQBOjLhVEVANSymEy0F8r7M7MaOQzIqWCJkL+3Mo
         Tr4DGBdoHdxf5LoQzqG6TaSfHJJmr8TRLTWvmNEgURxG04w27rsuW1kkbe3/wKpeXoqi
         POyg==
X-Gm-Message-State: ACgBeo0t9wuvD3TEq3/j33Y9aR023VNpCFC7PoxPoCWlqxsOPr8ZnoYg
        6fyhG3r48brSJY3EaDoJFY0fOUYgYv6aEQ==
X-Google-Smtp-Source: AA6agR4oqNAHT3skkLL8z4S5vrHUtKq51DYfmou39MytoGaxfia8DIn1ix+HbFn57EpuwS/7wmtwog==
X-Received: by 2002:a05:6a00:2188:b0:538:46a8:7049 with SMTP id h8-20020a056a00218800b0053846a87049mr12111534pfi.10.1661923914636;
        Tue, 30 Aug 2022 22:31:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 199-20020a6300d0000000b00419ab8f8d2csm2529674pga.20.2022.08.30.22.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 22:31:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <119e0cec-7fe0-4516-f419-22bf1b62058b@roeck-us.net>
Date:   Tue, 30 Aug 2022 22:31:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     "Farber, Eliav" <farbere@amazon.com>, jdelvare@suse.com,
        robh+dt@kernel.org, p.zabel@pengutronix.de, rtanwar@maxlinear.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     talel@amazon.com, hhhawa@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, ronenk@amazon.com, itamark@amazon.com,
        shellykz@amazon.com, shorer@amazon.com, amitlavi@amazon.com,
        almogbs@amazon.com, dkl@amazon.com, andriy.shevchenko@intel.com
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-4-farbere@amazon.com>
 <3a059f0d-708a-91b9-16a0-722c8227d311@roeck-us.net>
 <6413740a-aeed-8696-b5bf-1d96df15d2cc@amazon.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 03/19] hwmon: (mr75203) update pvt->v_num to the actual
 number of used sensors
In-Reply-To: <6413740a-aeed-8696-b5bf-1d96df15d2cc@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/30/22 21:50, Farber, Eliav wrote:
> On 8/31/2022 5:41 AM, Guenter Roeck wrote:
>> On 8/30/22 12:21, Eliav Farber wrote:
>>> This issue is relevant when "intel,vm-map" is set in device-tree, and
>>> defines a lower number of VMs than actually supported.
>>>
>>> This change is needed for all places that use pvt->v_num later on in the
>>> code.
>>>
>>> Signed-off-by: Eliav Farber <farbere@amazon.com>
>>> ---
>>>   drivers/hwmon/mr75203.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
>>> index 0e29877a1a9c..f89f7bb5d698 100644
>>> --- a/drivers/hwmon/mr75203.c
>>> +++ b/drivers/hwmon/mr75203.c
>>> @@ -605,6 +605,7 @@ static int mr75203_probe(struct platform_device *pdev)
>>>                                       break;
>>>
>>>                       vm_num = i;
>>> +                     pvt->v_num = i;
>>
>> How about the existing assignment in the probe function ? 
> The probe function uses a local variable vm_num which is also updated
> (just one line earlier in code) in the previous patch.
> 

I meant
	pvt->v_num = vm_num;
at line 536 of the current code, but I guess the idea is to overwrite that.

Thanks,
Guenter

