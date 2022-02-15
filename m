Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0664B7755
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242693AbiBORld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:41:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242618AbiBORl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:41:29 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64DE4A3C4;
        Tue, 15 Feb 2022 09:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644946878; x=1676482878;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4yiWFkfWSslO+frra9N96ukQwZe8gg2MbNGsiRbMA0o=;
  b=afehDQpGwkM4VgnRdYaQZXmtVsJovnwPRvY+Dx7Am+OXR0GPGrqywZFE
   xo5wLAUCTI0WR7g7DO+hkN8PBFIZUBH/ty7YjQgDHMs6DVfG/pB6N7GJK
   wYYbDBKWFxmP+ssP+Yqnl4siuNAB9+jx8ocmjVvbpNeYfZzwm1ggzQc/C
   8=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Feb 2022 09:41:18 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 09:41:17 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Feb 2022 09:41:17 -0800
Received: from [10.110.63.253] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 15 Feb
 2022 09:41:16 -0800
Message-ID: <04237d77-bd5e-c0d9-5154-e6118a3af53d@quicinc.com>
Date:   Tue, 15 Feb 2022 09:41:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/2] drm/msm/dp: enable widebus feature for display
 port
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <vkoul@kernel.org>,
        <daniel@ffwll.ch>, <airlied@linux.ie>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_abhinavk@quicinc.com>,
        <quic_aravindh@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1644878346-28511-1-git-send-email-quic_khsieh@quicinc.com>
 <1644878346-28511-3-git-send-email-quic_khsieh@quicinc.com>
 <YgsqcTruwrvaGBxw@yoga>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <YgsqcTruwrvaGBxw@yoga>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/14/2022 8:22 PM, Bjorn Andersson wrote:
> On Mon 14 Feb 16:39 CST 2022, Kuogee Hsieh wrote:
>
>> Widebus feature will transmit two pixel data per pixel clock to interface.
>> This feature now is required to be enabled to easy migrant to higher
>> resolution applications in future. However since some legacy chipsets
>> does not support this feature, this feature is enabled base on chip's
>> hardware revision.
>>
>> changes in v2:
>> -- remove compression related code from timing
>> -- remove op_info from  struct msm_drm_private
>> -- remove unnecessary wide_bus_en variables
>> -- pass wide_bus_en into timing configuration by struct msm_dp
>>
>> Changes in v3:
>> -- split patch into 3 patches
>> -- enable widebus feature base on chip hardware revision
>>
>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  4 +++-
>>   drivers/gpu/drm/msm/dp/dp_catalog.c         | 36 +++++++++++++++++++++++++++--
>>   drivers/gpu/drm/msm/dp/dp_catalog.h         |  3 ++-
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c            | 13 +++++++----
>>   drivers/gpu/drm/msm/dp/dp_ctrl.h            |  1 +
>>   drivers/gpu/drm/msm/dp/dp_display.c         | 30 ++++++++++++++++++++++++
>>   drivers/gpu/drm/msm/dp/dp_display.h         |  2 ++
>>   drivers/gpu/drm/msm/dp/dp_panel.c           |  4 ++--
>>   drivers/gpu/drm/msm/dp/dp_panel.h           |  2 +-
>>   drivers/gpu/drm/msm/msm_drv.h               |  6 +++++
>>   10 files changed, 90 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> index 0c22839..b2d23c2 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> @@ -2167,8 +2167,10 @@ int dpu_encoder_setup(struct drm_device *dev, struct drm_encoder *enc,
>>   		timer_setup(&dpu_enc->vsync_event_timer,
>>   				dpu_encoder_vsync_event_handler,
>>   				0);
>> -	else if (disp_info->intf_type == DRM_MODE_ENCODER_TMDS)
>> +	else if (disp_info->intf_type == DRM_MODE_ENCODER_TMDS) {
>>   		dpu_enc->dp = priv->dp[disp_info->h_tile_instance[0]];
>> +		dpu_enc->wide_bus_en = msm_dp_wide_bus_enable(dpu_enc->dp);
>> +	}
>>   
>>   	INIT_DELAYED_WORK(&dpu_enc->delayed_off_work,
>>   			dpu_encoder_off_work);
>> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
>> index 64f0b26..99d087e 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_catalog.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
>> @@ -483,6 +483,27 @@ int dp_catalog_ctrl_set_pattern_state_bit(struct dp_catalog *dp_catalog,
>>   }
>>   
>>   /**
>> + * dp_catalog_hw_revision() - retrieve DP hw revision
>> + *
>> + * @dp_catalog: DP catalog structure
>> + *
>> + * return: u32
> Q: What's 2+2?
> A: Integer
>
> This should say:
>
> Return: the controller hardware revision
>
>> + *
>> + * This function return the DP controller hw revision
> That's what "Return:" in the kernel-doc is supposed to clarify...
>
> https://docs.kernel.org/doc-guide/kernel-doc.html is good to read.
>
>> + *
>> + */
>> +u32 dp_catalog_hw_revision(struct dp_catalog *dp_catalog)
>> +{
>> +	u32 revision;
>> +	struct dp_catalog_private *catalog = container_of(dp_catalog,
>> +				struct dp_catalog_private, dp_catalog);
>> +
>> +	revision = dp_read_ahb(catalog, REG_DP_HW_VERSION);
> There's no need for a local variable here, just:
>
> 	return dp_read_ahb();
>
>> +
>> +	return revision;
>> +}
>> +
>> +/**
>>    * dp_catalog_ctrl_reset() - reset DP controller
>>    *
>>    * @dp_catalog: DP catalog structure
>> @@ -739,10 +760,11 @@ u32 dp_catalog_ctrl_read_phy_pattern(struct dp_catalog *dp_catalog)
>>   }
>>   
>>   /* panel related catalog functions */
>> -int dp_catalog_panel_timing_cfg(struct dp_catalog *dp_catalog)
>> +int dp_catalog_panel_timing_cfg(struct dp_catalog *dp_catalog, bool wide_bus_en)
>>   {
>>   	struct dp_catalog_private *catalog = container_of(dp_catalog,
>>   				struct dp_catalog_private, dp_catalog);
>> +	u32 reg;
>>   
>>   	dp_write_link(catalog, REG_DP_TOTAL_HOR_VER,
>>   				dp_catalog->total);
>> @@ -751,7 +773,17 @@ int dp_catalog_panel_timing_cfg(struct dp_catalog *dp_catalog)
>>   	dp_write_link(catalog, REG_DP_HSYNC_VSYNC_WIDTH_POLARITY,
>>   				dp_catalog->width_blanking);
>>   	dp_write_link(catalog, REG_DP_ACTIVE_HOR_VER, dp_catalog->dp_active);
>> -	dp_write_p0(catalog, MMSS_DP_INTF_CONFIG, 0);
>> +
>> +	reg = dp_read_p0(catalog, MMSS_DP_INTF_CONFIG);
>> +
>> +	if (wide_bus_en)
>> +		reg |= BIT(4);	/* DATABUS_WIDEN */
> #define DATABUS_WIDEN BIT(4)
>
> Would save you the need for writing that comment.
>
>> +	else
>> +		reg &= ~BIT(4);
>> +
>> +	DRM_DEBUG_DP("wide_bus_en=%d reg=%x\n", wide_bus_en, reg);
>> +
>> +	dp_write_p0(catalog, MMSS_DP_INTF_CONFIG, reg);
>>   	return 0;
>>   }
>>   
>> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp/dp_catalog.h
>> index 7dea101..a3a0129 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_catalog.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
>> @@ -95,6 +95,7 @@ void dp_catalog_ctrl_config_misc(struct dp_catalog *dp_catalog, u32 cc, u32 tb);
>>   void dp_catalog_ctrl_config_msa(struct dp_catalog *dp_catalog, u32 rate,
>>   				u32 stream_rate_khz, bool fixed_nvid);
>>   int dp_catalog_ctrl_set_pattern_state_bit(struct dp_catalog *dp_catalog, u32 pattern);
>> +u32 dp_catalog_hw_revision(struct dp_catalog *dp_catalog);
>>   void dp_catalog_ctrl_reset(struct dp_catalog *dp_catalog);
>>   bool dp_catalog_ctrl_mainlink_ready(struct dp_catalog *dp_catalog);
>>   void dp_catalog_ctrl_enable_irq(struct dp_catalog *dp_catalog, bool enable);
>> @@ -115,7 +116,7 @@ void dp_catalog_ctrl_send_phy_pattern(struct dp_catalog *dp_catalog,
>>   u32 dp_catalog_ctrl_read_phy_pattern(struct dp_catalog *dp_catalog);
>>   
>>   /* DP Panel APIs */
>> -int dp_catalog_panel_timing_cfg(struct dp_catalog *dp_catalog);
>> +int dp_catalog_panel_timing_cfg(struct dp_catalog *dp_catalog, bool wide_bus_en);
>>   void dp_catalog_dump_regs(struct dp_catalog *dp_catalog);
>>   void dp_catalog_panel_tpg_enable(struct dp_catalog *dp_catalog,
>>   				struct drm_display_mode *drm_mode);
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index 245e1b9..1c4cf9d 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> @@ -154,7 +154,7 @@ static void dp_ctrl_config_ctrl(struct dp_ctrl_private *ctrl)
>>   	dp_catalog_ctrl_config_ctrl(ctrl->catalog, config);
>>   }
>>   
>> -static void dp_ctrl_configure_source_params(struct dp_ctrl_private *ctrl)
>> +static void dp_ctrl_configure_source_params(struct dp_ctrl_private *ctrl, bool wide_bus_en)
>>   {
>>   	u32 cc, tb;
>>   
>> @@ -167,7 +167,7 @@ static void dp_ctrl_configure_source_params(struct dp_ctrl_private *ctrl)
>>   		ctrl->panel->dp_mode.bpp);
>>   	cc = dp_link_get_colorimetry_config(ctrl->link);
>>   	dp_catalog_ctrl_config_misc(ctrl->catalog, cc, tb);
>> -	dp_panel_timing_cfg(ctrl->panel);
>> +	dp_panel_timing_cfg(ctrl->panel, wide_bus_en);
>>   }
>>   
>>   /*
>> @@ -1796,6 +1796,7 @@ int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl)
>>   	int ret = 0;
>>   	bool mainlink_ready = false;
>>   	struct dp_ctrl_private *ctrl;
>> +	u32 pixel_rate_orig;
>>   
>>   	if (!dp_ctrl)
>>   		return -EINVAL;
>> @@ -1804,6 +1805,10 @@ int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl)
>>   
>>   	ctrl->dp_ctrl.pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;
>>   
>> +	pixel_rate_orig = ctrl->dp_ctrl.pixel_rate;
>> +	if (dp_ctrl->wide_bus_en)
>> +		ctrl->dp_ctrl.pixel_rate >>= 1;
>> +
>>   	DRM_DEBUG_DP("rate=%d, num_lanes=%d, pixel_rate=%d\n",
>>   		ctrl->link->link_params.rate,
>>   		ctrl->link->link_params.num_lanes, ctrl->dp_ctrl.pixel_rate);
>> @@ -1839,11 +1844,11 @@ int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl)
>>   	 */
>>   	reinit_completion(&ctrl->video_comp);
>>   
>> -	dp_ctrl_configure_source_params(ctrl);
>> +	dp_ctrl_configure_source_params(ctrl, dp_ctrl->wide_bus_en);
>>   
>>   	dp_catalog_ctrl_config_msa(ctrl->catalog,
>>   		ctrl->link->link_params.rate,
>> -		ctrl->dp_ctrl.pixel_rate, dp_ctrl_use_fixed_nvid(ctrl));
>> +		pixel_rate_orig, dp_ctrl_use_fixed_nvid(ctrl));
>>   
>>   	dp_ctrl_setup_tr_unit(ctrl);
>>   
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> index 2433edb..4dff44d 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> @@ -17,6 +17,7 @@ struct dp_ctrl {
>>   	bool orientation;
>>   	atomic_t aborted;
>>   	u32 pixel_rate;
>> +	bool wide_bus_en;
>>   };
>>   
>>   int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl);
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index e89556ad..d45a3aa 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -117,6 +117,8 @@ struct dp_display_private {
>>   	struct dp_event event_list[DP_EVENT_Q_MAX];
>>   	spinlock_t event_lock;
>>   
>> +	bool wide_bus_en;
>> +
>>   	struct dp_audio *audio;
>>   };
>>   
>> @@ -845,6 +847,8 @@ static int dp_display_enable(struct dp_display_private *dp, u32 data)
>>   		return 0;
>>   	}
>>   
>> +	dp->ctrl->wide_bus_en = dp->wide_bus_en;
>> +
>>   	rc = dp_ctrl_on_stream(dp->ctrl);
>>   	if (!rc)
>>   		dp_display->power_on = true;
>> @@ -979,6 +983,7 @@ int dp_display_get_modes(struct msm_dp *dp,
>>   		dp->connector, dp_mode);
>>   	if (dp_mode->drm_mode.clock)
>>   		dp->max_pclk_khz = dp_mode->drm_mode.clock;
>> +
>>   	return ret;
>>   }
>>   
>> @@ -1451,6 +1456,28 @@ void msm_dp_irq_postinstall(struct msm_dp *dp_display)
>>   	}
>>   }
>>   
>> +bool msm_dp_wide_bus_enable(struct msm_dp *dp_display)
>> +{
>> +	struct dp_display_private *dp;
>> +	u32 revision, major, minor;
>> +
>> +	dp = container_of(dp_display, struct dp_display_private, dp_display);
>> +
>> +	/* for the time being widebus only support on DP */
>> +	if (dp_display->connector_type  == DRM_MODE_CONNECTOR_DisplayPort) {
> Is there a reason for not enabling widebus for eDP? (I'm perfectly fine
> with doing us doing that separately at a later point, but I'm curious)

yes, widebus can be enabled for eDP too.

Just ask hardware engineer thsi question, they said widebus is 
recommended to be enabled at both eDP and DP.

I will enable it later.


>
>> +		revision = dp_catalog_hw_revision(dp->catalog);
>> +		major = ((revision >> 28) & 0x0ff);
>> +		minor = ((revision >> 16) & 0x0fff);
>> +
>> +	DRM_DEBUG_DP("id=%d major=%d minor=%d\n", dp->id, major, minor);
> The indentation of this line is wrong.
>
>> +
>> +		if (major >= 1 && minor >= 2)
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>>   void msm_dp_debugfs_init(struct msm_dp *dp_display, struct drm_minor *minor)
>>   {
>>   	struct dp_display_private *dp;
>> @@ -1505,6 +1532,9 @@ int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
>>   	dp_priv->panel->connector = dp_display->connector;
>>   
>>   	priv->connectors[priv->num_connectors++] = dp_display->connector;
>> +
>> +	dp_priv->wide_bus_en = msm_dp_wide_bus_enable(dp_display);
> Not sure if I'm missing some patches, but my branch branch doesn't have
> a dp_priv in this function.

My fault, I uploaded patches for review at my working directory instead 
of msm-next branch.


>
> Regards,
> Bjorn
>
>> +
>>   	return 0;
>>   }
>>   
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
>> index 8e80e3b..d9cb9ee 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
>> @@ -23,6 +23,8 @@ struct msm_dp {
>>   
>>   	hdmi_codec_plugged_cb plugged_cb;
>>   
>> +	bool wide_bus_en;
>> +
>>   	u32 max_pclk_khz;
>>   
>>   	u32 max_dp_lanes;
>> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
>> index 71db10c..71deb1e 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
>> @@ -353,7 +353,7 @@ void dp_panel_dump_regs(struct dp_panel *dp_panel)
>>   	dp_catalog_dump_regs(catalog);
>>   }
>>   
>> -int dp_panel_timing_cfg(struct dp_panel *dp_panel)
>> +int dp_panel_timing_cfg(struct dp_panel *dp_panel, bool wide_bus_en)
>>   {
>>   	u32 data, total_ver, total_hor;
>>   	struct dp_catalog *catalog;
>> @@ -404,7 +404,7 @@ int dp_panel_timing_cfg(struct dp_panel *dp_panel)
>>   
>>   	catalog->dp_active = data;
>>   
>> -	dp_catalog_panel_timing_cfg(catalog);
>> +	dp_catalog_panel_timing_cfg(catalog, wide_bus_en);
>>   	panel->panel_on = true;
>>   
>>   	return 0;
>> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
>> index 9023e5b..5ec341a 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_panel.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_panel.h
>> @@ -57,7 +57,7 @@ struct dp_panel {
>>   
>>   int dp_panel_init_panel_info(struct dp_panel *dp_panel);
>>   int dp_panel_deinit(struct dp_panel *dp_panel);
>> -int dp_panel_timing_cfg(struct dp_panel *dp_panel);
>> +int dp_panel_timing_cfg(struct dp_panel *dp_panel, bool wide_bus_en);
>>   void dp_panel_dump_regs(struct dp_panel *dp_panel);
>>   int dp_panel_read_sink_caps(struct dp_panel *dp_panel,
>>   		struct drm_connector *connector);
>> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
>> index 07f6c41..667f3a8 100644
>> --- a/drivers/gpu/drm/msm/msm_drv.h
>> +++ b/drivers/gpu/drm/msm/msm_drv.h
>> @@ -398,6 +398,7 @@ void msm_dp_irq_postinstall(struct msm_dp *dp_display);
>>   void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_display);
>>   
>>   void msm_dp_debugfs_init(struct msm_dp *dp_display, struct drm_minor *minor);
>> +bool msm_dp_wide_bus_enable(struct msm_dp *dp_display);
>>   
>>   #else
>>   static inline int __init msm_dp_register(void)
>> @@ -448,6 +449,11 @@ static inline void msm_dp_debugfs_init(struct msm_dp *dp_display,
>>   {
>>   }
>>   
>> +bool msm_dp_wide_bus_enable(struct msm_dp *dp_display)
>> +{
>> +	return false;
>> +}
>> +
>>   #endif
>>   
>>   void __init msm_mdp_register(void);
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
