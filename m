Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E6E4B94E0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 01:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238677AbiBQAWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 19:22:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiBQAWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 19:22:37 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D478136869;
        Wed, 16 Feb 2022 16:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645057344; x=1676593344;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ucdt4Brg9XCP0oAU6WsflfUGosiIIcW4RUCgD2Kvpt8=;
  b=Kgc4wlnnq3sPDdXte9OnNgKNDEZlU51T+gYRzfsV98rAbpl0se+2KO5s
   eBcZUlY/8ZCxlXTS5q88jB0T0x5ymNVQ2nL+A0XSe0ZYb01cb03NzqEFN
   hzaAxx92gmn7EiJIg6W2NdK72IrgCxk9N9hhb6XWTYbj7FPPzGpQMKATH
   0=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 16 Feb 2022 16:22:24 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 16:22:23 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 16 Feb 2022 16:22:23 -0800
Received: from [10.110.54.133] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 16 Feb
 2022 16:22:21 -0800
Message-ID: <f480811d-3e82-a6c7-1e57-fabe51604f9b@quicinc.com>
Date:   Wed, 16 Feb 2022 16:22:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/3] drm/msm/dp: replace DRM_DEBUG_DP marco with
 drm_dbg_dp
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <airlied@linux.ie>, <bjorn.andersson@linaro.org>,
        <daniel@ffwll.ch>, <dmitry.baryshkov@linaro.org>,
        <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <vkoul@kernel.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1643828199-8564-1-git-send-email-quic_khsieh@quicinc.com>
 <1643828199-8564-4-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n534MH7ih4nKbjY5EewcZ0J73Zp_A=Q-CJ0M_z3nWoVaVQ@mail.gmail.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAE-0n534MH7ih4nKbjY5EewcZ0J73Zp_A=Q-CJ0M_z3nWoVaVQ@mail.gmail.com>
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


On 2/16/2022 3:46 PM, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2022-02-02 10:56:39)
>
> Please add some commit text
>
>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_audio.c   |  49 +++++++++++------
>>   drivers/gpu/drm/msm/dp/dp_catalog.c |  34 +++++++-----
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 106 +++++++++++++++++++-----------------
>>   drivers/gpu/drm/msm/dp/dp_display.c |  68 +++++++++++++----------
>>   drivers/gpu/drm/msm/dp/dp_drm.c     |   4 +-
>>   drivers/gpu/drm/msm/dp/dp_link.c    |  99 +++++++++++++++++++--------------
>>   drivers/gpu/drm/msm/dp/dp_panel.c   |  43 +++++++++------
>>   drivers/gpu/drm/msm/dp/dp_parser.c  |   2 +-
>>   drivers/gpu/drm/msm/dp/dp_power.c   |  20 ++++---
>>   9 files changed, 246 insertions(+), 179 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
>> index d7e4a39..4fbbe0a 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_audio.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_audio.c
>> @@ -136,7 +136,8 @@ static void dp_audio_stream_sdp(struct dp_audio_private *audio)
>>          parity_byte = dp_audio_calculate_parity(new_value);
>>          value |= ((new_value << HEADER_BYTE_1_BIT)
>>                          | (parity_byte << PARITY_BYTE_1_BIT));
>> -       DRM_DEBUG_DP("Header Byte 1: value = 0x%x, parity_byte = 0x%x\n",
>> +       drm_dbg_dp((struct drm_device *)NULL,
> Why can't we pass the platform device pointer? Surely the cast is not
> necessary and in fact harmful.

Platform device only available at top level (dp_display.c), other level 
has no access to platform device or drm_device.

I will just apss NULL, such as  drm_dbg_dp(NULL, ...), if not device 
available.

