Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BA44C71F4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbiB1QuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237790AbiB1QuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:50:03 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BFB23BD5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:49:23 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id h16so15320939iol.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YMyd8c6J3+rCTg9puRGFk4pJ96SQy0gvXgqrijaQR0U=;
        b=oZszB8ju2Po5v7iYJ3C1MrIYtM6Mo6N1292fA6WUX7VbPl0yeDOWaSsA7XW1vtF0rj
         iG3YZDQTk+hGoaiMp3sSIg+XLfNpU89W0kDQvg0Ozi2ae29SIudyzRvZ3vlL0bRkd156
         4TM8ceXZV2hoeo9jTV1LnLhKtKzaDPWPoRMIsck3Uw83QO/uhah1mEIhlwxApUwvpJjg
         0JqxcNqhT3wSRsK5fog+gqo7sgfrMpwAqmeBAwigdqHKCf32CzNLH9zvquRu/KlmL+mI
         t5kvZNLeALfl/Nh/9+EMQenVps2CGVI/hRN5oYDQoWO6ushxbcBw7y7nfytaNNlXP3r6
         29zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YMyd8c6J3+rCTg9puRGFk4pJ96SQy0gvXgqrijaQR0U=;
        b=rgBCKeZMq+5gEfdVUuxpdojdloSfFibpo81z0npu2IimgbRE0I8L32Q8KgBtlyqIIS
         xJgNvP855BkY3za6lg3Jn4GYVU4uoGwKDa6ezrrzCM2tzsJMJOB/m2bEDzvTjhHNtooE
         A47rT3cHBZyeSy2idJlcbrJtDcq0Xnvt6JbLB4jk8nxW/BLWv+G3H0kxunn4T/RLjlnY
         dZvZliiFSSXdJCIu2hRlJ4vgJqdsIt4KeeWcAaFSF9zX6d0pimQxwYtTCEW/I+2CARTU
         Foj9nA08MaGCI/+CFVN/1Xha+crO0qyjYrAXoUZ/pBXDU4sF88+Z4CmjvXTul6aAEfx/
         hKPQ==
X-Gm-Message-State: AOAM532iue2HygTPq/PU1Ylu9+fQVbPXbyOPS28LSXnoPCAxpdzwtzfZ
        L9dWpavOX6oautF+RycozKOoPg==
X-Google-Smtp-Source: ABdhPJz53BvW619kIjGbeTrc6JO62rTJbsak/OPM91ENt96Q4xOAIKPDKoGTSU06sipCTxMuuGqvcw==
X-Received: by 2002:a05:6638:4387:b0:315:260:2225 with SMTP id bo7-20020a056638438700b0031502602225mr17958693jab.298.1646066963168;
        Mon, 28 Feb 2022 08:49:23 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id w17-20020a056e0213f100b002c25c60d366sm6334593ilj.85.2022.02.28.08.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 08:49:22 -0800 (PST)
Message-ID: <5ebd555c-90a2-6f84-de27-e9524bff8a21@linaro.org>
Date:   Mon, 28 Feb 2022 10:49:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 19/27] bus: mhi: ep: Add support for powering down the
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
References: <20220228124344.77359-1-manivannan.sadhasivam@linaro.org>
 <20220228124344.77359-20-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220228124344.77359-20-manivannan.sadhasivam@linaro.org>
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

On 2/28/22 6:43 AM, Manivannan Sadhasivam wrote:
> Add support for MHI endpoint power_down that includes stopping all
> available channels, destroying the channels, resetting the event and
> transfer rings and freeing the host cache.
> 
> The stack will be powered down whenever the physical bus link goes down.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/bus/mhi/ep/main.c | 78 +++++++++++++++++++++++++++++++++++++++
>   include/linux/mhi_ep.h    |  6 +++
>   2 files changed, 84 insertions(+)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 47807102baad..4956440273ad 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -21,6 +21,8 @@
>   
>   static DEFINE_IDA(mhi_ep_cntrl_ida);
>   
> +static int mhi_ep_destroy_device(struct device *dev, void *data);
> +
>   static int mhi_ep_send_event(struct mhi_ep_cntrl *mhi_cntrl, u32 ring_idx,
>   			     struct mhi_ring_element *el, bool bei)
>   {
> @@ -432,6 +434,68 @@ static irqreturn_t mhi_ep_irq(int irq, void *data)
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
> +		mhi_chan = &mhi_cntrl->mhi_chan[i];
> +		if (!mhi_chan->ring.started)
> +			continue;
> +
> +		mutex_lock(&mhi_chan->lock);
> +		/* Send channel disconnect status to client drivers */
> +		if (mhi_chan->xfer_cb) {
> +			result.transaction_status = -ENOTCONN;
> +			result.bytes_xferd = 0;
> +			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
> +		}
> +
> +		mhi_chan->state = MHI_CH_STATE_DISABLED;
> +		mutex_unlock(&mhi_chan->lock);
> +	}
> +
> +	flush_workqueue(mhi_cntrl->wq);
> +
> +	/* Destroy devices associated with all channels */
> +	device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL, mhi_ep_destroy_device);
> +
> +	/* Stop and reset the transfer rings */
> +	for (i = 0; i < mhi_cntrl->max_chan; i++) {
> +		mhi_chan = &mhi_cntrl->mhi_chan[i];
> +		if (!mhi_chan->ring.started)
> +			continue;
> +
> +		ch_ring = &mhi_cntrl->mhi_chan[i].ring;
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
> +	mhi_cntrl->enabled = false;
> +}
> +
>   int mhi_ep_power_up(struct mhi_ep_cntrl *mhi_cntrl)
>   {
>   	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> @@ -486,6 +550,16 @@ int mhi_ep_power_up(struct mhi_ep_cntrl *mhi_cntrl)
>   }
>   EXPORT_SYMBOL_GPL(mhi_ep_power_up);
>   
> +void mhi_ep_power_down(struct mhi_ep_cntrl *mhi_cntrl)
> +{
> +	if (mhi_cntrl->enabled)
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
> @@ -765,6 +839,10 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
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
> index 1b7dec859a5e..8e062a4c84f4 100644
> --- a/include/linux/mhi_ep.h
> +++ b/include/linux/mhi_ep.h
> @@ -251,4 +251,10 @@ void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl);
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

