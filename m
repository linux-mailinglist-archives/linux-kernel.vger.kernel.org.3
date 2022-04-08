Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55514F95C9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbiDHMaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiDHM3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:29:42 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0501E33DCB3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 05:27:38 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id k21so14803895lfe.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 05:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=K0ZCLZVZHjdQHjkYjq3C12VlmjiKcOqPn8qAHZEMDHQ=;
        b=le54dYxu8FyFjTVPe2rw9al+gUfpK8XpisfSSexN51FHGO0IKgVuuQYfFkdi5dN9+v
         bnHH8KuPRCenyHJ+fX9a7adPG7owTMYVXSBstsfTNPfGD6kf0GgzaV69JnJzzFORMNBl
         MP3OX4iPLVYpIVgd8ys8J0+Rufm7V6kjcNdAqk9klTGQ7mDW2X+tlWu5bnz2ysSqexaO
         h9zdGqcdVHN8zOXaVb1FvnkhS+hvzg38XYBByoMH2DQz/u75Bsvck7a6cdQMZD8ozrcC
         zQBE5XnYneJWrxEv/ZXzIiTP0nMGlNvHsQZPb809zW+BAcLt7UJdg6O7Qq5LMTe6fSTn
         kkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=K0ZCLZVZHjdQHjkYjq3C12VlmjiKcOqPn8qAHZEMDHQ=;
        b=f1IRe4PMbnelhtLUSh1WadJqprsCrP1hHppumbu+JeEKXUiMD4vpU0gljX1/vdM3Cv
         RBVShMFlF4nEU0LhM4clmyJg2wziC/ICPkatXD/DIwYbpmpvAI1VuLCTA1Sry2PlK+vU
         ch9EO/sntnkcptgrklwPwC8udN6DKExEtlX3CsNdz6Mr4X+sa+9MvLQ1Oa04bxibOj+6
         QgPgjHWvsCqDN5mwNJ5ZGOKgsT5edqxzc7VTpA1gfKwDyhiq5qc6Fx3uXR4UvlaluK8+
         o9LuKsbfblVegJ8prPRJwTmiqKTbK/kXqtIhk4vY/MjRMr21L2PInPsb+/ngDi+0UmbL
         kB4w==
X-Gm-Message-State: AOAM530mzQqnr/qE61iswphkZFTEhFu0kRJ/wYyt4bCSIo30TSJxjJfo
        3WjOUH0feusjvQcdRQZzTLesxA==
X-Google-Smtp-Source: ABdhPJzBSUDRvdN9JvvkhYDhLk+irBa4u3Y8M14DyV37zV5TOvxgfbqWJ42CgbTKxCHU5yPrW8KMxw==
X-Received: by 2002:a05:6512:3a89:b0:44a:796c:8db0 with SMTP id q9-20020a0565123a8900b0044a796c8db0mr12343651lfu.123.1649420857060;
        Fri, 08 Apr 2022 05:27:37 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id k1-20020a2ea281000000b0024b54446beesm50453lja.107.2022.04.08.05.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 05:27:36 -0700 (PDT)
Message-ID: <625ce8a0-4e25-5513-5599-c1cdebf5a3a5@linaro.org>
Date:   Fri, 8 Apr 2022 15:27:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] drm/msm/dp: enhance both connect and disconnect
 pending_timeout handle
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, vkoul@kernel.org,
        daniel@ffwll.ch, airlied@linux.ie, agross@kernel.org,
        bjorn.andersson@linaro.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1649280493-4393-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1649280493-4393-1-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 00:28, Kuogee Hsieh wrote:
> dp_hpd_plug_handle() is responsible for setting up main link and send
> uevent to notify user space framework to start video stream. Similarly,
> dp_hdp_unplug_handle is responsible to send uevent to notify user space
> framework to stop video stream and then tear down main link.
> However there are rare cases, such as in the middle of system suspending,
> that uevent could not be delivered to user space framework. Therefore
> some kind of recover mechanism armed by timer need to be in place in the
> case of user space framework does not respond to uevent.

Hmm, how does userpsace 'respond' to the uevent? The driver should send 
hotplug notifications to userspace, but it must not expect any 
particular reaction. The userspace might be as simple, as fbdev 
emulation, but the driver still should function correctly.

> This patch have both dp_conenct_pending_timeout and
> dp_disconnect_pending_timeout are used to stop video stream and tear down
> main link and eventually restore DP driver state to known default
> DISCONNECTED state in the case of timer fired due to framework does not
> respond to uevent so that DP driver can recover itself gracefully at next
> dongle unplug followed by plugin event.
> 
> Changes in v2:
> -- replace dp_display_usbpd_disconnect_cb with dp_display_notify_disconnect
> 
> Fixes: 8ede2ecc3e5e ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 36 ++++++++++++++++++++-----
>   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  1 +
>   drivers/gpu/drm/msm/dp/dp_display.c | 54 ++++++++++++++++++++++++++++---------
>   3 files changed, 72 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index dcd0126..48990fb 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1910,15 +1910,12 @@ int dp_ctrl_off_link_stream(struct dp_ctrl *dp_ctrl)
>   	return ret;
>   }
>   
> -int dp_ctrl_off(struct dp_ctrl *dp_ctrl)
> +int dp_ctrl_off_link(struct dp_ctrl *dp_ctrl)
>   {
>   	struct dp_ctrl_private *ctrl;
>   	struct dp_io *dp_io;
>   	struct phy *phy;
> -	int ret = 0;
> -
> -	if (!dp_ctrl)
> -		return -EINVAL;
> +	int ret;
>   
>   	ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
>   	dp_io = &ctrl->parser->io;
> @@ -1926,7 +1923,34 @@ int dp_ctrl_off(struct dp_ctrl *dp_ctrl)
>   
>   	dp_catalog_ctrl_mainlink_ctrl(ctrl->catalog, false);
>   
> -	dp_catalog_ctrl_reset(ctrl->catalog);
> +	ret = dp_power_clk_enable(ctrl->power, DP_CTRL_PM, false);
> +	if (ret) {
> +		DRM_ERROR("Failed to disable link clocks. ret=%d\n", ret);
> +	}
> +
> +	DRM_DEBUG_DP("Before, phy=%p init_count=%d power_on=%d\n",
> +		phy, phy->init_count, phy->power_count);
> +
> +	phy_power_off(phy);
> +
> +	DRM_DEBUG_DP("After, phy=%p init_count=%d power_on=%d\n",
> +		phy, phy->init_count, phy->power_count);
> +
> +	return ret;
> +}
> +
> +int dp_ctrl_off(struct dp_ctrl *dp_ctrl)
> +{
> +	struct dp_ctrl_private *ctrl;
> +	struct dp_io *dp_io;
> +	struct phy *phy;
> +	int ret;
> +
> +	ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
> +	dp_io = &ctrl->parser->io;
> +	phy = dp_io->phy;
> +
> +	dp_catalog_ctrl_mainlink_ctrl(ctrl->catalog, false);
>   
>   	ret = dp_power_clk_enable(ctrl->power, DP_STREAM_PM, false);
>   	if (ret)
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> index 2433edb..ffafe17 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> @@ -22,6 +22,7 @@ struct dp_ctrl {
>   int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl);
>   int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl);
>   int dp_ctrl_off_link_stream(struct dp_ctrl *dp_ctrl);
> +int dp_ctrl_off_link(struct dp_ctrl *dp_ctrl);
>   int dp_ctrl_off(struct dp_ctrl *dp_ctrl);
>   void dp_ctrl_push_idle(struct dp_ctrl *dp_ctrl);
>   void dp_ctrl_isr(struct dp_ctrl *dp_ctrl);
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 178b774..a6200a5 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -451,11 +451,14 @@ static int dp_display_usbpd_configure_cb(struct device *dev)
>   
>   static int dp_display_usbpd_disconnect_cb(struct device *dev)
>   {
> +	return 0;
> +}
> +
> +static void dp_display_notify_disconnect(struct device *dev)
> +{
>   	struct dp_display_private *dp = dev_get_dp_display_private(dev);
>   
>   	dp_add_event(dp, EV_USER_NOTIFICATION, false, 0);
> -
> -	return 0;
>   }
>   
>   static void dp_display_handle_video_request(struct dp_display_private *dp)
> @@ -593,10 +596,16 @@ static int dp_connect_pending_timeout(struct dp_display_private *dp, u32 data)
>   
>   	mutex_lock(&dp->event_mutex);
>   
> +	/*
> +	 * main link had been setup but video is not ready yet
> +	 * only tear down main link
> +	 */
>   	state = dp->hpd_state;
>   	if (state == ST_CONNECT_PENDING) {
> -		dp->hpd_state = ST_CONNECTED;
>   		DRM_DEBUG_DP("type=%d\n", dp->dp_display.connector_type);
> +		dp_ctrl_off_link(dp->ctrl);
> +		dp_display_host_phy_exit(dp);
> +		dp->hpd_state = ST_DISCONNECTED;
>   	}
>   
>   	mutex_unlock(&dp->event_mutex);
> @@ -645,6 +654,7 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
>   		if (dp->link->sink_count == 0) {
>   			dp_display_host_phy_exit(dp);
>   		}
> +		dp_display_notify_disconnect(&dp->pdev->dev);
>   		mutex_unlock(&dp->event_mutex);
>   		return 0;
>   	}
> @@ -661,19 +671,22 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
>   		return 0;
>   	}
>   
> -	dp->hpd_state = ST_DISCONNECT_PENDING;
> -
>   	/* disable HPD plug interrupts */
>   	dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_PLUG_INT_MASK, false);
>   
>   	/*
>   	 * We don't need separate work for disconnect as
>   	 * connect/attention interrupts are disabled
> -	 */
> -	dp_display_usbpd_disconnect_cb(&dp->pdev->dev);
> +	*/
> +	dp_display_notify_disconnect(&dp->pdev->dev);
>   
> -	/* start sentinel checking in case of missing uevent */
> -	dp_add_event(dp, EV_DISCONNECT_PENDING_TIMEOUT, 0, DP_TIMEOUT_5_SECOND);
> +	if (state == ST_DISPLAY_OFF) {
> +		dp->hpd_state = ST_DISCONNECTED;
> +	} else {
> +		/* start sentinel checking in case of missing uevent */
> +		dp_add_event(dp, EV_DISCONNECT_PENDING_TIMEOUT, 0, DP_TIMEOUT_5_SECOND);
> +		dp->hpd_state = ST_DISCONNECT_PENDING;
> +	}
>   
>   	/* signal the disconnect event early to ensure proper teardown */
>   	dp_display_handle_plugged_change(&dp->dp_display, false);
> @@ -695,10 +708,16 @@ static int dp_disconnect_pending_timeout(struct dp_display_private *dp, u32 data
>   
>   	mutex_lock(&dp->event_mutex);
>   
> +	/*
> +	 * main link had been set up and video is ready
> +	 * tear down main link, video stream and phy
> +	 */
>   	state =  dp->hpd_state;
>   	if (state == ST_DISCONNECT_PENDING) {
> -		dp->hpd_state = ST_DISCONNECTED;
>   		DRM_DEBUG_DP("type=%d\n", dp->dp_display.connector_type);
> +		dp_ctrl_off(dp->ctrl);
> +		dp_display_host_phy_exit(dp);
> +		dp->hpd_state = ST_DISCONNECTED;
>   	}
>   
>   	mutex_unlock(&dp->event_mutex);
> @@ -1571,6 +1590,12 @@ int msm_dp_display_enable(struct msm_dp *dp, struct drm_encoder *encoder)
>   
>   	mutex_lock(&dp_display->event_mutex);
>   
> +	state = dp_display->hpd_state;
> +	if (state == ST_DISCONNECTED) {
> +		mutex_unlock(&dp_display->event_mutex);
> +		return rc;
> +	}
> +
>   	/* stop sentinel checking */
>   	dp_del_event(dp_display, EV_CONNECT_PENDING_TIMEOUT);
>   
> @@ -1588,8 +1613,6 @@ int msm_dp_display_enable(struct msm_dp *dp, struct drm_encoder *encoder)
>   		return rc;
>   	}
>   
> -	state =  dp_display->hpd_state;
> -
>   	if (state == ST_DISPLAY_OFF)
>   		dp_display_host_phy_init(dp_display);
>   
> @@ -1638,13 +1661,18 @@ int msm_dp_display_disable(struct msm_dp *dp, struct drm_encoder *encoder)
>   	/* stop sentinel checking */
>   	dp_del_event(dp_display, EV_DISCONNECT_PENDING_TIMEOUT);
>   
> +	state = dp_display->hpd_state;
> +	if (state == ST_DISCONNECTED || state == ST_DISPLAY_OFF) {
> +		mutex_unlock(&dp_display->event_mutex);
> +		return rc;
> +	}
> +
>   	dp_display_disable(dp_display, 0);
>   
>   	rc = dp_display_unprepare(dp);
>   	if (rc)
>   		DRM_ERROR("DP display unprepare failed, rc=%d\n", rc);
>   
> -	state =  dp_display->hpd_state;
>   	if (state == ST_DISCONNECT_PENDING) {
>   		/* completed disconnection */
>   		dp_display->hpd_state = ST_DISCONNECTED;


-- 
With best wishes
Dmitry
