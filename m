Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F092F561B47
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 15:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbiF3N11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbiF3N1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:27:25 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEAE33E9A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:27:24 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id t17-20020a1c7711000000b003a0434b0af7so1691266wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3uL7S2W5wN/+jflQoV3bAbJ3bLJFCX03amVujxIJvq8=;
        b=Sf992KZuXqlhIEbSl5nytEW8JG+Gggb/JBkLjKDkc7HEXX3mVbyfncyj6CD1e98zM9
         0qM9OWjWT98QLgm1X9PbtzVnhLUril+7ZvbD4aVXzDjRhqFO2I+1G6JTrZm185BbEDju
         /LN5+Y2pNqNXMOcqVceMhZQ0g7iHwjbwm4ovi3D0i5eQMvi1SLqBIYST0+XmXknh7XgX
         mVEht5mx0PhKef/JNl+C9P5l963AeTY3fV2QRNspiyCewDXbJvWqVFDJm6wUPxsVVCfi
         /lqZDM1LIQdmg8cpGHCV4PwWzE8dJZ6YH3uQfv82Y9hID4fDkWlDU8rpGr3i0q/VFGKU
         I5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3uL7S2W5wN/+jflQoV3bAbJ3bLJFCX03amVujxIJvq8=;
        b=wWUeydfQVVtcolJ3RyBnMmMfN0Q7uR2iJrVM9qR7gxkXPB2q/9rb263gabfL8x10qM
         sz7mDrTDw0XaVlK1f3ZDlCSbanZIrmazHfHid+rSTwCokT6ZM3CUrXX/7AZAzLhXp3lx
         R+sKBORmn/bOml+CiTGsQC2oHuVfjTD8GPeQi2EoqXnpp8mS3dpQy/r2X67aPYQOq/ar
         3h2UV/JFdmujoITBowNW9fDuDyaOeCCLP0/ZO1ypD+xEOiSQIpWsRF7xQ6wfGWxr8uER
         r4XswwYmOQkMipCl+BjcGozpz96xmzDuXm45/UzQGyAraH3Y4p8QjWyMNGtPudnliHtI
         wzsA==
X-Gm-Message-State: AJIora8U7fjQd71mxsbcjHzpnKLpjctcsUgKe9whXkxMNeHIxg/fHX2K
        IyCviFYbx0hUfLesvEjGcb4MNo/ZEmefXA==
X-Google-Smtp-Source: AGRyM1vSCfsiFnrzxnn7W5JSa663yVGfHgulBXFGfZ6n0K7cwsry5Z7ZfRhLnbIP8qtFYvXWSvgoIA==
X-Received: by 2002:a05:600c:3659:b0:3a0:3915:8700 with SMTP id y25-20020a05600c365900b003a039158700mr9687564wmq.127.1656595643117;
        Thu, 30 Jun 2022 06:27:23 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id h3-20020adfe983000000b0021b97ffa2a9sm20114787wrm.46.2022.06.30.06.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 06:27:22 -0700 (PDT)
Message-ID: <986d197e-f40c-8fd8-449f-3f62b8366e60@linaro.org>
Date:   Thu, 30 Jun 2022 15:27:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] thermal/drivers/u8500: Remove the get_trend function
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
References: <20220616202537.303655-1-daniel.lezcano@linaro.org>
 <20220616202537.303655-3-daniel.lezcano@linaro.org>
 <f4b13249-abe8-080f-4d36-24ef67d4fb62@linaro.org>
 <CACRpkdZBUVGP6whu-ojW9KKapeuYKQbXWn1MEpJ33KFav+8zqQ@mail.gmail.com>
 <0a6c992d-ea88-c3fe-1837-8be4e912d266@linaro.org>
 <CAKfTPtBVBDsy3oc1vaSSLwYcz6y2VdT4d-NZzt=QRW+eUMm9tA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAKfTPtBVBDsy3oc1vaSSLwYcz6y2VdT4d-NZzt=QRW+eUMm9tA@mail.gmail.com>
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


Hi Vincent,

On 30/06/2022 14:32, Vincent Guittot wrote:
> On Thu, 30 Jun 2022 at 12:16, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 28/06/2022 14:50, Linus Walleij wrote:
>>> On Tue, Jun 28, 2022 at 10:40 AM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>
>>>> Adding Linus who is missing in the recipient list.
>>>>
>>>>
>>>> On 16/06/2022 22:25, Daniel Lezcano wrote:
>>>>> The get_trend function relies on the interrupt to set the raising or
>>>>> dropping trend. However the interpolated temperature is already giving
>>>>> the temperature information to the thermal framework which is able to
>>>>> deduce the trend.
>>>>>
>>>>> Remove the trend code.
>>>>>
>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>
>>> I certainly trust you with this :)
>>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>>
>>> The code was originally written by Hongbo Zhang, but co-developed
>>> and tested by Vincent Guittot I think, so paging
>>> him as well.
>>
>> Ok, thanks
>>
>> If Vincent has no concern with this change, I'll queue up the series
> 
> I don't have any particular concerns. I'm just curious, are you
> planning to remove the get_trend completely from the thermal framework
> ?

Well, actually the get_trend() ops was added for ACPI and because the 
ops was there, some drivers provided their own implementation and it 
appears they are unnecessary. It is this pointless code I want to remove.

Only the get_trend() ops will remain for the ACPI. Hopefully we can 
remove the ops in the future.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
