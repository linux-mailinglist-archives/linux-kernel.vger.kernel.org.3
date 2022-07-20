Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1334257BE32
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiGTTBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiGTTBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:01:39 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E0452E74;
        Wed, 20 Jul 2022 12:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658343697; x=1689879697;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=TOzvRVPqNoT1OqYi1zjIrLa3zYswQtJ3Ow/4dkchUlE=;
  b=PZEhYzB9p43f4TRxtvNvOU64PDBiFzChrPQKPNcC9Z4qnPSM3e/KCQUP
   IDYD7Eal3yfkOo5dMnLFiUhUzAsM1XmR7qkBdQyXAGK2Tiy2FnC5kxvDK
   BK010gKgI2mawJXdtBO4EWCc+hHuPYqC+sQWjbCASHdbhGxAzv9kufZat
   4=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Jul 2022 12:01:36 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 12:01:36 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 12:01:36 -0700
Received: from [10.38.240.17] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 20 Jul
 2022 12:01:32 -0700
Message-ID: <2a33f6a4-2b23-5709-4b8a-6e4699989b85@quicinc.com>
Date:   Wed, 20 Jul 2022 12:01:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v4] drm/msm/dp: make eDP panel as the first connected
 connector
Content-Language: en-US
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <bjorn.andersson@linaro.org>
CC:     <quic_aravindh@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1657135928-31195-1-git-send-email-quic_khsieh@quicinc.com>
 <22d4abbf-db93-82e1-ecf1-e7804e72c21b@quicinc.com>
In-Reply-To: <22d4abbf-db93-82e1-ecf1-e7804e72c21b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/2022 11:47 AM, Abhinav Kumar wrote:
> 
> 
> On 7/6/2022 12:32 PM, Kuogee Hsieh wrote:
>> Some userspace presumes that the first connected connector is the main
>> display, where it's supposed to display e.g. the login screen. For
>> laptops, this should be the main panel.
>>
>> This patch call drm_helper_move_panel_connectors_to_head() after
>> drm_bridge_connector_init() to make sure eDP stay at head of
>> connected connector list. This fixes unexpected corruption happen
>> at eDP panel if eDP is not placed at head of connected connector
>> list.
>>
>> Changes in v2:
>> -- move drm_helper_move_panel_connectors_to_head() to
>>         dpu_kms_drm_obj_init()
>>
>> Changes in v4:
>> -- move drm_helper_move_panel_connectors_to_head() to msm_drm_init()
>>
>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Fixes: c8afe684c95c ("drm/msm: basic KMS driver for snapdragon")

Lets drop the previous fixes tag and use this one as its more recent and 
appropriate as it added eDP support for sc7280.

Fixes: ef7837ff091c ("drm/msm/dp: Add DP controllers for sc7280")

>> ---
>>   drivers/gpu/drm/msm/msm_drv.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/msm_drv.c 
>> b/drivers/gpu/drm/msm/msm_drv.c
>> index 4a3dda2..4d518c2 100644
>> --- a/drivers/gpu/drm/msm/msm_drv.c
>> +++ b/drivers/gpu/drm/msm/msm_drv.c
>> @@ -419,6 +419,8 @@ static int msm_drm_init(struct device *dev, const 
>> struct drm_driver *drv)
>>           }
>>       }
>> +    drm_helper_move_panel_connectors_to_head(ddev);
>> +
>>       ddev->mode_config.funcs = &mode_config_funcs;
>>       ddev->mode_config.helper_private = &mode_config_helper_funcs;
