Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74C9505AA3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240934AbiDRPMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345186AbiDRPMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:12:07 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2043835DFD;
        Mon, 18 Apr 2022 07:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650290803; x=1681826803;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1+UciU6UDGSquvBgLbHOI+8n8zvn60fxo9kUcmea6PA=;
  b=mHYziQ8YZlU3hGbSX/KwBG5qXxQpAHPc4i6yD1GplODyq7NQ+/dV2VNn
   ksOR7WYZhXpuq0AQWSucpOcFcAaNj6nHCuh6vMihGoxoH1Hb2grQCM1hC
   +UEM6aDl6zmi6hxthL78CREtzsRPT2Eg4rFZT1vRfzfnp6hTjTGknNZKU
   k=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 18 Apr 2022 07:06:43 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 07:06:42 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Apr 2022 07:06:41 -0700
Received: from [10.216.27.177] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 18 Apr
 2022 07:06:37 -0700
Message-ID: <77a94d4c-c79e-dede-f365-769f0fae883c@quicinc.com>
Date:   Mon, 18 Apr 2022 19:36:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v7 2/4] arm64: dts: qcom: sc7280: Add nodes for wcd9385
 and max98360a codec
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
 <1649863277-31615-3-git-send-email-quic_srivasam@quicinc.com>
 <Ylcl830KnrzXHpSx@google.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <Ylcl830KnrzXHpSx@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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


On 4/14/2022 1:05 AM, Matthias Kaehlcke wrote:
Thanks for your time Matthias!!!
> On Wed, Apr 13, 2022 at 08:51:15PM +0530, Srinivasa Rao Mandadapu wrote:
>> Add wcd938x and  max98360a codecs for audio use case on
>> sc7280 based platforms.
>> Add tlmm gpio property in wcd938x node for switching CTIA/OMTP Headset.
>> Add amp_en node for  max98360a codec.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
> Applicable to all you patches: a per-patch change log would be really
> nice for reviewers. It can help them to focus on the parts that have
> actually changed with respect to earlier revisions they might have
> already reviewed.

Okay. Understood. But we have been updating change log in cover letter, 
it would be difficult to segregate now.

Next time onward will take care.

>
>>   arch/arm64/boot/dts/qcom/sc7280-crd.dts        |  6 ++
>>   arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  8 +++
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 94 ++++++++++++++++++++++++++
>>   3 files changed, 108 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
>> index e2efbdd..b944366 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> Your branch needs a refresh, this file doesn't exist anymore.
>
> You'll want to change sc7280-crd-r3.dts for the CRD <= 2.x and
> sc7280-herobrine-crd.dts for the CRD >= 3.x
Okay. Will do accordingly.
>
>> @@ -84,6 +84,12 @@ ap_ts_pen_1v8: &i2c13 {
>>   	pins = "gpio51";
>>   };
>>   
>> +&wcd938x {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&us_euro_hs_sel>;
>> +	us-euro-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
>> +};
>> +
>>   &tlmm {
>>   	tp_int_odl: tp-int-odl {
>>   		pins = "gpio7";
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
>> index dc17f20..8e4f822 100644
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
> I agreed earlier that sorting by node name is correct, but that wasn't
> entirely true. The nodes should be sorted by name within the 'device'
> section, i.e. after the comment "/* BOARD-SPECIFIC TOP LEVEL NODES */".
Okay. will sort accordingly.
>
>>   	chosen {
>>   		stdout-path = "serial0:115200n8";
>>   	};
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index 110d9e9..6004c08 100644
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
>> +		compatible = "qcom,wcd9385-codec";
>> +		#sound-dai-cells = <1>;
>> +
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&wcd_reset_n>, <&wcd_reset_n_sleep>;
> Shouldn't this be:
>
> 		pinctrl-names = "default", "sleep";
> 		pinctrl-0 = <&wcd_reset_n>;
> 		pinctrl-1 = <&wcd_reset_n_sleep>;
>
> ?
Okay. Will update accordingly.
>
> nit: make the ordering of properties (pinctrl, #sound-dai-cells) and
> spacing within the node consistent for max98360a and wcd938x? Not
> super-important, but since both are codecs and added by the same
> patch, why not :)
Okay. will maintain accordingly.
>
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
>> @@ -238,6 +273,19 @@
>>   	modem-init;
>>   };
>>   
>> +&lpass_rx_macro {
>> +	status = "okay";
>> +};
>> +
>> +&lpass_tx_macro {
>> +	status = "okay";
>> +};
>> +
>> +&lpass_va_macro {
>> +	status = "okay";
>> +	vdd-micb-supply = <&vreg_bob>;
>> +};
>> +
>>   &pcie1 {
>>   	status = "okay";
>>   	perst-gpio = <&tlmm 2 GPIO_ACTIVE_LOW>;
>> @@ -298,6 +346,24 @@
>>   	cd-gpios = <&tlmm 91 GPIO_ACTIVE_LOW>;
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
>>   &uart5 {
>>   	compatible = "qcom,geni-debug-uart";
>>   	status = "okay";
>> @@ -561,6 +627,12 @@
>>   };
>>   
>>   &tlmm {
>> +	amp_en: amp-en {
>> +		pins = "gpio63";
>> +		bias-pull-down;
>> +		drive-strength = <2>;
>> +	};
>> +
>>   	bt_en: bt-en {
>>   		pins = "gpio85";
>>   		function = "gpio";
>> @@ -643,5 +715,27 @@
>>   		function = "gpio";
>>   		bias-pull-down;
>>   	};
>> +
>> +	us_euro_hs_sel: us-euro-hs-sel {
>> +		pins = "gpio81";
>> +		function = "gpio";
>> +		bias-pull-down;
>> +		drive-strength = <2>;
>> +	};
>> +
>> +	wcd_reset_n: wcd-reset-n {
>> +		pins = "gpio83";
>> +		function = "gpio";
>> +		drive-strength = <8>;
>> +		output-high;
>> +	};
>> +
>> +	wcd_reset_n_sleep: wcd-reset-n-sleep {
>> +		pins = "gpio83";
>> +		function = "gpio";
>> +		drive-strength = <8>;
>> +		bias-disable;
>> +		output-low;
>> +	};
>>   };
>>   
>> -- 
>> 2.7.4
>>
