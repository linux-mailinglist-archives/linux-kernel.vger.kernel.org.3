Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6014E4FB5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243323AbiCWJsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239488AbiCWJsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:48:37 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BC810FDD;
        Wed, 23 Mar 2022 02:47:07 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id z92so1104719ede.13;
        Wed, 23 Mar 2022 02:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=KHm72o5Y4MjVl7rRhvPVahUTvwKrMwJLAH7A+mLGnhw=;
        b=wa50lWNVFGL+Lek+Iu//NdwQiOcMLZmvNNMIKk2wR2bRl2t10UjFETTzYn73iWLahv
         aXJ3UnXOMJRO0LBOMrOxpNOMDQlBkeEGx8Jm78hfXAPjBbKZJ8evBiW7W8NyVmm1eMR7
         7GhKLl4zoC3TdTyKZWkUdB2Y7EwoqTxcURWSMKKrtFJp8wvzcF/bFyoZzRXmrhFQWT58
         KDr4W8R76Pyzl+Ut7AWK+Dq5kMhA/WKHD42dtmGRZKEnNd2ICVP2u3B+DD4h9n0K12Cw
         Cc/CRp1VcdSyFE9P6cqiJMMqUIginxE1J1HhX0gbDEy7LIbNKsfUv1HpImqn2/Wr045O
         LDPA==
X-Gm-Message-State: AOAM531tSNHmYRBBMtDPwEKRWwDqzK9QcebPNA7f0859pmCNMdKe2YAb
        0j7MTpx6mJrXkt/dFIvhQTz1sVarqT4=
X-Google-Smtp-Source: ABdhPJy7Te9mb6SAVMrVpJ0UoTWaTwu2FW1kGcfE7g15tD/BYULe2tkh14yK8RQhDHew1/1SerTqBA==
X-Received: by 2002:aa7:c683:0:b0:418:f5f3:9684 with SMTP id n3-20020aa7c683000000b00418f5f39684mr33731202edq.184.1648028826179;
        Wed, 23 Mar 2022 02:47:06 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id q15-20020a1709060e4f00b006cdf4535cf2sm9473886eji.67.2022.03.23.02.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 02:47:05 -0700 (PDT)
Message-ID: <e6d014ca-4568-20f2-0254-e8fe51f30e5d@kernel.org>
Date:   Wed, 23 Mar 2022 10:47:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/4] power: supply: max17042_battery: use ModelCfg refresh
 on max17055
Content-Language: en-US
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Hans de Goede <hdegoede@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     Purism Kernel Team <kernel@puri.sm>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220318001048.20922-1-sebastian.krzyszkowiak@puri.sm>
 <7080597.aeNJFYEL58@pliszka>
 <5d43031e-382d-b12c-bba2-0e630fbec1ad@kernel.org>
 <2957015.e9J7NaK4W3@pliszka>
In-Reply-To: <2957015.e9J7NaK4W3@pliszka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2022 21:44, Sebastian Krzyszkowiak wrote:
> On niedziela, 20 marca 2022 13:18:49 CET Krzysztof Kozlowski wrote:
>> On 18/03/2022 20:58, Sebastian Krzyszkowiak wrote:
>>> On piątek, 18 marca 2022 09:22:16 CET Krzysztof Kozlowski wrote:
>>>> On 18/03/2022 01:10, Sebastian Krzyszkowiak wrote:
>>>>> Unlike other models, max17055 doesn't require cell characterization
>>>>> data and operates on smaller amount of input variables (DesignCap,
>>>>> VEmpty, IChgTerm and ModelCfg). Input data can already be filled in
>>>>> by max17042_override_por_values, however model refresh bit has to be
>>>>> set after adjusting input variables in order to make them apply.
>>>>>
>>>>> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
>>>>> ---
>>>>>
>>>>>  drivers/power/supply/max17042_battery.c | 73 +++++++++++++++----------
>>>>>  include/linux/power/max17042_battery.h  |  3 +
>>>>>  2 files changed, 48 insertions(+), 28 deletions(-)
>>>>>
>>>>> diff --git a/drivers/power/supply/max17042_battery.c
>>>>> b/drivers/power/supply/max17042_battery.c index
>>>>> c019d6c52363..c39250349a1d 100644
>>>>> --- a/drivers/power/supply/max17042_battery.c
>>>>> +++ b/drivers/power/supply/max17042_battery.c
>>>>> @@ -806,6 +806,13 @@ static inline void
>>>>> max17042_override_por_values(struct max17042_chip *chip)>
>>>>>
>>>>>  	    (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055)) {
>>>>>  		
>>>>>  		max17042_override_por(map, MAX17047_V_empty, config-
>>>>
>>>> vempty);
>>>>
>>>>>  	}
>>>>>
>>>>> +
>>>>> +	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055) {
>>>>> +		max17042_override_por(map, MAX17055_ModelCfg, config-
>>>>
>>>> model_cfg);
>>>>
>>>>> +		// VChg is 1 by default, so allow it to be set to 0
>>>>
>>>> Consistent comment, so /* */
>>>>
>>>> I actually do not understand fully the comment and the code. You write
>>>> entire model_cfg to MAX17055_ModelCfg and then immediately do it again,
>>>> but with smaller mask. Why?
>>>
>>> That's because VChg is 1 on POR, and max17042_override_por doesn't do
>>> anything when value equals 0 - which means that if the whole
>>> config->model_cfg is 0, VChg won't get unset (which is needed for 4.2V
>>> batteries).
>>>
>>> This could actually be replaced with a single regmap_write.
>>
>> I got it now. But if config->model_cfg is 0, should VChg be unset?
> 
> That's a good question.
> 
> max17042_override_por doesn't override the register value when the given value 
> equals zero in order to not override POR defaults with unset platform data. 
> This way one can set only the registers that they want to change in `config` 
> and the rest are untouched. This, however, only works if we assume that zero 
> means "don't touch", which isn't the case for ModelCfg.
> 
> On the Librem 5, we need to unset VChg bit because our battery is only being 
> charged up to 4.2V. Allowing to unset this bit only without having to touch 
> the rest of the register was the motivation behind the current version of this 
> patch, however, thinking about it now I can see that it fails to do that in 
> the opposite case - when the DT contains a simple-battery with maximum voltage 
> higher than 4.25V, VChg will be set in config->model_cfg causing the whole 
> register to be overwritten.

This is actually nice description which could be put into a comment there.

> 
> So, I see two possible solutions:
> 
> 1) move VChg handling to a separate variable in struct max17042_config_data. 
> This way model_cfg can stay zero when there's no need to touch the rest of the 
> register. This minimizes changes over current code.
> 
> 2) remove max17042_override_por_values in its current shape altogether and 
> make it only deal with the values that are actually being set by the driver 
> (and only extend it in the future as it gains more ability). Currently most of 
> this function is only usable with platform data - is there actually any user 
> of max17042 that would need to configure the gauge without DT in the mainline 
> kernel? My quick search didn't find any. Do we need or want to keep platform 
> data support at all?
> 
> I'm leaning towards option 2, as it seems to me that currently this driver is 
> being cluttered quite a lot by what's essentially a dead code. Adding new 
> parameters to read from DT for POR initialization (which is necessary for 
> other models than MAX17055) should be rather easy, but trying to fit them into 
> current platform_data-oriented code may be not.

I am in for removal of platform data.

Best regards,
Krzysztof
