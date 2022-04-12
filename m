Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D2B4FE40B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356700AbiDLOpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 10:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiDLOpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:45:30 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01A911155;
        Tue, 12 Apr 2022 07:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649774593; x=1681310593;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VU3GYKC59IivdJ9+i6NONjh2iSY8jUOMPiFKqTo6hzU=;
  b=Rzvmeg95ykqg6JI5xHE6gsxCdYTwxAfi3BGBBugpEwAR7IQja0Vbi9+k
   o8X7w6FJ93i15Z/5Rr3RAiBnqdpYI1869DSsD+sBKOHCcFHnPeWrvOXml
   B0Y5fA2kjjxvaL36i2ch6LQnBK8g4mKQYgKbJxZkMQaA4Eo6NOQ8+rX/0
   w=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 12 Apr 2022 07:43:12 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 07:43:12 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 12 Apr 2022 07:43:11 -0700
Received: from [10.216.28.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 12 Apr
 2022 07:43:08 -0700
Message-ID: <50953847-3c7f-ce2e-3447-87ba1893a976@quicinc.com>
Date:   Tue, 12 Apr 2022 20:13:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v8 1/2] arm64: dts: qcom: sc7280: Add pinmux for I2S
 speaker and Headset
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <agross@kernel.org>, <robh+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1649769281-12458-1-git-send-email-quic_srivasam@quicinc.com>
 <1649769281-12458-2-git-send-email-quic_srivasam@quicinc.com>
 <YlWNt7f5EUk7I4by@builder.lan>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YlWNt7f5EUk7I4by@builder.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/12/2022 8:03 PM, Bjorn Andersson wrote:
Thanks for your time Bjorn!!!
> On Tue 12 Apr 08:14 CDT 2022, Srinivasa Rao Mandadapu wrote:
>
>> Add pinmux nodes for primary and secondary I2S for SC7280 based platforms.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 14 +++++++++++
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi     | 40 ++++++++++++++++++++++++++++++++
>>   2 files changed, 54 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index ecbf2b8..1fc94b5 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -359,6 +359,20 @@
>>   	bias-disable;
>>   };
>>   
>> +&mi2s1_data0 {
>> +	drive-strength = <6>;
>> +	bias-disable;
>> +};
>> +
>> +&mi2s1_sclk {
>> +	drive-strength = <6>;
>> +	bias-disable;
>> +};
>> +
>> +&mi2s1_ws {
>> +	drive-strength = <6>;
>> +};
>> +
>>   &pm7325_gpios {
>>   	key_vol_up_default: key-vol-up-default {
>>   		pins = "gpio6";
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index f0b64be..6e6cfeda 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -3522,6 +3522,46 @@
>>   				function = "edp_hot";
>>   			};
>>   
>> +			mi2s0_data0: mi2s0-data0 {
> Are these ever going to be selected individually, or could this be:
>
> mi2s0_state: mi2s0-state {
> 	data0 {
> 		...;
> 	};
>
> 	data1 {
> 		...;
> 	};
>
> 	mclk {
> 		...;
> 	};
>
> 	etc
> };
>
> mi2s1-state {
> 	...;
> };
>
> And then a single pinctrl-0 = <&mi2c0_state>;
>
> Regards,
> Bjorn

We are not selecting individually. Actually we were following the same, 
but Doug Anderson suggested this way of handling in 1st version of patches.

So changed accordingly.

>
>> +				pins = "gpio98";
>> +				function = "mi2s0_data0";
>> +			};
>> +
>> +			mi2s0_data1: mi2s0-data1 {
>> +				pins = "gpio99";
>> +				function = "mi2s0_data1";
>> +			};
>> +
>> +			mi2s0_mclk: mi2s0-mclk {
>> +				pins = "gpio96";
>> +				function = "pri_mi2s";
>> +			};
>> +
>> +			mi2s0_sclk: mi2s0-sclk {
>> +				pins = "gpio97";
>> +				function = "mi2s0_sck";
>> +			};
>> +
>> +			mi2s0_ws: mi2s0-ws {
>> +				pins = "gpio100";
>> +				function = "mi2s0_ws";
>> +			};
>> +
>> +			mi2s1_data0: mi2s1-data0 {
>> +				pins = "gpio107";
>> +				function = "mi2s1_data0";
>> +			};
>> +
>> +			mi2s1_sclk: mi2s1-sclk {
>> +				pins = "gpio106";
>> +				function = "mi2s1_sck";
>> +			};
>> +
>> +			mi2s1_ws: mi2s1-ws {
>> +				pins = "gpio108";
>> +				function = "mi2s1_ws";
>> +			};
>> +
>>   			pcie1_clkreq_n: pcie1-clkreq-n {
>>   				pins = "gpio79";
>>   				function = "pcie1_clkreqn";
>> -- 
>> 2.7.4
>>
