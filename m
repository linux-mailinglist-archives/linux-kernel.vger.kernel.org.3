Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA095196F6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 07:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344679AbiEDFoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 01:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiEDFoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 01:44:19 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3D126104;
        Tue,  3 May 2022 22:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651642844; x=1683178844;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nD9Yd2tjQcZusGHucY1wp7TRcdWxNvW77SUlhTgYrfc=;
  b=etKBGjJxcyZz117O7v0Rlibd0aqPAd7ytUnwlKuHN06gCSjlZhAf3q4g
   0yRy5xiFGZP8JcNxlDcQLJ7k7KokQAk4YofrX2zz7L93hZyIGGuoJwpBa
   AsdV9U7O3Nym07tBqMj0IX6RytatI2ylPeE0kNbWqx76NOYBnN0RS0kOV
   Y=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 03 May 2022 22:40:44 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 22:40:44 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 3 May 2022 22:40:43 -0700
Received: from [10.216.1.126] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 3 May 2022
 22:40:40 -0700
Message-ID: <fe2721e7-d987-5cef-cc7b-3e138cf3fa1d@quicinc.com>
Date:   Wed, 4 May 2022 11:10:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v4] arm64: dts: qcom: sc7280: Add lpasscore & lpassaudio
 clock controllers
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220503113246.13857-1-quic_tdas@quicinc.com>
 <YnF7b7n4Yn+NcP/b@google.com>
From:   Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <YnF7b7n4Yn+NcP/b@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Matthias,

On 5/4/2022 12:28 AM, Matthias Kaehlcke wrote:
> On Tue, May 03, 2022 at 05:02:46PM +0530, Taniya Das wrote:
>> Add the low pass audio clock controller device nodes. Keep the lpasscc
>> clock node disabled and enabled for lpass pil based devices.
>>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> ---
>> [v4]
>>   * Mark lpasscc[lpasscc@3000000] device node as "disabled".
>>
>> [v3]
>>   * Fix unwanted extra spaces in reg property.
>>   * Fix lpass_aon node clock phandle <&lpasscc> to <&lpasscore>
>>
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 44 ++++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index f0b64be63c21..477a754741a1 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -8,6 +8,8 @@
>>   #include <dt-bindings/clock/qcom,dispcc-sc7280.h>
>>   #include <dt-bindings/clock/qcom,gcc-sc7280.h>
>>   #include <dt-bindings/clock/qcom,gpucc-sc7280.h>
>> +#include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
>> +#include <dt-bindings/clock/qcom,lpasscorecc-sc7280.h>
>>   #include <dt-bindings/clock/qcom,rpmh.h>
>>   #include <dt-bindings/clock/qcom,videocc-sc7280.h>
>>   #include <dt-bindings/gpio/gpio.h>
>> @@ -1978,6 +1980,48 @@
>>   			clocks = <&gcc GCC_CFG_NOC_LPASS_CLK>;
>>   			clock-names = "iface";
>>   			#clock-cells = <1>;
>> +			status = "disabled";
>> +		};
>> +
>> +		lpass_audiocc: clock-controller@3300000 {
>> +			compatible = "qcom,sc7280-lpassaudiocc";
>> +			reg = <0 0x03300000 0 0x30000>;
>> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
>> +			       <&lpass_aon LPASS_AON_CC_MAIN_RCG_CLK_SRC>;
>> +			clock-names = "bi_tcxo", "lpass_aon_cc_main_rcg_clk_src";
>> +			power-domains = <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
>> +			#clock-cells = <1>;
>> +			#power-domain-cells = <1>;
>> +		};
>> +
>> +		lpass_aon: clock-controller@3380000 {
>> +			compatible = "qcom,sc7280-lpassaoncc";
>> +			reg = <0 0x03380000 0 0x30000>;
>> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
>> +			       <&rpmhcc RPMH_CXO_CLK_A>,
>> +			       <&lpasscore LPASS_CORE_CC_CORE_CLK>;
>> +			clock-names = "bi_tcxo", "bi_tcxo_ao", "iface";
>> +			#clock-cells = <1>;
>> +			#power-domain-cells = <1>;
>> +		};
>> +
>> +		lpasscore: clock-controller@3900000 {
> 
> nit: lpass_core?
> 
> The other labels have an underscore, it wouldn't hurt to be consistent.

Sure, will take care in the next patch.

> 
>> +			compatible = "qcom,sc7280-lpasscorecc";
>> +			reg = <0 0x03900000 0 0x50000>;
>> +			clocks =  <&rpmhcc RPMH_CXO_CLK>;
>> +			clock-names = "bi_tcxo";
>> +			power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>;
>> +			#clock-cells = <1>;
>> +			#power-domain-cells = <1>;
>> +		};
>> +
>> +		lpass_hm: clock-controller@3c00000 {
>> +			compatible = "qcom,sc7280-lpasshm";
>> +			reg = <0 0x3c00000 0 0x28>;
>> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
>> +			clock-names = "bi_tcxo";
>> +			#clock-cells = <1>;
>> +			#power-domain-cells = <1>;
>>   		};
>>
>>   		lpass_ag_noc: interconnect@3c40000 {
>> --


-- 
Thanks & Regards,
Taniya Das.
