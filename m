Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D74C4B8BA5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbiBPOlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:41:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiBPOlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:41:46 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4072716B;
        Wed, 16 Feb 2022 06:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645022493; x=1676558493;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=NTr5l/kjPw/+EYpzQlgU6KSNc69rhpWj63Jfbws9zPY=;
  b=DygwmQC5pIRj564kjAiDpm98tmPYtTZom6ML5reMZWeG8FuRiusPgxAF
   EPlkKHkDFdQK0dVFha55gKMe9Fols0CyDYbGTJgkbOM10dNEtIn94DJkP
   udonTevDXJawwfIshfypa2Wg7HN4yCfljwFSV3boIDG6gEaYfJPBilvOr
   Y=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 16 Feb 2022 06:41:31 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 06:41:30 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 16 Feb 2022 06:41:30 -0800
Received: from [10.216.55.237] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 16 Feb
 2022 06:41:24 -0800
Subject: Re: [PATCH v6 7/7] pinctrl: qcom: Update clock voting as optional
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@codeaurora.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <rohitkr@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1644851994-22732-1-git-send-email-quic_srivasam@quicinc.com>
 <1644851994-22732-8-git-send-email-quic_srivasam@quicinc.com>
 <a209336a-9108-f1ac-ee6d-a838df115c6d@linaro.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
Message-ID: <b663f63f-4a5a-3a2a-9be7-fa7258ce93c5@quicinc.com>
Date:   Wed, 16 Feb 2022 20:11:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <a209336a-9108-f1ac-ee6d-a838df115c6d@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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


On 2/16/2022 7:50 PM, Srinivas Kandagatla wrote:
Thanks for Your Time Srini!!!
>
> On 14/02/2022 15:19, Srinivasa Rao Mandadapu wrote:
>> Update bulk clock voting to optional voting as ADSP bypass platform 
>> doesn't
>> need macro and decodec clocks, these are maintained as power domains and
>> operated from lpass audio core cc.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   drivers/pinctrl/qcom/pinctrl-lpass-lpi.c        | 16 +++++++++-------
>>   drivers/pinctrl/qcom/pinctrl-lpass-lpi.h        |  1 +
>>   drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c |  1 +
>>   3 files changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c 
>> b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
>> index 8a82fd9..103f0a6c 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
>> @@ -407,13 +407,15 @@ int lpi_pinctrl_probe(struct platform_device 
>> *pdev)
>>           return dev_err_probe(dev, PTR_ERR(pctrl->slew_base),
>>                        "Slew resource not provided\n");
>>   -    ret = devm_clk_bulk_get(dev, MAX_LPI_NUM_CLKS, pctrl->clks);
>> -    if (ret)
>> -        return dev_err_probe(dev, ret, "Can't get clocks\n");
>> -
>> -    ret = clk_bulk_prepare_enable(MAX_LPI_NUM_CLKS, pctrl->clks);
>> -    if (ret)
>> -        return dev_err_probe(dev, ret, "Can't enable clocks\n");
>> +    if (!data->is_clk_optional) {
>> +        ret = devm_clk_bulk_get(dev, MAX_LPI_NUM_CLKS, pctrl->clks);
>> +        if (ret)
>> +            return dev_err_probe(dev, ret, "Can't get clocks\n");
>> +
>> +        ret = clk_bulk_prepare_enable(MAX_LPI_NUM_CLKS, pctrl->clks);
>> +        if (ret)
>> +            return dev_err_probe(dev, ret, "Can't enable clocks\n");
>> +    }
>>         pctrl->desc.pctlops = &lpi_gpio_pinctrl_ops;
>>       pctrl->desc.pmxops = &lpi_gpio_pinmux_ops;
>> diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h 
>> b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
>> index a511d72..c1079bf 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
>> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
>> @@ -77,6 +77,7 @@ struct lpi_pinctrl_variant_data {
>>       int ngroups;
>>       const struct lpi_function *functions;
>>       int nfunctions;
>> +    int is_clk_optional;
>>   };
>>     int lpi_pinctrl_probe(struct platform_device *pdev);
>> diff --git a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c 
>> b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
>> index 5bf30d97..4277e31 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
>> @@ -143,6 +143,7 @@ static const struct lpi_pinctrl_variant_data 
>> sc7280_lpi_data = {
>>       .ngroups = ARRAY_SIZE(sc7280_groups),
>>       .functions = sc7280_functions,
>>       .nfunctions = ARRAY_SIZE(sc7280_functions),
>> +    .is_clk_optional = 1,
>
> This is forcefully set assuming that sc7280 is always used in ADSP 
> bypass mode. Which is not correct.
>
> Can't you use devm_clk_bulk_get_optional instead?

Yes. Agreed. Initially used devm_clk_bulk_get_optional, but Bjorn 
suggested for conditional check instead of optional.

Again Shall we go for optional clock voting?

>
> --srini
>
>>   };
>>     static const struct of_device_id lpi_pinctrl_of_match[] = {
