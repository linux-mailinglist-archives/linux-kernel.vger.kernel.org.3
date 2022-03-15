Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F3B4D9ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 16:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349442AbiCOPek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244057AbiCOPee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:34:34 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD3E3BF83;
        Tue, 15 Mar 2022 08:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647358402; x=1678894402;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BrkCwsrMScpDdULJP2t9eWLoVN/539qVzRcEKcaOnQY=;
  b=A+ABZgqSL+UwVVbTe5kXSkB+24n4+QKPkr6M5FXc2D34oopUOV/1ecmY
   yWeuFWwpfLG8xtVlFbBNL73ap3ZYuuQgLDQLEzAeeEbxfnJREvovIkVpO
   l0uOTQcfCn3SdmrUKdbw15G2ynSZIM/f7/A4qQ1+Z0isTXOAgFYSpKnn2
   Y=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Mar 2022 08:33:22 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 08:33:21 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Mar 2022 08:33:21 -0700
Received: from [10.216.59.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 15 Mar
 2022 08:33:15 -0700
Message-ID: <919b576d-8074-8c78-106e-af2c769413be@quicinc.com>
Date:   Tue, 15 Mar 2022 21:03:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v10 7/7] pinctrl: qcom: Update clock voting as optional
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <agross@kernel.org>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <quic_plai@quicinc.com>,
        <bgoswami@codeaurora.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <srinivas.kandagatla@linaro.org>, <rohitkr@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1646737394-4740-1-git-send-email-quic_srivasam@quicinc.com>
 <1646737394-4740-8-git-send-email-quic_srivasam@quicinc.com>
 <Yieczzo96xSaA7jp@ripper>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <Yieczzo96xSaA7jp@ripper>
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


On 3/8/2022 11:43 PM, Bjorn Andersson wrote:
Thanks for your time Bjorn!!!
> On Tue 08 Mar 03:03 PST 2022, Srinivasa Rao Mandadapu wrote:
>
>> Update bulk clock voting to optional voting as ADSP bypass platform doesn't
>> need macro and decodec clocks,
> Even I am not sure what "ADSP bypass platform" means, so please express
> this better.

Actually LPASS contains internal DSP for post processing and other 
activities. Some vendors are

provided LPASS HW without enabling DSP. That's why, we call ADSP Bypass.

>
> Are they optional because sc7280 typically come with ADSP based audio,
> but it might not and if not then we shouldn't control those clocks?

They are GDSC switches. In ADSP based solution, HLOS intiate as clock to 
DSP firmware and it

handles GDSC switch. In case of ADSP bypass solution,  kernel Clock 
drivers handles them as power domains.

These GDSCs in genaral gets on if we vote for any clock which depends on 
them.

>
>> these are maintained as power domains and
>> operated from lpass audio core cc.
>>
> So there are clocks, but they are exposed as power-domains? Or are you
> just trying to say that the LPASS LPI pinctrl block is always in a
> power-domain controlled by the audio clock-controller?
>
> Regards,
> Bjorn

Yes, They are actually GDSC switches, but they are controlled as power 
domains in case of ADSP bypass case and

as clocks in ADSP based solutions.

>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   drivers/pinctrl/qcom/pinctrl-lpass-lpi.c        | 12 +++++++++---
>>   drivers/pinctrl/qcom/pinctrl-lpass-lpi.h        |  1 +
>>   drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c |  1 +
>>   3 files changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
>> index 1ab572f..c618b74 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
>> @@ -407,9 +407,15 @@ int lpi_pinctrl_probe(struct platform_device *pdev)
>>   		return dev_err_probe(dev, PTR_ERR(pctrl->slew_base),
>>   				     "Slew resource not provided\n");
>>   
>> -	ret = devm_clk_bulk_get(dev, MAX_LPI_NUM_CLKS, pctrl->clks);
>> -	if (ret)
>> -		return dev_err_probe(dev, ret, "Can't get clocks\n");
>> +	if (data->is_clk_optional) {
>> +		ret = devm_clk_bulk_get_optional(dev, MAX_LPI_NUM_CLKS, pctrl->clks);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret, "Can't get clocks\n");
>> +	} else {
>> +		ret = devm_clk_bulk_get(dev, MAX_LPI_NUM_CLKS, pctrl->clks);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret, "Can't get clocks\n");
>> +	}
>>   
>>   	ret = clk_bulk_prepare_enable(MAX_LPI_NUM_CLKS, pctrl->clks);
>>   	if (ret)
>> diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
>> index afbac2a..3bcede6 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
>> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
>> @@ -77,6 +77,7 @@ struct lpi_pinctrl_variant_data {
>>   	int ngroups;
>>   	const struct lpi_function *functions;
>>   	int nfunctions;
>> +	int is_clk_optional;
>>   };
>>   
>>   int lpi_pinctrl_probe(struct platform_device *pdev);
>> diff --git a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
>> index d67ff25..304d8a2 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
>> @@ -142,6 +142,7 @@ static const struct lpi_pinctrl_variant_data sc7280_lpi_data = {
>>   	.ngroups = ARRAY_SIZE(sc7280_groups),
>>   	.functions = sc7280_functions,
>>   	.nfunctions = ARRAY_SIZE(sc7280_functions),
>> +	.is_clk_optional = 1,
>>   };
>>   
>>   static const struct of_device_id lpi_pinctrl_of_match[] = {
>> -- 
>> 2.7.4
>>
