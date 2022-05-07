Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA9051E4EA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 08:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445890AbiEGG4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 02:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445870AbiEGG4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 02:56:36 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B575DBD3
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 23:52:50 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id bg25so5692275wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 23:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5ugJecicSvHEwm+RVDtMYhlgxoNcr0z5OqAxwLTJcpY=;
        b=Cw3NFUj1PG3LMT+NOYspXs2/n3Dq0oIFxCS3zCqAHi1RVtd22ciu1k24gVy0/qIFee
         Ri3B4BMCMpOjwb2sMhxh3wrXk70Ck3l9L9yugdFzbgwgWhbTVVsBlnTw2MrhLasaq2ZQ
         TApYlP5cAVCFB2CQ/o1f9aVq1H3eymge9OfFgUa2LAErLvYhKeIBBCrX8Ei0fbtBvhEi
         3+goqWpYP190Jtc7Wqzu5e+lNFEJSQFwfyTA8A3E1g570dRENcE20hZBfs4b2/pLxJMF
         91/4bLWOwhokeIClldzXKvB5raMgy7RjdK8AfxD8cat/4zEqbDCNlwKyg6kE0dJbU5Nu
         k+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5ugJecicSvHEwm+RVDtMYhlgxoNcr0z5OqAxwLTJcpY=;
        b=wT5OFQb6iB0ZVPayJEnTFqYCjDMcnQK1ZHjupEEr7bD9Fh2qhJBA4OxI4s9bLE3I9n
         hyL3W/hKLAIb6a4qkFx7r2wYAyub7glc9HKt7UzkH8VkTKASrY0Y1X4SQxZ1baz1BECn
         nrY5Oz1ku83ZQB+TFuDnsCFyPHI+XgUUPstgr9zmIbe1fg8OKl4TuYDYBWKPeumSsVF2
         A0AhJSpnWyxcDAE/xuzMCU18rnoG3r3g2ZwETNhepSyjpTKs7ZUKqDYBsfK/UJScTo4G
         M+muGIqRZX6q2BH0Bvp63mNk8dcnOt3qoWqvzOz1a3yEuC6iN+K5lJ8asuNyHawNiPLI
         v1tA==
X-Gm-Message-State: AOAM531mb5GI3X281h9Tvs+no6hypu+oHWcp87/lLVeNGr+yrfTnUnMp
        VrSncc/usKaEHljoy/4UuKspdg==
X-Google-Smtp-Source: ABdhPJzr0j/crsH61UsDFzT+Kh89tbOFBhhvp98wBAzg8Je4H7OusP4OvkkLXYHNs2AVkd5EyVM3xQ==
X-Received: by 2002:a05:600c:21d9:b0:394:2398:3bff with SMTP id x25-20020a05600c21d900b0039423983bffmr6872480wmj.101.1651906368905;
        Fri, 06 May 2022 23:52:48 -0700 (PDT)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id q1-20020adff501000000b0020c5253d8cdsm5186462wro.25.2022.05.06.23.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 23:52:48 -0700 (PDT)
Message-ID: <8643d266-7108-2440-43e1-c51b829ba481@linaro.org>
Date:   Sat, 7 May 2022 07:52:46 +0100
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
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <725af523-d144-e373-e09b-fb48b3afb9ed@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Pierre,

On 06/05/2022 15:13, Pierre-Louis Bossart wrote:
> 
> 
> On 5/6/22 03:47, Srinivas Kandagatla wrote:
>> Currently timeout for autoenumeration during probe and bus reset is set to
>> 2 secs which is really a big value. This can have an adverse effect on
>> boot time if the slave device is not ready/reset.
>> This was the case with wcd938x which was not reset yet but we spent 2
>> secs waiting in the soundwire controller probe. Reduce this time to
>> 1/10 of Hz which should be good enough time to finish autoenumeration
>> if any slaves are available on the bus.
> 
> Humm, now that I think of it I am not sure what reducing the timeout does.
> 
> It's clear that autoenumeration should be very fast, but if there is
> nothing to enumerate what would happen then? It seems that reducing the
> timeout value only forces an inconsistent configuration to be exposed
> earlier, but that would not result in a functional change where the
> missing device would magically appear, would it? Is this change mainly
> to make the tests fail faster? If the 'slave device is not ready/reset',
> is there a recovery mechanism to recheck later?
> 
> Would you mind clarifying what happens after the timeout, and why the
> timeout would happen in the first place?

This issue is mostly present/seen with WCD938x codec due to its Linux 
device model.
WCD938x Codec has 3 Linux component drivers
1. TX Component (A soundwire device connected to TX Soundwire Master)
2. RX Component (A soundwire device connected to RX Soundwire Master)
3. Master Component (Linux component framework master for (1) and  (2) 
and registers ASoC codec)

Also we have only one reset for (1) and (2).

reset line is handled by (3)
There are two possibilities when the WCD938x reset can happen,

1. If reset happens earlier than probing (1) and (2) which is best case.


2. if reset happens after (1) and (2) are probed then SoundWire TX and 
RX master will have spend 2 + 2 secs waiting, Which is a long time out
Hence the patch.

TBH, the 2 sec timeout value was just a random number which I added at 
the start, we had to come up with some sensible value over the time 
anyway for that.

You could say why do we need wait itself in the first place.

The reason we need wait in first place is because, there is a danger of 
codec accessing registers even before enumeration is finished. Because 
most of the ASoC codec registration happens as part of codec/component 
driver probe function rather than status callback.

I hope this answers your questions.

thanks,
--srini



> 
> Thanks!
> 
>>
>> Reported-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>
>> Changes since v1:
>> 	replaced HZ/10 with 100 as suggested by Pierre
>>
>>   drivers/soundwire/qcom.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>> index 7367aa88b8ac..d6111f69d320 100644
>> --- a/drivers/soundwire/qcom.c
>> +++ b/drivers/soundwire/qcom.c
>> @@ -105,7 +105,7 @@
>>   
>>   #define SWRM_SPECIAL_CMD_ID	0xF
>>   #define MAX_FREQ_NUM		1
>> -#define TIMEOUT_MS		(2 * HZ)
>> +#define TIMEOUT_MS		100
>>   #define QCOM_SWRM_MAX_RD_LEN	0x1
>>   #define QCOM_SDW_MAX_PORTS	14
>>   #define DEFAULT_CLK_FREQ	9600000
