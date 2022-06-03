Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83AC53C902
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 13:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243896AbiFCLD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 07:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237380AbiFCLD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 07:03:26 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4CA2F016;
        Fri,  3 Jun 2022 04:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654254203; x=1685790203;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KBAKvX9/GNCNqNjkKFmolG/8gDtP8L5C5SntjrMrokk=;
  b=i9I+iSIeAGz4hn6PBEqLa2v0hEm4WFbZz7e94472vMSVkS2KmEZDEf73
   jJvHa3ZBH3C2BM21znnrcBtorvblxJMv5ubAhSFEK/95C/FZteDnKn+J6
   KFFw4A7QOAmCfnsJdAnbW0Odj8HtaiFUQL2JOzxUHZM3ntELXIcQ6Uc3r
   Q=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 03 Jun 2022 04:03:23 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 04:03:22 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 3 Jun 2022 04:03:21 -0700
Received: from [10.216.32.198] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 3 Jun 2022
 04:03:15 -0700
Message-ID: <a2b7de25-55a4-7d31-2787-be6d0ccf9500@quicinc.com>
Date:   Fri, 3 Jun 2022 16:33:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 2/2] pinctrl: qcom: sc7280: Add lpi pinctrl variant
 data for adsp based targets
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <linux-gpio@vger.kernel.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1654079415-26217-1-git-send-email-quic_srivasam@quicinc.com>
 <1654079415-26217-3-git-send-email-quic_srivasam@quicinc.com>
 <CACRpkdYQW7WByaGoSFKT91OwRao_jJdCAbL0pUuj3vdS6TdkQg@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CACRpkdYQW7WByaGoSFKT91OwRao_jJdCAbL0pUuj3vdS6TdkQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/3/2022 3:58 PM, Linus Walleij wrote:
Thanks for Your time and valuable inputs Linus!!!
> On Wed, Jun 1, 2022 at 12:30 PM Srinivasa Rao Mandadapu
> <quic_srivasam@quicinc.com> wrote:
>
> So one way to just use a propert and avoid more compatible strings:
>
>> Add compatible string and lpi pinctrl variant data structure for adsp
>> enabled sc7280 platforms.
>> This variant data structure rnd compatible name required for
>> distingushing ADSP based platforms and ADSP bypass platforms.
>> In case of ADSP enabled platforms, where audio is routed through ADSP
>> macro and decodec GDSC Switches are triggered as clocks by pinctrl
>> driver and ADSP firmware controls them. So It's mandatory to enable
>> them in ADSP based solutions.
>> In case of ADSP bypass platforms clock voting is optional as these macro
>> and dcodec GDSC switches are maintained as power domains and operated from
>> lpass clock drivers.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
>> index 2add9a4..c9e85d9 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
>> @@ -134,6 +134,16 @@ static const struct lpi_function sc7280_functions[] = {
>>          LPI_FUNCTION(wsa_swr_data),
>>   };
>>
>> +static const struct lpi_pinctrl_variant_data sc7280_adsp_lpi_data = {
> Remove static and export this struct in drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
We can remove entire data structure if my below approach is okay.
>
>> +       .pins = sc7280_lpi_pins,
>> +       .npins = ARRAY_SIZE(sc7280_lpi_pins),
>> +       .groups = sc7280_groups,
>> +       .ngroups = ARRAY_SIZE(sc7280_groups),
>> +       .functions = sc7280_functions,
>> +       .nfunctions = ARRAY_SIZE(sc7280_functions),
>> +       .is_clk_optional = false,
>> +};
>>
>>
>>   static const struct lpi_pinctrl_variant_data sc7280_lpi_data = {
>>          .pins = sc7280_lpi_pins,
>>          .npins = ARRAY_SIZE(sc7280_lpi_pins),
>> @@ -149,6 +159,10 @@ static const struct of_device_id lpi_pinctrl_of_match[] = {
>>                 .compatible = "qcom,sc7280-lpass-lpi-pinctrl",
>>                 .data = &sc7280_lpi_data,
>>          },
>> +       {
>> +               .compatible = "qcom,sc7280-lpass-adsp-lpi-pinctrl",
>> +               .data = &sc7280_adsp_lpi_data,
>> +       },
> Drop this and instead add some code in the probe()
> in drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> lines:
>
> if (of_device_is_compatible(np, "qcom,sc7280-lpass-lpi-pinctrl") &&
> of_property_read_bool(np, "qcom,adsp-mode))
>       data = &sc7280_adsp_lpi_data;

Here, only diff between ADSP and ADSP bypass variant dats is 
"is_clk_optional" field.

So we can keep something like this. Kindly suggest, if it's not making 
sense.

if (of_device_is_compatible(np, "qcom,sc7280-lpass-lpi-pinctrl") &&
of_property_read_bool(np, "qcom,adsp-mode))
      data->is_clk_optional = false;

>
> Yours,
> Linus Walleij
