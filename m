Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8779506A64
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351323AbiDSLbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244434AbiDSLbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:31:04 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DAE2612D;
        Tue, 19 Apr 2022 04:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650367701; x=1681903701;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7x3TYXYbot5GgNgc0jGFA3hupHhRC7kRkRPyHXOsERA=;
  b=cquVnqjsPZZ1F788jn23y44nLYt9HmtZhk9oP1Z2lsyJYTDzCbGB/mlu
   BkRTTzkDjxll3x++o4yepS5X8DVNUD5ujgOIWfMsCPB1oSpFcoq4gzzTU
   fjCspbh1srKWFuGrovMLhoSgBCH0ZxdjZqb9M9IpDiGaBYwwdnTLtmJw3
   Y=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 19 Apr 2022 04:28:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 04:28:19 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 19 Apr 2022 04:28:19 -0700
Received: from [10.216.20.240] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 19 Apr
 2022 04:28:15 -0700
Message-ID: <c9124bdc-397a-8c1a-1133-1f85a0d37538@quicinc.com>
Date:   Tue, 19 Apr 2022 16:58:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v8 4/4] arm64: dts: qcom: sc7280: Add dt nodes for sound
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
References: <1650291252-30398-1-git-send-email-quic_srivasam@quicinc.com>
 <1650291252-30398-5-git-send-email-quic_srivasam@quicinc.com>
 <Yl2nuxzH0mcPa94B@google.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <Yl2nuxzH0mcPa94B@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/18/2022 11:32 PM, Matthias Kaehlcke wrote:
Thanks for your time Matthias!!!
> On Mon, Apr 18, 2022 at 07:44:12PM +0530, Srinivasa Rao Mandadapu wrote:
>> Add dt nodes for sound card support, which is using WCD938x headset
>> playback, capture, I2S speaker playback and DMICs via VA macro.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts | 23 ++++++++
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi   | 93 ++++++++++++++++++++++++++++++
>>   2 files changed, 116 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
>> index aa0bf6e2..bf15bbe 100644
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
> Should this also be added to sc7280-herobrine-crd.dts?
Okay. Will add it corresponding dts file.
>
>> +
>>   &wcd938x {
>>   	pinctrl-names = "default";
>>   	pinctrl-0 = <&us_euro_hs_sel>;
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index e880837..640b1338 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -85,6 +85,99 @@
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
> The '@1' is the address of the lpass CPU DAI, which doesn't seem correct
> here. As I brought up on v7 [1] I think this value isn't even necessarily
> unique, a SoC could have multiple IP blocks with audio buses, each with
> their own DAI address space. The binding (currently) requires an
> 'address'/id, rather than using the CPU DAI id I suggest to enumerate the
> links linearly, starting with 0.
Okay. Will update accordingly.
>
> [1] https://patchwork.kernel.org/project/linux-arm-msm/patch/1649863277-31615-5-git-send-email-quic_srivasam@quicinc.com/
>
>> +			link-name = "MAX98360A";
> The binding requires a 'reg' property, even though it isn't used (also
> discussed on v7). I think the 'reg' property should be removed from the
> binding and the DTs that use it, but maybe that should be done in a
> separate series. In the meantime the value should match that of the
> node.
Okay. for now will revert this change. and will take care your 
suggestion in a separate patch set.
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
>> +		dai-link@5 {
>> +			link-name = "DisplayPort";
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
>> +		dai-link@6 {
>> +			link-name = "WCD9385 Playback";
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
>> +		dai-link@19 {
>> +			link-name = "WCD9385 Capture";
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
>> +		dai-link@25 {
>> +			link-name = "DMIC";
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
