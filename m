Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0CB4FE1C1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355299AbiDLNJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356048AbiDLNDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:03:15 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADE669736;
        Tue, 12 Apr 2022 05:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649767409; x=1681303409;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8qFvSrU/FS5QRhradwFMQHfJ1XOmmKNV0jg14xFTIMU=;
  b=iyzaUyrZalz9/hEnyx8dIom0noAAdAwisKuEW2XUepo+dW0rezr9BW8Q
   zTIqCZfafJoxci/ODo5CAa3hKWH5twFHB1TxoMCOcy9glpR/7xJ36BXhh
   M502DNE3QjoZq3+eP+cxosiqSG9kWlvQPIiBQT3/kki2u2oOqljm+rtHm
   8=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 12 Apr 2022 05:43:29 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 05:43:27 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 12 Apr 2022 05:43:27 -0700
Received: from [10.216.28.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 12 Apr
 2022 05:43:22 -0700
Message-ID: <d6431bae-e9c6-e9ec-6ccc-aeb9d9391cc5@quicinc.com>
Date:   Tue, 12 Apr 2022 18:13:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v7 1/2] arm64: dts: qcom: sc7280: Add pinmux for I2S
 speaker and Headset
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1649685184-8448-1-git-send-email-quic_srivasam@quicinc.com>
 <1649685184-8448-2-git-send-email-quic_srivasam@quicinc.com>
 <YlR8Ai8Yv4j9fGAC@google.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YlR8Ai8Yv4j9fGAC@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/12/2022 12:35 AM, Matthias Kaehlcke wrote:
Thanks for your time Matthias!!!
> On Mon, Apr 11, 2022 at 07:23:03PM +0530, Srinivasa Rao Mandadapu wrote:
>> Add pinmux nodes for primary and secondary I2S for SC7280 based platforms.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 14 +++++++++++
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi     | 41 ++++++++++++++++++++++++++++++++
>>   2 files changed, 55 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index ecbf2b8..4ba2274 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -462,6 +462,20 @@
>>   	drive-strength = <10>;
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
> With the new names the nodes should be inserted between 'dp_hot_plug_det' and
> 'pm7325_gpios'.
Okay. will change accordingly.
>
>>   &tlmm {
>>   	bt_en: bt-en {
>>   		pins = "gpio85";
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index f0b64be..8099c80 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -3527,6 +3527,31 @@
>>   				function = "pcie1_clkreqn";
>>   			};
>>   
>> +			mi2s0_data0: mi2s0-data0 {
> Similar as above, the new nodes should be inserted between
> 'edp_hot_plug_det' and 'pcie1_clkreq_n'.
Okay.
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
>>   			qspi_clk: qspi-clk {
>>   				pins = "gpio14";
>>   				function = "qspi_clk";
>> @@ -4261,6 +4286,22 @@
>>   				drive-strength = <2>;
>>   				bias-bus-hold;
>>   			};
>> +
>> +			mi2s1_data0: mi2s1-data0 {
> see above
Okay.
>
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
