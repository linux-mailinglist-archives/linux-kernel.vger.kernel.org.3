Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E881858723E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbiHAUSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbiHAUSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:18:45 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8AE2BC8;
        Mon,  1 Aug 2022 13:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659385123; x=1690921123;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3q4LLeG/W8kgmZyTfF/ii6+XJjoOenvpsCafYt2ua74=;
  b=nFPmbiGeH6/twR/qmxp8u5vD3RTFA2aPxmVi8decj5b2U5VzH9GdUUv5
   kz/DT+DCL68Dj8mNMIiI/Ju+6tXgyREKC6WXKqqGAlQYd3Tuyfy9ILVX2
   +8SYKEbX6mhVE2Q/52yojWU9CtaY88j+I769wnUvkGjtijb1a7Fl0xaO0
   c=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Aug 2022 13:18:43 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 13:18:42 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 1 Aug 2022 13:18:42 -0700
Received: from [10.111.174.48] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 1 Aug 2022
 13:18:38 -0700
Message-ID: <488f0db0-6fa9-8a66-f055-f2cc57470a47@quicinc.com>
Date:   Mon, 1 Aug 2022 13:18:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [Freedreno] [PATCH v2] drm/msm/dp: delete
 DP_RECOVERED_CLOCK_OUT_EN to fix tps4
Content-Language: en-US
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <bjorn.andersson@linaro.org>
CC:     <quic_sbillaka@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <quic_aravindh@quicinc.com>, <freedreno@lists.freedesktop.org>
References: <1659384830-9909-1-git-send-email-quic_khsieh@quicinc.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <1659384830-9909-1-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/1/2022 1:13 PM, Kuogee Hsieh wrote:
> Data Symbols scrambled is required for tps4 at link training 2.
> Therefore SCRAMBLING_DISABLE bit should not be set for tps4 to
> work.
> RECOVERED_CLOCK_OUT_EN is for enable simple EYE test for jitter
> measurement with minimal equipment for embedded applications purpose
> and is not required to be set during normal operation.
> Current implementation always have RECOVERED_CLOCK_OUT_EN bit set
> which cause SCRAMBLING_DISABLE bit wrongly set at tps4 which prevent
> tps4 from working.
> This patch delete setting RECOVERED_CLOCK_OUT_EN to fix SCRAMBLING_DISABLE
> be wrongly set at tps4.
> 
> Changes in v2:
> -- fix Fixes tag
> 
> Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>

This is a good catch !

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

> ---
>   drivers/gpu/drm/msm/dp/dp_ctrl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index ab6aa13..013ca02 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1214,7 +1214,7 @@ static int dp_ctrl_link_train_2(struct dp_ctrl_private *ctrl,
>   	if (ret)
>   		return ret;
>   
> -	dp_ctrl_train_pattern_set(ctrl, pattern | DP_RECOVERED_CLOCK_OUT_EN);
> +	dp_ctrl_train_pattern_set(ctrl, pattern);
>   
>   	for (tries = 0; tries <= maximum_retries; tries++) {
>   		drm_dp_link_train_channel_eq_delay(ctrl->aux, ctrl->panel->dpcd);
