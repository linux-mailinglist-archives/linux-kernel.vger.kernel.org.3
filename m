Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA2D58D3D6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 08:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237693AbiHIGet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 02:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbiHIGer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 02:34:47 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A832018A;
        Mon,  8 Aug 2022 23:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1660026886; x=1691562886;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mg9vIVUx08wD84/AJ2iAaKf+in4l8tFD4HkpfPm7fKM=;
  b=qcw3ocxwzR+U//C+Y7QnlcJI4Hlz58wabrOch2Ntrr1qw1CX3Az3A2lP
   aa1WM4EsIPUnMMhkr3nlxoT8ccnWM5VYnWF+ZeOGhNLjl9iSF7cIZe7sW
   Vgyu33qwYs++GdSgEUAYoPAgpA+7gZPrL9YL+l1srbyFYYnQFzp8Eitoh
   8=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 08 Aug 2022 23:34:46 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 23:34:45 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 8 Aug 2022 23:34:44 -0700
Received: from [10.216.39.97] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 8 Aug 2022
 23:34:38 -0700
Message-ID: <e3e087ba-b6d8-981f-e22f-cadd557c35af@quicinc.com>
Date:   Tue, 9 Aug 2022 12:04:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 7/8] remoteproc: qcom: Add support for memory sandbox
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     <agross@kernel.org>, <bgoswami@quicinc.com>,
        <bjorn.andersson@linaro.org>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <judyhsiao@chromium.org>,
        <lgirdwood@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <perex@perex.cz>, <quic_plai@quicinc.com>,
        <quic_rohkumar@quicinc.com>, <robh+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <swboyd@chromium.org>,
        <tiwai@suse.com>
References: <1659536480-5176-1-git-send-email-quic_srivasam@quicinc.com>
 <1659536480-5176-8-git-send-email-quic_srivasam@quicinc.com>
 <2729cd6f-17ff-70d8-52c5-3dceb93e6a82@wanadoo.fr>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <2729cd6f-17ff-70d8-52c5-3dceb93e6a82@wanadoo.fr>
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


On 8/7/2022 2:09 AM, Christophe JAILLET wrote:
Thanks for Your Time CJ!!!
> Hi,
>
> the error handling below looks odd.
>
> Le 03/08/2022 à 16:21, Srinivasa Rao Mandadapu a écrit :
>> Add memory sandbox support for ADSP based platforms secure booting.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu 
>> <quic_srivasam-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org>
>> ---
>>   drivers/remoteproc/qcom_q6v5_adsp.c | 101 
>> +++++++++++++++++++++++++++++++++++-
>>   1 file changed, 99 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c 
>> b/drivers/remoteproc/qcom_q6v5_adsp.c
>> index 3dbd035..f81da47 100644
>> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
>> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
>
>>   static int adsp_start(struct rproc *rproc)
>>   {
>>       struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
>> @@ -341,7 +429,13 @@ static int adsp_start(struct rproc *rproc)
>>       ret = qcom_q6v5_prepare(&adsp->q6v5);
>>       if (ret)
>>           return ret;
>> -
>> +    if (!adsp->is_wpss) {
>> +        ret = adsp_map_smmu(adsp, rproc);
>> +        if (ret) {
>> +            dev_err(adsp->dev, "ADSP smmu mapping failed\n");
>> +            goto adsp_smmu_unmap;
> goto disable_irqs;?
Yes. will correct it accordingly.
>
>> +        }
>> +    }
>>       ret = clk_prepare_enable(adsp->xo);
>>       if (ret)
>>           goto disable_irqs;
>
> goto adsp_smmu_unmap;?
Yes. will correct it accordingly.
>
>> @@ -402,6 +496,9 @@ static int adsp_start(struct rproc *rproc)
>>       clk_disable_unprepare(adsp->xo);
>>   disable_irqs:
>>       qcom_q6v5_unprepare(&adsp->q6v5);
>> +adsp_smmu_unmap:
>> +    iommu_unmap(adsp->iommu_dom, adsp->mem_phys, adsp->mem_size);
>> +    iommu_domain_free(adsp->iommu_dom);
>
> Should this new hunk be above disable_irqs?
> And I think that it should be guardd with a "if (!adsp->is_wpss)".
Yes. will correct it accordingly.
>
> CJ
>
>>         return ret;
>>   }
>
