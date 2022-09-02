Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAD85AAB4C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbiIBJZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbiIBJZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:25:31 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB6440E37
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:25:26 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t5so1515813pjs.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 02:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=1bTDW9HnOkiIYV5uJ57r2XB6ZhefyzNRvfE7YurBQEo=;
        b=AxLhRfI9R75qPsG2gU38kDjJE6+gQI1IxuS5UvbEKVwR+RpHAuLOPy2k25fSJN/2zl
         c0kZopziRkgXAFT1PmJagrGzop2dWOJJlE8lMM4O44fFYQBtRoJwEe4DkBK5N9xWNga0
         jCVHtUcWGs6Z+BsXFc6+qSDpwE+mfyte1Ab4NU4XKdFIrOZV/KUu+EYsb/Jji7RnBZLD
         iFCwq3+Txw/mM+Q9HXabRCEeodOo6PCF91749PkivG+Gv+KTELhJm1zm5XMRe3N65o8A
         T8RCNI0s1JP4mm8MvfsdFRtFQq09f+TTiI49Zd0eB+ZXLprw5jvqyv8wHPwJs9odb4c3
         jaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1bTDW9HnOkiIYV5uJ57r2XB6ZhefyzNRvfE7YurBQEo=;
        b=J4uGHYFYBJpztpHdThVHuXuHCD6Tn9aylM3PLJw8XbbROGbb9R5vOajIvDshD3S5Jo
         hdmN9YWO0ga/RPibkZk3zzMJdhTKyu61aoHaWjhkjXAeUIemh9INWNRTbWubhBrydv44
         Lgg6h8jEmEYvINlwjfYGDJlZtUhQBB/1V7OXX8OXw+jwEZP6wj0NZYwtNMYmze1HhBwB
         UPvzRJu2fUBYrS8zr4Ft2Mh2VXolNMYhMM3q/tNmYYKOF5rNwjVk4n1vzZyK1iHmoAHT
         EzwlNbZeaBzPRVOaH3X++u4cpx2IO/VGLUSjkQTdykwqcDT4jD43nvVlgRsP3zBFaCij
         +rJw==
X-Gm-Message-State: ACgBeo1+z8H8oJXPmafZsZQ4bC278jxmxQj/FXLUOB8IWAx+f+mqwu/m
        FFx1PZNBZPEm4mNA80WeWcajkw==
X-Google-Smtp-Source: AA6agR703vVUNiUJs+wEbCRE7Q3PqGL/0ksxZ5aMw4iWUxLstSZPLNkWHqA8WmHx+gBlSutsukvN4A==
X-Received: by 2002:a17:902:e751:b0:174:89f8:cef2 with SMTP id p17-20020a170902e75100b0017489f8cef2mr26838879plf.156.1662110725762;
        Fri, 02 Sep 2022 02:25:25 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c60:5362:9d7f:2354:1d0a:78e3? ([2401:4900:1c60:5362:9d7f:2354:1d0a:78e3])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902f54f00b001728ac8af94sm1110860plf.248.2022.09.02.02.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 02:25:25 -0700 (PDT)
Message-ID: <58ab7d34-71af-f69c-1961-fd484cb477ac@linaro.org>
Date:   Fri, 2 Sep 2022 14:55:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] dt-bindings: leds: Describe optional 'reg' property used
 for Qualcomm LPG nodes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        robh@kernel.org, pavel@ucw.cz, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20220721195502.1525214-1-bhupesh.sharma@linaro.org>
 <CAA8EJppGS38aP7gyd1c3kNgraAVJDoqUef2cDfZpu2aL_iwW0g@mail.gmail.com>
 <YvFZgr1RRq6tYaVC@ripper> <a35dc076-e33f-1b31-2a01-27bb37301039@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <a35dc076-e33f-1b31-2a01-27bb37301039@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/22 12:21 PM, Krzysztof Kozlowski wrote:
> On 08/08/2022 21:44, Bjorn Andersson wrote:
>> On Thu 21 Jul 13:19 PDT 2022, Dmitry Baryshkov wrote:
>>
>>> On Thu, 21 Jul 2022 at 22:55, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
>>>>
>>>> As Bjorn noted in [1], it is useful to describe the optional
>>>> 'reg' property for Qualcomm LPG nodes as it is used in
>>>> some Qualcomm dts files.
>>>
>>> I don't think this is correct. LPG block maps to several regions, so
>>> using just one of them in reg doesn't look correct.
>>>
>>
>> I agree, but I also like the uniformity of having unit addresses for the
>> devices on the spmi buses.
> 
> regulators also do not have reg, so I guess consistency is already gone.
> 
> I vote here to reflect the real hardware/device which means:
> 1. IIUC, the design of entire SPMI bindings and its implementation is
> around parent device sitting on SPMI bus and children using its
> regmap/io space.
> 2. The children are not really re-usable for different cases/devices
> (e.g. standalone WLED or LPG, outside of PMIC).
> 3. This means entire design is tightly coupled and LPG (or wled,
> regulators) bindings describe the piece of PMIC, thus I find appropriate
> skipping "reg".
> 4. If we want to keep the "reg", then it should rather reflect reality,
> so if Dmitry said - multiple items for separate IO address ranges.

Ok, so I think the majority opinion is to skip 'reg' from the 
devicetree-binding. Lets stick to that.

>>
>>>> This fixes the following 'make dtbs_check' error reported for
>>>> pm8350c & sc8280xp pwm nodes:
>>>>
>>>> arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb:
>>>>   pwm@e800: 'reg' does not match any of the regexes:
>>>>   '^led@[0-9a-f]$', 'pinctrl-[0-9]+'
>>>
>>> I'd prefer to follow the existing schema and to drop the region from
>>> those files.
>>>
>>
>> I'm fine either way, but we have more of these nodes, so I would like to
>> hear from the DT maintainers on the direction to take. All nodes on the
>> spmi bus has an (at least one) address, so it would be accurate to state
>> this in the node.
>>
>> It does however not seem like devicetree@, nor Krzysztof is Cc'ed on
>> this patch, so I've added them...
>>
> 
> Anyway this patch has to be resent to properly reach DT patchwork.
> 
> Bhupesh,
> 
> Please use scripts/get_maintainer.pl to Cc relevant folks and mailing
> lists. While resending, add appropriate device prefix to subject, so:
> dt-bindings: leds: qcom-lpg:

Sure, will send v2 accordingly.

Thanks.
