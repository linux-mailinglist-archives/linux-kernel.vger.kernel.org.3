Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0471E55DEED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240896AbiF0VFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 17:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239752AbiF0VFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 17:05:17 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CA3BE21;
        Mon, 27 Jun 2022 14:05:16 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id h85so10946819iof.4;
        Mon, 27 Jun 2022 14:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Vz+PIAaZ/qnk8nyNJa+zdscW6Bv7pgzaLQ1N3O646A=;
        b=fb8+D+yNUn8PFpbBCK2tOaynmaUkCmyisKNHU4wp+0l44GMrZnA7sk1Hug7FPbXsK3
         GWxs+eggF3HrzBOwaBq/s72HDMIluF7IJZrXgcx71gA17A0919tc7feK+nJeuyeVTED9
         cDHwgChUeF3Ylgf9Dsos807/ggRLqbbnFJ0/AwP/m9udsfELHX+ZmticY7VwsM68v4gi
         /aYm0ZiutyUcOTIw4ck2xAxI3yIaUYE2QLxrPAgMkWzgu2lwZd8h2nqJqKJ1a2sMhYxs
         yGv9WlwcjssVaocue43u0fPKQ+82Yhr9zBwkrb6QxbWjRc/VIcbkTT0EdAkrP9bD+ZOu
         CMcA==
X-Gm-Message-State: AJIora8mpLQAoOl33sgcqS6iWOfQCRD4KfAX61v8AhE/rkrL7cf0WX5K
        Q4TE5MNIEsyykEtKRkZWJA==
X-Google-Smtp-Source: AGRyM1vd1hXiT92FmmZEOLGUlOXC2cFf/xqKvRpLsJL6tDRsS+f6gzt0eb8Fg2+4cpBZmPRJbrsmGQ==
X-Received: by 2002:a05:6638:25c8:b0:332:198c:dbf6 with SMTP id u8-20020a05663825c800b00332198cdbf6mr8908919jat.52.1656363915770;
        Mon, 27 Jun 2022 14:05:15 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id a13-20020a927f0d000000b002d8f50441absm4934985ild.10.2022.06.27.14.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 14:05:15 -0700 (PDT)
Received: (nullmailer pid 2956189 invoked by uid 1000);
        Mon, 27 Jun 2022 21:05:12 -0000
Date:   Mon, 27 Jun 2022 15:05:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
        Pin-Yen Lin <treapking@chromium.org>,
        Allen Chen <allen.chen@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Robert Foss <robert.foss@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>
Subject: Re: [PATCH v5 7/9] drm/bridge: it6505: Register number of Type C
 switches
Message-ID: <20220627210512.GB2905757-robh@kernel.org>
References: <20220622173605.1168416-1-pmalani@chromium.org>
 <20220622173605.1168416-8-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622173605.1168416-8-pmalani@chromium.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 05:34:36PM +0000, Prashant Malani wrote:
> From: Pin-Yen Lin <treapking@chromium.org>
> 
> Parse the "switches" node, if available, and count and store the number
> of Type-C switches within it. The extcon registration is still
> supported, but we don't expect both extcon and typec-switch be
> registered at the same time.
> 
> This patch sets a foundation for the actual registering of Type-C
> switches with the Type-C connector class framework.
> 
> Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
> 
> v5 is the first version for this patch.
> 
>  drivers/gpu/drm/bridge/ite-it6505.c | 34 +++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index 4b673c4792d7..b259f9f367f6 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -452,6 +452,7 @@ struct it6505 {
>  	struct delayed_work delayed_audio;
>  	struct it6505_audio_data audio;
>  	struct dentry *debugfs;
> +	int num_typec_switches;
>  
>  	/* it6505 driver hold option */
>  	bool enable_drv_hold;
> @@ -3229,13 +3230,28 @@ static void it6505_shutdown(struct i2c_client *client)
>  		it6505_lane_off(it6505);
>  }
>  
> +static int it6505_register_typec_switches(struct device *device, struct it6505 *it6505)
> +{
> +	struct device_node *of;
> +
> +	of = of_get_child_by_name(device->of_node, "switches");
> +	if (!of)
> +		return -ENODEV;
> +
> +	it6505->num_typec_switches = of_get_child_count(of);
> +	if (it6505->num_typec_switches <= 0)
> +		return -ENODEV;
> +
> +	return 0;
> +}

Not that I expect this to remain, but you have the same function in 2 
files. That's a clear sign this belongs in a helper.

Rob
