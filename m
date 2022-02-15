Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BAC4B7A94
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244617AbiBOWkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:40:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244581AbiBOWj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:39:57 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C723DC117D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:39:45 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id 24so227557ioe.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=re/4W0t355bFeLYhx+xr4ZRPkVNWP0Fw1tKZSAZTCso=;
        b=t7bklTxAsjkPR8MafGrsxSL6UCcWNKHNGJvM2g4eqU1WswOk5VoWrBiU3rQN0Aaq6B
         NAXPk2Dlq6vwP4toOmzXxUdCBhtHicUJ66KpmViV0/0Gw3R5Wm8ZaOzAegLz3zgxAfuD
         O+FoxX4DHoYzxHJlk54S0AtJ6zXSsnQlEsLeKOuXJOcSQLXEKQHVBFdM3vhzVx7KfOfc
         WJKogBf0Xx56uaFWYim2lk+zUYFQr+Z+Vqx1+DWpmtbqAbST/eBQuo47OX2WoNiIRabB
         txUs74ZyVxHr1euvQHL4k/VAkNteXPqya2no4whb9W8j55a5vyhFtJpZYIkIWvb43SvX
         LShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=re/4W0t355bFeLYhx+xr4ZRPkVNWP0Fw1tKZSAZTCso=;
        b=P5wmmvkbnC6icKThM14w6CSVE52AejITX1GMUGVKxxYuHBurkqXxc34mSUZCpwbK4b
         NdL2ylM7EGqJFm/TSlI5utwX1kRX9U8fOLokTtUnRMpU1V9GKjL6u06TNN7iO8/21jL+
         8tclg+ps+IADJ+dYUI6PU9gUy5MzC7pu6ZdSAImvWee1RxI0cgg6Kapb0r1HgzT9ntcK
         LXV37dExqHkjHzmaCtr13PXHDRz7JCiCL0Wsx6/wAk5/YE67pqQAVA5v2qwsl7+QRKQR
         YaDXoLBvfx0WwMH/W+nobTvEiH9Z81cJCZHFXHqVg/oT4n0bQEdgc/K42UFjddsIC229
         DDbg==
X-Gm-Message-State: AOAM530DpveK+1EFBubnMpfjTMNaeuqnkLV87xrR+Fd0soBE5rgzIEOs
        EUwm9Q8jJYZ6VqB+2HRjCBDeRw==
X-Google-Smtp-Source: ABdhPJzUUNzt8tSEdjrTTV6D0Bs33fyYYYC5lP3Ad6HNuAaPMEGJPmguuKDfEm7/yQN6B8GLCOG5Pw==
X-Received: by 2002:a05:6638:3045:: with SMTP id u5mr705163jak.105.1644964785137;
        Tue, 15 Feb 2022 14:39:45 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id j14sm22034009ilc.62.2022.02.15.14.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 14:39:44 -0800 (PST)
Message-ID: <e666f950-2e45-bc8e-9c4e-1f5f990428f1@linaro.org>
Date:   Tue, 15 Feb 2022 16:39:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 17/25] bus: mhi: ep: Add support for powering down the
 MHI endpoint stack
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
 <20220212182117.49438-18-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220212182117.49438-18-manivannan.sadhasivam@linaro.org>
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
> Add support for MHI endpoint power_down that includes stopping all
> available channels, destroying the channels, resetting the event and
> transfer rings and freeing the host cache.
> 
> The stack will be powered down whenever the physical bus link goes down.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Not much to say here either, just a few suggestions.

					-Alex

> ---
>   drivers/bus/mhi/ep/main.c | 81 +++++++++++++++++++++++++++++++++++++++
>   include/linux/mhi_ep.h    |  6 +++
>   2 files changed, 87 insertions(+)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 016e819f640a..14cb08de4263 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -21,6 +21,8 @@
>   
>   static DEFINE_IDA(mhi_ep_cntrl_ida);
>   
> +static int mhi_ep_destroy_device(struct device *dev, void *data);
> +
>   static int mhi_ep_send_event(struct mhi_ep_cntrl *mhi_cntrl, u32 ring_idx,
>   			     struct mhi_ep_ring_element *el)
>   {
> @@ -492,6 +494,71 @@ static irqreturn_t mhi_ep_irq(int irq, void *data)
>   	return IRQ_HANDLED;
>   }
>   
> +static void mhi_ep_abort_transfer(struct mhi_ep_cntrl *mhi_cntrl)
> +{
> +	struct mhi_ep_ring *ch_ring, *ev_ring;
> +	struct mhi_result result = {};
> +	struct mhi_ep_chan *mhi_chan;
> +	int i;
> +
> +	/* Stop all the channels */
> +	for (i = 0; i < mhi_cntrl->max_chan; i++) {
		mhi_chan = &mhi_cntrl->mhi_chan[i];
		ch_ring = &mhi_chan->ring;
	
> +		ch_ring = &mhi_cntrl->mhi_chan[i].ring;
> +		if (!ch_ring->started)
> +			continue;
> +
> +		mhi_chan = &mhi_cntrl->mhi_chan[i];
> +		mutex_lock(&mhi_chan->lock);
> +		/* Send channel disconnect status to client drivers */
> +		if (mhi_chan->xfer_cb) {
> +			result.transaction_status = -ENOTCONN;
> +			result.bytes_xferd = 0;
> +			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
> +		}
> +
> +		/* Set channel state to DISABLED */

Omit the above comment.

> +		mhi_chan->state = MHI_CH_STATE_DISABLED;
> +		mutex_unlock(&mhi_chan->lock);
> +	}
> +
> +	flush_workqueue(mhi_cntrl->ring_wq);
> +	flush_workqueue(mhi_cntrl->state_wq);
> +
> +	/* Destroy devices associated with all channels */
> +	device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL, mhi_ep_destroy_device);
> +
> +	/* Stop and reset the transfer rings */
> +	for (i = 0; i < mhi_cntrl->max_chan; i++) {
		mhi_chan = ...

		if (!mhi_chan->ring.started)
			continue;

> +		ch_ring = &mhi_cntrl->mhi_chan[i].ring;
> +		if (!ch_ring->started)
> +			continue;
> +
> +		mhi_chan = &mhi_cntrl->mhi_chan[i];
> +		mutex_lock(&mhi_chan->lock);
> +		mhi_ep_ring_reset(mhi_cntrl, ch_ring);
> +		mutex_unlock(&mhi_chan->lock);
> +	}
> +
> +	/* Stop and reset the event rings */
> +	for (i = 0; i < mhi_cntrl->event_rings; i++) {
> +		ev_ring = &mhi_cntrl->mhi_event[i].ring;
> +		if (!ev_ring->started)
> +			continue;
> +
> +		mutex_lock(&mhi_cntrl->event_lock);
> +		mhi_ep_ring_reset(mhi_cntrl, ev_ring);
> +		mutex_unlock(&mhi_cntrl->event_lock);
> +	}
> +
> +	/* Stop and reset the command ring */
> +	mhi_ep_ring_reset(mhi_cntrl, &mhi_cntrl->mhi_cmd->ring);
> +
> +	mhi_ep_free_host_cfg(mhi_cntrl);
> +	mhi_ep_mmio_mask_interrupts(mhi_cntrl);
> +
> +	mhi_cntrl->is_enabled = false;
> +}
> +
>   int mhi_ep_power_up(struct mhi_ep_cntrl *mhi_cntrl)
>   {
>   	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> @@ -548,6 +615,16 @@ int mhi_ep_power_up(struct mhi_ep_cntrl *mhi_cntrl)
>   }
>   EXPORT_SYMBOL_GPL(mhi_ep_power_up);
>   
> +void mhi_ep_power_down(struct mhi_ep_cntrl *mhi_cntrl)
> +{
> +	if (mhi_cntrl->is_enabled)
> +		mhi_ep_abort_transfer(mhi_cntrl);
> +
> +	kfree(mhi_cntrl->mhi_event);
> +	disable_irq(mhi_cntrl->irq);
> +}
> +EXPORT_SYMBOL_GPL(mhi_ep_power_down);
> +
>   static void mhi_ep_release_device(struct device *dev)
>   {
>   	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
> @@ -828,6 +905,10 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
>   }
>   EXPORT_SYMBOL_GPL(mhi_ep_register_controller);
>   
> +/*
> + * It is expected that the controller drivers will power down the MHI EP stack
> + * using "mhi_ep_power_down()" before calling this function to unregister themselves.
> + */
>   void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl)
>   {
>   	struct mhi_ep_device *mhi_dev = mhi_cntrl->mhi_dev;
> diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
> index 53895f1c68e1..4f86e7986c93 100644
> --- a/include/linux/mhi_ep.h
> +++ b/include/linux/mhi_ep.h
> @@ -260,4 +260,10 @@ void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl);
>    */
>   int mhi_ep_power_up(struct mhi_ep_cntrl *mhi_cntrl);
>   
> +/**
> + * mhi_ep_power_down - Power down the MHI endpoint stack
> + * @mhi_cntrl: MHI controller
> + */
> +void mhi_ep_power_down(struct mhi_ep_cntrl *mhi_cntrl);
> +
>   #endif

