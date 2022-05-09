Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAACB51FF27
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbiEIOMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236927AbiEIOMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:12:16 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAFD227825
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 07:08:21 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k2so19619048wrd.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 07:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CN3/TIblunEmTfTGTQQLjlPKeiSgXjQJ0JkChiazJpI=;
        b=fjYKWuFAh2nxD9f1IzYEzZEyT5Y44vxrJFNg3JmmakmsiDJvkYXqaIewg0v8eB0EP5
         iFAdYV7t0QdxBhlxtHkmlH8852MdyAEiFRDyolFRoQNO7jPjctJkG6odoS6FCwQtOB4o
         LfykkBZJ/l27KcFVpyeg6FTe8e1BeOCThxd9a30eSZcqF9GhFAHP+ZKsKV7jqOYBwA38
         j717LSyDNerwm1FWO7seDdqmMPlAMusOldFOBKxw5zG1Dg7ICP8DEJ6WOkvKotzUyc4L
         biurZGHal+JDwRCZzA5dT30fumVytXFvd96gKmxivJh4Kq1Mxd0z2utdXpXTaoXktD+Z
         d82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CN3/TIblunEmTfTGTQQLjlPKeiSgXjQJ0JkChiazJpI=;
        b=RRU0vb5cjT5D4xY0yzYQ0dnSbjJRWEVKE44jGReVI/qRR8uPkzEUcU9kKZSccMH587
         lO13Rv/YGMQGNjgopnJYD0521VH9jBVZOEnlXkua5selzSd5NG7uzKWtcllyDiGlm4uF
         u1DXTrav9QR+PJ7Vj+qFUsQlqK/YIEeRHSjIZ2dOUjOi505ODPTPzYtA5e+oMVtgpz0j
         9+ZIR5HfxWIp+HbzTVAvdHYXK69HhXf9SrhiqRbUjLiXNobIdlaX9MeD/7kEiJfxuqDe
         +Qg3P041GnJB+tKSEOdCZV+W1jodc5bxrl9Mtj2N/oa7JuVjiQKS2/KNt+qz/JifoW9X
         qFXA==
X-Gm-Message-State: AOAM532UVEEdPOmX3UTqp3pJ4UiPRI8utOrSHz2HFx/QrLsyHb1O+co5
        TklRtkSwp0Inw//ykvhP6jrgKw==
X-Google-Smtp-Source: ABdhPJyrM1S7nbR0Cl1V0XFRvhXAm3F8I6t0KELsVJLnGWEV4yBOC6N5aFBvRrp6sKKjF6xyFF71Fg==
X-Received: by 2002:adf:de83:0:b0:20a:cbb5:903a with SMTP id w3-20020adfde83000000b0020acbb5903amr13753816wrl.544.1652105299332;
        Mon, 09 May 2022 07:08:19 -0700 (PDT)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id s6-20020adfea86000000b0020c5253d907sm11401610wrm.83.2022.05.09.07.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 07:08:18 -0700 (PDT)
Message-ID: <fd355232-c5e3-ba1b-801d-526ee6f04946@linaro.org>
Date:   Mon, 9 May 2022 15:08:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] soundwire: qcom: adjust autoenumeration timeout
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bard.liao@intel.com,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
References: <20220506084705.18525-1-srinivas.kandagatla@linaro.org>
 <725af523-d144-e373-e09b-fb48b3afb9ed@linux.intel.com>
 <8643d266-7108-2440-43e1-c51b829ba481@linaro.org>
 <d9646029-29b1-d71b-d1f5-b33267888e3c@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <d9646029-29b1-d71b-d1f5-b33267888e3c@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/05/2022 14:31, Pierre-Louis Bossart wrote:
> 
> 
> On 5/7/22 01:52, Srinivas Kandagatla wrote:
>> Thanks Pierre,
>>
>> On 06/05/2022 15:13, Pierre-Louis Bossart wrote:
>>>
>>>
>>> On 5/6/22 03:47, Srinivas Kandagatla wrote:
>>>> Currently timeout for autoenumeration during probe and bus reset is
>>>> set to
>>>> 2 secs which is really a big value. This can have an adverse effect on
>>>> boot time if the slave device is not ready/reset.
>>>> This was the case with wcd938x which was not reset yet but we spent 2
>>>> secs waiting in the soundwire controller probe. Reduce this time to
>>>> 1/10 of Hz which should be good enough time to finish autoenumeration
>>>> if any slaves are available on the bus.
>>>
>>> Humm, now that I think of it I am not sure what reducing the timeout
>>> does.
>>>
>>> It's clear that autoenumeration should be very fast, but if there is
>>> nothing to enumerate what would happen then? It seems that reducing the
>>> timeout value only forces an inconsistent configuration to be exposed
>>> earlier, but that would not result in a functional change where the
>>> missing device would magically appear, would it? Is this change mainly
>>> to make the tests fail faster? If the 'slave device is not ready/reset',
>>> is there a recovery mechanism to recheck later?
>>>
>>> Would you mind clarifying what happens after the timeout, and why the
>>> timeout would happen in the first place?
>>
>> This issue is mostly present/seen with WCD938x codec due to its Linux
>> device model.
>> WCD938x Codec has 3 Linux component drivers
>> 1. TX Component (A soundwire device connected to TX Soundwire Master)
>> 2. RX Component (A soundwire device connected to RX Soundwire Master)
>> 3. Master Component (Linux component framework master for (1) and  (2)
>> and registers ASoC codec)
>>
>> Also we have only one reset for (1) and (2).
>>
>> reset line is handled by (3)
>> There are two possibilities when the WCD938x reset can happen,
>>
>> 1. If reset happens earlier than probing (1) and (2) which is best case.
>>
>>
>> 2. if reset happens after (1) and (2) are probed then SoundWire TX and
>> RX master will have spend 2 + 2 secs waiting, Which is a long time out
>> Hence the patch.
>>
>> TBH, the 2 sec timeout value was just a random number which I added at
>> the start, we had to come up with some sensible value over the time
>> anyway for that.
>>
>> You could say why do we need wait itself in the first place.
>>
>> The reason we need wait in first place is because, there is a danger of
>> codec accessing registers even before enumeration is finished. Because
>> most of the ASoC codec registration happens as part of codec/component
>> driver probe function rather than status callback.
>>
>> I hope this answers your questions.
> 
> 
> Humm, not really.
> 
> First, you're using this TIMEOUT_MS value in 3 unrelated places, and
> using 2 different struct completion, which means there are side effects
> beyond autoenumeration.

2 of these 3 are autoenum ones, one is in probe path and other in bus 
reset path during pm.

The final one is broadcast timeout, new timeout value should be okay for 
that too, given that we need 10ms timeout.

> 
> qcom.c-         /*
> 
> qcom.c-          * sleep for 10ms for MSM soundwire variant to allow
> broadcast
> 
> qcom.c-          * command to complete.
> 
> qcom.c-          */
> 
> qcom.c-         ret = wait_for_completion_timeout(&swrm->broadcast,
> 
> qcom.c:                                   msecs_to_jiffies(TIMEOUT_MS));
> 
> --
> 
> qcom.c-         goto err_clk;
> 
> qcom.c- }
> 
> qcom.c-
> 
> qcom.c- qcom_swrm_init(ctrl);
> 
> qcom.c- wait_for_completion_timeout(&ctrl->enumeration,
> 
> qcom.c:                             msecs_to_jiffies(TIMEOUT_MS));
> 
> --
> 
> qcom.c-         if (!swrm_wait_for_frame_gen_enabled(ctrl))
> 
> qcom.c-                 dev_err(ctrl->dev, "link failed to connect\n");
> 
> qcom.c-
> 
> qcom.c-         /* wait for hw enumeration to complete */
> 
> qcom.c-         wait_for_completion_timeout(&ctrl->enumeration,
> 
> qcom.c:                                   msecs_to_jiffies(TIMEOUT_MS)); >
> 
> And then I don't get what you do on a timeout. in the enumeration part,

We can't do much on the timeout.

> the timeout value is not checked for, so I guess enumeration proceeds
> without the hardware being available? That seems to contradict the
> assertion that you don't want to access registers before the hardware is
> properly initialized.

Even if enumeration timeout, we will not access the registers because 
the ASoC codec is not registered yet from WCD938x component master.

> 
> And then on broadcast you have this error handling:
> 
> 		ret = wait_for_completion_timeout(&swrm->broadcast,
> 						  msecs_to_jiffies(TIMEOUT_MS));
> 		if (!ret)
> 			ret = SDW_CMD_IGNORED;
> 		else
> 			ret = SDW_CMD_OK;
> 
> Which is equally confusing since SDW_CMD_IGNORED is really an error, and
> the bus layer does not really handle it well - not to mention that I
> vaguely recall the qcom hardware having its own definition of IGNORED?
QCom hardware alteast the version based on which this driver was written 
did not have any support to report errors type back on register read/writes.

In this case a broad cast read or write did not generate a complete 
interrupt its assumed that its ignored, as there is no way to say if its 
error or ignored.

--srini




> 
