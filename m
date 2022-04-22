Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD2750B924
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448220AbiDVNyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237448AbiDVNyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:54:33 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0385A09E;
        Fri, 22 Apr 2022 06:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650635500; x=1682171500;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WE7YHMrwloejOLsdhI2L2jS3RCFA7bhrqOuTFvqzVkU=;
  b=JRyzzsnls1nieHai0Xh9T8vQtR7VhU4uQi6/tq2ahHkJhplE2vSre7nv
   sEfWGEIqShhy+GOGBV9vV4t9hhKq4Pg6l08BvE5vMtWWLvYE+2k4lKzcQ
   ey/aRFpqZgAQY5jm7zxNaOV6h+CRTH383pYcA8SO+TbC5Ioq1AHJb44f6
   M=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 22 Apr 2022 06:51:40 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 06:51:39 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Apr 2022 06:51:39 -0700
Received: from [10.216.36.2] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 22 Apr
 2022 06:51:34 -0700
Message-ID: <88f2a859-3a3c-7aed-ebdb-4ca90b3b08dc@quicinc.com>
Date:   Fri, 22 Apr 2022 19:21:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v9 11/12] arm64: dts: qcom: sc7280: Add sound node for CRD
 1.0 and CRD 2.0
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1650552459-21077-1-git-send-email-quic_srivasam@quicinc.com>
 <1650552459-21077-12-git-send-email-quic_srivasam@quicinc.com>
 <YmGa5iQ1ozTs5jLJ@google.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YmGa5iQ1ozTs5jLJ@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/21/2022 11:26 PM, Matthias Kaehlcke wrote:
Thanks for your time Matthias!!!
> On Thu, Apr 21, 2022 at 08:17:38PM +0530, Srinivasa Rao Mandadapu wrote:
>
>> Subject: arm64: dts: qcom: sc7280: Add sound node for CRD 1.0 and CRD 2.0
> nit: and the IDP boards?
Okay.
>
>> Add dt nodes for sound card support on revision 3 and 4
>> (aka CRD 1.0 and 2.0) boards, which is using WCD938x headset
>> playback, capture, I2S speaker playback and DMICs via VA macro.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts | 23 +++++++
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi   | 98 ++++++++++++++++++++++++++++++
>>   2 files changed, 121 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
>> index 462d655..763d2bf 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
>> @@ -87,6 +87,29 @@ ap_ts_pen_1v8: &i2c13 {
>>   	pins = "gpio51";
>>   };
>>   
>> +&sound {
>> +	audio-routing =
>> +		"IN1_HPHL", "HPHL_OUT",
>> +		"IN2_HPHR", "HPHR_OUT",
>> +		"AMIC1", "MIC BIAS1",
>> +		"AMIC2", "MIC BIAS2",
>> +		"VA DMIC0", "MIC BIAS1",
>> +		"VA DMIC1", "MIC BIAS1",
>> +		"VA DMIC2", "MIC BIAS3",
>> +		"VA DMIC3", "MIC BIAS3",
>> +		"TX SWR_ADC0", "ADC1_OUTPUT",
>> +		"TX SWR_ADC1", "ADC2_OUTPUT",
>> +		"TX SWR_ADC2", "ADC3_OUTPUT",
>> +		"TX SWR_DMIC0", "DMIC1_OUTPUT",
>> +		"TX SWR_DMIC1", "DMIC2_OUTPUT",
>> +		"TX SWR_DMIC2", "DMIC3_OUTPUT",
>> +		"TX SWR_DMIC3", "DMIC4_OUTPUT",
>> +		"TX SWR_DMIC4", "DMIC5_OUTPUT",
>> +		"TX SWR_DMIC5", "DMIC6_OUTPUT",
>> +		"TX SWR_DMIC6", "DMIC7_OUTPUT",
>> +		"TX SWR_DMIC7", "DMIC8_OUTPUT";
>> +};
>> +
>>   &wcd938x {
>>   	pinctrl-names = "default", "sleep", "us_euro_hs_sel";
>>   	pinctrl-0 = <&wcd_reset_n>;
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index 2e991e8..f2ad0c6 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -85,6 +85,104 @@
>>   		pinctrl-names = "default";
>>   		pinctrl-0 = <&nvme_pwren>;
>>   	};
>> +
>> +	sound: sound {
>> +		compatible = "google,sc7280-herobrine";
>> +		model = "sc7280-wcd938x-max98360a-1mic";
>> +
>> +		audio-routing =
>> +			"IN1_HPHL", "HPHL_OUT",
>> +			"IN2_HPHR", "HPHR_OUT",
>> +			"AMIC1", "MIC BIAS1",
>> +			"AMIC2", "MIC BIAS2",
>> +			"VA DMIC0", "MIC BIAS3",
>> +			"VA DMIC1", "MIC BIAS3",
>> +			"VA DMIC2", "MIC BIAS1",
>> +			"VA DMIC3", "MIC BIAS1",
>> +			"TX SWR_ADC0", "ADC1_OUTPUT",
>> +			"TX SWR_ADC1", "ADC2_OUTPUT",
>> +			"TX SWR_ADC2", "ADC3_OUTPUT",
>> +			"TX SWR_DMIC0", "DMIC1_OUTPUT",
>> +			"TX SWR_DMIC1", "DMIC2_OUTPUT",
>> +			"TX SWR_DMIC2", "DMIC3_OUTPUT",
>> +			"TX SWR_DMIC3", "DMIC4_OUTPUT",
>> +			"TX SWR_DMIC4", "DMIC5_OUTPUT",
>> +			"TX SWR_DMIC5", "DMIC6_OUTPUT",
>> +			"TX SWR_DMIC6", "DMIC7_OUTPUT",
>> +			"TX SWR_DMIC7", "DMIC8_OUTPUT";
>> +
>> +		qcom,msm-mbhc-hphl-swh = <1>;
>> +		qcom,msm-mbhc-gnd-swh = <1>;
>> +
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		#sound-dai-cells = <0>;
>> +
>> +		dai-link@0 {
>> +			link-name = "MAX98360A";
>> +			reg = <MI2S_SECONDARY>;
> This usually is the same as the node address. Given that it's a bogus value that
> isn't used the link number seems a better choice than the lpass DAI id.
Okay. Will update reg property with link number.
>
> Note for other reviewers: the current state of discussion is to remove this
> property from the binding and device trees in a follow up series.
>
>> +
>> +			cpu {
>> +				sound-dai = <&lpass_cpu MI2S_SECONDARY>;
>> +			};
>> +
>> +			codec {
>> +				sound-dai = <&max98360a>;
>> +			};
>> +		};
>> +
>> +		dai-link@1 {
>> +			link-name = "DisplayPort";
>> +			reg = <LPASS_DP_RX>;
>> +
>> +			cpu {
>> +				sound-dai = <&lpass_cpu LPASS_DP_RX>;
>> +			};
>> +
>> +			codec {
>> +				sound-dai = <&mdss_dp>;
>> +			};
>> +		};
>> +
>> +		dai-link@2 {
>> +			link-name = "WCD9385 Playback";
>> +			reg = <LPASS_CDC_DMA_RX0>;
>> +
>> +			cpu {
>> +				sound-dai = <&lpass_cpu LPASS_CDC_DMA_RX0>;
>> +			};
>> +
>> +			codec {
>> +				sound-dai = <&wcd938x 0>, <&swr0 0>, <&lpass_rx_macro 0>;
>> +			};
>> +		};
>> +
>> +		dai-link@3 {
>> +			link-name = "WCD9385 Capture";
>> +			reg = <LPASS_CDC_DMA_TX3>;
>> +
>> +			cpu {
>> +				sound-dai = <&lpass_cpu LPASS_CDC_DMA_TX3>;
>> +			};
>> +
>> +			codec {
>> +				sound-dai = <&wcd938x 1>, <&swr1 0>, <&lpass_tx_macro 0>;
>> +			};
>> +		};
>> +
>> +		dai-link@4 {
>> +			link-name = "DMIC";
>> +			reg = <LPASS_CDC_DMA_VA_TX0>;
>> +
>> +			cpu {
>> +				sound-dai = <&lpass_cpu LPASS_CDC_DMA_VA_TX0>;
>> +			};
>> +
>> +			codec {
>> +				sound-dai = <&lpass_va_macro 0>;
>> +			};
>> +		};
>> +	};
>>   };
>>   
>>   &apps_rsc {
>> -- 
>> 2.7.4
>>
