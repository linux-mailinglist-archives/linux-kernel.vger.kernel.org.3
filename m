Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1264FBE56
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346935AbiDKOIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347084AbiDKOIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:08:04 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039652706;
        Mon, 11 Apr 2022 07:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649685950; x=1681221950;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0Kk56LmgC+V4pObETO0B0bCp5Q95K95byo8lRQNSDEs=;
  b=fROwvRoz7n2fzQemBhKOCrRxYYCs9q444YNz7KxSdmcozJCLX4wHUDwP
   vUfXL4g9dsX3WsAehQ6BmY1+L26CUNypLFmIeV3LK0cLRk9rNWyaNTyZh
   WcGODU6LEviQwmQDiH6fU/aEoMWFEumXhqsC6fQ5p1whynhLgVxogeCel
   8=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 11 Apr 2022 07:05:50 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 07:05:49 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Apr 2022 07:05:49 -0700
Received: from [10.216.15.65] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 11 Apr
 2022 07:05:45 -0700
Message-ID: <338cf0bc-8a88-cc6c-9528-1d0ec633aee6@quicinc.com>
Date:   Mon, 11 Apr 2022 19:35:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6 2/3] arm64: dts: qcom: sc7280: Add lpass cpu node
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <srinivas.kandagatla@linaro.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>,
        <quic_rohkumar@quicinc.com>
References: <1649157220-29304-1-git-send-email-quic_srivasam@quicinc.com>
 <1649157220-29304-3-git-send-email-quic_srivasam@quicinc.com>
 <YkzPzP7kYgaYKwcQ@google.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YkzPzP7kYgaYKwcQ@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/6/2022 4:55 AM, Matthias Kaehlcke wrote:
Thanks for your time Matthias!!!
> On Tue, Apr 05, 2022 at 04:43:39PM +0530, Srinivasa Rao Mandadapu wrote:
>> Add lpass cpu node for audio on sc7280 based platforms.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 28 ++++++++++++++
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi     | 63 ++++++++++++++++++++++++++++++++
>>   2 files changed, 91 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index 83c76b2..e3d8cbf 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -273,6 +273,34 @@
>>   	modem-init;
>>   };
>>   
>> +&lpass_cpu {
>> +	status = "okay";
>> +
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&sec_mi2s_data0>, <&sec_mi2s_sclk>, <&sec_mi2s_ws>;
>> +
>> +	mi2s-secondary@1 {
> in line with an earlier comment, the primary/secondary terminology seem to
> reflect how things are called in the datasheet (which only talks about a
> primary/secondary master clock, otherwise about mi2sN). How about calling
> these nodes 'dai-link@N' as in the binding (and a bunch of other
> boards/SoCs)?
Okay. will change accordingly.
>
>> +		reg = <MI2S_SECONDARY>;
>> +		qcom,playback-sd-lines = <0>;
>> +	};
>> +
>> +	hdmi-primary@5 {
>> +		reg = <LPASS_DP_RX>;
>> +	};
>> +
>> +	wcd-rx@6 {
>> +		reg = <LPASS_CDC_DMA_RX0>;
>> +	};
>> +
>> +	wcd-tx@19 {
>> +		reg = <LPASS_CDC_DMA_TX3>;
>> +	};
>> +
>> +	va-tx@25 {
>> +		reg = <LPASS_CDC_DMA_VA_TX0>;
>> +	};
>> +};
>> +
>>   &lpass_tlmm {
>>   	dmic01_active: dmic01-active {
>>   		clk {
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 78ec84c..e808d53 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -19,6 +19,7 @@
>>   #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>>   #include <dt-bindings/reset/qcom,sdm845-pdc.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> +#include <dt-bindings/sound/qcom,lpass.h>
>>   #include <dt-bindings/thermal/thermal.h>
>>   
>>   / {
>> @@ -2101,6 +2102,68 @@
>>   			#clock-cells = <1>;
>>   		};
>>   
>> +		lpass_cpu: audio@3987000 {
>> +			compatible = "qcom,sc7280-lpass-cpu";
>> +
>> +			reg = <0 0x03987000 0 0x68000>,
>> +			      <0 0x03b00000 0 0x29000>,
>> +			      <0 0x03260000 0 0xc000>,
>> +			      <0 0x03280000 0 0x29000>,
>> +			      <0 0x03340000 0 0x29000>,
>> +			      <0 0x0336c000 0 0x3000>;
>> +
> Drop empty line, 'reg' and 'reg-names' belong together'.
Okay.
>
>> +			reg-names = "lpass-hdmiif",
>> +				    "lpass-lpaif",
>> +				    "lpass-rxtx-cdc-dma-lpm",
>> +				    "lpass-rxtx-lpaif",
>> +				    "lpass-va-lpaif",
>> +				    "lpass-va-cdc-dma-lpm";
>> +
>> +			iommus = <&apps_smmu 0x1820 0>,
>> +				 <&apps_smmu 0x1821 0>,
>> +				 <&apps_smmu 0x1832 0>;
>> +			status = "disabled";
> Detter put this at the end as many other nodes do, rather than
> 'hiding' it inmidst of the hardware description.
Okay. will do accordingly.
>
>> +
>> +			power-domains =	<&rpmhpd SC7280_LCX>;
>> +			power-domain-names = "lcx";
>> +			required-opps = <&rpmhpd_opp_nom>;
>> +
>> +			clocks = <&lpass_aon LPASS_AON_CC_AUDIO_HM_H_CLK>,
>> +				 <&lpass_audiocc LPASS_AUDIO_CC_EXT_MCLK0_CLK>,
>> +				 <&lpasscore LPASS_CORE_CC_SYSNOC_MPORT_CORE_CLK>,
>> +				 <&lpasscore LPASS_CORE_CC_EXT_IF0_IBIT_CLK>,
>> +				 <&lpasscore LPASS_CORE_CC_EXT_IF1_IBIT_CLK>,
>> +				 <&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM_CLK>,
>> +				 <&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM0_CLK>,
>> +				 <&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM1_CLK>,
>> +				 <&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM2_CLK>,
>> +				 <&lpass_aon LPASS_AON_CC_VA_MEM0_CLK>;
>> +			clock-names = "aon_cc_audio_hm_h",
>> +				      "audio_cc_ext_mclk0",
>> +				      "core_cc_sysnoc_mport_core",
>> +				      "core_cc_ext_if0_ibit",
>> +				      "core_cc_ext_if1_ibit",
>> +				      "audio_cc_codec_mem",
>> +				      "audio_cc_codec_mem0",
>> +				      "audio_cc_codec_mem1",
>> +				      "audio_cc_codec_mem2",
>> +				      "aon_cc_va_mem0";
>> +
>> +			#sound-dai-cells = <1>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
>> +
> drop empty line, 'interrupts' and 'interrupt-names' belong together.
Okay.
>
>> +			interrupt-names = "lpass-irq-lpaif",
>> +					  "lpass-irq-hdmi",
>> +					  "lpass-irq-vaif",
>> +					  "lpass-irq-rxtxif";
>> +		};
>> +
>>   		lpass_ag_noc: interconnect@3c40000 {
>>   			reg = <0 0x03c40000 0 0xf080>;
>>   			compatible = "qcom,sc7280-lpass-ag-noc";
