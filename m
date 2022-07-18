Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9428C57897B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbiGRSV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbiGRSVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:21:25 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68EA2ED7B;
        Mon, 18 Jul 2022 11:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658168484; x=1689704484;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=8scmRzdfuIEvcSseij22MbSKAuV9T6SSdN+N6EeZDm0=;
  b=Sega/9F93qB3Fc7peKkyOnu3+QheE+Q9V0H87rv3+vJM9YwPzH38MpDg
   1KhbkUsr9aMk9yru6VosEHeyrHCAmyxIs3TzTl/+LgseKj8bX4sL2SBgL
   s3+3zppcRlO+qY3q64bleJxSs6IFc55UiJoxosknQLGEhnL67+CqMwRtE
   g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Jul 2022 11:21:24 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 11:21:24 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Jul 2022 11:21:23 -0700
Received: from [10.38.240.17] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 18 Jul
 2022 11:21:22 -0700
Message-ID: <de0037e7-aef5-ca30-6b95-9ad644435ed5@quicinc.com>
Date:   Mon, 18 Jul 2022 11:21:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [Freedreno] [PATCH RESEND] drm/msm/dsi: fix the inconsistent
 indenting
Content-Language: en-US
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
To:     sunliming <sunliming@kylinos.cn>, <christian.koenig@amd.com>,
        <robdclark@gmail.com>, <dmitry.baryshkov@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <kelulanainsley@gmail.com>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "kernel test robot" <lkp@intel.com>
References: <20220708005832.439722-1-sunliming@kylinos.cn>
 <57d342b6-6254-9bb0-da80-a2f6b4d5eefe@quicinc.com>
In-Reply-To: <57d342b6-6254-9bb0-da80-a2f6b4d5eefe@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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



On 7/8/2022 9:03 AM, Abhinav Kumar wrote:
> 
> 
> On 7/7/2022 5:58 PM, sunliming wrote:
>> Fix the inconsistent indenting in function msm_dsi_dphy_timing_calc_v3().
>>
>> Fix the following smatch warnings:
>>
>> drivers/gpu/drm/msm/dsi/phy/dsi_phy.c:350 
>> msm_dsi_dphy_timing_calc_v3() warn: inconsistent indenting
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: sunliming <sunliming@kylinos.cn>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Fixes: f1fa7ff44056 ("drm/msm/dsi: implement auto PHY timing calculator 
for 10nm PHY")
>> ---
>>   drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c 
>> b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
>> index a39de3bdc7fa..56dfa2d24be1 100644
>> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
>> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
>> @@ -347,7 +347,7 @@ int msm_dsi_dphy_timing_calc_v3(struct 
>> msm_dsi_dphy_timing *timing,
>>       } else {
>>           timing->shared_timings.clk_pre =
>>               linear_inter(tmax, tmin, pcnt2, 0, false);
>> -            timing->shared_timings.clk_pre_inc_by_2 = 0;
>> +        timing->shared_timings.clk_pre_inc_by_2 = 0;
>>       }
>>       timing->ta_go = 3;
