Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1D151C21D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352112AbiEEOTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240196AbiEEOSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:18:34 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481585A08B;
        Thu,  5 May 2022 07:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651760093; x=1683296093;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1QeWKZKXMa6Yso2QWy5AgePC5WLU/2DhcKlxt+f67nE=;
  b=HcdNuBgvvCuVLNAGDJefLubNAaAMkEGZAzRKkx9Mbdhmb9z7LRAwRTCU
   EAF+creWN34mKGA5QaBvqvJccHJFxPRSh9OX3XlFkuU8GadEb5afyW6nX
   11Cl1oTUVnGvRxWBewkygrvFPvXnUQg95urS3hy8B2cwv9kHQTOSOzqSD
   4=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 May 2022 07:14:52 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 07:14:52 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 07:14:51 -0700
Received: from [10.216.34.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 5 May 2022
 07:14:47 -0700
Message-ID: <7ccbbc02-a3bb-f42e-13b2-abb84693f1da@quicinc.com>
Date:   Thu, 5 May 2022 19:44:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v13 3/4] arm64: dts: qcom: sc7280: add lpass lpi pin
 controller node
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1651662987-11704-1-git-send-email-quic_srivasam@quicinc.com>
 <1651662987-11704-4-git-send-email-quic_srivasam@quicinc.com>
 <YnL3m1gzggaSZ+c5@google.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YnL3m1gzggaSZ+c5@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/2022 3:30 AM, Matthias Kaehlcke wrote:
Thanks for your time Matthias!!!
> On Wed, May 04, 2022 at 04:46:26PM +0530, Srinivasa Rao Mandadapu wrote:
>> Add LPASS LPI pinctrl node required for Audio functionality on sc7280
>> based platforms.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Please remove my tag for now, the patch changed quite a bit since the
> last version.
Okay. Will remove it.
>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 64 ++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi     | 91 ++++++++++++++++++++++++++++++++
>>   2 files changed, 155 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index 754da58..fb0e313 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -367,6 +367,70 @@
>>   	bias-disable;
>>   };
>>   
>> +&lpass_dmic01_clk {
>> +	drive-strength = <8>;
>> +	bias-disable;
>> +};
>> +
>> +&lpass_dmic01_data {
>> +	bias-pull-down;
>> +};
>> +
>> +&lpass_dmic01_clk_sleep {
>> +	drive-strength = <2>;
>> +};
> Should be after 'lpass_dmic01_clk', not only because of alphanumerical sorting
> order, but also because the two belong together.
Okay. Will sort accordingly.
>
>> +
>> +&lpass_dmic23_clk {
>> +	drive-strength = <8>;
>> +	bias-disable;
>> +};
>> +
>> +&lpass_dmic23_data {
>> +	bias-pull-down;
>> +};
>> +
>> +&lpass_dmic23_clk_sleep {
>> +	drive-strength = <2>;
>> +};
> ditto
Okay.
>
>> +
>> +&lpass_rx_swr_clk {
>> +	drive-strength = <2>;
>> +	slew-rate = <1>;
>> +	bias-disable;
>> +};
>> +
>> +&lpass_rx_swr_data {
>> +	drive-strength = <2>;
>> +	slew-rate = <1>;
>> +	bias-bus-hold;
>> +};
>> +
>> +&lpass_rx_swr_clk_sleep {
>> +	drive-strength = <2>;
> The drive strength is the same as for 'lpass_rx_swr_clk', so I think you
> could omit it?
Okay. will remove it and re post.
>
>> +	bias-pull-down;
>> +};
> fix sorting order
Okay. Will sort accordingly.
>
>> +
>> +&lpass_rx_swr_data_sleep {
>> +	drive-strength = <2>;
> drive strength not needed?
Okay.
>
>> +	bias-pull-down;
>> +};
>> +
>> +&lpass_tx_swr_clk {
>> +	drive-strength = <2>;
>> +	slew-rate = <1>;
>> +	bias-disable;
>> +};
>> +
>> +&lpass_tx_swr_data {
>> +	slew-rate = <1>;
>> +	bias-bus-hold;
>> +};
>> +
>> +&lpass_tx_swr_clk_sleep {
>> +	drive-strength = <2>;
> drive strength not needed?
Okay.
>
>> +	bias-pull-down;
>> +};
> fix sorting order
Okay. Will sort accordingly.
>
>> +
>>   &mi2s1_data0 {
>>   	drive-strength = <6>;
>>   	bias-disable;
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index c5b6b46..c961ca1 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -2224,6 +2224,97 @@
>>   			qcom,bcm-voters = <&apps_bcm_voter>;
>>   		};
>>   
>> +		lpass_tlmm: pinctrl@33c0000 {
>> +			compatible = "qcom,sc7280-lpass-lpi-pinctrl";
>> +			reg = <0 0x033c0000 0x0 0x20000>,
>> +				<0 0x03550000 0x0 0x10000>;
>> +			gpio-controller;
>> +			#gpio-cells = <2>;
>> +			gpio-ranges = <&lpass_tlmm 0 0 15>;
>> +
>> +			#clock-cells = <1>;
>> +
>> +			lpass_dmic01_clk: dmic01-clk {
>> +				pins = "gpio6";
>> +				function = "dmic1_clk";
>> +			};
>> +
>> +			lpass_dmic01_data: dmic01-data {
>> +				pins = "gpio7";
>> +				function = "dmic1_data";
>> +			};
>> +
>> +			lpass_dmic01_clk_sleep: dmic01-clk-sleep {
>> +				pins = "gpio6";
>> +				function = "dmic1_clk";
>> +			};
> fix sorting order
Okay. Will sort accordingly.
>
>> +
>> +			lpass_dmic01_data_sleep: dmic01-data-sleep {
>> +				pins = "gpio7";
>> +				function = "dmic1_data";
>> +			};
>> +
>> +			lpass_dmic23_clk: dmic23-clk {
>> +				pins = "gpio8";
>> +				function = "dmic2_clk";
>> +			};
>> +
>> +			lpass_dmic23_data: dmic23-data {
>> +				pins = "gpio9";
>> +				function = "dmic2_data";
>> +			};
>> +
>> +			lpass_dmic23_clk_sleep: dmic23-clk-sleep {
>> +				pins = "gpio8";
>> +				function = "dmic2_clk";
>> +			};
> fix sorting order
Okay. Will sort accordingly.
>
>> +
>> +			lpass_dmic23_data_sleep: dmic23-data-sleep {
>> +				pins = "gpio9";
>> +				function = "dmic2_data";
>> +			};
>> +
>> +			lpass_rx_swr_clk: rx-swr-clk {
>> +				pins = "gpio3";
>> +				function = "swr_rx_clk";
>> +			};
>> +
>> +			lpass_rx_swr_data: rx-swr-data {
>> +				pins = "gpio4", "gpio5";
>> +				function = "swr_rx_data";
>> +			};
>> +
>> +			lpass_rx_swr_clk_sleep: rx-swr-clk-sleep {
>> +				pins = "gpio3";
>> +				function = "swr_rx_clk";
>> +			};
> fix sorting order
Okay. Will sort accordingly.
>
>> +
>> +			lpass_rx_swr_data_sleep: rx-swr-data-sleep {
>> +				pins = "gpio4", "gpio5";
>> +				function = "swr_rx_data";
>> +			};
>> +
>> +			lpass_tx_swr_clk: tx-swr-clk {
>> +				pins = "gpio0";
>> +				function = "swr_tx_clk";
>> +			};
>> +
>> +			lpass_tx_swr_data: tx-swr-data {
>> +				pins = "gpio1", "gpio2", "gpio14";
>> +				function = "swr_tx_data";
>> +			};
>> +
>> +			lpass_tx_swr_clk_sleep: tx-swr-clk-sleep {
>> +				pins = "gpio0";
>> +				function = "swr_tx_clk";
>> +			};
> fix sorting order
Okay. Will sort accordingly.
>
>> +
>> +			lpass_tx_swr_data_sleep: tx-swr-data-sleep {
>> +				pins = "gpio1", "gpio2", "gpio14";
>> +				function = "swr_tx_data";
>> +			};
>> +		};
>> +
>>   		gpu: gpu@3d00000 {
>>   			compatible = "qcom,adreno-635.0", "qcom,adreno";
>>   			reg = <0 0x03d00000 0 0x40000>,
>> -- 
>> 2.7.4
>>
