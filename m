Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AA84C7154
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbiB1QJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbiB1QJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:09:58 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FEC48390
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:09:19 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id y5so10301308ill.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=O0H+TecCDmXx7RnmxXZU0mHLmQoXxcExT+Opk1joW0Y=;
        b=FPgXaXPE0eplgBTiBfeqaRL8iabntcduK4elYOjyB9wyJHBzY68pjbatEI3YfOrlM9
         df7M9JImAhxSBQt25bR1MPok7gukpDGgSP7fTOr3tJGTPTstSCjwvHaxzrGZbENe/H25
         Oz/JLQ1GVezTJv3E80RaIkuGmuTRKqyvD9OhH6pmoweDPtzICY/qjHc49jGGoR3PpqkR
         4FHL+nmAe7dnFptj8uTLsFXxhLLzejBMH4rvK1kRQDtnS1kyA4SAYoAlQ8OuoqOBvJgQ
         ejGeSKRr+kNB6BOmvF8BjxMmyxeA9tapRJ5rRYSZpx2qCATEAVe9FWoMSbV/Drs2bHQd
         dbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O0H+TecCDmXx7RnmxXZU0mHLmQoXxcExT+Opk1joW0Y=;
        b=4wvMFCP4F3TWY3eBqBhwJ4CiXwy5JjyVkQWMERcBNjge5v4RrScC7qA2uc/XTcjxGc
         SVdX4HCsQCZzeOT/aOsqnQ4tzcdneAxCP5wJcrD4nlP6IiXIZR2H4fw4cQUhVluX4ufV
         pZk34p+SiQndPRIooyvzkPUiFj3bdCH9h/usDPE7AW3s/WBpDOd0V9lUhfeinY1kTov7
         76AUMxnIVX5Vs68cIbFYbxWnZhwJgsTyzl+vDj5wXqneKYIat1APkQ+OeZoqk/2JJl1G
         7MefIHdVYUzF60olCEiZnAG/BDWI3dPfYztbKwD3kmMrqiEybocFoNUTjWHVB6nYVW11
         6Nuw==
X-Gm-Message-State: AOAM532x9baEp3DVX4oLS21XoVKFyOmSjc6/aQpCe59SEWAtWI+pyb2E
        NcAxZScZXa3YQMfDu/ksxWWvCA==
X-Google-Smtp-Source: ABdhPJzCCVq6NYp2+fiRUXN/TeTnC5Qrb/yBvZQJMa5Ie6VZ2FoOg4nWKn5bJbCkURK4yTIolU2Qzw==
X-Received: by 2002:a05:6e02:1d95:b0:2bf:9dd:3225 with SMTP id h21-20020a056e021d9500b002bf09dd3225mr19282886ila.89.1646064558425;
        Mon, 28 Feb 2022 08:09:18 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id v3-20020a5d9483000000b00640d3d4acabsm5778775ioj.44.2022.02.28.08.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 08:09:17 -0800 (PST)
Message-ID: <6657446f-b050-a525-b77f-0538ee995fcc@linaro.org>
Date:   Mon, 28 Feb 2022 10:09:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 11/27] bus: mhi: ep: Add support for registering MHI
 endpoint client drivers
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hemant Kumar <hemantk@codeaurora.org>
References: <20220228124344.77359-1-manivannan.sadhasivam@linaro.org>
 <20220228124344.77359-12-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220228124344.77359-12-manivannan.sadhasivam@linaro.org>
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
> This commit adds support for registering MHI endpoint client drivers
> with the MHI endpoint stack. MHI endpoint client drivers bind to one
> or more MHI endpoint devices inorder to send and receive the upper-layer
> protocol packets like IP packets, modem control messages, and
> diagnostics messages over MHI bus.
> 
> Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/bus/mhi/ep/main.c | 85 +++++++++++++++++++++++++++++++++++++++
>   include/linux/mhi_ep.h    | 57 +++++++++++++++++++++++++-
>   2 files changed, 140 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 87ca42c7b067..2bdcf1657479 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -198,9 +198,88 @@ void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl)
>   }
>   EXPORT_SYMBOL_GPL(mhi_ep_unregister_controller);
>   
> +static int mhi_ep_driver_probe(struct device *dev)
> +{
> +	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
> +	struct mhi_ep_driver *mhi_drv = to_mhi_ep_driver(dev->driver);
> +	struct mhi_ep_chan *ul_chan = mhi_dev->ul_chan;
> +	struct mhi_ep_chan *dl_chan = mhi_dev->dl_chan;
> +
> +	ul_chan->xfer_cb = mhi_drv->ul_xfer_cb;
> +	dl_chan->xfer_cb = mhi_drv->dl_xfer_cb;
> +
> +	return mhi_drv->probe(mhi_dev, mhi_dev->id);
> +}
> +
> +static int mhi_ep_driver_remove(struct device *dev)
> +{
> +	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
> +	struct mhi_ep_driver *mhi_drv = to_mhi_ep_driver(dev->driver);
> +	struct mhi_result result = {};
> +	struct mhi_ep_chan *mhi_chan;
> +	int dir;
> +
> +	/* Skip if it is a controller device */
> +	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
> +		return 0;
> +
> +	/* Disconnect the channels associated with the driver */
> +	for (dir = 0; dir < 2; dir++) {
> +		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
> +
> +		if (!mhi_chan)
> +			continue;
> +
> +		mutex_lock(&mhi_chan->lock);
> +		/* Send channel disconnect status to the client driver */
> +		if (mhi_chan->xfer_cb) {
> +			result.transaction_status = -ENOTCONN;
> +			result.bytes_xferd = 0;
> +			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
> +		}
> +
> +		mhi_chan->state = MHI_CH_STATE_DISABLED;
> +		mhi_chan->xfer_cb = NULL;
> +		mutex_unlock(&mhi_chan->lock);
> +	}
> +
> +	/* Remove the client driver now */
> +	mhi_drv->remove(mhi_dev);
> +
> +	return 0;
> +}
> +
> +int __mhi_ep_driver_register(struct mhi_ep_driver *mhi_drv, struct module *owner)
> +{
> +	struct device_driver *driver = &mhi_drv->driver;
> +
> +	if (!mhi_drv->probe || !mhi_drv->remove)
> +		return -EINVAL;
> +
> +	/* Client drivers should have callbacks defined for both channels */
> +	if (!mhi_drv->ul_xfer_cb || !mhi_drv->dl_xfer_cb)
> +		return -EINVAL;
> +
> +	driver->bus = &mhi_ep_bus_type;
> +	driver->owner = owner;
> +	driver->probe = mhi_ep_driver_probe;
> +	driver->remove = mhi_ep_driver_remove;
> +
> +	return driver_register(driver);
> +}
> +EXPORT_SYMBOL_GPL(__mhi_ep_driver_register);
> +
> +void mhi_ep_driver_unregister(struct mhi_ep_driver *mhi_drv)
> +{
> +	driver_unregister(&mhi_drv->driver);
> +}
> +EXPORT_SYMBOL_GPL(mhi_ep_driver_unregister);
> +
>   static int mhi_ep_match(struct device *dev, struct device_driver *drv)
>   {
>   	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
> +	struct mhi_ep_driver *mhi_drv = to_mhi_ep_driver(drv);
> +	const struct mhi_device_id *id;
>   
>   	/*
>   	 * If the device is a controller type then there is no client driver
> @@ -209,6 +288,12 @@ static int mhi_ep_match(struct device *dev, struct device_driver *drv)
>   	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
>   		return 0;
>   
> +	for (id = mhi_drv->id_table; id->chan[0]; id++)
> +		if (!strcmp(mhi_dev->name, id->chan)) {
> +			mhi_dev->id = id;
> +			return 1;
> +		}
> +
>   	return 0;
>   };
>   
> diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
> index 9c58938371e2..efcbdc51464f 100644
> --- a/include/linux/mhi_ep.h
> +++ b/include/linux/mhi_ep.h
> @@ -108,8 +108,8 @@ struct mhi_ep_cntrl {
>    * @mhi_cntrl: Controller the device belongs to
>    * @id: Pointer to MHI Endpoint device ID struct
>    * @name: Name of the associated MHI Endpoint device
> - * @ul_chan: UL channel for the device
> - * @dl_chan: DL channel for the device
> + * @ul_chan: UL (from host to endpoint) channel for the device
> + * @dl_chan: DL (from endpoint to host) channel for the device
>    * @dev_type: MHI device type
>    */
>   struct mhi_ep_device {
> @@ -122,7 +122,60 @@ struct mhi_ep_device {
>   	enum mhi_device_type dev_type;
>   };
>   
> +/**
> + * struct mhi_ep_driver - Structure representing a MHI Endpoint client driver
> + * @id_table: Pointer to MHI Endpoint device ID table
> + * @driver: Device driver model driver
> + * @probe: CB function for client driver probe function
> + * @remove: CB function for client driver remove function
> + * @ul_xfer_cb: CB function for UL (from host to endpoint) data transfer
> + * @dl_xfer_cb: CB function for DL (from endpoint to host) data transfer
> + */
> +struct mhi_ep_driver {
> +	const struct mhi_device_id *id_table;
> +	struct device_driver driver;
> +	int (*probe)(struct mhi_ep_device *mhi_ep,
> +		     const struct mhi_device_id *id);
> +	void (*remove)(struct mhi_ep_device *mhi_ep);
> +	void (*ul_xfer_cb)(struct mhi_ep_device *mhi_dev,
> +			   struct mhi_result *result);
> +	void (*dl_xfer_cb)(struct mhi_ep_device *mhi_dev,
> +			   struct mhi_result *result);
> +};
> +
>   #define to_mhi_ep_device(dev) container_of(dev, struct mhi_ep_device, dev)
> +#define to_mhi_ep_driver(drv) container_of(drv, struct mhi_ep_driver, driver)
> +
> +/*
> + * module_mhi_ep_driver() - Helper macro for drivers that don't do
> + * anything special other than using default mhi_ep_driver_register() and
> + * mhi_ep_driver_unregister().  This eliminates a lot of boilerplate.
> + * Each module may only use this macro once.
> + */
> +#define module_mhi_ep_driver(mhi_drv) \
> +	module_driver(mhi_drv, mhi_ep_driver_register, \
> +		      mhi_ep_driver_unregister)
> +
> +/*
> + * Macro to avoid include chaining to get THIS_MODULE
> + */
> +#define mhi_ep_driver_register(mhi_drv) \
> +	__mhi_ep_driver_register(mhi_drv, THIS_MODULE)
> +
> +/**
> + * __mhi_ep_driver_register - Register a driver with MHI Endpoint bus
> + * @mhi_drv: Driver to be associated with the device
> + * @owner: The module owner
> + *
> + * Return: 0 if driver registrations succeeds, a negative error code otherwise.
> + */
> +int __mhi_ep_driver_register(struct mhi_ep_driver *mhi_drv, struct module *owner);
> +
> +/**
> + * mhi_ep_driver_unregister - Unregister a driver from MHI Endpoint bus
> + * @mhi_drv: Driver associated with the device
> + */
> +void mhi_ep_driver_unregister(struct mhi_ep_driver *mhi_drv);
>   
>   /**
>    * mhi_ep_register_controller - Register MHI Endpoint controller

