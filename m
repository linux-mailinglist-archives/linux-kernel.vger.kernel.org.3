Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4434BFC46
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiBVPTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbiBVPSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:18:46 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B227614A075
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:18:20 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id c14so16734943ioa.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xBV5CfTYWd1OPj8rDibNSsYE0rmrF2IsLJinLQ/4VQk=;
        b=Hm8SzBkNIXZgJ9JetW86MwmzMLxbeT5wbqrh9AG1ecTuQQMYvLCHy0Mrnblhek+uQ7
         5vN46g40HF6mIgtlX6UwIbDDwfyLHeZfIfM9pF9QHSo+8AaPKRRWWnL+I0oNnck1L1cL
         VG2Af7J4IXpDS/VEuv3HyJ64JIVLYIxiOvcDHmflxGooyRQa/2EkctT4xBrWzt0PNLtk
         CUaN6O5LEw+W1VZ7IU+IfzK0db41N7tcAAGUtcNYDz9fvGTAP4xsjH99YVVo6p1YoAiQ
         lIJcgCKvA6ueFhDCMg+NT/usYUx0O6QSUm3A9d3A2YeWR7NsF16OKl2S/RkEhbZE345u
         SJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xBV5CfTYWd1OPj8rDibNSsYE0rmrF2IsLJinLQ/4VQk=;
        b=PFhhJj1AdwcHFkgZILbavMLIWRQaCx2rXKxvRkBfWU+KOWd0lcVRTVAZnvwvisf+L9
         t2KtzR/iDGIAbLt0JQ4bKEX3GpTQRsSq2MAXTZEbzuO2SPJvTD2aTdbvQVhb5dEWV/ZO
         Umt9Tb/GzZ9gsDLx4zllymkDbVdmmvfRwMO7XQaYAByhDuiQPhnZHGF14qIjE0M1Dwda
         TNyY1H9XGQaEHZah73N3I+I7Ph62w0q6grTuIjTfdhCyoqwWRgp5Kj+iSg8RWNtgX+fs
         aB77iOwgnNua6v5xkv34aS2xBwrqBrVIVJ+5wjk1wuGiM4+PETv2nHZBTs8DBpRbq3Di
         czXg==
X-Gm-Message-State: AOAM5331FY7HI3+H+cURHStxa4H3J0SQOoYdCxPlKpC2rDxwnJtsOCzu
        r6im/QV22fAmNJAhPez+/n8Eug==
X-Google-Smtp-Source: ABdhPJyMvIEt4P/tuJaiYPOYcuZuTEcosqlAjiBFoPqe4vzK4hj8jmvdHrMpZt9qMBLSbpg2p6Rn3Q==
X-Received: by 2002:a05:6638:1405:b0:30d:69cd:f44 with SMTP id k5-20020a056638140500b0030d69cd0f44mr18926507jad.208.1645543100023;
        Tue, 22 Feb 2022 07:18:20 -0800 (PST)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id r7sm7860220ilc.24.2022.02.22.07.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 07:18:19 -0800 (PST)
Message-ID: <f3248103-9450-dcf0-719d-77c6dcd85bfe@linaro.org>
Date:   Tue, 22 Feb 2022 09:18:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 23/25] bus: mhi: ep: Add support for queueing SKBs to
 the host
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        vinod.koul@linaro.org, bjorn.andersson@linaro.org,
        dmitry.baryshkov@linaro.org, quic_vbadigan@quicinc.com,
        quic_cang@quicinc.com, quic_skananth@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
 <20220212182117.49438-24-manivannan.sadhasivam@linaro.org>
 <766e6568-0b80-c745-dd8f-7f401fb0422d@linaro.org>
 <20220222143825.GH5029@thinkpad>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220222143825.GH5029@thinkpad>
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

On 2/22/22 8:38 AM, Manivannan Sadhasivam wrote:
> On Tue, Feb 15, 2022 at 04:40:29PM -0600, Alex Elder wrote:
>> On 2/12/22 12:21 PM, Manivannan Sadhasivam wrote:
>>> Add support for queueing SKBs to the host over the transfer ring of the
>>> relevant channel. The mhi_ep_queue_skb() API will be used by the client
>>> networking drivers to queue the SKBs to the host over MHI bus.
>>>
>>> The host will add ring elements to the transfer ring periodically for
>>> the device and the device will write SKBs to the ring elements. If a
>>> single SKB doesn't fit in a ring element (TRE), it will be placed in
>>> multiple ring elements and the overflow event will be sent for all ring
>>> elements except the last one. For the last ring element, the EOT event
>>> will be sent indicating the packet boundary.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>
>> I'm a little confused by this, so maybe you can provide
>> a better explanation somehow.
>>
>> 					-Alex
>>
>>> ---
>>>    drivers/bus/mhi/ep/main.c | 102 ++++++++++++++++++++++++++++++++++++++
>>>    include/linux/mhi_ep.h    |  13 +++++
>>>    2 files changed, 115 insertions(+)
>>>
>>> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
>>> index baf383a4857b..e4186b012257 100644
>>> --- a/drivers/bus/mhi/ep/main.c
>>> +++ b/drivers/bus/mhi/ep/main.c
>>> @@ -488,6 +488,108 @@ int mhi_ep_process_tre_ring(struct mhi_ep_ring *ring, struct mhi_ep_ring_element
>>>    	return 0;
>>>    }
>>> +int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, enum dma_data_direction dir,
>>> +		     struct sk_buff *skb, size_t len, enum mhi_flags mflags)
>>
>> Why are both skb and len supplied?  Will an skb be supplied
>> without wanting to send all of it?  Must len be less than
>> skb->len?  I'm a little confused about the interface.
>>
>> Also, the data direction is *out*, right?  You'll never
>> be queueing a "receive" SKB?
>>
> 
> This was done to be compatible with the MHI host API where the host can queue
> SKBs in both directions. But I think I should stop doing this.


OK.

>>> +{
>>> +	struct mhi_ep_chan *mhi_chan = (dir == DMA_FROM_DEVICE) ? mhi_dev->dl_chan :
>>> +								mhi_dev->ul_chan;
>>> +	struct mhi_ep_cntrl *mhi_cntrl = mhi_dev->mhi_cntrl;
>>> +	struct device *dev = &mhi_chan->mhi_dev->dev;
>>> +	struct mhi_ep_ring_element *el;
>>> +	struct mhi_ep_ring *ring;
>>> +	size_t bytes_to_write;
>>> +	enum mhi_ev_ccs code;
>>> +	void *read_from_loc;
>>> +	u32 buf_remaining;
>>> +	u64 write_to_loc;
>>> +	u32 tre_len;
>>> +	int ret = 0;
>>> +
>>> +	if (dir == DMA_TO_DEVICE)
>>> +		return -EINVAL;
>>
>> Can't you just preclude this from happening, or
>> know it won't happen by inspection?
>>
>>> +
>>> +	buf_remaining = len;
>>> +	ring = &mhi_cntrl->mhi_chan[mhi_chan->chan].ring;
>>> +
>>> +	mutex_lock(&mhi_chan->lock);
>>> +
>>> +	do {
>>> +		/* Don't process the transfer ring if the channel is not in RUNNING state */
>>> +		if (mhi_chan->state != MHI_CH_STATE_RUNNING) {
>>> +			dev_err(dev, "Channel not available\n");
>>> +			ret = -ENODEV;
>>> +			goto err_exit;
>>> +		}
>>> +
>>
>> It would be nice if the caller could know whether there
>> was enough room *before* you start transferring things.
>> It's probably a lot of work to get to that point though.
>>
> 
> No, the caller will do this check but the check is included here so that we
> don't run out of buffers when the packet needs to be splitted.
> 
>>> +		if (mhi_ep_queue_is_empty(mhi_dev, dir)) {
>>> +			dev_err(dev, "TRE not available!\n");
>>> +			ret = -EINVAL;
>>> +			goto err_exit;
>>> +		}
>>> +
>>> +		el = &ring->ring_cache[ring->rd_offset];
>>> +		tre_len = MHI_EP_TRE_GET_LEN(el);
>>> +		if (skb->len > tre_len) {
>>> +			dev_err(dev, "Buffer size (%d) is too large for TRE (%d)!\n",
>>> +				skb->len, tre_len);
>>
>> This means the receive buffer must be big enough to hold
>> any incoming SKB.  This is *without* checking for the
>> CHAIN flag in the TRE, so what you describe in the
>> patch description seems not to be true.  I.e., multiple
>> TREs in a TRD will *not* be consumed if the SKB data
>> requires more than what's left in the current TRE.
>>
> 
> I think I removed this check for v3 but somehow the change got lost :/

Looking at this now, it's possible I got confused about
which direction the data was moving; but I'm not really
sure.

 From the perspective of the endpoint device, this is the
*transmit* function.  But when the device is transmitting,
it is moving data into the *receive* buffers that the host
has allocated and supplied via the transfer ring.

My statement seems to be correct though, with this logic,
the host must supply a buffer large enough to receive the
entire next SKB, or it will get an error back.  I no longer
know what happens when this function (mhi_ep_queue_skb())
returns an error--is the skb dropped?

> But anyway, there is no need to check for CHAIN flag while writing to host.
> CHAIN flag is only used or even make sense when host writes data to device, so

I'm not sure that's correct, but I don't want to get into that issue here.
We can talk about that separately.

> that it knows the packet boundary and could use the CHAIN flag to tell the
> device where the boundary lies.

This doesn't sound to me like what the purpose of the CHAIN flag is,
but perhaps I'm misunderstanding you.  Let's have a quick private
chat about this so we don't waste any more e-mail bandwidth.

					-Alex

> But when the device writes to host, it already has the pre-queued elements from
> host that has no idea where the packet boundary lies. So the host would've set
> only EOT on all TREs and expects the device to send OVERFLOW event for TREs that
> don't have the complete packet. Then finally, when device sends EOT event, the
> host will detect the boundary.
> 
> Thanks,
> Mani

