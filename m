Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA9151E7C1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 16:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352279AbiEGOZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 10:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiEGOZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 10:25:51 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A695041F91;
        Sat,  7 May 2022 07:22:04 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id qe3-20020a17090b4f8300b001dc24e4da73so9323275pjb.1;
        Sat, 07 May 2022 07:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=+bDRRJsf3sxhL7K6Xwk8ODyk2HCXEePcVNx/7zFAdus=;
        b=H4FWj5WmxUs89S2kegyV8I5mA3vlMjbj0ynPj/sKgKb3juR3lI1kLZawQK+7nacdCm
         IusXPg0GJxGlwfAC7sdpx6R2ifl6cdycNKIaZA6GhZ/vK1VFfxSq9ZnBZKmAeIHNEvEe
         erNDOYKVvR/jKAQjZQCAxGMfQdf6oPfz8wAvZnbC/zAVw4XiG/sJNWzJgVdP8LH8+gmJ
         afa4ctpuajrkC6673XAcCAWsAV4Ixp+Satx1xZ6XARVsjZxt3HhS9gRyY8cKuoF+wj13
         +MQIjwjPxNBIdQ52i22csiGo6K/GCQ9ETIqM6m/Od0FCC52Q+4h5zOiI3YaVAKBUWEsO
         QEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=+bDRRJsf3sxhL7K6Xwk8ODyk2HCXEePcVNx/7zFAdus=;
        b=nua3OLVLe4WcRFm4WDKmubaIlwUn7SxiFAGdBMehGZ5fzdyvcnO6eeRXDehCCorTUX
         JfnYnBo2IeysusZu3HUHPWfRR2UbDmy3klacwdgpu/ZbscXUFS3pbuRNyVtHlpoGzUDe
         ETaf97+5zQdTIeGIzQclGLXLFSTxF/Dos8rZogvDU7d7DtU+SG4TBJZGidhwAUqHNw9o
         E1H+2wro76YpEAuLUURQpeCEmsFqo0hU91BakDO1CsDALUgAtuN0BqYyHl5uFMxMqf8w
         8c2TkHlf6IDNegJkI58nE7ucroihPuZAm1lDkvheb5Qethm/K0mf5Hdo34K/24oy8goS
         ddiQ==
X-Gm-Message-State: AOAM531a0JKdsFVi94CRd4dWGyUzuwksxHDzmwaXgS3bcM58b8OTNOby
        xeinwnxozitLcpR3iYKbwD0=
X-Google-Smtp-Source: ABdhPJyBwx+QyUvBHxmo3pa4xzm9Iu0rW7rJ2VjQ8ClzzGA78qBTPiOFAThBM3zN/4KOx377t/k7jw==
X-Received: by 2002:a17:90b:1651:b0:1dc:aec3:c17 with SMTP id il17-20020a17090b165100b001dcaec30c17mr9645489pjb.43.1651933324129;
        Sat, 07 May 2022 07:22:04 -0700 (PDT)
Received: from [172.30.1.41] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id l186-20020a6391c3000000b003c14af505f8sm5212086pge.16.2022.05.07.07.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 07:22:03 -0700 (PDT)
Message-ID: <6c6ec0db-111c-e48f-57ce-0e444a0d168e@gmail.com>
Date:   Sat, 7 May 2022 23:21:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH 2/2] PM / devfreq: rk3399_dmc: Block PMU during
 transitions
Content-Language: en-US
From:   Chanwoo Choi <cwchoi00@gmail.com>
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
 <582e3645-b24e-356e-7f0f-0d37bb1e32e6@gmail.com>
In-Reply-To: <582e3645-b24e-356e-7f0f-0d37bb1e32e6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 4. 14. 08:13, Chanwoo Choi wrote:
> On 22. 4. 14. 07:45, Heiko Stübner wrote:
>> Hi,
>>
>> Am Donnerstag, 14. April 2022, 00:14:40 CEST schrieb Chanwoo Choi:
>>> On 22. 4. 6. 10:48, Brian Norris wrote:
>>>> See the previous patch ("soc: rockchip: power-domain: Manage resource
>>>> conflicts with firmware") for a thorough explanation of the conflicts.
>>>> While ARM Trusted Firmware may be modifying memory controller and
>>>> power-domain states, we need to block the kernel's power-domain driver.
>>>>
>>>> If the power-domain driver is disabled, there is no resource conflict
>>>> and this becomes a no-op.
>>>>
>>>> Signed-off-by: Brian Norris <briannorris@chromium.org>
>>>> ---
>>>>
>>>>    drivers/devfreq/rk3399_dmc.c | 13 +++++++++++++
>>>>    1 file changed, 13 insertions(+)
>>>>
>>>> diff --git a/drivers/devfreq/rk3399_dmc.c 
>>>> b/drivers/devfreq/rk3399_dmc.c
>>>> index e494d1497d60..daff40702615 100644
>>>> --- a/drivers/devfreq/rk3399_dmc.c
>>>> +++ b/drivers/devfreq/rk3399_dmc.c
>>>> @@ -21,6 +21,7 @@
>>>>    #include <linux/rwsem.h>
>>>>    #include <linux/suspend.h>
>>>> +#include <soc/rockchip/pm_domains.h>
>>>>    #include <soc/rockchip/rk3399_grf.h>
>>>>    #include <soc/rockchip/rockchip_sip.h>
>>>> @@ -93,6 +94,16 @@ static int rk3399_dmcfreq_target(struct device 
>>>> *dev, unsigned long *freq,
>>>>        mutex_lock(&dmcfreq->lock);
>>>> +    /*
>>>> +     * Ensure power-domain transitions don't interfere with ARM 
>>>> Trusted
>>>> +     * Firmware power-domain idling.
>>>> +     */
>>>> +    err = rockchip_pmu_block();
>>>> +    if (err) {
>>>> +        dev_err(dev, "Failed to block PMU: %d\n", err);
>>>> +        goto out_unlock;
>>>> +    }
>>>> +
>>>>        /*
>>>>         * Some idle parameters may be based on the DDR controller 
>>>> clock, which
>>>>         * is half of the DDR frequency.
>>>> @@ -198,6 +209,8 @@ static int rk3399_dmcfreq_target(struct device 
>>>> *dev, unsigned long *freq,
>>>>        dmcfreq->volt = target_volt;
>>>>    out:
>>>> +    rockchip_pmu_unblock();
>>>> +out_unlock:
>>>>        mutex_unlock(&dmcfreq->lock);
>>>>        return err;
>>>>    }
>>>
>>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>>
>> so I guess you're ok with me picking up both patches, right?
>> [Just making sure :-) ]
> 
> This patch have the dependency of latest devfreq-next branch.
> So that need to make the immutable branch between rockchip and devfreq.
> 

Hi Heiko and Brian,

Is there any other progress?

IMHO, if rockchip maintainer reply the acked-by from patch1
and then agree these patches to be applied to devfreq.git,
I can take them.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
