Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90224BA206
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241376AbiBQNyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:54:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbiBQNyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:54:43 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0AC25B6F8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:54:28 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d27so9190785wrb.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uP+5oPN8/mDtxgUqziR9/1MjwO5GUIP5L5fmLtRSQ4o=;
        b=Gcj1RiexcX8pUewnBho0N4a5ikx5JpddYFJh/Bi7rzju0Nh+ToYVE9x+P17o+LoQXL
         3Tpvz1vnUBW0DU8omi+RP+m71x7Sta40Sa+agTzw+p6fpddcGExB8Ustrg83kKsn2RpL
         YKudY2jUz48NWW6O3/ng0bHOu44NjZMo+7YD65Zx2qLdFuusJLFbKsJ+MFC1NTCGRzdY
         U9iUweK1hcvaUQpS/QCOlE4wA1XplfAQOlqMiAboJgTdiZZXJIah8zHl+IW7Yl6Cfpu/
         VAjVIy2QWXyk9ZxI3wL5lupEtGZs8WhToWXJqTcts6HkCw/jrO37ukHVJc2CBGR7Qnea
         8gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uP+5oPN8/mDtxgUqziR9/1MjwO5GUIP5L5fmLtRSQ4o=;
        b=djS+RIIJzZ7ly0ne9S98w/PknlpOCCkppbYuwpjyIcc3LIFktCd8O/nxgTeGhDYDy2
         vLWNhMNdz0GozZHZeWt5+p53MTr2fxqKoxc36YVntnmQBHWxSHh9u+rtC0NIESRBtIA8
         Ah7qD6DP24YwcebXHl9z4iOUJh1HWw15in9YCAAV3vOZOQrsL3QvtO+9kGHMbSvMElpO
         rlAtsFExZkDuZcogMCbYOEYIQDoruBMeBCYghO5Tk9NQhtRnLswNf3l2GwAQ8t3j02qr
         7gztkhhPhq4XrzLyZZpCKs8d4/P6D1ZSndW6g3kQAGDK3D9xrkB1bYfHXg/cV9d8nGaG
         eCUg==
X-Gm-Message-State: AOAM530gkDKQ8gVFN/jV6xJ9xvXsT+bfUT8uc67pzynmAh/JLLQMfxz/
        CyGWT+zr72AWpswAWgGtbjcbIREMQ6KqSA==
X-Google-Smtp-Source: ABdhPJxSXalGp5VQGQ0D+CtQiADoEFjMZVVV2hxy/Nx1jW0FS3VHq+Z8neuG36hpDyuS/OWK961NaA==
X-Received: by 2002:adf:f0c6:0:b0:1e7:13f7:74b9 with SMTP id x6-20020adff0c6000000b001e713f774b9mr2389857wro.361.1645106066837;
        Thu, 17 Feb 2022 05:54:26 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:6165:d98a:b553:c3c1? ([2a01:e34:ed2f:f020:6165:d98a:b553:c3c1])
        by smtp.googlemail.com with ESMTPSA id s7sm21864864wrw.71.2022.02.17.05.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 05:54:26 -0800 (PST)
Message-ID: <cfbaefa5-fc7b-bd0f-e4ed-8f046de2a7cf@linaro.org>
Date:   Thu, 17 Feb 2022 14:54:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 3/7] powercap/dtpm: Fixup kfree for virtual node
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     rjw@rjwysocki.net, heiko@sntech.de, lukasz.luba@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20220130210210.549877-1-daniel.lezcano@linaro.org>
 <20220130210210.549877-3-daniel.lezcano@linaro.org>
 <CAPDyKFqV++g63Asax8TNSEgujxJ=uM9XG2_Advu34JidYBCGtg@mail.gmail.com>
 <e44b9c4b-2ac4-4ea4-c771-bde13943af5f@linaro.org>
 <CAPDyKFr8Ycr2cbiD5MM9FSPc1qea+Yp9=cottcGAo7HmFR9Eaw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAPDyKFr8Ycr2cbiD5MM9FSPc1qea+Yp9=cottcGAo7HmFR9Eaw@mail.gmail.com>
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

On 17/02/2022 14:17, Ulf Hansson wrote:
> On Wed, 16 Feb 2022 at 19:10, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 16/02/2022 17:22, Ulf Hansson wrote:
>>> On Sun, 30 Jan 2022 at 22:02, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> When the node is virtual there is no release function associated which
>>>> can free the memory.
>>>>
>>>> Free the memory when no 'ops' exists.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> ---
>>>>    drivers/powercap/dtpm.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
>>>> index 0b0121c37a1b..7bddd25a6767 100644
>>>> --- a/drivers/powercap/dtpm.c
>>>> +++ b/drivers/powercap/dtpm.c
>>>> @@ -181,12 +181,12 @@ int dtpm_release_zone(struct powercap_zone *pcz)
>>>>
>>>>           if (dtpm->ops)
>>>>                   dtpm->ops->release(dtpm);
>>>> +       else
>>>> +               kfree(dtpm);
>>>>
>>>
>>> This doesn't look correct. Below you check dtpm against "root", which
>>> may be after its memory has been freed.
>>>
>>> If the ->release() function should be responsible for freeing the
>>> dtpm, it needs to be called after the check below.
>>
>> It is harmless, 'root' is not dereferenced but used as an ID
>>
>> Moreover, in the patch 5/7 it is moved out this function.
> 
> Right. It just looks a bit odd here.
> 
>>
>>
>>>>           if (root == dtpm)
>>>>                   root = NULL;
>>>>
>>>> -       kfree(dtpm);
> 
> So then why doesn't this kfree do the job already?
> 
> kfree(NULL) works fine, if dtpm->ops->release(dtpm) already freed the data.

The description is confusing.

Actually, there is a double kfree. When there is a ops->release, the 
kfree is done there and again a few lines after.

The issue was introduced with the change where dtpm had a private data 
field to store the backend specific structure and was converted to a 
backend specific structure containing a dtpm node [1].

So this function was calling release from the dtpm backend which was 
freeing the specific data in the dtpm->private and then here was freeing 
the dtpm. Now, the backend frees the structure which contains the dtpm 
structure, so when returning from ops->release(), dtpm is already free.

I should change the description and add a Fixes tag to the change 
described above.

[1] 
https://lore.kernel.org/r/20210312130411.29833-4-daniel.lezcano@linaro.org



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
