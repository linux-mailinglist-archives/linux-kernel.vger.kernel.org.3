Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479D64F225C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 07:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiDEFEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 01:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiDEFD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 01:03:56 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F568114E;
        Mon,  4 Apr 2022 22:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649134881; x=1680670881;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ifEf31liwJF8Zk4jYo7UU+c21Lmu4DqdQijKygniokA=;
  b=F4DfvXFCDVgRUNS7fpUzwa/qXZSNoGZfqMNTo9jzJEUYRQcpfTPOiL/s
   tSjB2UdOiZCfWU7AL1RF8P08TASgoG58bF5x0/oE0Fw9jET7uPItayLyf
   Xkyvr55q0NSSP1lZHrhOfQ8AkJPh0iJ+gce/NwhsucAFfTvcVM+VEILuv
   c=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 Apr 2022 22:01:21 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 22:01:05 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Apr 2022 22:01:05 -0700
Received: from [10.216.10.223] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 4 Apr 2022
 22:01:01 -0700
Message-ID: <897dd23a-b747-ac7a-29f8-23d313c77d63@quicinc.com>
Date:   Tue, 5 Apr 2022 10:30:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 1/3] arm64: dts: qcom: sc7280: Add nodes for va tx and
 rx macros and external codecs
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <devicetree@vger.kernel.org>,
        <dianders@chromium.org>, <judyhsiao@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1647865696-19192-1-git-send-email-quic_srivasam@quicinc.com>
 <1647865696-19192-2-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n52E+_BUr33=DCt_rBi-KtdtG01PeRFJ-G98ME4Ka-6q8A@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n52E+_BUr33=DCt_rBi-KtdtG01PeRFJ-G98ME4Ka-6q8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/22/2022 1:35 AM, Stephen Boyd wrote:
Thanks for your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-03-21 05:28:14)
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
>> index e2efbdd..224a82d 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
>> @@ -84,6 +84,12 @@ ap_ts_pen_1v8: &i2c13 {
>>          pins = "gpio51";
>>   };
>>
>> +&wcd938x {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&us_euro_select>;
>> +       us-euro-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
>> +};
>> +
>>   &tlmm {
>>          tp_int_odl: tp-int-odl {
>>                  pins = "gpio7";
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
>> index de646d9..c6a04c3 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
>> @@ -20,6 +20,14 @@
>>   #include "sc7280-chrome-common.dtsi"
>>
>>   / {
>> +       max98360a: audio-codec-0 {
>> +               compatible = "maxim,max98360a";
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&amp_en>;
>> +               sdmode-gpios = <&tlmm 63 GPIO_ACTIVE_HIGH>;
>> +               #sound-dai-cells = <0>;
>> +       };
>> +
>>          chosen {
>>                  stdout-path = "serial0:115200n8";
>>          };
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index 4a7b18a..5f75c9a 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -20,6 +20,41 @@
>>                  serial1 = &uart7;
>>          };
>>
>> +       max98360a: audio-codec-0 {
>> +               compatible = "maxim,max98360a";
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&amp_en>;
>> +               sdmode-gpios = <&tlmm 63 GPIO_ACTIVE_HIGH>;
>> +               #sound-dai-cells = <0>;
>> +       };
>> +
>> +       wcd938x: audio-codec-1 {
>> +               compatible = "qcom,wcd9380-codec";
>> +               #sound-dai-cells = <1>;
>> +
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&wcd938x_reset_active>, <&wcd938x_reset_sleep>;
>> +               reset-gpios = <&tlmm 83 GPIO_ACTIVE_HIGH>;
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
>> +               qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000
>> +                                                         500000 500000 500000>;
>> +               qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
>> +               qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
>> +       };
>> +
>>          gpio-keys {
>>                  compatible = "gpio-keys";
>>                  label = "gpio-keys";
>> @@ -476,6 +511,143 @@
>>          drive-strength = <6>;
>>   };
>>
>> +&soc {
> Why is the soc node being modified in the board file? I expect these
> nodes to always be present in the SoC (sc7280) so they should be largely
> defined in the sc7280.dtsi file, except for any voltage supplies that
> are described in the board file because the board design dictates what
> power supplies are connected to the SoC pads.
Okay. will place accordingly.
>
>> +       rxmacro: codec@3200000 {
>> +               compatible = "qcom,sc7280-lpass-rx-macro";
>> +               reg = <0 0x03200000 0 0x1000>;
>> +
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&rx_swr_active>;
>> +
>> +               clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
>> +                        <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
>> +                        <&vamacro>;
>> +               clock-names = "mclk", "npl", "fsgen";
>> +
>> +               power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
>> +                               <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
>> +               power-domain-names ="macro", "dcodec";
>> +
>> +               #clock-cells = <0>;
>> +               #sound-dai-cells = <1>;
>> +       };
> This whole node can be moved to sc7280.dtsi and then we can have a
> simple
>
> 	&rxmacro {
> 		status = "okay";
> 	};
>
> here.
Okay.
>
>> +
>> +       txmacro: codec@3220000 {
>> +               compatible = "qcom,sc7280-lpass-tx-macro";
>> +               reg = <0 0x03220000 0 0x1000>;
>> +
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&tx_swr_active>;
>> +
>> +               clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
>> +                        <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
>> +                        <&vamacro>;
>> +               clock-names = "mclk", "npl", "fsgen";
>> +
>> +               power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
>> +                               <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
>> +               power-domain-names ="macro", "dcodec";
>> +
>> +               #clock-cells = <0>;
>> +               #sound-dai-cells = <1>;
> Same, but txmacro.
Okay.
>
>> +       };
>> +
>> +       vamacro: codec@3370000 {
>> +               compatible = "qcom,sc7280-lpass-va-macro";
>> +               reg = <0 0x03370000 0 0x1000>;
>> +
>> +               pinctrl-0 = <&dmic01_active>;
>> +               pinctrl-names = "default";
>> +
>> +               clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>;
>> +               clock-names = "mclk";
>> +
>> +               power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
>> +                               <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
>> +               power-domain-names ="macro", "dcodec";
>> +
>> +               vdd-micb-supply = <&vreg_bob>;
>> +
>> +               #clock-cells = <0>;
>> +               #sound-dai-cells = <1>;
> This one can move as well, except for vdd-micb-supply which needs to
> stay here.
>
> 	&vamacro {
> 		status = "okay";
> 		vdd-micb-supply = <&vreg_bob>;
> 	};
Okay.
>> +       };
>> +
>> +       swr0: soundwire@3210000 {
>> +               compatible = "qcom,soundwire-v1.6.0";
>> +               reg = <0 0x03210000 0 0x2000>;
> This node should largely go into the sc7280.dtsi file.
Okay.
>
>> +
>> +               interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
>> +               clocks = <&rxmacro>;
>> +               clock-names = "iface";
>> +
>> +               qcom,din-ports = <0>;
>> +               qcom,dout-ports = <5>;
>> +
>> +               resets = <&lpass_audiocc LPASS_AUDIO_SWR_RX_CGCR>;
>> +               reset-names = "swr_audio_cgcr";
>> +
>> +               qcom,ports-word-length =        /bits/ 8 <0x01 0x07 0x04 0xff 0xff>;
>> +               qcom,ports-sinterval-low =      /bits/ 8 <0x03 0x3f 0x1f 0x03 0x03>;
>> +               qcom,ports-offset1 =            /bits/ 8 <0x00 0x00 0x0b 0x01 0x01>;
>> +               qcom,ports-offset2 =            /bits/ 8 <0x00 0x00 0x0b 0x00 0x00>;
>> +               qcom,ports-lane-control =       /bits/ 8 <0x01 0x00 0x00 0x00 0x00>;
>> +               qcom,ports-block-pack-mode =    /bits/ 8 <0xff 0x00 0x01 0xff 0xff>;
>> +               qcom,ports-hstart =             /bits/ 8 <0xff 0x03 0xff 0xff 0xff>;
>> +               qcom,ports-hstop =              /bits/ 8 <0xff 0x06 0xff 0xff 0xff>;
>> +               qcom,ports-block-group-count =  /bits/ 8 <0xff 0xff 0xff 0xff 0x00>;
> Are these properties board specific? The sm8250.dtsi file has them so I
> guess not.
Yes. They are not board specific.  will move accordingly.
>
>> +
>> +               #sound-dai-cells = <1>;
>> +               #address-cells = <2>;
>> +               #size-cells = <0>;
>> +
>> +               wcd_rx: codec@0,4 {
>> +                       compatible = "sdw20217010d00";
> Is this some component on the board? If so then it should stay here in
> this file.
Yes. it's WCD codec component on board.
>
>> +                       reg = <0 4>;
>> +                       #sound-dai-cells = <1>;
>> +                       qcom,rx-port-mapping = <1 2 3 4 5>;
>> +               };
>> +       };
>> +
>> +       swr1: soundwire@3230000 {
>> +               compatible = "qcom,soundwire-v1.6.0";
>> +               reg = <0 0x03230000 0 0x2000>;
>> +
>> +               interrupts-extended = <&intc GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
>> +                                     <&pdc 130 IRQ_TYPE_LEVEL_HIGH>;
>> +               interrupt-names = "swr_master_irq", "swr_wake_irq";
>> +               clocks = <&txmacro>;
>> +               clock-names = "iface";
>> +
>> +               qcom,din-ports = <3>;
>> +               qcom,dout-ports = <0>;
>> +
>> +               resets = <&lpass_audiocc LPASS_AUDIO_SWR_TX_CGCR>;
>> +               reset-names = "swr_audio_cgcr";
>> +
>> +               qcom,ports-sinterval-low =      /bits/ 8 <0x01 0x03 0x03>;
>> +               qcom,ports-offset1 =            /bits/ 8 <0x01 0x00 0x02>;
>> +               qcom,ports-offset2 =            /bits/ 8 <0x00 0x00 0x00>;
>> +               qcom,ports-hstart =             /bits/ 8 <0xff 0xff 0xff>;
>> +               qcom,ports-hstop =              /bits/ 8 <0xff 0xff 0xff>;
>> +               qcom,ports-word-length =        /bits/ 8 <0xff 0x0 0xff>;
>> +               qcom,ports-block-pack-mode =    /bits/ 8 <0xff 0xff 0xff>;
>> +               qcom,ports-block-group-count =  /bits/ 8 <0xff 0xff 0xff>;
>> +               qcom,ports-lane-control =       /bits/ 8 <0x00 0x01 0x00>;
>> +               qcom,port-offset = <1>;
>> +
>> +               #sound-dai-cells = <1>;
>> +               #address-cells = <2>;
>> +               #size-cells = <0>;
>> +
>> +               wcd_tx: codec@0,3 {
>> +                       compatible = "sdw20217010d00";
>> +                       reg = <0 3>;
>> +                       #sound-dai-cells = <1>;
>> +                       qcom,tx-port-mapping = <1 2 3 4>;
>> +               };
> Same question about being a board component. Probably yes?
Yes.
>
>> +       };
>> +};
>> +
>>   &tlmm {
>>          amp_en: amp-en {
