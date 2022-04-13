Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B861F50025C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238856AbiDMXQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbiDMXP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:15:59 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2E61FCDA;
        Wed, 13 Apr 2022 16:13:37 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id h15-20020a17090a054f00b001cb7cd2b11dso3911470pjf.5;
        Wed, 13 Apr 2022 16:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kWx4kuwqUqPCRq2vnSKBnzzGe5+yrJ0mzhBM9ESQvds=;
        b=qeL5sRdil4P1oO5GVdWOovYd5WwhZ+goHVTepE0Eqx/2H3qtJzKKTZme7lHRmfMW/Q
         UusYhPDToq1dlNCFX8A9sW01Msnfd9JI0Axlv/rpnJwGFbql8jlkG16n20SNYZibbMmf
         KblnmUVPv9/hZYcIvZBX2Z9i1qihzmpRwSXFAz+/HYaDnQTssahfnqAqfZ7q9GNCl8uE
         /EN8TPoSBiExnWrCOEz5J8JbqGQelRQfGt5SnbEq2M2taNxqnPYkpRdofeyX8rLhcjVM
         zfXPq+yombU5+XcGUgb+sfqT+BrjpdfEcVqtoNIzR4RpcpOEfvNYqwUQonWNnZF3Ze3t
         6ZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kWx4kuwqUqPCRq2vnSKBnzzGe5+yrJ0mzhBM9ESQvds=;
        b=sYzQM8V7Gzcazer1zNO+d6RDlbj34cngzSmJsnHk1CP/CkeWRswA2ftVhY1YAPnmO7
         k5lw8XFxbxQgaFd7v31F5f9Q0Y/3dMTuKFK5nH3YRuaT7jzNPpL4cxGZFngiS64Q4e+B
         32FcgxZLuPvaVMhHf2tmexN52EHeM+JuBSqJIYcbPtzkZfA4GZ2JtoAqyJx2KFwsUvJ0
         VjqHzEXTxld0IGkXHxWsgGPYEG5zxF0ToV/s8oqSYTbh4nKmXrF7yBuyDXV0tmbP0lo1
         /KNKCWYcLKCIGs6rR6Pxyq6Kx7VS19IWeaq7bVyQO17KZZTd+UBaE9F2u1wYjgiFyK0j
         XrTA==
X-Gm-Message-State: AOAM5333XeQdbmJqahiFdYQX4fS7tiE9da9yCcgh2j05iJtWtlZ77WD1
        BohWTm5OAvlrK7w12mx/WNa8nRQGCeg=
X-Google-Smtp-Source: ABdhPJxzBPi73YEPEQiMGVA1+E5/vikRotNKxeILYirYP1w1ewhUibYQFMdWYGiJqtjeKoaKay7pEg==
X-Received: by 2002:a17:90b:4a41:b0:1c7:a0d7:718c with SMTP id lb1-20020a17090b4a4100b001c7a0d7718cmr1120180pjb.57.1649891617074;
        Wed, 13 Apr 2022 16:13:37 -0700 (PDT)
Received: from [172.30.1.44] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id e15-20020a63ae4f000000b003995a4ce0aasm166419pgp.22.2022.04.13.16.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 16:13:36 -0700 (PDT)
Message-ID: <582e3645-b24e-356e-7f0f-0d37bb1e32e6@gmail.com>
Date:   Thu, 14 Apr 2022 08:13:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 2/2] PM / devfreq: rk3399_dmc: Block PMU during
 transitions
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-kernel@vger.kernel.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        linux-pm@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20220406014842.2771799-1-briannorris@chromium.org>
 <20220405184816.RFC.2.I2d73b403944f0b8b5871a77585b73f31ccc62999@changeid>
 <8824147c-5512-a7a5-9e89-60b510111500@gmail.com> <3484357.R56niFO833@diego>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <3484357.R56niFO833@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 4. 14. 07:45, Heiko Stübner wrote:
> Hi,
> 
> Am Donnerstag, 14. April 2022, 00:14:40 CEST schrieb Chanwoo Choi:
>> On 22. 4. 6. 10:48, Brian Norris wrote:
>>> See the previous patch ("soc: rockchip: power-domain: Manage resource
>>> conflicts with firmware") for a thorough explanation of the conflicts.
>>> While ARM Trusted Firmware may be modifying memory controller and
>>> power-domain states, we need to block the kernel's power-domain driver.
>>>
>>> If the power-domain driver is disabled, there is no resource conflict
>>> and this becomes a no-op.
>>>
>>> Signed-off-by: Brian Norris <briannorris@chromium.org>
>>> ---
>>>
>>>    drivers/devfreq/rk3399_dmc.c | 13 +++++++++++++
>>>    1 file changed, 13 insertions(+)
>>>
>>> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
>>> index e494d1497d60..daff40702615 100644
>>> --- a/drivers/devfreq/rk3399_dmc.c
>>> +++ b/drivers/devfreq/rk3399_dmc.c
>>> @@ -21,6 +21,7 @@
>>>    #include <linux/rwsem.h>
>>>    #include <linux/suspend.h>
>>>    
>>> +#include <soc/rockchip/pm_domains.h>
>>>    #include <soc/rockchip/rk3399_grf.h>
>>>    #include <soc/rockchip/rockchip_sip.h>
>>>    
>>> @@ -93,6 +94,16 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
>>>    
>>>    	mutex_lock(&dmcfreq->lock);
>>>    
>>> +	/*
>>> +	 * Ensure power-domain transitions don't interfere with ARM Trusted
>>> +	 * Firmware power-domain idling.
>>> +	 */
>>> +	err = rockchip_pmu_block();
>>> +	if (err) {
>>> +		dev_err(dev, "Failed to block PMU: %d\n", err);
>>> +		goto out_unlock;
>>> +	}
>>> +
>>>    	/*
>>>    	 * Some idle parameters may be based on the DDR controller clock, which
>>>    	 * is half of the DDR frequency.
>>> @@ -198,6 +209,8 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
>>>    	dmcfreq->volt = target_volt;
>>>    
>>>    out:
>>> +	rockchip_pmu_unblock();
>>> +out_unlock:
>>>    	mutex_unlock(&dmcfreq->lock);
>>>    	return err;
>>>    }
>>
>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> so I guess you're ok with me picking up both patches, right?
> [Just making sure :-) ]

This patch have the dependency of latest devfreq-next branch.
So that need to make the immutable branch between rockchip and devfreq.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
