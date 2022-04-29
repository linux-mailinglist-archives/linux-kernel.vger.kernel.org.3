Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FF65150EE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbiD2QgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbiD2QgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:36:14 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CF2DA6E8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:32:56 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j15so11503410wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=S4NuDlQ4H333iLs1hPXqfwMkGd7SKFHcf7phIVGCdKU=;
        b=ePvqPx9exwhp1XFBmqykvbTUy9T9vZFmlnlXlKf0CDvmruz0alVYRaew6CPNgZDjqC
         o64hwcYzaoeuItfAe99tpfGXj/nJOr9A5rjv+TSnD8grUFOxs21mZrhAxVD1vxAdBLyJ
         Jjp+qcBp5DCYeJEFrSklrbQk0f3x2HdhwEFYazp9qWgC8yKeixDOe4gRlNIUFxzLnsxF
         tMMocfCW5oC5tSlutya1le9xZZaEwfSBpA57C58BWA1p27fqFy2itWFb4DP93N7wmziH
         2oh/kPTJoXG6fgGPQhscjqqa6FwbtVzV583KA4oqoWarfnjkCrbj+S39iV+sdLoCTBQ7
         PLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S4NuDlQ4H333iLs1hPXqfwMkGd7SKFHcf7phIVGCdKU=;
        b=Mm7Qwmei0f7h4DScPKpQXynHcIp9o4v/b/bnFqUA4pxyIdD7742SIzR4yqwcO/WDw5
         qHSAMSKlfYHLFzj2nkh1GQW+joaZ4R7WzA3u6a9HlvQuG/txcCpQk8URJq+EbMroz55W
         RWyibsVe1VwgrpzgNL8vScDYZ0Q6fl19WsRNyJ2kkaMxLKrWEyBP71Nj6wkcA9sDJUXi
         Y4MygaqWlGFmLLDeTGZE+B+vg74dEQL1Aq0rnrA6CCNTkSP5x97Hca5+cU6kaEM9Anwz
         FoHNgMVG3pHN+1ZkQcWuuQllaAQg3vlqpXC+Pq2VQ4/euHfEf7x0A3A6Bx5kTNxFKnrP
         ctnQ==
X-Gm-Message-State: AOAM532b6CclyvajxQp99hSgrLESNdWCFUm7uhSehfSXFzUwF6LNhC16
        bDPr9gdlq7de9j9thMGHgwHjww==
X-Google-Smtp-Source: ABdhPJwnv6Sk8kzJ/jkU6fHgBhsL7U0fcKilKFur9FZMXs3z+CS+h066AYkE41m88w6TZU1G404EdQ==
X-Received: by 2002:a5d:6205:0:b0:1e4:b3fd:9ba8 with SMTP id y5-20020a5d6205000000b001e4b3fd9ba8mr30662388wru.426.1651249974796;
        Fri, 29 Apr 2022 09:32:54 -0700 (PDT)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id o9-20020adf8b89000000b0020adeb916d8sm3019401wra.30.2022.04.29.09.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 09:32:53 -0700 (PDT)
Message-ID: <1c7395c8-10fb-98cd-9046-fa429f268da4@linaro.org>
Date:   Fri, 29 Apr 2022 17:32:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] soundwire: qcom: adjust autoenumeration timeout
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bard.liao@intel.com,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
References: <20220429160928.24614-1-srinivas.kandagatla@linaro.org>
 <e9f4001d-a9f4-fae7-521a-76f8880ba82b@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <e9f4001d-a9f4-fae7-521a-76f8880ba82b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/04/2022 17:19, Pierre-Louis Bossart wrote:
> 
> 
> On 4/29/22 11:09, Srinivas Kandagatla wrote:
>> Currently timeout for autoenumeration during probe and bus reset is set to
>> 2 secs which is really a big value. This can have an adverse effect on
>> boot time if the slave device is not ready/reset.
>> This was the case with wcd938x which was not reset yet but we spent 2
>> secs waiting in the soundwire controller probe. Reduce this time to
>> 1/10 of Hz which should be good enough time to finish autoenumeration
>> if any slaves are available on the bus.
> 
> Can I ask why this is dependent on a software configuration you have no control on?
> 
> Why not simply:
> 
> #define TIMEOUT_MS		100
> 
> ?

That will work too.

--srini


> 
>>
>> Reported-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/soundwire/qcom.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>> index da1ad7ebb1aa..432e5cb9a4d2 100644
>> --- a/drivers/soundwire/qcom.c
>> +++ b/drivers/soundwire/qcom.c
>> @@ -105,7 +105,7 @@
>>   
>>   #define SWRM_SPECIAL_CMD_ID	0xF
>>   #define MAX_FREQ_NUM		1
>> -#define TIMEOUT_MS		(2 * HZ)
>> +#define TIMEOUT_MS		(HZ/10)
>>   #define QCOM_SWRM_MAX_RD_LEN	0x1
>>   #define QCOM_SDW_MAX_PORTS	14
>>   #define DEFAULT_CLK_FREQ	9600000
