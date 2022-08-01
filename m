Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763FA5871FC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbiHAUI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiHAUIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:08:24 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D2827B00;
        Mon,  1 Aug 2022 13:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659384503; x=1690920503;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z2sKdEmuR5GzYMOhpZvEQcMlZYe/O/eQFVyPPPVjpGM=;
  b=vP7AIw461jRm7Q85tnBz+9hQR10wSdo3fF1HOlrzL/nRL0SZPoszkalN
   C6VihlJ1msDuUszMMuztzX7QKh3k2UBtsubpWCAAkyeHcBQbV7FBQ5crz
   1oyug4ILF/WgywcHZ3u83nbEmZo3qcPcJPmXOv+ns/dvFPXJqAvp5iQBS
   A=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Aug 2022 13:08:23 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 13:08:22 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 1 Aug 2022 13:08:22 -0700
Received: from [10.110.16.215] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 1 Aug 2022
 13:08:20 -0700
Message-ID: <89f3dfa2-0983-5e33-281f-94539492d1d2@quicinc.com>
Date:   Mon, 1 Aug 2022 13:08:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/msm/dp: delete DP_RECOVERED_CLOCK_OUT_EN to fix tps4
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <airlied@linux.ie>, <bjorn.andersson@linaro.org>,
        <daniel@ffwll.ch>, <dianders@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <vkoul@kernel.org>
CC:     <quic_aravindh@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1659382970-17477-1-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n52=zJ0ScrknAhsvJQc5hXP7+TGaoa4gnaVzsT26bQL_Uw@mail.gmail.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAE-0n52=zJ0ScrknAhsvJQc5hXP7+TGaoa4gnaVzsT26bQL_Uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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



On 8/1/2022 12:51 PM, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2022-08-01 12:42:50)
>> Data Symbols scrambled is required for tps4 at link training 2.
>> Therefore SCRAMBLING_DISABLE bit should not be set for tps4 to
>> work.
>> RECOVERED_CLOCK_OUT_EN is for enable simple EYE test for jitter
>> measurement with minimal equipment for embedded applications purpose
>> and is not required to be set during normal operation.
>> Current implementation always have RECOVERED_CLOCK_OUT_EN bit set
>> which cause SCRAMBLING_DISABLE bit wrongly set at tps4 which prevent
>> tps4 from working.
>> This patch delete setting RECOVERED_CLOCK_OUT_EN to fix SCRAMBLING_DISABLE
>> be wrongly set at tps4.
>>
>> Fixes: 956653250b21 ("drm/msm/dp: add support of tps4 (training pattern 4) for HBR3")
>>
>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index ab6aa13..013ca02 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> @@ -1214,7 +1214,7 @@ static int dp_ctrl_link_train_2(struct dp_ctrl_private *ctrl,
>>          if (ret)
>>                  return ret;
>>
>> -       dp_ctrl_train_pattern_set(ctrl, pattern | DP_RECOVERED_CLOCK_OUT_EN);
>> +       dp_ctrl_train_pattern_set(ctrl, pattern);
> This line is from the first patch introducing this driver. Even if this
> is fixing tps4 support, it sounds like the bit should never have been
> enabled in the first place. Why isn't the fixes tag targeted at the
> first commit? Does it hurt to apply it without commit 956653250b21?
agree, it should be fixed to first patch
