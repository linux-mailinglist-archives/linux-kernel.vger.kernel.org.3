Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03424573B86
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbiGMQqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236826AbiGMQqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:46:31 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21F52FFE3;
        Wed, 13 Jul 2022 09:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657730783; x=1689266783;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=kqLgUdZi53D6drYvYhKcGz92QsRtwzVgO8AAS9UQ2q0=;
  b=y21v731/ufUxDI49JyraQWlz4OhYm+dpXUZTDEBK2aFDqXh2agnNXmCx
   hHpwyIO3FqaP9bDi6aV6W8i4ysYZ/EV+TyuhqjQSzesFyD+riNF8Afddj
   5GR/RcTeAsOMTm8onCYQxqDsMp1SqlYLRxOqDq7hyPPLkxA8LEIdwDiUA
   c=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Jul 2022 09:46:23 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 09:46:22 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Jul 2022 09:46:22 -0700
Received: from [10.216.11.138] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 13 Jul
 2022 09:46:05 -0700
Message-ID: <3def0f92-6784-df60-9533-e2902cda0185@quicinc.com>
Date:   Wed, 13 Jul 2022 22:15:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] soundwire: qcom: Update error prints to debug prints
Content-Language: en-US
To:     Joe Perches <joe@perches.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
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
 <8cde58d2-3b10-b88b-2d10-88e76fbcac06@quicinc.com>
 <75404573094d1c46172fcd51dad6a4e564da1542.camel@perches.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <75404573094d1c46172fcd51dad6a4e564da1542.camel@perches.com>
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


On 7/13/2022 9:31 PM, Joe Perches wrote:
Thanks for your time Joe!!!
> On Wed, 2022-07-13 at 20:22 +0530, Srinivasa Rao Mandadapu wrote:
>> On 7/13/2022 7:53 PM, Pierre-Louis Bossart wrote:
>> Thanks for your time Pierre-Louis!!!
>>> On 7/13/22 07:22, Srinivasa Rao Mandadapu wrote:
>>>> Upadte error prints to debug prints to avoid redundant logging in kernel
>>> update
> []
>>>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> []
>>>> @@ -573,11 +573,10 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
>>>>    				break;
>>>>    			case SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED:
>>>>    			case SWRM_INTERRUPT_STATUS_CHANGE_ENUM_SLAVE_STATUS:
>>>> -				dev_err_ratelimited(swrm->dev, "%s: SWR new slave attached\n",
>>>> -					__func__);
>>>> +				dev_dbg(swrm->dev, "%s: SWR new slave attached\n", __func__);
> Could also drop the "%s: ", __func__ as it's already a unique message
> and dynamic debug could add it back if really desired.
Okay. It's removed and posted v2 patch.
>
