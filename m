Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9864A82DB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350124AbiBCLEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:04:52 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:11730 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349926AbiBCLEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:04:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643886285; x=1675422285;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=B23bwCifTvnTSgm2vpuE0fXZNAIZiLoV40AZh39t7EE=;
  b=NMJ3vsBjsr+/eppArlWQbCAVR078xGlpw9mWIBvkMUn039vYtAbpd33n
   oC8dYoUl5ws3z5C5tcKdLTeshSpigWFqHJRsMhtbB9Ut40X2FfINDiCjN
   di3IhMF3eLGBItkjOH4ySaMm+I22XT/C1pj+ZB1rKVnLquSwGFs3rv+/F
   4=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 03 Feb 2022 03:04:44 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 03:04:44 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 03:04:44 -0800
Received: from [10.216.62.64] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 3 Feb 2022
 03:04:40 -0800
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: sc7280: Add nodes for va tx and
 rx macros and external codecs
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <devicetree@vger.kernel.org>,
        <dianders@chromium.org>, <judyhsiao@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <rohitkr@codeaurora.org>,
        <srinivas.kandagatla@linaro.org>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1641208380-15510-1-git-send-email-quic_srivasam@quicinc.com>
 <1641208380-15510-2-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n523iE-rkSKNvZaF8+qOezEQLo-hAhhMcRoHs9kVa0iLZg@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
Message-ID: <b21bf403-053f-bd21-94ff-5c5cfb6eaacf@quicinc.com>
Date:   Thu, 3 Feb 2022 16:34:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n523iE-rkSKNvZaF8+qOezEQLo-hAhhMcRoHs9kVa0iLZg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/6/2022 1:45 AM, Stephen Boyd wrote:
Thanks for Your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-01-03 03:12:58)
>> SC7280 has VA, TX and RX macros with SoundWire Controllers to attach with
>> codecs like WCD938x, max98360a using soundwire masters and i2s bus.
>> Add these nodes for sc7280 based platforms audio use case.
>> Add tlmm gpio property in wcd938x node for switching CTIA/OMTP Headset.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280-crd.dts  |   4 ++
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi |  52 ++++++++++++++
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi     | 113 +++++++++++++++++++++++++++++++
>>   3 files changed, 169 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
>> index cd2755c..035cca9 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
>> @@ -72,6 +72,10 @@ ap_ts_pen_1v8: &i2c13 {
>>          pins = "gpio51";
>>   };
>>
>> +&wcd938x {
>> +       qcom,us-euro-gpios = <&tlmm 81 0>;
> Why is this a qcom prefix vs. a standard foo-gpios property?
Okay. will remove qcom.
>
>> +};
>> +
>>   &tlmm {
>>          tp_int_odl: tp-int-odl {
>>                  pins = "gpio7";
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index ddeb508..94614c9 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -636,3 +636,55 @@
>>                  bias-pull-up;
>>          };
>>   };
>> +
>> +&swr0 {
>> +       wcd_rx: wcd938x-rx{
> space before { please
>
> Also, are these speakers or amps or something like that? I'd expect the
> node name to be more generic.
Okay. Will change accordingly.
>
>> +               compatible = "sdw20217010d00";
>> +               reg = <0 4>;
>> +               #sound-dai-cells = <1>;
>> +               qcom,rx-port-mapping = <1 2 3 4 5>;
>> +       };
>> +};
>> +
>> +&swr1 {
>> +       wcd_tx: wcd938x-tx{
>> +               compatible = "sdw20217010d00";
>> +               reg = <0 3>;
>> +               #sound-dai-cells = <1>;
>> +               qcom,tx-port-mapping = <1 2 3 4>;
>> +       };
>> +};
>> +
>> +&soc {
>> +       max98360a: audio-codec-0 {
> This shouldn't be a child of the soc node.
Okay. Will move it to root node.
>
>> +               compatible = "maxim,max98360a";
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&amp_en>;
>> +               sdmode-gpios = <&tlmm 63 GPIO_ACTIVE_HIGH>;
>> +               #sound-dai-cells = <0>;
>> +       };
>> +
>> +       wcd938x: codec {
> Same comment.
Okay.
>
>> +               compatible = "qcom,wcd9380-codec";
>> +               #sound-dai-cells = <1>;
>> +
>> +               reset-gpios = <&tlmm 83 0>;
>> +
>> +               qcom,rx-device = <&wcd_rx>;
>> +               qcom,tx-device = <&wcd_tx>;
>> +
>> +               vdd-rxtx-supply = <&vreg_l18b_1p8>;
>> +               vdd-io-supply = <&vreg_l18b_1p8>;
>> +               vdd-buck-supply = <&vreg_l17b_1p8>;
>> +               vdd-mic-bias-supply = <&vreg_bob>;
>> +
>> +               qcom,micbias1-microvolt = <1800000>;
>> +               qcom,micbias2-microvolt = <1800000>;
>> +               qcom,micbias3-microvolt = <1800000>;
>> +               qcom,micbias4-microvolt = <1800000>;
>> +
>> +               qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
>> +               qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
>> +               qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
>> +       };
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 6233f2c..c0d9de3 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -1744,6 +1744,119 @@
>>                          #clock-cells = <1>;
>>                  };
>>
>> +               rxmacro: rxmacro@3200000 {
> What is rxmacro? Maybe 'soundwire'?
No. it's not soundwire. it's digital codec macro internal to LPASS.
>
>> +                       pinctrl-names = "default";
>> +                       pinctrl-0 = <&rx_swr_active>;
>> +                       compatible = "qcom,sc7280-lpass-rx-macro";
>> +                       reg = <0 0x3200000 0 0x1000>;
>> +
>> +                       clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
>> +                                       <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
>> +                                       <&vamacro>;
>> +                       clock-names = "mclk", "npl", "fsgen";
>> +                       #clock-cells = <0>;
>> +                       clock-frequency = <9600000>;
>> +                       clock-output-names = "mclk";
>> +                       #sound-dai-cells = <1>;
>> +               };
>> +
>> +               /* rx macro */
>> +               swr0: soundwire-controller@3210000 {
> Is 'controller' redundant? i.e. soundwire is always a controller? Maybe
> 'soundwire' is better
Okay. will remove controller.
>
>> +                       reg = <0 0x3210000 0 0x2000>;
>> +                       compatible = "qcom,soundwire-v1.6.0";
>> +                       interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
>> +                       clocks = <&rxmacro>;
>> +                       clock-names = "iface";
>> +                       label = "RX";
>> +
>> +                       qcom,din-ports = <0>;
>> +                       qcom,dout-ports = <5>;
>> +                       qcom,swrm-hctl-reg = <0x032a90a0>;
>> +
>> +                       qcom,ports-word-length =        /bits/ 8 <0x01 0x07 0x04 0xFF 0xFF>;
>> +                       qcom,ports-sinterval-low =      /bits/ 8 <0x03 0x3F 0x1F 0x03 0x03>;
>> +                       qcom,ports-offset1 =            /bits/ 8 <0x00 0x00 0x0B 0x01 0x01>;
>> +                       qcom,ports-offset2 =            /bits/ 8 <0x00 0x00 0x0B 0x00 0x00>;
>> +                       qcom,ports-lane-control =       /bits/ 8 <0x01 0x00 0x00 0x00 0x00>;
>> +                       qcom,ports-block-pack-mode =    /bits/ 8 <0xFF 0x00 0x01 0xFF 0xFF>;
>> +                       qcom,ports-hstart =             /bits/ 8 <0xFF 0x03 0xFF 0xFF 0xFF>;
>> +                       qcom,ports-hstop =              /bits/ 8 <0xFF 0x06 0xFF 0xFF 0xFF>;
>> +                       qcom,ports-block-group-count =  /bits/ 8 <0xFF 0xFF 0xFF 0xFF 0x00>;
> Why is this bit stuff in DT vs. in the device driver?

This is soundwire ports configuration and is followed in 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/sm8250.dtsi?h=v5.17-rc2

>
>> +
>> +                       #sound-dai-cells = <1>;
>> +                       #address-cells = <2>;
>> +                       #size-cells = <0>;
>> +               };
>> +
>> +               txmacro: txmacro@3220000 {
>> +                       pinctrl-names = "default";
>> +                       pinctrl-0 = <&tx_swr_active>;
>> +                       compatible = "qcom,sc7280-lpass-tx-macro";
>> +                       reg = <0 0x3220000 0 0x1000>;
>> +
>> +                       clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
>> +                                        <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
>> +                                        <&vamacro>;
> Please align the clocks here so the < starts on the same column.
Okay.
>
>> +                       clock-names = "mclk", "npl", "fsgen";
>> +
>> +                       #clock-cells = <0>;
>> +                       clock-frequency = <9600000>;
>> +                       clock-output-names = "mclk";
>> +                       #address-cells = <2>;
>> +                       #size-cells = <2>;
>> +                       #sound-dai-cells = <1>;
>> +               };
>> +
>> +               /* tx macro */
> Do we need these comments? Please remove them as they're practically
> useless.
Okay. Will remove it.
>
>> +               swr1: soundwire-controller@3230000 {
>> +                       reg = <0 0x3230000 0 0x2000>;
>> +                       compatible = "qcom,soundwire-v1.6.0";
>> +
>> +                       interrupts-extended =
>> +                                       <&intc GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
>> +                                       <&pdc 130 IRQ_TYPE_LEVEL_HIGH>;
>> +                       interrupt-names = "swr_master_irq", "swr_wake_irq";
>> +                       clocks = <&txmacro>;
>> +                       clock-names = "iface";
>> +                       label = "TX";
>> +
>> +                       qcom,din-ports = <3>;
>> +                       qcom,dout-ports = <0>;
>> +                       qcom,swrm-hctl-reg = <0x032a90a8>;
> This looks like some common register location for soundwire oops bits.
> Is it another device? Or maybe it's a common register base that needs to
> be a syscon?
We are in discussion on this, how to handle it appropriately. Will 
change accordingly after design concluded.
>
>> +
>> +                       qcom,ports-sinterval-low =      /bits/ 8 <0x01 0x03 0x03>;
>> +                       qcom,ports-offset1 =            /bits/ 8 <0x01 0x00 0x02>;
>> +                       qcom,ports-offset2 =            /bits/ 8 <0x00 0x00 0x00>;
>> +                       qcom,ports-hstart =             /bits/ 8 <0xFF 0xFF 0xFF>;
>> +                       qcom,ports-hstop =              /bits/ 8 <0xFF 0xFF 0xFF>;
>> +                       qcom,ports-word-length =        /bits/ 8 <0xFF 0x0 0xFF>;
>> +                       qcom,ports-block-pack-mode =    /bits/ 8 <0xFF 0xFF 0xFF>;
>> +                       qcom,ports-block-group-count =  /bits/ 8 <0xFF 0xFF 0xFF>;
>> +                       qcom,ports-lane-control =       /bits/ 8 <0x00 0x01 0x00>;
>> +                       qcom,port-offset = <1>;
>> +
>> +                       #sound-dai-cells = <1>;
>> +                       #address-cells = <2>;
>> +                       #size-cells = <0>;
>> +               };
>> +
>> +               vamacro: codec@3370000 {
>> +                       compatible = "qcom,sc7280-lpass-va-macro";
>> +                       pinctrl-0 = <&dmic01_active>;
>> +                       pinctrl-names = "default";
>> +
>> +                       vdd-micb-supply = <&vreg_bob>;
> The supplies need to be set in the board file, no the soc file as they
> can be different depending on what the hardware engineer wires to the
> pins on the SoC.
Okay. Will move it to board specific file.
>
>> +                       reg = <0 0x3370000 0 0x1000>;
>> +                       clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
>> +                                       <&lpass_audiocc LPASS_AUDIO_CC_RX_MCLK_CLK>;
>> +                       clock-names = "mclk", "macro";
>> +
>> +                       #clock-cells = <0>;
>> +                       clock-frequency = <9600000>;
>> +                       clock-output-names = "fsgen";
>> +                       #sound-dai-cells = <1>;
>> +               };
>> +
>>                  lpass_tlmm: pinctrl@33c0000 {
>>                          compatible = "qcom,sc7280-lpass-lpi-pinctrl";
>>                          reg = <0 0x33c0000 0x0 0x20000>,
>> --
>> 2.7.4
>>
