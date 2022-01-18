Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C924926F6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 14:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242255AbiARNRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 08:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbiARNRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:17:41 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046EBC061574;
        Tue, 18 Jan 2022 05:17:41 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso4743657wms.4;
        Tue, 18 Jan 2022 05:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Q7VK09hbhq9EF54NXn3wG/WGVYjtOlKUjjiSI8lz1ck=;
        b=dGRXIOV4goUxOIaWV646IpZ8F1nDyXNUH/J3l5cyAa9AB5BDE96BztzhhahUYB3BIL
         jlGpO8yZnafBRe6gFpFy94a+OwASwyI9BOyMwuucVNHWjxgNjcUAC6FbVaveZwJJSuzl
         BTVqJDrDh9X8BaS/TqAd8SlAazmgFHpsbcpBeCDoOERQHqlETvSeDuttPLMzml0UyTTx
         7c3RRFEfSoj55Orxijj/drBvI/BqtV5USJrqhVSoLcTsl4zkYl8SH2bREz30Kgy6TM0+
         UfrpNLDnFm4YDLpJ3SGVpoF1ZWlrmmt5ny7kNpOmpHuD3Z62qKn2sJk2XX0Vlw0W7RE9
         QwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Q7VK09hbhq9EF54NXn3wG/WGVYjtOlKUjjiSI8lz1ck=;
        b=SBb/RRv+8WWyR17XhHc64icjWlbChOxjfRjwD15mbwALe2B4qK9+Ln9jNI+lODj2MP
         3uQTeVeN/TeU9DMPUgtzC2YX5F3gI+Jt5kddaT5/e2Yf9zK30V/pLYzDITum+PQFIFSQ
         fYFWTRrIS7ERFYtIqKuOtfQ+AFuctWardYwBWczBssKBw2H9yWbon95dJmqTz2uJ85LC
         4pPxOSC3PmNeITL3kvtgd1dC9yHj2xVaebIyQEHGSY+QxmzrfxwDS2EKAKPJMantk5C4
         rnvpeFGZiiFJbd5s0VUQqxASLsZ/XJbK4oulhZokvHOt8Orx/V5ItCsbl45IJWpO19qD
         sKPg==
X-Gm-Message-State: AOAM532FfGZZfGN/GqKEtFogIxe1GuJYmAKllWbVbqx1fFIQXbiHtZzY
        YylWRnkzmpgvxSIaGb6sXYY=
X-Google-Smtp-Source: ABdhPJw1UPBVre/JNKUC+L4E+4ziUHkUgPD9UeI112aZ+x3y/3f7KSt7xQVyvz+AmxisjpUlbcMjwg==
X-Received: by 2002:adf:ffc7:: with SMTP id x7mr23088441wrs.623.1642511859529;
        Tue, 18 Jan 2022 05:17:39 -0800 (PST)
Received: from [192.168.1.145] ([207.188.161.251])
        by smtp.gmail.com with ESMTPSA id c8sm2938627wmq.34.2022.01.18.05.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 05:17:38 -0800 (PST)
Message-ID: <f5486d12-b048-c062-e571-cf39da7e4c1b@gmail.com>
Date:   Tue, 18 Jan 2022 14:17:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/2] soc: mediatek: pwrap: add pwrap driver for MT8186
 SoC
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220107104633.7500-1-johnson.wang@mediatek.com>
 <20220107104633.7500-2-johnson.wang@mediatek.com>
 <9949a1f7-1ed5-a137-c7b9-2ef8d8e1caf8@gmail.com>
 <544f5085fc8597ce9ce3eb7dc1b5d08fb1ac8755.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <544f5085fc8597ce9ce3eb7dc1b5d08fb1ac8755.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/01/2022 10:25, Johnson Wang wrote:
> Hi Matthias,
> 
> On Fri, 2022-01-14 at 16:46 +0100, Matthias Brugger wrote:
>>
>> On 07/01/2022 11:46, Johnson Wang wrote:
>>> MT8186 are highly integrated SoC and use PMIC_MT6366 for
>>> power management. This patch adds pwrap master driver to
>>> access PMIC_MT6366.
>>>
>>
>> It seems this new arbiter is significantly different from the version
>> 1. Please
>> explain that in the commit message.
>>
>>> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
>>> ---
>>>    drivers/soc/mediatek/mtk-pmic-wrap.c | 72
>>> ++++++++++++++++++++++++++++
>>>    1 file changed, 72 insertions(+)
>>>
>>> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c
>>> b/drivers/soc/mediatek/mtk-pmic-wrap.c
>>> index 952bc554f443..78866ebf7f04 100644
>>> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
>>> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
>>> @@ -30,6 +30,7 @@
>>>    #define PWRAP_GET_WACS_REQ(x)		(((x) >> 19) &
>>> 0x00000001)
>>>    #define PWRAP_STATE_SYNC_IDLE0		BIT(20)
>>>    #define PWRAP_STATE_INIT_DONE0		BIT(21)
>>> +#define PWRAP_STATE_INIT_DONE0_V2	BIT(22)
>>
>> That's a strange name, does it come from the datasheet description?
> 
> Thanks for your review.
> 
> No, there is only PWRAP_STATE_INIT_DONE0 in MT8186 datasheet.
> However, it's the 22nd bit in MT8186 and the 21st bit in other SoCs.
> So we changed its name to avoid redefinition of PWRAP_STATE_INIT_DONE0.
> 
> Could you give us some suggestion on proper definition naming?
> Do you think PWRAP_STATE_INIT_DONE0_MT8186 will be a better choice?
> 

Is this a difference that only will show up on the PMIC-wrapper of MT8186 or 
will other SoCs include the same IP? If not, then PWRAP_STATE_INIT_DONE0_MT8186 
should be fine. Otherwise we would need a better name.

>>
>>>    #define PWRAP_STATE_INIT_DONE1		BIT(15)
>>>    
>>>    /* macro for WACS FSM */
>>> @@ -77,6 +78,8 @@
>>>    #define PWRAP_CAP_INT1_EN	BIT(3)
>>>    #define PWRAP_CAP_WDT_SRC1	BIT(4)
>>>    #define PWRAP_CAP_ARB		BIT(5)
>>> +#define PWRAP_CAP_MONITOR_V2	BIT(6)
>>
>> Not used capability, please delete.
>>
>>
>> Regards,
>> Matthias
> 
> PWRAP_CAP_MONITOR_V2 is not used right now.
> We can remove it in next version.
> But this capability will be added when we need it.
> 

That's OK, we should add capability definitions once they are added to the 
driver, not before that.

Thanks,
Matthias
