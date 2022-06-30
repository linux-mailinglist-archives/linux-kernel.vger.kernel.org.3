Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43822561F02
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbiF3PSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235657AbiF3PR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:17:59 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A24344D8;
        Thu, 30 Jun 2022 08:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656602278; x=1688138278;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FDi0FOKTrj8PQy31Ckcb5baI4yZzM2OKFrPDYMBFWyQ=;
  b=fAMALFF96QJJx02GpidsUetH1xR7zbCxptjGyzEF7OvkrfEAOlNAqifr
   CVaNX9ZDSrVBL/P1SbdP7MUTONUF/I2JrwErPVSHCQIe+17TLHVKMEQqH
   S9UPP7WF9tBxkKpPwiUpkkGvTPzyqdE99VQ34dIMXQfed5aC6hZU+U+ja
   E=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Jun 2022 08:17:58 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 08:17:57 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 30 Jun 2022 08:17:56 -0700
Received: from [10.216.41.7] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 30 Jun
 2022 08:17:50 -0700
Message-ID: <78bfe8bd-b07e-5a53-156b-ad8b24829f29@quicinc.com>
Date:   Thu, 30 Jun 2022 20:47:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 4/4] drm/msm/adreno: Fix up formatting
Content-Language: en-US
To:     Joe Perches <joe@perches.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        <~postmarketos/upstreaming@lists.sr.ht>
CC:     <martin.botka@somainline.org>,
        <angelogioacchino.delregno@somainline.org>,
        <marijn.suijten@somainline.org>, <jamipkettunen@somainline.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Emma Anholt <emma@anholt.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20220528160353.157870-1-konrad.dybcio@somainline.org>
 <20220528160353.157870-4-konrad.dybcio@somainline.org>
 <d470331985c7d82c6e5bb6d548ab610479416761.camel@perches.com>
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <d470331985c7d82c6e5bb6d548ab610479416761.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/28/2022 10:22 PM, Joe Perches wrote:
> On Sat, 2022-05-28 at 18:03 +0200, Konrad Dybcio wrote:
>> Leading spaces are not something checkpatch likes, and it says so when
>> they are present. Use tabs consistently to indent function body and
>> unwrap a 83-char-long line, as 100 is cool nowadays.
> unassociated trivia:
>
>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> []
>> @@ -199,7 +199,7 @@ static inline int adreno_is_a420(struct adreno_gpu *gpu)
>>   
>>   static inline int adreno_is_a430(struct adreno_gpu *gpu)
>>   {
>> -       return gpu->revn == 430;
>> +	return gpu->revn == 430;
>>   }
> looks like these could/should return bool
But this is just a format fix.

>
>>   static inline int adreno_is_a506(struct adreno_gpu *gpu)
>> @@ -239,7 +239,7 @@ static inline int adreno_is_a540(struct adreno_gpu *gpu)
>>   
>>   static inline int adreno_is_a618(struct adreno_gpu *gpu)
>>   {
>> -       return gpu->revn == 618;
>> +	return gpu->revn == 618;
>>   }
> etc...

Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>


-Akhil.
