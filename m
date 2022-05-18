Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93DE52C140
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241129AbiERRaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241081AbiERRaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:30:00 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F56719FF43;
        Wed, 18 May 2022 10:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652894999; x=1684430999;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FjJ+9xSrC3MzYALAqvbVXtyf2yB1lnVWdTlBlRcSlBc=;
  b=ycjzq0C/pLYzMmGGHYZKA7RiBrWB+24+r6xjmgMxWdMs9tLCtUu2HOeq
   uMyI3r/xqCsJYADkgYI5IGJ8fxwW4w9z6rtSOa8oFL6EcIJRVCTKmdxKB
   +lE1yzIlpwRRiS60FBb5ips9dR0cljxb1qSxtbZwZ7r+UmUcxyu3z+XxV
   c=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 May 2022 10:29:59 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 10:29:58 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 10:29:58 -0700
Received: from [10.110.42.114] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 18 May
 2022 10:29:57 -0700
Message-ID: <98295144-2e05-674b-4983-5f1738480c86@quicinc.com>
Date:   Wed, 18 May 2022 10:29:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 0/2] eDP/DP Phy vdda realted function
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1652892186-22346-1-git-send-email-quic_khsieh@quicinc.com>
 <CAA8EJpqq4fxxgY0mj0JBans3GE-HAuad4Zsf7Ntwy1WW3bHbTQ@mail.gmail.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAA8EJpqq4fxxgY0mj0JBans3GE-HAuad4Zsf7Ntwy1WW3bHbTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/18/2022 10:16 AM, Dmitry Baryshkov wrote:
> On Wed, 18 May 2022 at 19:43, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>> 1) add regulator_set_load() to eDP/DP phy
>> 2) remove vdda related function out of eDP/DP controller
> These patches touch two subsystems and have a dependency between them.
> How do we merge them?

currently, both phy and controller are vote for regulator. The last vote 
will just increase count.

Therefore the dependency should be very loose.


>> Kuogee Hsieh (2):
>>    phy/qcom: add regulator_set_load to edp/dp phy
>>    drm/msm/dp: delete vdda regulator related functions from eDP/DP
>>      controller
>>
>>   drivers/gpu/drm/msm/dp/dp_parser.c  | 14 ------
>>   drivers/gpu/drm/msm/dp/dp_parser.h  |  6 ---
>>   drivers/gpu/drm/msm/dp/dp_power.c   | 95 +------------------------------------
>>   drivers/phy/qualcomm/phy-qcom-edp.c | 25 ++++++++--
>>   drivers/phy/qualcomm/phy-qcom-qmp.c | 13 +++++
>>   5 files changed, 36 insertions(+), 117 deletions(-)
>>
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
>
