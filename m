Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DE5505AAD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345286AbiDRPPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345308AbiDRPOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:14:37 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68692F39A;
        Mon, 18 Apr 2022 07:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650290992; x=1681826992;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wo7n7i7NcFwEADL9B4t8WYMscex9ezkkM2mITVauwjY=;
  b=UEUslPdvpCwEU4GVoJ6HVUcA5JVplu7d9kuQiquJ4yYPozk0PYDqYLRq
   W1SSBawNtYAGWl59FtPPdzs5x9gQDBiRLrglSsLw3L2hLITys4lV2EB8X
   fhPtBfozunbrtedDpSpnQnCDPLKTynZQW5Ozz6U6rhnnYFKBO/vxK966V
   0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Apr 2022 07:09:52 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 07:09:51 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Apr 2022 07:09:51 -0700
Received: from [10.216.27.177] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 18 Apr
 2022 07:09:46 -0700
Message-ID: <78b1e04c-e7d0-a81d-799e-5c570c2bf106@quicinc.com>
Date:   Mon, 18 Apr 2022 19:39:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v7 4/4] arm64: dts: qcom: sc7280: Add dt nodes for sound
 card
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1649863277-31615-1-git-send-email-quic_srivasam@quicinc.com>
 <1649863277-31615-5-git-send-email-quic_srivasam@quicinc.com>
 <Ylc/aR0hUGa6OKBO@google.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <Ylc/aR0hUGa6OKBO@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/14/2022 2:53 AM, Matthias Kaehlcke wrote:
Thanks for your time Matthias!!!
> On Wed, Apr 13, 2022 at 08:51:17PM +0530, Srinivasa Rao Mandadapu wrote:
>> Add dt nodes for sound card support, which is using WCD938x headset
>> playback, capture, I2S speaker playback and DMICs via VA macro.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280-crd.dts  | 23 ++++++++
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 93 ++++++++++++++++++++++++++++++++
>>   2 files changed, 116 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
>> index b944366..1e16854 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> You need to refresh your tree, this file has been renamed to
> sc7280-crd-r3.dts. That DT is for the CRD <= 2.x, newer versions
> use sc7280-herobrine-crd.dts.
Okay. will update accordingly.
>
>> @@ -90,6 +90,29 @@ ap_ts_pen_1v8: &i2c13 {
>>   	us-euro-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
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
>>   &tlmm {
>>   	tp_int_odl: tp-int-odl {
>>   		pins = "gpio7";
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index cf62d06..a7c884a 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -84,6 +84,99 @@
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
>> +		dai-link@1 {
>> +			link-name = "MAX98360A";
>> +			reg = <MI2S_SECONDARY>;
> Dumb question: is this value actually used? A quick glance through
> qcom_snd_parse_of() suggests it isn't. And the CPU DAI id is already
> specified in the 'sound-dai' property below.
>
> In a quick test I replaced the corresponding 'reg' values in
> sc7180-trogdor.dtsi with 'random' values and audio playback on
> my coachz (sc7180-trogdor-coachz-r3.dts) still works ...

Yes. agree that it's not being used. But i am not sure of general syntax 
followed.

for now  will delete it.

>
>> +			cpu {
>> +				sound-dai = <&lpass_cpu MI2S_SECONDARY>;
>> +			};
>> +
>> +			codec {
>> +				sound-dai = <&max98360a>;
>> +			};
>> +		};
>> +
>> +		dai-link@5 {
>> +			link-name = "DisplayPort";
>> +			reg = <LPASS_DP_RX>;
> nit: add an empty line (in all links) to separate the properties from the node
Okay.
>
>> +			cpu {
>> +				sound-dai = <&lpass_cpu LPASS_DP_RX>;
>> +			};
>> +
>> +			codec {
>> +				sound-dai = <&mdss_dp>;
>> +			};
>> +		};
>> +
>> +		dai-link@6 {
>> +			link-name = "WCD9385 Playback";
>> +			reg = <LPASS_CDC_DMA_RX0>;
>> +			cpu {
>> +				sound-dai = <&lpass_cpu LPASS_CDC_DMA_RX0>;
>> +			};
>> +
>> +			codec {
>> +				sound-dai = <&wcd938x 0>, <&swr0 0>, <&lpass_rx_macro 0>;
>> +			};
>> +		};
>> +
>> +		dai-link@19 {
>> +			link-name = "WCD9385 Capture";
>> +			reg = <LPASS_CDC_DMA_TX3>;
>> +			cpu {
>> +				sound-dai = <&lpass_cpu LPASS_CDC_DMA_TX3>;
>> +			};
>> +
>> +			codec {
>> +				sound-dai = <&wcd938x 1>, <&swr1 0>, <&lpass_tx_macro 0>;
>> +			};
>> +		};
>> +
>> +		dai-link@25 {
>> +			link-name = "DMIC";
>> +			reg = <LPASS_CDC_DMA_VA_TX0>;
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
