Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E989E4BFA71
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiBVOJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbiBVOJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:09:26 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75B015F617
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:09:00 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id h13so362653qvk.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Xqy5QKYZUVik+xQ3v/BV4Q233CuzTNH+f5Hje8r4UrI=;
        b=aGIIG0timJUg6GqBs7BQEga6tkXr3leN8qS/gdipqyzpUFCqQkhRhM7UZe2pVyLcgm
         NOb3dsFsdJciYIMXJuNhQY2WUhYIwifHoKXAxGkcT+WEJUP6rAWREQ8BsToWjyfTPIrv
         1Gia/lwpYFtICvwKofZOdKvajWAV0p2Yj6N4JVAbKmVeu1/iV0LKcPwccNE71C6LFLrI
         1UL2sV6UmJqsZt9jsrcCgwaKVMRq3o3rBAMI85FQ/PZRZZ3ywz5wKyIOOlqhsHSRTe/y
         b20BwfwS8h8HFx5aY6uAhL/6Ug/B65sontRAmVB2YUKzm9kzcsNjicDtP4SeQiYeumNs
         VAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xqy5QKYZUVik+xQ3v/BV4Q233CuzTNH+f5Hje8r4UrI=;
        b=OlT6LN9rwQHk1zKznN5NFRMnwMHtb+6vwQVhX/tbiIbngZPubeFM9TVOwdn152iU4Y
         FWzW2TjT/CzvpuC4S2LC+5fJMBtdZ1ar7Cx2Kda1C4J7VQVOBjePGopDRpl1RMtDG9Vi
         FgdJPPRgwgZQeZIg3xibahokP+zsqOcT+hbVCYASe+vK3QaeU+0XJ4K74rafH63WgBeZ
         0yidq7TTVa1yOkPkJNHsnaCxE5kF5YmMXaIsSir3KKJC7tMvuyiFgA1JQSQNrmgkIvSq
         +3xea7gp0QgyZDfaWh90DWx28qbkiCp1W57KZBd1rmLSE7iAM5iuxpBMZLbgItCLeNjE
         72oA==
X-Gm-Message-State: AOAM532Qvi9OgG6EpIvRaoWTbQqrAzX8IPLFXxQB3mloMXIq0I2wYaKn
        ebZIMYh9ugOfQ7EqIGonU7FMWg==
X-Google-Smtp-Source: ABdhPJyu9Jgp+cBMPis6i+EmxSqRp8Qurp/ec9d0f6KFWdqDr/xI0wAEwk7qjS45pCIqzW1QSNPz9Q==
X-Received: by 2002:a05:622a:607:b0:2d7:35db:81e4 with SMTP id z7-20020a05622a060700b002d735db81e4mr21875783qta.281.1645538939986;
        Tue, 22 Feb 2022 06:08:59 -0800 (PST)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id m5sm6184543qkd.36.2022.02.22.06.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 06:08:59 -0800 (PST)
Message-ID: <72118049-0ae0-69a9-97de-2c132e5f3b6c@linaro.org>
Date:   Tue, 22 Feb 2022 08:08:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 15/25] bus: mhi: ep: Add support for processing MHI
 endpoint interrupts
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        vinod.koul@linaro.org, bjorn.andersson@linaro.org,
        dmitry.baryshkov@linaro.org, quic_vbadigan@quicinc.com,
        quic_cang@quicinc.com, quic_skananth@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
 <20220212182117.49438-16-manivannan.sadhasivam@linaro.org>
 <d5bf8b66-e9ec-4750-9d9d-deb55cbcee94@linaro.org>
 <20220222081859.GC5029@thinkpad>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220222081859.GC5029@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/22 2:18 AM, Manivannan Sadhasivam wrote:
> On Tue, Feb 15, 2022 at 04:39:30PM -0600, Alex Elder wrote:
>> On 2/12/22 12:21 PM, Manivannan Sadhasivam wrote:
>>> Add support for processing MHI endpoint interrupts such as control
>>> interrupt, command interrupt and channel interrupt from the host.
>>>
>>> The interrupts will be generated in the endpoint device whenever host
>>> writes to the corresponding doorbell registers. The doorbell logic
>>> is handled inside the hardware internally.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>
>> Unless I'm mistaken, you have some bugs here.
>>
>> Beyond that, I question whether you should be using workqueues
>> for handling all interrupts.  For now, it's fine, but there
>> might be room for improvement after this is accepted upstream
>> (using threaded interrupt handlers, for example).
>>
> 
> Only reason I didn't use bottom halves is that the memory for TRE buffers need
> to be allocated each time, so essentially the caller should not sleep.

Threaded interrupt handlers can sleep.  If scheduled, they run
immediately after hard interrupt handlers.  For receive buffers,
yes, replacing a receive buffer just consumed would require an
allocation, but for transmit I think it might be possible to
avoid the need to do a memory allocation.  (Things to think
about at some future date.)

> This is currently a limitation of iATU where there are only 8 windows for
> mapping the host memory and each memory region size is also limited.

Those are hard limitations, and probably what constrains you the most.

					-Alex
> 
>> 					-Alex
>>
>>> ---
>>>    drivers/bus/mhi/ep/main.c | 113 +++++++++++++++++++++++++++++++++++++-
>>>    include/linux/mhi_ep.h    |   2 +
>>>    2 files changed, 113 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
>>> index ccb3c2795041..072b872e735b 100644
>>> --- a/drivers/bus/mhi/ep/main.c
>>> +++ b/drivers/bus/mhi/ep/main.c
>>> @@ -185,6 +185,56 @@ static void mhi_ep_ring_worker(struct work_struct *work)
>>>    	}
>>>    }
>>> +static void mhi_ep_queue_channel_db(struct mhi_ep_cntrl *mhi_cntrl,
>>> +				    unsigned long ch_int, u32 ch_idx)
>>> +{
>>> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>>> +	struct mhi_ep_ring_item *item;
>>> +	struct mhi_ep_ring *ring;
>>> +	unsigned int i;
>>
>> Why not u32 i?  And why is the ch_int argument unsigned long?  The value
>> passed in is a u32.
>>
> 
> for_each_set_bit() expects the 2nd argument to be of type "unsigned long".
> 
> Thanks,
> Mani

