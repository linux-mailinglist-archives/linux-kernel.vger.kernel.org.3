Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B5A510AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355134AbiDZUtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355103AbiDZUtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:49:15 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2CC3ED18;
        Tue, 26 Apr 2022 13:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651005966; x=1682541966;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H/MSWAr9aGb3XoC6bVHw7v/tgbOnpwvSajQyOcB3O3A=;
  b=f7gIuo6s7yD5KcP7PWHSCo6D80ZhVYoObv09XsvR8BBfaA+QqMcPBOrM
   t8UFZhgZbhrAQp95NwCZq2HStVnGhsT5csnZ2yCXxybTr0N0BKb4fv/AN
   7204jfR2dju1IE0uynez4X2/VJRzjwTKHS+zZaKmpk/2RJn2VF9JY19h0
   0=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 26 Apr 2022 13:46:06 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 13:46:05 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Apr 2022 13:46:04 -0700
Received: from [10.111.160.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 26 Apr
 2022 13:46:01 -0700
Message-ID: <a21a6ad5-5ed3-6207-8af7-655d19197041@quicinc.com>
Date:   Tue, 26 Apr 2022 13:45:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [RFC PATCH] drm/edid: drm_add_modes_noedid() should set lowest
 resolution as preferred
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        <dri-devel@lists.freedesktop.org>
CC:     <robdclark@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <quic_khsieh@quicinc.com>, <quic_aravindh@quicinc.com>,
        <swboyd@chromium.org>, <dmitry.baryshkov@linaro.org>,
        <quic_sbillaka@quicinc.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        <linux-kernel@vger.kernel.org>
References: <20220426132121.RFC.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20220426132121.RFC.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/2022 1:21 PM, Douglas Anderson wrote:
> If we're unable to read the EDID for a display because it's corrupt /
> bogus / invalid then we'll add a set of standard modes for the
> display. When userspace looks at these modes it doesn't really have a
> good concept for which mode to pick and it'll likely pick the highest
> resolution one by default. That's probably not ideal because the modes
> were purely guesses on the part of the Linux kernel.
> 
> Let's instead set 640x480 as the "preferred" mode when we have no EDID.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

drm_dmt_modes array is sorted but you are also relying on this check to 
eliminate the non-60fps modes

5611 		if (drm_mode_vrefresh(ptr) > 61)
5612 			continue;

I am not sure why we filter out the modes > 61 vrefresh.

If that check will remain this is okay.

If its not, its not reliable that the first mode will be 640x480@60

> ---
> 
>   drivers/gpu/drm/drm_edid.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 7a8482b75071..64ccfff4167e 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -5839,6 +5839,15 @@ int drm_add_modes_noedid(struct drm_connector *connector,
>   			continue;
>   		mode = drm_mode_duplicate(dev, ptr);
>   		if (mode) {
> +			/*
> +			 * The drm_dmt_modes array is sorted so that lower
> +			 * resolutions come first. We'll set the lowest
> +			 * resolution mode as preferred. We have no EDID so
> +			 * we should prefer the lowest resolution mode as
> +			 * the safest one.
> +			 */
> +			if (num_modes == 0)
> +				mode->type |= DRM_MODE_TYPE_PREFERRED;
>   			drm_mode_probed_add(connector, mode);
>   			num_modes++;
>   		}
