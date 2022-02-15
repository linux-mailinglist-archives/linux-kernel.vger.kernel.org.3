Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABF34B7A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244608AbiBOWki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:40:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244656AbiBOWke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:40:34 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87817C1CBD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:40:20 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id h16so205326iol.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+uTHRk3vn7b7240d9lio/cLpuJ5VeLhU2HIShoQoe3s=;
        b=vF45jgK33rDmLC5vaRHXf40anc6xJJto78rHU7n2P5Bug6lneHisJ6dBt4IGhYT3Ti
         r0aias7lXyx5U8Yy3HpaxUoxXJkZWZQ70IUMBw4uuksDvMau4hR067jT4nmqgiY04LhB
         TfxDNnbuak5ugCRSWRVg4MiK9jIq4wqBrpFoeGQylkA62POK89vFB0PeGP54dbbTnRsm
         3opQd8nS8cOTPKB1V+DzY5DvlvXpN0YlJAPR+uKQLWwPjSEuHt1IhRVS9cqr6JVyf5rQ
         jYyaYxBfA0vUFg51fn+fWWRjJ/Jx2O43GQY0w92BcUpI81yGTFc2dERFQ7Kxtxn4hBBY
         UhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+uTHRk3vn7b7240d9lio/cLpuJ5VeLhU2HIShoQoe3s=;
        b=Spt0Y5MU3rHg16IRwl11BfKhhx5g/+vLkY7jXIlZgsgIF4JFG95EtRYfR8tuohKuQt
         SxmJTnaGF1PZf9t5e3jhCjxaQDcsfdjojWGe0A8ZdJYzcwkNieDIGEBNOejH/pmkjh7Q
         mDaMwQJdpCrtRK2Urzhaw8wXjibYIqVh4WPCwr2dyzHO+17JwlZTGMynOj7LshvRLsJk
         lK1wzkk9GeJOE2+YOnuNVleFuhUhU4fYkqtIlUTZuJ9V3ekEKI+JMW7NHx6/lU0c+Gei
         JwJsEK+0s5ZaaCsFcvqieJPJfCt9tp19PVQWy9/KNIlUwBwB21CH1ea+/Ez6rWKr3Li3
         HHhA==
X-Gm-Message-State: AOAM5315I5m74J+7zhfuFsiIelqjaI/6PgkskXc5h9WdRah0A14+hNAQ
        1JAbl1BVTgxBqzKV2+kw9cS7SQ==
X-Google-Smtp-Source: ABdhPJze6g641WYPPyTfOJlx0sIM7ves+ZntOwvUsqAR2cnEAKhv3zTlnI+/n54IVAZPyZ8QNwYYng==
X-Received: by 2002:a05:6638:371f:: with SMTP id k31mr691842jav.208.1644964819781;
        Tue, 15 Feb 2022 14:40:19 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id c17sm59020ilq.68.2022.02.15.14.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 14:40:19 -0800 (PST)
Message-ID: <f91de912-977b-4e78-2e8c-12f4c09134bd@linaro.org>
Date:   Tue, 15 Feb 2022 16:40:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 22/25] bus: mhi: ep: Add support for processing
 transfer ring
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
 <20220212182117.49438-23-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220212182117.49438-23-manivannan.sadhasivam@linaro.org>
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

On 2/12/22 12:21 PM, Manivannan Sadhasivam wrote:
> Add support for processing the transfer ring from host. For the transfer
> ring associated with DL channel, the xfer callback will simply invoked.
> For the case of UL channel, the ring elements will be read in a buffer
> till the write pointer and later passed to the client driver using the
> xfer callback.
> 
> The client drivers should provide the callbacks for both UL and DL
> channels during registration.

I think you already checked and guaranteed that.

I have a question and suggestion below.  But it could
be considered an optimization that could be implemented
in the future, so:

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/bus/mhi/ep/main.c | 49 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index b937c6cda9ba..baf383a4857b 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -439,6 +439,55 @@ static int mhi_ep_read_channel(struct mhi_ep_cntrl *mhi_cntrl,
>   	return 0;
>   }
>   
> +int mhi_ep_process_tre_ring(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el)
> +{
> +	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
> +	struct mhi_result result = {};
> +	u32 len = MHI_EP_DEFAULT_MTU;
> +	struct mhi_ep_chan *mhi_chan;
> +	int ret;
> +
> +	mhi_chan = &mhi_cntrl->mhi_chan[ring->ch_id];
> +
> +	/*
> +	 * Bail out if transfer callback is not registered for the channel.
> +	 * This is most likely due to the client driver not loaded at this point.
> +	 */
> +	if (!mhi_chan->xfer_cb) {
> +		dev_err(&mhi_chan->mhi_dev->dev, "Client driver not available\n");
> +		return -ENODEV;
> +	}
> +
> +	if (ring->ch_id % 2) {
> +		/* DL channel */
> +		result.dir = mhi_chan->dir;
> +		mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
> +	} else {
> +		/* UL channel */
> +		do {
> +			result.buf_addr = kzalloc(len, GFP_KERNEL);

So you allocate an 8KB buffer into which you copy
received data, then pass that to the ->xfer_cb()
function.  Then you free that buffer.  Repeatedly.

Two questions about this:
- This suggests that after copying the data in, the
   ->xfer_cb() function will copy it again, is that
   correct?
- If that is correct, why not just reuse the same 8KB
   buffer, allocated once outside the loop?

It might also be nice to consider whether you could
allocate the buffer here and have the ->xfer_cb()
function be responsible for freeing it (and ideally,
pass it along rather than copying it again).

> +			if (!result.buf_addr)
> +				return -ENOMEM;
> +
> +			ret = mhi_ep_read_channel(mhi_cntrl, ring, &result, len);
> +			if (ret < 0) {
> +				dev_err(&mhi_chan->mhi_dev->dev, "Failed to read channel\n");
> +				kfree(result.buf_addr);
> +				return ret;
> +			}
> +
> +			result.dir = mhi_chan->dir;
> +			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
> +			kfree(result.buf_addr);
> +			result.bytes_xferd = 0;
> +
> +			/* Read until the ring becomes empty */
> +		} while (!mhi_ep_queue_is_empty(mhi_chan->mhi_dev, DMA_TO_DEVICE));
> +	}
> +
> +	return 0;
> +}
> +
>   static int mhi_ep_cache_host_cfg(struct mhi_ep_cntrl *mhi_cntrl)
>   {
>   	struct device *dev = &mhi_cntrl->mhi_dev->dev;

