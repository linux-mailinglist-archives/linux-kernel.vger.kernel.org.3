Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C5353AE1B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 22:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiFAUrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 16:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiFAUp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:45:56 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11BA1EBEDF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 13:36:23 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id g12so3243842lja.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 13:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hnRMWgmEz6zfwIb82WIa9Y2K1DBEpYohPM7DyrugX8E=;
        b=oYGbX6KaeTgPk2iAU48PyWEJ5sasp65b85/ExshGxB51y6g8J4muFbIxohJDhEtipq
         Qgq/oCQzFlBiR4WHRMKEDlVO3aSr1t8zMfT4bYVqu6+wjuWJtu5/6oQgxPVxr6fbL9hj
         D1oPZ7tUHkT3TqNZdnIxKGEE0JZM3HbroqlaDoHJuJ0XyFLFT7DsZFUY5igq4vLNXDNe
         ovsiXfKMppKA4nkSqLQosuxjbCNNBWJ4iY5rYU48E529rSfz12O1TxWBD5wBuUBWf2Hm
         Xrrqsgi4GmqBXVtYus0EKe9R71ceIO6t3WFfmLEG5Z4Y6SWMWUa08SRfSeHQoRMoWSK3
         4U+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hnRMWgmEz6zfwIb82WIa9Y2K1DBEpYohPM7DyrugX8E=;
        b=oCMFnMGyBwfLrLw3X0Nm+6TllsURERKDxUwQpdKZCB39Tvh7qAoDNuqQoSYZMDY+NE
         JEUCjt+5Tl8/FR3efxkxXrBPEDSO/mSr32U4ODv6ZjZKEmSe93uVVNb+ZJvfi1rWXGDk
         kUDgVWrJB/8AAnHWwobrAqaTc3oyP35f6kuKhQ7N9Pj1gBQNfNtI8+yFi770JONKYtqL
         lXWyAamrIJfl3xrOoNVsRq9e8vyHEWmwLf3QDSInnSGx7yOgSvEals1zFXONMseS1kt7
         ImSIhoL71n0jRl9kdF6fxGjiwNvlcqsaf0wjGLQZVmh5SytWEIy32vbMOFrZwY5qsdeR
         7/5A==
X-Gm-Message-State: AOAM5328cCZfCK2OeH9gN6vpyXXIsqJwXu0sC64C8LkFOzQgFiptfE9y
        wJh/9DOIA+dJYDiVuyg54n6uBQ==
X-Google-Smtp-Source: ABdhPJxkJRwJB0bBCZulH1+0G/aFguKjl0xcNUukjBNO1bwjaJ7gLhhqqPPOS2Y6T+q9wYEA6cqYBw==
X-Received: by 2002:a05:651c:1542:b0:249:a87f:8a34 with SMTP id y2-20020a05651c154200b00249a87f8a34mr39972015ljp.442.1654115782175;
        Wed, 01 Jun 2022 13:36:22 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id 17-20020ac25f51000000b00477cdd77ac0sm557258lfz.175.2022.06.01.13.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 13:36:21 -0700 (PDT)
Message-ID: <10e79606-65d7-73bc-34e1-92ed5740d8fc@linaro.org>
Date:   Wed, 1 Jun 2022 23:36:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 1/2] drm/probe-helper: Add helper for
 drm_helper_probe_single_connector_modes()
Content-Language: en-GB
To:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, swboyd@chromium.org,
        quic_khsieh@quicinc.com, quic_sbillaka@quicinc.com,
        quic_abhinavk@quicinc.com, ville.syrjala@linux.intel.com,
        quic_aravindh@quicinc.com, tzimmermann@suse.de,
        robdclark@gmail.com, linux-arm-msm@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220511155749.v3.1.I2dd93486c6952bd52f2020904de0133970d11b29@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220511155749.v3.1.I2dd93486c6952bd52f2020904de0133970d11b29@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 01:58, Douglas Anderson wrote:
> The drm_helper_probe_single_connector_modes() is a bit long. Let's
> break a chunk off to update and validate modes. This helps avoid one
> goto and also will allow us to more easily call the helper a second
> time in a future patch without adding looping or another goto.
> 
> This change is intended to be a no-op change--just code movement.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> 
> Changes in v3:
> - Removed WARN_ON
> 
> Changes in v2:
> - Two underscores for __drm_helper_update_and_validate().
> - Return err and use WARN_ON instead of returning a bool.
> 
>   drivers/gpu/drm/drm_probe_helper.c | 106 ++++++++++++++++-------------
>   1 file changed, 60 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
> index 682359512996..2570d47e7eab 100644
> --- a/drivers/gpu/drm/drm_probe_helper.c
> +++ b/drivers/gpu/drm/drm_probe_helper.c
> @@ -354,6 +354,61 @@ drm_helper_probe_detect(struct drm_connector *connector,
>   }
>   EXPORT_SYMBOL(drm_helper_probe_detect);
>   
> +static int __drm_helper_update_and_validate(struct drm_connector *connector,
> +					    uint32_t maxX, uint32_t maxY,
> +					    struct drm_modeset_acquire_ctx *ctx)
> +{
> +	struct drm_device *dev = connector->dev;
> +	struct drm_display_mode *mode;
> +	int mode_flags = 0;
> +	int ret;
> +
> +	drm_connector_list_update(connector);
> +
> +	if (connector->interlace_allowed)
> +		mode_flags |= DRM_MODE_FLAG_INTERLACE;
> +	if (connector->doublescan_allowed)
> +		mode_flags |= DRM_MODE_FLAG_DBLSCAN;
> +	if (connector->stereo_allowed)
> +		mode_flags |= DRM_MODE_FLAG_3D_MASK;
> +
> +	list_for_each_entry(mode, &connector->modes, head) {
> +		if (mode->status != MODE_OK)
> +			continue;
> +
> +		mode->status = drm_mode_validate_driver(dev, mode);
> +		if (mode->status != MODE_OK)
> +			continue;
> +
> +		mode->status = drm_mode_validate_size(mode, maxX, maxY);
> +		if (mode->status != MODE_OK)
> +			continue;
> +
> +		mode->status = drm_mode_validate_flag(mode, mode_flags);
> +		if (mode->status != MODE_OK)
> +			continue;
> +
> +		ret = drm_mode_validate_pipeline(mode, connector, ctx,
> +						 &mode->status);
> +		if (ret) {
> +			drm_dbg_kms(dev,
> +				    "drm_mode_validate_pipeline failed: %d\n",
> +				    ret);
> +
> +			if (drm_WARN_ON_ONCE(dev, ret != -EDEADLK))
> +				mode->status = MODE_ERROR;
> +			else
> +				return -EDEADLK;
> +		}
> +
> +		if (mode->status != MODE_OK)
> +			continue;
> +		mode->status = drm_mode_validate_ycbcr420(mode, connector);
> +	}
> +
> +	return 0;
> +}
> +
>   /**
>    * drm_helper_probe_single_connector_modes - get complete set of display modes
>    * @connector: connector to probe
> @@ -421,7 +476,6 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
>   	const struct drm_connector_helper_funcs *connector_funcs =
>   		connector->helper_private;
>   	int count = 0, ret;
> -	int mode_flags = 0;
>   	bool verbose_prune = true;
>   	enum drm_connector_status old_status;
>   	struct drm_modeset_acquire_ctx ctx;
> @@ -519,52 +573,12 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
>   			   connector->status == connector_status_unknown))
>   		count = drm_add_modes_noedid(connector, 1024, 768);
>   	count += drm_helper_probe_add_cmdline_mode(connector);
> -	if (count == 0)
> -		goto prune;
> -
> -	drm_connector_list_update(connector);
> -
> -	if (connector->interlace_allowed)
> -		mode_flags |= DRM_MODE_FLAG_INTERLACE;
> -	if (connector->doublescan_allowed)
> -		mode_flags |= DRM_MODE_FLAG_DBLSCAN;
> -	if (connector->stereo_allowed)
> -		mode_flags |= DRM_MODE_FLAG_3D_MASK;
> -
> -	list_for_each_entry(mode, &connector->modes, head) {
> -		if (mode->status != MODE_OK)
> -			continue;
> -
> -		mode->status = drm_mode_validate_driver(dev, mode);
> -		if (mode->status != MODE_OK)
> -			continue;
> -
> -		mode->status = drm_mode_validate_size(mode, maxX, maxY);
> -		if (mode->status != MODE_OK)
> -			continue;
> -
> -		mode->status = drm_mode_validate_flag(mode, mode_flags);
> -		if (mode->status != MODE_OK)
> -			continue;
> -
> -		ret = drm_mode_validate_pipeline(mode, connector, &ctx,
> -						 &mode->status);
> -		if (ret) {
> -			drm_dbg_kms(dev,
> -				    "drm_mode_validate_pipeline failed: %d\n",
> -				    ret);
> -
> -			if (drm_WARN_ON_ONCE(dev, ret != -EDEADLK)) {
> -				mode->status = MODE_ERROR;
> -			} else {
> -				drm_modeset_backoff(&ctx);
> -				goto retry;
> -			}
> +	if (count != 0) {
> +		ret = __drm_helper_update_and_validate(connector, maxX, maxY, &ctx);
> +		if (ret == -EDEADLK) {
> +			drm_modeset_backoff(&ctx);
> +			goto retry;
>   		}
> -
> -		if (mode->status != MODE_OK)
> -			continue;
> -		mode->status = drm_mode_validate_ycbcr420(mode, connector);
>   	}
>   
>   prune:


-- 
With best wishes
Dmitry
