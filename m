Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4044C8F5E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbiCAPqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbiCAPp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:45:59 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E554ECC8;
        Tue,  1 Mar 2022 07:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646149518; x=1677685518;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C/BjzGXxbcQNucZ4IX+eGwpvmWxMB4jt2HQM1WP1dbg=;
  b=MQteWPZW0dA6PEbnQ5k5EHn4JgBDd7WOjqwTiipPVWNnfCOXrbhz0n+8
   5+edV8OxUj1I/3SYDgeGMGbKlcWdwABaxiroXsncX082w68AM5tyaF/d6
   9IAaK1bxygdDKQyFrSVx50oppQTCwSdDdUDW+sTszrVPVZVyBWt2F6rRQ
   A=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Mar 2022 07:45:17 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 07:45:07 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 1 Mar 2022 07:45:07 -0800
Received: from [10.216.24.177] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Tue, 1 Mar 2022
 07:45:00 -0800
Message-ID: <134a64a9-abab-df25-a613-2d01ac7e5ee5@quicinc.com>
Date:   Tue, 1 Mar 2022 21:14:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 1/2] soundwire: qcom: Add compatible name for v1.6.0
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <alsa-devel@alsa-project.org>, <bgoswami@codeaurora.org>,
        <bjorn.andersson@linaro.org>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <judyhsiao@chromium.org>,
        <lgirdwood@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <quic_plai@quicinc.com>,
        <robh+dt@kernel.org>, <rohitkr@codeaurora.org>,
        <sanyog.r.kale@intel.com>, <srinivas.kandagatla@linaro.org>,
        <tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1646030377-12092-1-git-send-email-quic_srivasam@quicinc.com>
 <1646030377-12092-2-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n53XVfXeVHFhokw7pwSOnL4MQAzDg-83OaH=FB=cB2gqdA@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n53XVfXeVHFhokw7pwSOnL4MQAzDg-83OaH=FB=cB2gqdA@mail.gmail.com>
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


On 3/1/2022 2:32 AM, Stephen Boyd wrote:
> Quoting Srinivasa Rao Mandadapu (2022-02-27 22:39:36)
>> Update compatible string and master data information in soundwire driver
>> to support v1.6.0 in lpass sc7280 based platform.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   drivers/soundwire/qcom.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>> index 9eb31ba..fb183bd 100644
>> --- a/drivers/soundwire/qcom.c
>> +++ b/drivers/soundwire/qcom.c
>> @@ -175,6 +175,11 @@ static struct qcom_swrm_data swrm_v1_5_data = {
>>          .default_cols = 16,
>>   };
>>
>> +static struct qcom_swrm_data swrm_v1_6_data = {
> Why not const?
Okay.
>
>> +       .default_rows = 50,
>> +       .default_cols = 16,
> This is the same as swrm_v1_5_data so just use that struct again?
Okay. Will use  swrm_v1_5_data.
>
>> +};
>> +
>>   #define to_qcom_sdw(b) container_of(b, struct qcom_swrm_ctrl, bus)
>>
>>   static int qcom_swrm_ahb_reg_read(struct qcom_swrm_ctrl *ctrl, int reg,
>> @@ -1343,6 +1348,7 @@ static int qcom_swrm_remove(struct platform_device *pdev)
>>   static const struct of_device_id qcom_swrm_of_match[] = {
>>          { .compatible = "qcom,soundwire-v1.3.0", .data = &swrm_v1_3_data },
>>          { .compatible = "qcom,soundwire-v1.5.1", .data = &swrm_v1_5_data },
> These other structs for v1.5 and v1.3 could also be const.
Okay. Will add const and re post.
>
>> +       { .compatible = "qcom,soundwire-v1.6.0", .data = &swrm_v1_6_data },
>>          {/* sentinel */},
