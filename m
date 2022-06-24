Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A0755A3F4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiFXVvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 17:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiFXVvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 17:51:01 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82ED87B58;
        Fri, 24 Jun 2022 14:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656107460; x=1687643460;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DnqbCmHRY/2v5TO3pWgmp/RU/G1NVE+z0cxe4bh3zbY=;
  b=opRV1aSF48cUiJ0t3XlG0kWd85hl/VW28h+ZbbInR+0dJWHriCA6RlSl
   gEC1tnA8ZKJ4O+LEJYkMk16WKDAf6NRZO4oXwVVjYO8LrboHcWRgm5IK+
   vq3KwmPFrBWXrvpWEIRoMW9199voMPwp38/x1uTLnWyTeMdrMa2AGWUPj
   k=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 24 Jun 2022 14:51:00 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 14:51:00 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 24 Jun 2022 14:50:59 -0700
Received: from [10.110.58.84] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 24 Jun
 2022 14:50:58 -0700
Message-ID: <0632e72a-3bd2-6320-4a00-6d3cf7d40513@quicinc.com>
Date:   Fri, 24 Jun 2022 14:50:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 1/3] drm/msm/dp: move struc of msm_display_info to
 msm_drv.h
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
CC:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1656090912-18074-1-git-send-email-quic_khsieh@quicinc.com>
 <1656090912-18074-2-git-send-email-quic_khsieh@quicinc.com>
 <CAD=FV=XD0Nb8GiaqEM52rEkUeVjuo46hBv9YUizdDu9zOH6QfA@mail.gmail.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAD=FV=XD0Nb8GiaqEM52rEkUeVjuo46hBv9YUizdDu9zOH6QfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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


On 6/24/2022 2:40 PM, Doug Anderson wrote:
> Hi,
>
> On Fri, Jun 24, 2022 at 10:15 AM Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>> With current implementation, communication between interface driver and
>> upper mdss encoder layer are implemented through function calls. This
>> increase code complexity. Since struct msm_display_info contains msm
>> generic display information, it can be expended to contains more useful
>> information, such as widebus and dcs, in future to serve as communication
>> channel purpose between interface driver and upper mdss encoder layer so
>> that existing function calls can be eliminated.
>> This patch more struct msm_display_info to msm_drv.h to be visible by
>> whole msm scope.
>>
>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h | 20 --------------------
>>   drivers/gpu/drm/msm/msm_drv.h               | 19 +++++++++++++++++++
>>   2 files changed, 19 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
>> index 781d41c..6b604c5 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
>> @@ -19,26 +19,6 @@
>>   #define IDLE_TIMEOUT   (66 - 16/2)
>>
>>   /**
>> - * struct msm_display_info - defines display properties
>> - * @intf_type:          DRM_MODE_ENCODER_ type
>> - * @capabilities:       Bitmask of display flags
>> - * @num_of_h_tiles:     Number of horizontal tiles in case of split interface
>> - * @h_tile_instance:    Controller instance used per tile. Number of elements is
>> - *                      based on num_of_h_tiles
>> - * @is_te_using_watchdog_timer:  Boolean to indicate watchdog TE is
>> - *                              used instead of panel TE in cmd mode panels
>> - * @dsc:               DSC configuration data for DSC-enabled displays
>> - */
>> -struct msm_display_info {
>> -       int intf_type;
>> -       uint32_t capabilities;
>> -       uint32_t num_of_h_tiles;
>> -       uint32_t h_tile_instance[MAX_H_TILES_PER_DISPLAY];
>> -       bool is_te_using_watchdog_timer;
>> -       struct msm_display_dsc_config *dsc;
> So in the structure you're "moving" there's this member called "dsc".
>
>
>> -};
>> -
>> -/**
>>    * dpu_encoder_assign_crtc - Link the encoder to the crtc it's assigned to
>>    * @encoder:   encoder pointer
>>    * @crtc:      crtc pointer
>> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
>> index fdbaad5..f9c263b 100644
>> --- a/drivers/gpu/drm/msm/msm_drv.h
>> +++ b/drivers/gpu/drm/msm/msm_drv.h
>> @@ -106,11 +106,30 @@ struct msm_drm_thread {
>>          struct kthread_worker *worker;
>>   };
>>
>> +<<<<<<< HEAD
> The above doesn't look like valid C to me.
>
>
>>   /* DSC config */
>>   struct msm_display_dsc_config {
>>          struct drm_dsc_config *drm;
>>   };
>>
>> +/**
>> + * struct msm_display_info - defines display properties
>> + * @intf_type:          DRM_MODE_ENCODER_ type
>> + * @capabilities:       Bitmask of display flags
>> + * @num_of_h_tiles:     Number of horizontal tiles in case of split interface
>> + * @h_tile_instance:    Controller instance used per tile. Number of elements is
>> + *                      based on num_of_h_tiles
>> + * @is_te_using_watchdog_timer:  Boolean to indicate watchdog TE is
>> + *                              used instead of panel TE in cmd mode panels
>> + */
>> +struct msm_display_info {
>> +       int intf_type;
>> +       uint32_t capabilities;
>> +       uint32_t num_of_h_tiles;
>> +       uint32_t h_tile_instance[MAX_H_TILES_PER_DISPLAY];
>> +       bool is_te_using_watchdog_timer;
> ...but then when you "move" the structure to its new location, which
> should be a noop, then <poof> the "dsc" variable vanishes (along with
> the kernel doc description of it before the structure).

Sorry, i did not resolve the conflicts correctly  when i cherry-pick 
them to msm-next tree.

Will fix them.

> -Doug
