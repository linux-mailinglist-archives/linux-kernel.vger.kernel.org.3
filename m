Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBDA573939
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbiGMOvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbiGMOvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:51:18 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB443C142;
        Wed, 13 Jul 2022 07:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657723878; x=1689259878;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=usEfZWG3K+DfGjkb7INoXNmqgT2ynC9Rk8m0pztykNE=;
  b=G3bBANNsQFl/6rkTep8Od1gu3IbsEY8UjhpdGqkFi3imoB1sngbcRHOR
   xLGr80hS2SV0pFguyCmF7mu31IeWLVjTsJuLlInCS+DvHgQdedTYtya6Q
   1ABFILm7IJVgJmSdNVE1bbGYf2ZAlyz6KoHszH9oQEAHaFd99shj8DxPb
   o=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Jul 2022 07:51:18 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 07:51:17 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Jul 2022 07:51:17 -0700
Received: from [10.216.22.132] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 13 Jul
 2022 07:51:10 -0700
Message-ID: <b5776efd-4d30-3dbf-796d-4f29ed1e3a92@quicinc.com>
Date:   Wed, 13 Jul 2022 20:21:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] soundwire: qcom: Update error prints to debug prints
Content-Language: en-US
To:     Andrew Halaney <ahalaney@redhat.com>
CC:     <vkoul@kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
References: <1657714921-28072-1-git-send-email-quic_srivasam@quicinc.com>
 <20220713135603.4vkyofw6x4mldxzp@halaneylaptop>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <20220713135603.4vkyofw6x4mldxzp@halaneylaptop>
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


On 7/13/2022 7:26 PM, Andrew Halaney wrote:
Thanks for your time Andrew.
> A couple of drive by nits:
>
> On Wed, Jul 13, 2022 at 05:52:01PM +0530, Srinivasa Rao Mandadapu wrote:
>> Upadte error prints to debug prints to avoid redundant logging in kernel
>> boot time, as these prints are informative prints in irq handler.
> s/Upadte/Update/
Okay. Will fix it.
>
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
> There's no need for __func__ usage with dev_dbg() when giving +f flag
> when enabling adds this for you!
Okay. Will remove __func__ and change dev_dbg() to dev_dbg_ratelimited().
>
> With those changes feel free to add:
>
>      Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
>
> Thanks,
> Andrew
>
>>   				swrm->reg_read(swrm, SWRM_MCP_SLV_STATUS, &slave_status);
>>   				if (swrm->slave_status == slave_status) {
>> -					dev_err(swrm->dev, "Slave status not changed %x\n",
>> +					dev_dbg(swrm->dev, "Slave status not changed %x\n",
>>   						slave_status);
>>   				} else {
>>   					qcom_swrm_get_device_status(swrm);
>> -- 
>> 2.7.4
>>
