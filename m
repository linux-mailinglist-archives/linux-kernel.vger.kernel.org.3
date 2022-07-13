Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD9E573947
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbiGMOxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiGMOw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:52:59 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2543C14D;
        Wed, 13 Jul 2022 07:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657723978; x=1689259978;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=CNNiJMucRthl7fECf9E6Pn8zMqMHyA+cokmpGr/PmFI=;
  b=WnYtnqOVBbsATaC/Q6BWCrxGRDRsF3c1dJuo/XQi9uW+CIFsHwhIxQMs
   6f7npLNQDw+lsGxcmaDfpeDXfT4ZTF30dWDGQgOCUt7S6k6nPwXMqWk9n
   YwO1LhIGeTxCsRdvy3Gi192QqYJ/IXZqUSmywRrnjLSN2dyYYabzCnwul
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Jul 2022 07:52:58 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 07:52:58 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Jul 2022 07:52:57 -0700
Received: from [10.216.22.132] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 13 Jul
 2022 07:52:52 -0700
Message-ID: <8cde58d2-3b10-b88b-2d10-88e76fbcac06@quicinc.com>
Date:   Wed, 13 Jul 2022 20:22:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] soundwire: qcom: Update error prints to debug prints
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <vkoul@kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
References: <1657714921-28072-1-git-send-email-quic_srivasam@quicinc.com>
 <75e9b775-3bbe-0b34-2bd6-b4ac74620672@linux.intel.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <75e9b775-3bbe-0b34-2bd6-b4ac74620672@linux.intel.com>
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


On 7/13/2022 7:53 PM, Pierre-Louis Bossart wrote:
Thanks for your time Pierre-Louis!!!
>
> On 7/13/22 07:22, Srinivasa Rao Mandadapu wrote:
>> Upadte error prints to debug prints to avoid redundant logging in kernel
> update
Okay. Will change it.
>
>> boot time, as these prints are informative prints in irq handler.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> ---
>>   drivers/soundwire/qcom.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>> index 9df970e..a4293d0 100644
>> --- a/drivers/soundwire/qcom.c
>> +++ b/drivers/soundwire/qcom.c
>> @@ -573,11 +573,10 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
>>   				break;
>>   			case SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED:
>>   			case SWRM_INTERRUPT_STATUS_CHANGE_ENUM_SLAVE_STATUS:
>> -				dev_err_ratelimited(swrm->dev, "%s: SWR new slave attached\n",
>> -					__func__);
>> +				dev_dbg(swrm->dev, "%s: SWR new slave attached\n", __func__);
> any reason why the rate limitation was dropped?
No Specific Reason as such. Will add ratelimited and re-spin it.
>
>>   				swrm->reg_read(swrm, SWRM_MCP_SLV_STATUS, &slave_status);
>>   				if (swrm->slave_status == slave_status) {
>> -					dev_err(swrm->dev, "Slave status not changed %x\n",
>> +					dev_dbg(swrm->dev, "Slave status not changed %x\n",
>>   						slave_status);
>>   				} else {
>>   					qcom_swrm_get_device_status(swrm);
