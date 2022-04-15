Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BE2501FC6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 02:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348110AbiDOAta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 20:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbiDOAt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 20:49:28 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33D9B822D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:47:00 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id m8so7977026ljc.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=csxGDJowjwfPfYbPWapMKvmutL0jsjVI2/38LVM08ks=;
        b=YEZiGpver9sFJAEaj/Wlc4KH7/QjuuTQm2INVtXsCnOkKyaMHHV1B/AAm8WGVpIXk7
         0mzrr4pHLliyFt4W/TtUbcGNt5ksYaZFWIoHKEfsC5c2np5ZrRJHb0DGd3WWVWu7NXeA
         mBEU9/Pyv+9Ihhrwh7Tv3nwTrZBtqFFWoR+D2eHXew++ORh8dY5Lbvct+tUEJMHt8Qhq
         /+0modCBYvkaxfVGNr2OcPuBF/yIfAY48MqAdz2eOuUOLF/7Z/ZMdrswEWrT5jpgF78B
         cF+tCvv/CY4HHtzt8UdZn94RJm+pNsvWyAt9Ok16y1RwGnd1wcboD1VmP+P6SsvaQyIZ
         3EMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=csxGDJowjwfPfYbPWapMKvmutL0jsjVI2/38LVM08ks=;
        b=7FU6MFR+/vtTWA8VQALf2gL2KbEUyJjT00twFtdrYCwrblua2OXYsoQh5Rt0AUUnr3
         MlQc1PQjV5fOLELXng1h63Oj0S8/XlkhNGZ2Z/3QCL84ThYFu1QZ5uhjBJjld8QYV8cA
         LCxwiY1s6aKkxYb1LsNMCDor4qOLYwDkxEzqkgCD/BL9i/MM1lvPsm0NIf5NgmUiqroE
         Ez9CaW/WHQErETRqd/SIzVn7F0F+MDrZq1gz6S9dbiwggoQjd8+fiXuLKxFeGehsAl65
         Ns8Xdq+rrH+ZO1F6LqhepSvTX3I121meEYhK6anmISwGD/M2lbgR+rQ4xEV7oasko5Uk
         38Yw==
X-Gm-Message-State: AOAM533VM9uOt7kI+5qrV+fzJgOR3xvb1Vc6JdvP1v8X3FCHFmYU3Nea
        MlLTQm2HTCkissEBPtDENntldA==
X-Google-Smtp-Source: ABdhPJz8ARF1bAttr+X+fmpQu7JeALGm9/J2SuNy0Vpm6dv70D2A/C7tDUMqp9sKKWsLpLzVIesHAA==
X-Received: by 2002:a2e:3a1a:0:b0:24b:59d4:7006 with SMTP id h26-20020a2e3a1a000000b0024b59d47006mr3024682lja.392.1649983618953;
        Thu, 14 Apr 2022 17:46:58 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z24-20020a0565120c1800b0044add225193sm156525lfu.228.2022.04.14.17.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 17:46:58 -0700 (PDT)
Message-ID: <a9a5dfb7-819b-d3a2-2c47-d5b239d21ad3@linaro.org>
Date:   Fri, 15 Apr 2022 03:46:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RFC PATCH 1/6] drm/dp: Helpers to make it easier for drivers to
 use DP AUX bus properly
Content-Language: en-GB
To:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org
Cc:     Robert Foss <robert.foss@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lyude Paul <lyude@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
References: <20220409023628.2104952-1-dianders@chromium.org>
 <20220408193536.RFC.1.I4182ae27e00792842cb86f1433990a0ef9c0a073@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220408193536.RFC.1.I4182ae27e00792842cb86f1433990a0ef9c0a073@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2022 05:36, Douglas Anderson wrote:
> As talked about in the kerneldoc for "struct dp_aux_ep_client" in this
> patch and also in the past in commit a1e3667a9835 ("drm/bridge:
> ti-sn65dsi86: Promote the AUX channel to its own sub-dev"), to use the
> DP AUX bus properly we really need two "struct device"s. One "struct
> device" is in charge of providing the DP AUX bus and the other is
> where we'll try to get a reference to the newly probed endpoint
> devices.
> 
> In ti-sn65dsi86 this wasn't too difficult to accomplish. That driver
> is already broken up into several "struct devices" anyway because it
> also provides a PWM and some GPIOs. Adding one more wasn't that
> difficult / ugly.
> 
> When I tried to do the same solution in parade-ps8640, it felt like I
> was copying too much boilerplate code. I made the realization that I
> didn't _really_ need a separate "driver" for each person that wanted
> to do the same thing. By putting all the "driver" related code in a
> common place then we could save a bit of hassle. This change
> effectively adds a new "ep_client" driver that can be used by
> anyone. The devices instantiated by this driver will just call through
> to the probe/remove/shutdown calls provided.
> 
> At the moment, the "ep_client" driver is backed by the Linux auxiliary
> bus (unfortunate naming--this has nothing to do with DP AUX). I didn't
> want to expose this to clients, though, so as far as clients are
> concerned they get a vanilla "struct device".

I have been thinking about your approach for quite some time. I think 
that enforcing a use of auxilliary device is an overkill. What do we 
really need is the the set callbacks in the bus struct or a notifier. We 
have to notify the aux_bus controller side that the client has been 
probed successfully or that the client is going to be removed. And this 
approach would make driver's life easier, since e.g. the bus code can 
pm_get the EP device before calling callbacks/notifiers and 
pm_put_autosuspend it afterwards.

> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>   drivers/gpu/drm/dp/drm_dp_aux_bus.c | 165 +++++++++++++++++++++++++++-
>   include/drm/dp/drm_dp_aux_bus.h     |  58 ++++++++++
>   2 files changed, 222 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/dp/drm_dp_aux_bus.c b/drivers/gpu/drm/dp/drm_dp_aux_bus.c
> index 415afce3cf96..5386ceacf133 100644
> --- a/drivers/gpu/drm/dp/drm_dp_aux_bus.c
> +++ b/drivers/gpu/drm/dp/drm_dp_aux_bus.c
> @@ -12,6 +12,7 @@
>    * to perform transactions on that bus.
>    */
>   
> +#include <linux/auxiliary_bus.h>
>   #include <linux/init.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
> @@ -299,6 +300,163 @@ void dp_aux_dp_driver_unregister(struct dp_aux_ep_driver *drv)
>   }
>   EXPORT_SYMBOL_GPL(dp_aux_dp_driver_unregister);
>   
> +/* -----------------------------------------------------------------------------
> + * DP AUX EP Client
> + */
> +
> +struct dp_aux_ep_client_data {
> +	struct dp_aux_ep_client *client;
> +	struct auxiliary_device adev;
> +};
> +
> +static int dp_aux_ep_client_probe(struct auxiliary_device *adev,
> +				  const struct auxiliary_device_id *id)
> +{
> +	struct dp_aux_ep_client_data *data =
> +		container_of(adev, struct dp_aux_ep_client_data, adev);
> +
> +	if (!data->client->probe)
> +		return 0;
> +
> +	return data->client->probe(&adev->dev, data->client);
> +}
> +
> +static void dp_aux_ep_client_remove(struct auxiliary_device *adev)
> +{
> +	struct dp_aux_ep_client_data *data =
> +		container_of(adev, struct dp_aux_ep_client_data, adev);
> +
> +	if (data->client->remove)
> +		data->client->remove(&adev->dev, data->client);
> +}
> +
> +static void dp_aux_ep_client_shutdown(struct auxiliary_device *adev)
> +{
> +	struct dp_aux_ep_client_data *data =
> +		container_of(adev, struct dp_aux_ep_client_data, adev);
> +
> +	if (data->client->shutdown)
> +		data->client->shutdown(&adev->dev, data->client);
> +}
> +
> +static void dp_aux_ep_client_dev_release(struct device *dev)
> +{
> +	struct auxiliary_device *adev = to_auxiliary_dev(dev);
> +	struct dp_aux_ep_client_data *data =
> +		container_of(adev, struct dp_aux_ep_client_data, adev);
> +
> +	kfree(data);
> +}
> +
> +/**
> + * dp_aux_register_ep_client() - Register an DP AUX EP client
> + * @client: The structure describing the client. It's the client's
> + *          responsibility to keep this memory around until
> + *          dp_aux_unregister_ep_client() is called, either explicitly or
> + *          implicitly via devm.
> + *
> + * See the description of "struct dp_aux_ep_client" for a full explanation
> + * of when you should use this and why.
> + *
> + * Return: 0 if no error or negative error code.
> + */
> +int dp_aux_register_ep_client(struct dp_aux_ep_client *client)
> +{
> +	struct dp_aux_ep_client_data *data;
> +	int ret;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->client = client;
> +	data->adev.name = "ep_client";
> +	data->adev.dev.parent = client->aux->dev;
> +	data->adev.dev.release = dp_aux_ep_client_dev_release;
> +	device_set_of_node_from_dev(&data->adev.dev, client->aux->dev);
> +
> +	ret = auxiliary_device_init(&data->adev);
> +	if (ret) {
> +		/*
> +		 * NOTE: if init doesn't fail then it takes ownership
> +		 * of memory and this kfree() is magically part of
> +		 * auxiliary_device_uninit().
> +		 */
> +		kfree(data);
> +		return ret;
> +	}
> +
> +	ret = auxiliary_device_add(&data->adev);
> +	if (ret)
> +		goto err_did_init;
> +
> +	client->_opaque = data;
> +
> +	return 0;
> +
> +err_did_init:
> +	auxiliary_device_uninit(&data->adev);
> +	return ret;
> +}
> +
> +/**
> + * dp_aux_unregister_ep_client() - Inverse of dp_aux_register_ep_client()
> + * @client: The structure describing the client.
> + *
> + * If dp_aux_register_ep_client() returns no error then you should call this
> + * to free resources.
> + */
> +void dp_aux_unregister_ep_client(struct dp_aux_ep_client *client)
> +{
> +	struct dp_aux_ep_client_data *data = client->_opaque;
> +
> +	auxiliary_device_delete(&data->adev);
> +	auxiliary_device_uninit(&data->adev);
> +}
> +
> +static void dp_aux_unregister_ep_client_void(void *data)
> +{
> +	dp_aux_unregister_ep_client(data);
> +}
> +
> +/**
> + * devm_dp_aux_register_ep_client() - devm wrapper for dp_aux_register_ep_client()
> + * @client: The structure describing the client.
> + *
> + * Handles freeing w/ devm on the device "client->aux->dev".
> + *
> + * Return: 0 if no error or negative error code.
> + */
> +int devm_dp_aux_register_ep_client(struct dp_aux_ep_client *client)
> +{
> +	int ret;
> +
> +	ret = dp_aux_register_ep_client(client);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(client->aux->dev,
> +					dp_aux_unregister_ep_client_void,
> +					client);
> +}
> +
> +static const struct auxiliary_device_id dp_aux_ep_client_id_table[] = {
> +	{ .name = "drm_dp_aux_bus.ep_client", },
> +	{},
> +};
> +
> +static struct auxiliary_driver dp_aux_ep_client_driver = {
> +	.name = "ep_client",
> +	.probe = dp_aux_ep_client_probe,
> +	.remove = dp_aux_ep_client_remove,
> +	.shutdown = dp_aux_ep_client_shutdown,
> +	.id_table = dp_aux_ep_client_id_table,
> +};
> +
> +/* -----------------------------------------------------------------------------
> + * Module init
> + */
> +
>   static int __init dp_aux_bus_init(void)
>   {
>   	int ret;
> @@ -307,11 +465,16 @@ static int __init dp_aux_bus_init(void)
>   	if (ret)
>   		return ret;
>   
> -	return 0;
> +	ret = auxiliary_driver_register(&dp_aux_ep_client_driver);
> +	if (ret)
> +		bus_unregister(&dp_aux_bus_type);
> +
> +	return ret;
>   }
>   
>   static void __exit dp_aux_bus_exit(void)
>   {
> +	auxiliary_driver_unregister(&dp_aux_ep_client_driver);
>   	bus_unregister(&dp_aux_bus_type);
>   }
>   
> diff --git a/include/drm/dp/drm_dp_aux_bus.h b/include/drm/dp/drm_dp_aux_bus.h
> index 4f19b20b1dd6..ecf68b6873bd 100644
> --- a/include/drm/dp/drm_dp_aux_bus.h
> +++ b/include/drm/dp/drm_dp_aux_bus.h
> @@ -54,4 +54,62 @@ int __dp_aux_dp_driver_register(struct dp_aux_ep_driver *aux_ep_drv,
>   				struct module *owner);
>   void dp_aux_dp_driver_unregister(struct dp_aux_ep_driver *aux_ep_drv);
>   
> +/**
> + * struct dp_aux_ep_device - Helper for clients of DP AUX EP devices
> + *
> + * The DP AUX bus can be a bit tricky to use properly. Usually, the way
> + * things work is that:
> + * - The DP controller driver provides the DP AUX bus and would like to probe
> + *   the endpoints on the DP AUX bus (AKA the panel) as part of its probe
> + *   routine.
> + * - The DP controller driver would also like to acquire a reference to the
> + *   DP AUX endpoints (AKA the panel) as part of its probe.
> + *
> + * The problem is that the DP AUX endpoints aren't guaranteed to complete their
> + * probe right away. They could be probing asynchronously or they simply might
> + * fail to acquire some resource and return -EPROBE_DEFER.
> + *
> + * The best way to solve this is to break the DP controller's probe into
> + * two parts. The first part will create the DP AUX bus. The second part will
> + * acquire the reference to the DP AUX endpoint. The first part can complete
> + * finish with no problems and be "done" even if the second part ends up
> + * deferring while waiting for the DP AUX endpoint.
> + *
> + * The dp_aux_ep_client structure and associated functions help with managing
> + * this common case. They will create/add a second "struct device" for you.
> + * In the probe for this second "struct device" (known as the "clientdev" here)
> + * you can acquire references to the AUX DP endpoints and can freely return
> + * -EPROBE_DEFER if they're not ready yet.
> + *
> + * A few notes:
> + * - The parent of the clientdev is guaranteed to be aux->dev
> + * - The of_node of the clientdev is guaranteed to be the same as the of_node
> + *   of aux->dev, copied with device_set_of_node_from_dev().
> + * - If you're doing "devm" type things in the clientdev's probe you should
> + *   use the clientdev. This makes lifetimes be managed properly.
> + *
> + * NOTE: there's no requirement to use these helpers if you have solved the
> + * problem described above in some other way.
> + */
> +struct dp_aux_ep_client {
> +	/** @probe: The second half of the probe */
> +	int (*probe)(struct device *clientdev, struct dp_aux_ep_client *client);
> +
> +	/** @remove: Remove function corresponding to the probe */
> +	void (*remove)(struct device *clientdev, struct dp_aux_ep_client *client);
> +
> +	/** @shutdown: Shutdown function corresponding to the probe */
> +	void (*shutdown)(struct device *clientdev, struct dp_aux_ep_client *client);
> +
> +	/** @aux: The AUX bus */
> +	struct drm_dp_aux *aux;
> +
> +	/** @_opaque: Used by the implementation */
> +	void *_opaque;
> +};
> +
> +int dp_aux_register_ep_client(struct dp_aux_ep_client *client);
> +void dp_aux_unregister_ep_client(struct dp_aux_ep_client *client);
> +int devm_dp_aux_register_ep_client(struct dp_aux_ep_client *client);
> +
>   #endif /* _DP_AUX_BUS_H_ */


-- 
With best wishes
Dmitry
