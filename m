Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD3E4DB54B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357389AbiCPPt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354614AbiCPPt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:49:57 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95AF443F2;
        Wed, 16 Mar 2022 08:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647445722; x=1678981722;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GudUircLqgrKK4G/097tEeYgThr0aEszZyU2Auw0xeA=;
  b=ityGNDl4HBMfCE/0y2EqpCrul/IG9pT7aV1c/2ZghdXAYA+R46AH1hLO
   XiohseSgG05a2ML735pA7lYp0DzAo8rztOc1tZrp60xLoNax05cZmYsXN
   +j22VthjV81d7XbeCQ9Oe066gsVkxhabEBbNyJgnQPX4uEB0yT1KD8BCN
   o=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 16 Mar 2022 08:48:42 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 08:48:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 16 Mar 2022 08:48:40 -0700
Received: from [10.216.40.72] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 16 Mar
 2022 08:48:34 -0700
Message-ID: <61fcca7d-983d-7f87-2ca2-e68dea7bc0b4@quicinc.com>
Date:   Wed, 16 Mar 2022 21:18:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v11 7/7] pinctrl: qcom: Update clock voting as optional
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
References: <1647359413-31662-1-git-send-email-quic_srivasam@quicinc.com>
 <1647359413-31662-8-git-send-email-quic_srivasam@quicinc.com>
 <YjDFcJOA8An58iTe@builder.lan>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YjDFcJOA8An58iTe@builder.lan>
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


On 3/15/2022 10:27 PM, Bjorn Andersson wrote:
Thanks for your time Bjorn!!!
> On Tue 15 Mar 10:50 CDT 2022, Srinivasa Rao Mandadapu wrote:
>
>> Update bulk clock voting to optional voting as ADSP bypass platform doesn't
>> need macro and decodec clocks, as these macro and dcodec GDSC switches are
>> maintained as power domains and operated from lpass clock drivers.
>>
> Sorry for missing your reply on my question on the previous version, I
> think this sounds reasonable.
Okay. Thanks!!!
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
>> index 0216ca1..3fc473a 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
>> @@ -401,9 +401,15 @@ int lpi_pinctrl_probe(struct platform_device *pdev)
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
> Dug into the clk_bulk_get() functions, and __clk_bulk_get() will print
> an error telling you which clock it failed to get. So I don't think your
> more generic error here doesn't add any value.
>
> Just return ret;
Okay will change accordingly.
>
>> +	} else {
>> +		ret = devm_clk_bulk_get(dev, MAX_LPI_NUM_CLKS, pctrl->clks);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret, "Can't get clocks\n");
>> +	}
> Depending on your taste, you could do:
>
> 	if (data->is_clk_optional)
> 		ret = devm_clk_bulk_get_optional();
> 	else
> 		ret = devm_clk_bulk_get();
>
> 	if (ret)
> 		return ret;
Okay. Will change accordingly.
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
> bool here please.
Okay. Will update.
>
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
> true
Okay.
>
> Regards,
> Bjorn
>
>>   };
>>   
>>   static const struct of_device_id lpi_pinctrl_of_match[] = {
>> -- 
>> 2.7.4
>>
