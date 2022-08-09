Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6F358D6BF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239687AbiHIJuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237382AbiHIJuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:50:02 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE09422B33;
        Tue,  9 Aug 2022 02:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1660038600; x=1691574600;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=xWYW2Lx5IACZPNUh/Q9fUyIb0IGLSPm5Yvm9TlxCy8o=;
  b=p5hXZbBtmh8yvWRYgLAfwa5iqGUNZM8HzlX7GhUDxHrvpWBFBAGFm4wL
   ifMbMPytb504zzHfgJzDxkrTN31JGnLAAmfd0ejRTlr+qA1EreJEg6Qi+
   VzVLIoRsdPPJR7/QdHouHBv3aGviSHPJNAlszkoCM2ju2Zy4GNpn6gzxC
   o=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Aug 2022 02:50:00 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 02:50:00 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 9 Aug 2022 02:49:58 -0700
Received: from [10.216.39.97] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 9 Aug 2022
 02:49:52 -0700
Message-ID: <3358f337-1c8a-3fff-e9de-fde44a2d6db2@quicinc.com>
Date:   Tue, 9 Aug 2022 15:19:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/8] remoteproc: qcom: Add compatible name for SC7280 ADSP
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
References: <1659536480-5176-1-git-send-email-quic_srivasam@quicinc.com>
 <1659536480-5176-4-git-send-email-quic_srivasam@quicinc.com>
 <6327ba5b-f3a9-7390-0456-67ba5ffde0b6@linaro.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <6327ba5b-f3a9-7390-0456-67ba5ffde0b6@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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


On 8/7/2022 2:27 AM, Dmitry Baryshkov wrote:
Thanks for Your Time Dimtry!!!
> On 03/08/2022 17:21, Srinivasa Rao Mandadapu wrote:
>> Update adsp pil data and compatible name for loading ADSP
>> binary on SC7280 based platforms.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> ---
>>   drivers/remoteproc/qcom_q6v5_adsp.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c 
>> b/drivers/remoteproc/qcom_q6v5_adsp.c
>> index 2f3b9f5..bb4494c 100644
>> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
>> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
>> @@ -697,6 +697,24 @@ static const struct adsp_pil_data 
>> adsp_resource_init = {
>>       },
>>   };
>>   +static const struct adsp_pil_data adsp_sc7280_resource_init = {
>> +    .crash_reason_smem = 423,
>> +    .firmware_name = "adsp.mbn",
>> +    .load_state = "adsp",
>> +    .ssr_name = "lpass",
>> +    .sysmon_name = "adsp",
>> +    .ssctl_id = 0x14,
>> +    .is_wpss = false,
>> +    .auto_boot = true,
>> +    .clk_ids = (const char*[]) {
>> +        "gcc_cfg_noc_lpass", NULL
>
> The clock is not mentioned in dt bindings.
Will update in dt bindings and re post it.
>
>> +    },
>> +    .num_clks = 1,
>> +    .proxy_pd_names = (const char*[]) {
>> +        NULL
>> +    },
>
> Is the empty array necessary?
Okay. Will remove it.
>
>> +};
>> +
>>   static const struct adsp_pil_data cdsp_resource_init = {
>>       .crash_reason_smem = 601,
>>       .firmware_name = "cdsp.mdt",
>> @@ -737,6 +755,7 @@ static const struct of_device_id adsp_of_match[] = {
>>       { .compatible = "qcom,qcs404-cdsp-pil", .data = 
>> &cdsp_resource_init },
>>       { .compatible = "qcom,sc7280-wpss-pil", .data = 
>> &wpss_resource_init },
>>       { .compatible = "qcom,sdm845-adsp-pil", .data = 
>> &adsp_resource_init },
>> +    { .compatible = "qcom,sc7280-adsp-pil", .data = 
>> &adsp_sc7280_resource_init },
>>       { },
>>   };
>>   MODULE_DEVICE_TABLE(of, adsp_of_match);
>
>
