Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984114FBE3F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346908AbiDKOFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346855AbiDKOE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:04:56 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016C43205C;
        Mon, 11 Apr 2022 07:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649685762; x=1681221762;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ek89UktAjLzWleHTZx947tfPTU35bCZ9ILBydvOzz9o=;
  b=Z/bQI1lTbMuYl0WJpWual1rfaM1uNtY9RzNyBzgpfqu9iHNKBqL4pM3N
   PXQw3HOzpOGgpzsUwS5c6sbttJnR37tzRwsOxxuo++8YkWETVyN/0uY1X
   qa9YVLsquPFnRlO7pIVo97A6fv+bnfZGNqG/KqNfFX0DSRHgtgNC24iCp
   4=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 11 Apr 2022 07:02:42 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 07:02:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Apr 2022 07:02:40 -0700
Received: from [10.216.15.65] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 11 Apr
 2022 07:02:36 -0700
Message-ID: <8fea1165-c8b6-6ce2-86dc-82274af8c43d@quicinc.com>
Date:   Mon, 11 Apr 2022 19:32:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6 1/3] arm64: dts: qcom: sc7280: Add nodes for va tx and
 rx macros and external codecs
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
 <1649157220-29304-2-git-send-email-quic_srivasam@quicinc.com>
 <Yky2Iwt+tvxvu4/S@google.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <Yky2Iwt+tvxvu4/S@google.com>
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


On 4/6/2022 3:05 AM, Matthias Kaehlcke wrote:
Thanks for your time Matthias!!!
> On Tue, Apr 05, 2022 at 04:43:38PM +0530, Srinivasa Rao Mandadapu wrote:
>> SC7280 has VA, TX and RX macros with SoundWire Controllers to attach with
>> codecs like WCD938x, max98360a using soundwire masters and i2s bus.
>> Add these nodes for sc7280 based platforms audio use case.
>> Add tlmm gpio property in wcd938x node for switching CTIA/OMTP Headset.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
> A change log would be helpful for reviewers
Change log added in cover letter.
>
>>   arch/arm64/boot/dts/qcom/sc7280-crd.dts        |   6 ++
>>   arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi |   8 ++
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       |  88 ++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi           | 121 +++++++++++++++++++++++++
>>   4 files changed, 223 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
>> index e2efbdd..224a82d 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> You might want to consider splitting this patch into one that
> adds the SoC specific bits and one for each board. It's cleaner
> and might allow to land the SoC specific bits even when the board
> specific part is still under discussion. It also might make the
> life easier for folks who want to pick the SoC specific parts,
> but aren't interested in the board bits (e.g. because they want
> to support a different board). Just a thought, the split is not
> strictly necessary.
Okay. will split accordingly.
>
>> @@ -84,6 +84,12 @@ ap_ts_pen_1v8: &i2c13 {
>>   	pins = "gpio51";
>>   };
>>   
>> +&wcd938x {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&us_euro_select>;
>> +	us-euro-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
>> +};
>> +
>>   &tlmm {
>>   	tp_int_odl: tp-int-odl {
>>   		pins = "gpio7";
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
>> index de646d9..c6a04c3 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
>> @@ -20,6 +20,14 @@
>>   #include "sc7280-chrome-common.dtsi"
>>   
>>   / {
>> +	max98360a: audio-codec-0 {
>> +		compatible = "maxim,max98360a";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&amp_en>;
>> +		sdmode-gpios = <&tlmm 63 GPIO_ACTIVE_HIGH>;
>> +		#sound-dai-cells = <0>;
>> +	};
>> +
> This node shouldn't be at top but with the other device nodes, in
> alphabetical order, i.e. before 'pwmleds'.

Actually we are sorting as per node name. Hence kept it here. As per 
previous reviewer comments, sorted accordingly.

Please suggest better approach.

>
>>   	chosen {
>>   		stdout-path = "serial0:115200n8";
>>   	};
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index f912a89..83c76b2 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -20,6 +20,41 @@
>>   		serial1 = &uart7;
>>   	};
>>   
>> +	max98360a: audio-codec-0 {
>> +		compatible = "maxim,max98360a";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&amp_en>;
>> +		sdmode-gpios = <&tlmm 63 GPIO_ACTIVE_HIGH>;
>> +		#sound-dai-cells = <0>;
>> +	};
>> +
>> +	wcd938x: audio-codec-1 {
>> +		compatible = "qcom,wcd9380-codec";
>> +		#sound-dai-cells = <1>;
>> +
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&wcd938x_reset_active>, <&wcd938x_reset_sleep>;
>> +		reset-gpios = <&tlmm 83 GPIO_ACTIVE_HIGH>;
>> +
>> +		qcom,rx-device = <&wcd_rx>;
>> +		qcom,tx-device = <&wcd_tx>;
>> +
>> +		vdd-rxtx-supply = <&vreg_l18b_1p8>;
>> +		vdd-io-supply = <&vreg_l18b_1p8>;
>> +		vdd-buck-supply = <&vreg_l17b_1p8>;
>> +		vdd-mic-bias-supply = <&vreg_bob>;
>> +
>> +		qcom,micbias1-microvolt = <1800000>;
>> +		qcom,micbias2-microvolt = <1800000>;
>> +		qcom,micbias3-microvolt = <1800000>;
>> +		qcom,micbias4-microvolt = <1800000>;
>> +
>> +		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000
>> +							  500000 500000 500000>;
>> +		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
>> +		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
>> +	};
>> +
>>   	gpio-keys {
>>   		compatible = "gpio-keys";
>>   		label = "gpio-keys";
>> @@ -373,6 +408,19 @@
>>   	status = "okay";
>>   };
>>   
>> +&rxmacro {
>> +	status = "okay";
>> +};
>> +
>> +&txmacro {
>> +	status = "okay";
>> +};
>> +
>> +&vamacro {
>> +	status = "okay";
>> +	vdd-micb-supply = <&vreg_bob>;
>> +};
>> +
>>   &sdhc_1 {
>>   	status = "okay";
>>   
>> @@ -574,6 +622,24 @@
>>   	drive-strength = <6>;
>>   };
>>   
>> +&swr0 {
>> +	wcd_rx: codec@0,4 {
>> +		compatible = "sdw20217010d00";
>> +		reg = <0 4>;
>> +		#sound-dai-cells = <1>;
>> +		qcom,rx-port-mapping = <1 2 3 4 5>;
>> +	};
>> +};
>> +
>> +&swr1 {
>> +	wcd_tx: codec@0,3 {
>> +		compatible = "sdw20217010d00";
>> +		reg = <0 3>;
>> +		#sound-dai-cells = <1>;
>> +		qcom,tx-port-mapping = <1 2 3 4>;
>> +	};
>> +};
>> +
>>   &tlmm {
>>   	amp_en: amp-en {
>>   		pins = "gpio63";
>> @@ -663,5 +729,27 @@
>>   		function = "gpio";
>>   		bias-pull-down;
>>   	};
>> +
>> +	us_euro_select: us-euro-select {
> nit: in the schematic this is called 'us_euro_hs_sel'. IMO it's preferable
> to use the name from the schematic rather than inventing a new one, unless
> there's a good reason for it.
Okay. will change accordingly.
>
>> +		pins = "gpio81";
>> +		function = "gpio";
>> +		bias-pull-down;
>> +		drive-strength = <2>;
>> +	};
>> +
>> +	wcd938x_reset_active: wcd938x-reset-active {
> same as above: the schematic calls this pin 'wcd_reset_n'
>
> drop the -active suffix
Okay. will change accordingly.
>
>> +		pins = "gpio83";
>> +		function = "gpio";
>> +		drive-strength = <16>;
> A value of 16 seems pretty high. Is it really needed?
Okay. Verified with drive strength 8. will change accordingly.
>
>> +		output-high;
>> +	};
>> +
>> +	wcd938x_reset_sleep: wcd938x-reset-sleep {
>> +		pins = "gpio83";
>> +		function = "gpio";
>> +		drive-strength = <16>;
> see above
okay.
>
>> +		bias-disable;
>> +		output-low;
>> +	};
>>   };
>>   
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index db74fc3..78ec84c 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -822,6 +822,127 @@
>>   			#power-domain-cells = <1>;
>>   		};
>>   
>> +		rxmacro: codec@3200000 {
> These node are not at the correct position. They should be sorted by
> address and hence be inserted between 'lpasscc@3000000' and
> 'interconnect@3c40000'.

Actually we are sorting as per node(codec) name. Hence kept it here. As 
per previous reviewer comments, sorted accordingly.

Please suggest better approach.

>
>> +			compatible = "qcom,sc7280-lpass-rx-macro";
>> +			reg = <0 0x03200000 0 0x1000>;
>> +
>> +			status = "disabled";
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&rx_swr_active>;
>> +
>> +			clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
>> +				 <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
>> +				 <&vamacro>;
>> +			clock-names = "mclk", "npl", "fsgen";
>> +
>> +			power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
>> +					<&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
>> +			power-domain-names ="macro", "dcodec";
>> +
>> +			#clock-cells = <0>;
>> +			#sound-dai-cells = <1>;
>> +		};
>> +
>> +		txmacro: codec@3220000 {
>> +			compatible = "qcom,sc7280-lpass-tx-macro";
>> +			reg = <0 0x03220000 0 0x1000>;
>> +
>> +			status = "disabled";
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&tx_swr_active>;
>> +
>> +			clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
>> +				 <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
>> +				 <&vamacro>;
>> +			clock-names = "mclk", "npl", "fsgen";
>> +
>> +			power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
>> +					<&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
>> +			power-domain-names ="macro", "dcodec";
>> +
>> +			#clock-cells = <0>;
>> +			#sound-dai-cells = <1>;
>> +		};
>> +
>> +		vamacro: codec@3370000 {
>> +			compatible = "qcom,sc7280-lpass-va-macro";
>> +			reg = <0 0x03370000 0 0x1000>;
>> +
>> +			status = "disabled";
>> +			pinctrl-0 = <&dmic01_active>;
>> +			pinctrl-names = "default";
>> +
>> +			clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>;
>> +			clock-names = "mclk";
>> +
>> +			power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
>> +					<&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
>> +			power-domain-names ="macro", "dcodec";
>> +
>> +			#clock-cells = <0>;
>> +			#sound-dai-cells = <1>;
>> +		};
>> +
>> +		swr0: soundwire@3210000 {
>> +			compatible = "qcom,soundwire-v1.6.0";
>> +			reg = <0 0x03210000 0 0x2000>;
>> +
>> +			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&rxmacro>;
>> +			clock-names = "iface";
>> +
>> +			qcom,din-ports = <0>;
>> +			qcom,dout-ports = <5>;
>> +
>> +			resets = <&lpass_audiocc LPASS_AUDIO_SWR_RX_CGCR>;
>> +			reset-names = "swr_audio_cgcr";
>> +
>> +			qcom,ports-word-length =	/bits/ 8 <0x01 0x07 0x04 0xff 0xff>;
>> +			qcom,ports-sinterval-low =	/bits/ 8 <0x03 0x3f 0x1f 0x03 0x03>;
>> +			qcom,ports-offset1 =		/bits/ 8 <0x00 0x00 0x0b 0x01 0x01>;
>> +			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x0b 0x00 0x00>;
>> +			qcom,ports-lane-control =	/bits/ 8 <0x01 0x00 0x00 0x00 0x00>;
>> +			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0x00 0x01 0xff 0xff>;
>> +			qcom,ports-hstart =		/bits/ 8 <0xff 0x03 0xff 0xff 0xff>;
>> +			qcom,ports-hstop =		/bits/ 8 <0xff 0x06 0xff 0xff 0xff>;
>> +			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0x00>;
>> +
>> +			#sound-dai-cells = <1>;
>> +			#address-cells = <2>;
>> +			#size-cells = <0>;
>> +		};
>> +
>> +		swr1: soundwire@3230000 {
>> +			compatible = "qcom,soundwire-v1.6.0";
>> +			reg = <0 0x03230000 0 0x2000>;
>> +
>> +			interrupts-extended = <&intc GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
>> +					      <&pdc 130 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "swr_master_irq", "swr_wake_irq";
>> +			clocks = <&txmacro>;
>> +			clock-names = "iface";
>> +
>> +			qcom,din-ports = <3>;
>> +			qcom,dout-ports = <0>;
>> +
>> +			resets = <&lpass_audiocc LPASS_AUDIO_SWR_TX_CGCR>;
>> +			reset-names = "swr_audio_cgcr";
>> +
>> +			qcom,ports-sinterval-low =	/bits/ 8 <0x01 0x03 0x03>;
>> +			qcom,ports-offset1 =		/bits/ 8 <0x01 0x00 0x02>;
>> +			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x00>;
>> +			qcom,ports-hstart =		/bits/ 8 <0xff 0xff 0xff>;
>> +			qcom,ports-hstop =		/bits/ 8 <0xff 0xff 0xff>;
>> +			qcom,ports-word-length =	/bits/ 8 <0xff 0x0 0xff>;
> s/0x0/0x00/
okay.
>
>> +			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0xff 0xff>;
>> +			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff>;
>> +			qcom,ports-lane-control =	/bits/ 8 <0x00 0x01 0x00>;
>> +			qcom,port-offset = <1>;
>> +
>> +			#sound-dai-cells = <1>;
>> +			#address-cells = <2>;
>> +			#size-cells = <0>;
>> +		};
> add empty line
Okay. will remove it.
>
>>   		ipcc: mailbox@408000 {
>>   			compatible = "qcom,sc7280-ipcc", "qcom,ipcc";
>>   			reg = <0 0x00408000 0 0x1000>;
