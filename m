Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A18355F5AD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 07:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiF2FcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 01:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiF2FcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 01:32:12 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F7527B2F;
        Tue, 28 Jun 2022 22:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656480731; x=1688016731;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HIMONIVkKmgkvahLcy/boT057QXRUoGCDFGbCyd0dk0=;
  b=k21jNLsOWiu2Uf+yr5ZbbfokNbBqDO9DGzCijuxQv9jWQJ619TlbEOtB
   nKpSxjJjaeN2ejbuMZUcmMxIXaPIR2s1XqbE8SqUInGKKharzt5ubulrV
   805Ef6ZBPViy37VEMBmHkK2kTaipZ2/yFSUAP52IDjLGEzkWt2dgbcNa/
   w=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Jun 2022 22:32:10 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 22:32:10 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 28 Jun 2022 22:32:09 -0700
Received: from [10.216.41.7] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 28 Jun
 2022 22:32:03 -0700
Message-ID: <654c8819-5721-838e-4148-6fbdc5fc2dcd@quicinc.com>
Date:   Wed, 29 Jun 2022 11:01:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 1/2] drm/msm/a6xx: Add support for a new 7c3 sku
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "Jonathan Marek" <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        "Sean Paul" <sean@poorly.run>, <linux-kernel@vger.kernel.org>
References: <20220510132256.v2.1.Ibf12c1b99feecc4130f1e3130a3fc4ddd710a2e9@changeid>
 <YrvVPiLQL6d4MrFV@builder.lan>
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <YrvVPiLQL6d4MrFV@builder.lan>
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

On 6/29/2022 9:59 AM, Bjorn Andersson wrote:
> On Tue 10 May 02:53 CDT 2022, Akhil P Oommen wrote:
>
>> Add a new sku to the fuse map of 7c3 gpu.
>>
>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> Is this series still needed/wanted? I've been waiting for patch 1 to be
> merged in the driver so that I can pick up the dts change.
>
> Regards,
> Bjorn
Internally, this sku is on hold. So we can drop this series for now. I 
will resend it if required in future.

-Akhil.

>
>> ---
>>
>> (no changes since v1)
>>
>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> index 841e47a..61bb21d 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> @@ -1771,6 +1771,8 @@ static u32 adreno_7c3_get_speed_bin(u32 fuse)
>>   		return 0;
>>   	else if (fuse == 190)
>>   		return 1;
>> +	else if (fuse == 96)
>> +		return 2;
>>   
>>   	return UINT_MAX;
>>   }
>> -- 
>> 2.7.4
>>

