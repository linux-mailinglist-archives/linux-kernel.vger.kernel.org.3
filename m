Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBB54B7AA0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242012AbiBOWk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:40:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244622AbiBOWkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:40:22 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3275AC12FF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:40:11 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id h5so247058ioj.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WqRdUD4NPYgjn/xTex4W1909MAlDsgxmlzC3H6JK6ho=;
        b=IsiyA0wPsSzId48p7apHbOeMGg2cAP5D+F8DckQAZKSsLnaPMkNpUm4oTBOrip4NTv
         EJE1lgPhdVO3jMSYVVS4V83r13bkBndDuaxbImswBGtngBGHS1xm8i49NagEHZWWEfCt
         X2B7pxfHfQgp+AQMsc6QGM8Q/sZN1b/7GzMVsfybDYeC4RrfdDfykmaWSyXgf7MOJ7AV
         JybdlvN8977uV539Mvw6xhj0m5sOsN6rvqCngpmU8losF1XkTArqDcIwOdyxApJ0REDL
         6VHTSm+4tAOCB1ZTlHXO7zD/w3rso78CekbZnkBGVBRJWLiO5970GPx6gWPqmNlctpEb
         iuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WqRdUD4NPYgjn/xTex4W1909MAlDsgxmlzC3H6JK6ho=;
        b=lUIyeksOMx8f2cm6sMLBBMnz8K58aKFpFIhhiuv8KmJ7m0CE8xlkRdcK+ZNDAeb5ID
         hgfTo1frGuKzlv4ebIqfoCs4qOXAw3Aj1g/F6L0+vjwJmwdP5czgMNNxLMxYfZoc3WvF
         RwWmXDXG4JnRakR+lYMIFrkUe975NReLXZIAk1VIK4jT2FJ4fHI4xQB6dG2EJcfeeSvf
         9joe55MaJCgGaMEy6FyfUJTnAg7lYUk1eM22/bTqFhW9M+jxc3GMRfL2m1ffFuZ4ANyX
         XVynnx1WPPoAwaBTriQGjQ1txRgdtpuMnHzjuoHGSiy1EsAtYoYb607fr5cXb+cxEHWC
         7kqw==
X-Gm-Message-State: AOAM5317ppIRpZ07kAXTYRHIqSb8B/wzMoiSQiOiVzSV7xFs4Iy6+lja
        MpBzDNxfvZ9CBiNRhiQgPi+zsw==
X-Google-Smtp-Source: ABdhPJzN+PCJaoXKTjwyWOeOzAL3yJY5gxih8B6x40w+/EwGLaot+ApYFertdOKhrwoZ4OP8C9JY+w==
X-Received: by 2002:a05:6602:3c5:: with SMTP id g5mr616649iov.155.1644964810550;
        Tue, 15 Feb 2022 14:40:10 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id e17sm21924253ilm.67.2022.02.15.14.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 14:40:10 -0800 (PST)
Message-ID: <767d0af3-82cc-8e16-a4c6-b0854a518cd5@linaro.org>
Date:   Tue, 15 Feb 2022 16:40:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 21/25] bus: mhi: ep: Add support for reading from the
 host
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
 <20220212182117.49438-22-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220212182117.49438-22-manivannan.sadhasivam@linaro.org>
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

On 2/12/22 12:21 PM, Manivannan Sadhasivam wrote:
> Data transfer between host and the ep device happens over the transfer
> ring associated with each bi-directional channel pair. Host defines the
> transfer ring by allocating memory for it. The read and write pointer
> addresses of the transfer ring are stored in the channel context.
> 
> Once host places the elements in the transfer ring, it increments the
> write pointer and rings the channel doorbell. Device will receive the
> doorbell interrupt and will process the transfer ring elements.
> 
> This commit adds support for reading the transfer ring elements from
> the transfer ring till write pointer, incrementing the read pointer and
> finally sending the completion event to the host through corresponding
> event ring.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Indentation nits mentioned.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/bus/mhi/ep/main.c | 103 ++++++++++++++++++++++++++++++++++++++
>   include/linux/mhi_ep.h    |   9 ++++
>   2 files changed, 112 insertions(+)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 4c2ee517832c..b937c6cda9ba 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -336,6 +336,109 @@ int mhi_ep_process_cmd_ring(struct mhi_ep_ring *ring, struct mhi_ep_ring_element
>   	return ret;
>   }
>   
> +bool mhi_ep_queue_is_empty(struct mhi_ep_device *mhi_dev, enum dma_data_direction dir)
> +{
> +	struct mhi_ep_chan *mhi_chan = (dir == DMA_FROM_DEVICE) ? mhi_dev->dl_chan :
> +								mhi_dev->ul_chan;
> +	struct mhi_ep_cntrl *mhi_cntrl = mhi_dev->mhi_cntrl;
> +	struct mhi_ep_ring *ring = &mhi_cntrl->mhi_chan[mhi_chan->chan].ring;
> +
> +	return !!(ring->rd_offset == ring->wr_offset);
> +}
> +EXPORT_SYMBOL_GPL(mhi_ep_queue_is_empty);
> +
> +static int mhi_ep_read_channel(struct mhi_ep_cntrl *mhi_cntrl,
> +				struct mhi_ep_ring *ring,
> +				struct mhi_result *result,
> +				u32 len)
> +{
> +	struct mhi_ep_chan *mhi_chan = &mhi_cntrl->mhi_chan[ring->ch_id];
> +	size_t bytes_to_read, read_offset, write_offset;
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	struct mhi_ep_ring_element *el;
> +	bool td_done = false;
> +	void *write_to_loc;
> +	u64 read_from_loc;
> +	u32 buf_remaining;
> +	int ret;
> +
> +	buf_remaining = len;
> +
> +	do {
> +		/* Don't process the transfer ring if the channel is not in RUNNING state */
> +		if (mhi_chan->state != MHI_CH_STATE_RUNNING)
> +			return -ENODEV;
> +
> +		el = &ring->ring_cache[ring->rd_offset];
> +
> +		/* Check if there is data pending to be read from previous read operation */
> +		if (mhi_chan->tre_bytes_left) {
> +			dev_dbg(dev, "TRE bytes remaining: %d\n", mhi_chan->tre_bytes_left);
> +			bytes_to_read = min(buf_remaining, mhi_chan->tre_bytes_left);
> +		} else {
> +			mhi_chan->tre_loc = MHI_EP_TRE_GET_PTR(el);
> +			mhi_chan->tre_size = MHI_EP_TRE_GET_LEN(el);
> +			mhi_chan->tre_bytes_left = mhi_chan->tre_size;
> +
> +			bytes_to_read = min(buf_remaining, mhi_chan->tre_size);
> +		}
> +
> +		read_offset = mhi_chan->tre_size - mhi_chan->tre_bytes_left;
> +		write_offset = len - buf_remaining;
> +		read_from_loc = mhi_chan->tre_loc + read_offset;
> +		write_to_loc = result->buf_addr + write_offset;
> +
> +		dev_dbg(dev, "Reading %zd bytes from channel (%d)\n", bytes_to_read, ring->ch_id);
> +		ret = mhi_cntrl->read_from_host(mhi_cntrl, read_from_loc, write_to_loc,
> +						bytes_to_read);
> +		if (ret < 0)
> +			return ret;
> +
> +		buf_remaining -= bytes_to_read;
> +		mhi_chan->tre_bytes_left -= bytes_to_read;
> +
> +		/*
> +		 * Once the TRE (Transfer Ring Element) of a TD (Transfer Descriptor) has been
> +		 * read completely:
> +		 *
> +		 * 1. Send completion event to the host based on the flags set in TRE.
> +		 * 2. Increment the local read offset of the transfer ring.

Your comments in this section explain some things that
I did not completely understand for a *very* long time.
The same flags are used in IPA, but are not as well
documented as they are for MHI.

> +		 */
> +		if (!mhi_chan->tre_bytes_left) {
> +			/*
> +			 * The host will split the data packet into multiple TREs if it can't fit
> +			 * the packet in a single TRE. In that case, CHAIN flag will be set by the
> +			 * host for all TREs except the last one.
> +			 */
> +			if (MHI_EP_TRE_GET_CHAIN(el)) {
> +				/*
> +				 * IEOB (Interrupt on End of Block) flag will be set by the host if
> +				 * it expects the completion event for all TREs of a TD.
> +				 */
> +				if (MHI_EP_TRE_GET_IEOB(el))
> +					mhi_ep_send_completion_event(mhi_cntrl,
> +					ring, MHI_EP_TRE_GET_LEN(el), MHI_EV_CC_EOB);

Check your indentation above.

> +			} else {
> +				/*
> +				 * IEOT (Interrupt on End of Transfer) flag will be set by the host
> +				 * for the last TRE of the TD and expects the completion event for
> +				 * the same.
> +				 */
> +				if (MHI_EP_TRE_GET_IEOT(el))
> +					mhi_ep_send_completion_event(mhi_cntrl,
> +					ring, MHI_EP_TRE_GET_LEN(el), MHI_EV_CC_EOT);

Indentation here too.

> +				td_done = true;
> +			}
> +
> +			mhi_ep_ring_inc_index(ring);
> +		}
> +
> +		result->bytes_xferd += bytes_to_read;
> +	} while (buf_remaining && !td_done);
> +
> +	return 0;
> +}
> +
>   static int mhi_ep_cache_host_cfg(struct mhi_ep_cntrl *mhi_cntrl)
>   {
>   	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
> index 276d29fef465..aaf4b6942037 100644
> --- a/include/linux/mhi_ep.h
> +++ b/include/linux/mhi_ep.h
> @@ -268,4 +268,13 @@ int mhi_ep_power_up(struct mhi_ep_cntrl *mhi_cntrl);
>    */
>   void mhi_ep_power_down(struct mhi_ep_cntrl *mhi_cntrl);
>   
> +/**
> + * mhi_ep_queue_is_empty - Determine whether the transfer queue is empty
> + * @mhi_dev: Device associated with the channels
> + * @dir: DMA direction for the channel
> + *
> + * Return: true if the queue is empty, false otherwise.
> + */
> +bool mhi_ep_queue_is_empty(struct mhi_ep_device *mhi_dev, enum dma_data_direction dir);
> +
>   #endif

