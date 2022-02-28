Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD60C4C71F9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238034AbiB1QwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238030AbiB1QwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:52:21 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4893385BFB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:51:42 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id c14so10459638ilm.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/bqp6/Y5E+6C6uxZOlWzzrVva8/H/F52MQlVhPx5vwc=;
        b=HBn7i/YYpsZX/wNCJnrPjD2O8Xmo5l2miL6iOcqOsIqLLghx14BXGlCABXIjiFzQHK
         vigb37Jjd4IxUUA8OGomc6Q+rPMUxX51QHkjDDA1qCkTsHvMGzBHs0+RFJugzFvlCcYQ
         K6mm+0iKnBRm8Xcwp8cmF81IP7IcKE0l5rSRlzTCLO1WM7+cs2E0aQVTaBHncce0DzS8
         JH7CHqDETujp+vRf7Wgzsz917aGgXDGSOF+ymwIWcaIbzMlv/BECDc36WwgIie8IIppY
         6iQXxIAhwN48dFD5eJ++1VFCvhPQ+YrJYsWtW6y56RofbB5PZZ4RT4bK4jxLFjR52nTC
         graA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/bqp6/Y5E+6C6uxZOlWzzrVva8/H/F52MQlVhPx5vwc=;
        b=qjkOp+R9IOy0ZnLSh7bgk9Hw+28OwjyqBcc/UmFPPwKsSwix2ynt7JjdIQnlr7vjVC
         7bV92B+zp+9J5S8n9iHXgJkDkzKJyQ5aPROKYP8XXbq5Sqg4fi7cUwwj0w27vfkDAbJA
         l0zUs8D/b5MQdKDFtH7LX6KqdmDKCLw2K2SYNLAHC9LxI8j85DBvVjyQKsKUN2tS3VUR
         8750FV8nybAobQ7yMCbyyT0F4L/Nnhy9ViT5DqVcmDUqTnBSHZrVoSrbbEiALxl3xOqP
         n6o+YIVKDrefBfY2FX6PtK+w+fZMtWbM9LEehQtdv2ac9JXfG+Rql9/odJd3SaDqk4br
         oNGA==
X-Gm-Message-State: AOAM532VZgNdI8zW78VmRM43SGTgodqWo6ft/2cbnTm2Y65z7YudGqxE
        NP3q6SmDwuQMKtEHcikeTxqTMw==
X-Google-Smtp-Source: ABdhPJzA6KBRxUY54trdttvAnTbELspEPLPtKc7uMUdQexvEucvC6Zek9BCgXVfF5iW2ibbZ+CcYyg==
X-Received: by 2002:a92:c691:0:b0:2be:8eab:9f7d with SMTP id o17-20020a92c691000000b002be8eab9f7dmr19702513ilg.26.1646067101657;
        Mon, 28 Feb 2022 08:51:41 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id 6-20020a056e0211a600b002c2494a5479sm6545385ilj.2.2022.02.28.08.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 08:51:41 -0800 (PST)
Message-ID: <1f301669-3d4c-dc79-a35b-7faf2c6045e9@linaro.org>
Date:   Mon, 28 Feb 2022 10:51:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 25/27] bus: mhi: ep: Add support for queueing SKBs to
 the host
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
 <20220228124344.77359-26-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220228124344.77359-26-manivannan.sadhasivam@linaro.org>
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
> Add support for queueing SKBs to the host over the transfer ring of the
> relevant channel. The mhi_ep_queue_skb() API will be used by the client
> networking drivers to queue the SKBs to the host over MHI bus.
> 
> The host will add ring elements to the transfer ring periodically for
> the device and the device will write SKBs to the ring elements. If a
> single SKB doesn't fit in a ring element (TRE), it will be placed in
> multiple ring elements and the overflow event will be sent for all ring
> elements except the last one. For the last ring element, the EOT event
> will be sent indicating the packet boundary.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/bus/mhi/ep/main.c | 82 +++++++++++++++++++++++++++++++++++++++
>   include/linux/mhi_ep.h    |  9 +++++
>   2 files changed, 91 insertions(+)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 63e14d55aa06..25d34cf26fd7 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -471,6 +471,88 @@ int mhi_ep_process_ch_ring(struct mhi_ep_ring *ring, struct mhi_ring_element *el
>   	return 0;
>   }
>   
> +/* TODO: Handle partially formed TDs */
> +int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
> +{
> +	struct mhi_ep_cntrl *mhi_cntrl = mhi_dev->mhi_cntrl;
> +	struct mhi_ep_chan *mhi_chan = mhi_dev->dl_chan;
> +	struct device *dev = &mhi_chan->mhi_dev->dev;
> +	struct mhi_ring_element *el;
> +	u32 buf_left, read_offset;
> +	struct mhi_ep_ring *ring;
> +	enum mhi_ev_ccs code;
> +	void *read_addr;
> +	u64 write_addr;
> +	size_t tr_len;
> +	u32 tre_len;
> +	int ret;
> +
> +	buf_left = skb->len;
> +	ring = &mhi_cntrl->mhi_chan[mhi_chan->chan].ring;
> +
> +	mutex_lock(&mhi_chan->lock);
> +
> +	do {
> +		/* Don't process the transfer ring if the channel is not in RUNNING state */
> +		if (mhi_chan->state != MHI_CH_STATE_RUNNING) {
> +			dev_err(dev, "Channel not available\n");
> +			ret = -ENODEV;
> +			goto err_exit;
> +		}
> +
> +		if (mhi_ep_queue_is_empty(mhi_dev, DMA_FROM_DEVICE)) {
> +			dev_err(dev, "TRE not available!\n");
> +			ret = -ENOSPC;
> +			goto err_exit;
> +		}
> +
> +		el = &ring->ring_cache[ring->rd_offset];
> +		tre_len = MHI_TRE_DATA_GET_LEN(el);
> +
> +		tr_len = min(buf_left, tre_len);
> +		read_offset = skb->len - buf_left;
> +		read_addr = skb->data + read_offset;
> +		write_addr = MHI_TRE_DATA_GET_PTR(el);
> +
> +		dev_dbg(dev, "Writing %zd bytes to channel (%u)\n", tr_len, ring->ch_id);
> +		ret = mhi_cntrl->write_to_host(mhi_cntrl, read_addr, write_addr, tr_len);
> +		if (ret < 0) {
> +			dev_err(dev, "Error writing to the channel\n");
> +			goto err_exit;
> +		}
> +
> +		buf_left -= tr_len;
> +		/*
> +		 * For all TREs queued by the host for DL channel, only the EOT flag will be set.
> +		 * If the packet doesn't fit into a single TRE, send the OVERFLOW event to
> +		 * the host so that the host can adjust the packet boundary to next TREs. Else send
> +		 * the EOT event to the host indicating the packet boundary.
> +		 */
> +		if (buf_left)
> +			code = MHI_EV_CC_OVERFLOW;
> +		else
> +			code = MHI_EV_CC_EOT;
> +
> +		ret = mhi_ep_send_completion_event(mhi_cntrl, ring, el, tr_len, code);
> +		if (ret) {
> +			dev_err(dev, "Error sending transfer completion event\n");
> +			goto err_exit;
> +		}
> +
> +		mhi_ep_ring_inc_index(ring);
> +	} while (buf_left);
> +
> +	mutex_unlock(&mhi_chan->lock);
> +
> +	return 0;
> +
> +err_exit:
> +	mutex_unlock(&mhi_chan->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(mhi_ep_queue_skb);
> +
>   static int mhi_ep_cache_host_cfg(struct mhi_ep_cntrl *mhi_cntrl)
>   {
>   	size_t cmd_ctx_host_size, ch_ctx_host_size, ev_ctx_host_size;
> diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
> index 74170dad09f6..bd3ffde01f04 100644
> --- a/include/linux/mhi_ep.h
> +++ b/include/linux/mhi_ep.h
> @@ -272,4 +272,13 @@ void mhi_ep_power_down(struct mhi_ep_cntrl *mhi_cntrl);
>    */
>   bool mhi_ep_queue_is_empty(struct mhi_ep_device *mhi_dev, enum dma_data_direction dir);
>   
> +/**
> + * mhi_ep_queue_skb - Send SKBs to host over MHI Endpoint
> + * @mhi_dev: Device associated with the DL channel
> + * @skb: SKBs to be queued
> + *
> + * Return: 0 if the SKBs has been sent successfully, a negative error code otherwise.
> + */
> +int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb);
> +
>   #endif

