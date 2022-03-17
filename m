Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F214DC88C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbiCQORK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbiCQORH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:17:07 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A940B1FF404;
        Thu, 17 Mar 2022 07:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647526550; x=1679062550;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v+XyM5CQexndeN0aX5tELqvxURliYkZn8wWDLVb7XmA=;
  b=NHfR57wEpbDupQcsuOKZoU6OLdE4bh+a4WnLDnO+aIP2fKLJD2VtbN/E
   CHuCXC6GO/JuzcJ7ACwLMBA/wQ5qu3DNgxaq93MJj4n9mYz1IItLq1QKX
   7Yx0Fl5UAkOp9Lzt90x3GVmubM9qE1+2EiWgQBGdzNDhAB8ExH66jrbjl
   I=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 17 Mar 2022 07:15:50 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 07:15:49 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 17 Mar 2022 07:15:49 -0700
Received: from [10.216.33.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 17 Mar
 2022 07:15:45 -0700
Message-ID: <c7be335b-6708-10ac-dd4e-ed2216d90517@quicinc.com>
Date:   Thu, 17 Mar 2022 19:45:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 1/3] arm64: dts: qcom: sc7280: Add nodes for va tx and
 rx macros and external codecs
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
References: <1644591438-6514-1-git-send-email-quic_srivasam@quicinc.com>
 <1644591438-6514-2-git-send-email-quic_srivasam@quicinc.com>
 <CAD=FV=XP7uQ+uxt05Gcn0SLeheO1-bMBemvka44s0vjGOApLwQ@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAD=FV=XP7uQ+uxt05Gcn0SLeheO1-bMBemvka44s0vjGOApLwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/1/2022 6:19 AM, Doug Anderson wrote:
Thanks for Your Time Doug!!!
> Hi,
>
> On Fri, Feb 11, 2022 at 6:57 AM Srinivasa Rao Mandadapu
> <quic_srivasam@quicinc.com> wrote:
>> SC7280 has VA, TX and RX macros with SoundWire Controllers to attach with
>> codecs like WCD938x, max98360a using soundwire masters and i2s bus.
>> Add these nodes for sc7280 based platforms audio use case.
>> Add tlmm gpio property in wcd938x node for switching CTIA/OMTP Headset.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280-crd.dts  |   4 +
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 178 +++++++++++++++++++++++++++++++
>>   2 files changed, 182 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
>> index e2efbdd..dd23b63 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
>> @@ -84,6 +84,10 @@ ap_ts_pen_1v8: &i2c13 {
>>          pins = "gpio51";
>>   };
>>
>> +&wcd938x {
>> +       us-euro-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
> Probably need GPIO 81 pinctrl entry?
Okay. Will add it.
>
>
>> +};
>> +
>>   &tlmm {
>>          tp_int_odl: tp-int-odl {
>>                  pins = "gpio7";
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index 1089fa0..07f8b1e 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -38,6 +38,14 @@
>>                  };
>>          };
>>
>> +       max98360a: audio-codec-0 {
> nit that sorting should be based on node name here, so "audio" should
> sort before "gpio-keys"
Okay. will sort acordingly.
>
>
>> +               compatible = "maxim,max98360a";
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&amp_en>;
> You refer to "amp_en", but I don't see it defined anywhere except in
> "herobrine" files, so I don't think this will compile for you, will
> it?
It's in dependent patch, which is in review state.
>
>
>> +               sdmode-gpios = <&tlmm 63 GPIO_ACTIVE_HIGH>;
>> +               #sound-dai-cells = <0>;
>> +       };
>> +
>>          nvme_3v3_regulator: nvme-3v3-regulator {
>>                  compatible = "regulator-fixed";
>>                  regulator-name = "VLDO_3V3";
>> @@ -49,6 +57,31 @@
>>                  pinctrl-names = "default";
>>                  pinctrl-0 = <&nvme_pwren>;
>>          };
>> +
>> +       wcd938x: codec {
> This is also sorted wrong.
Okay.
>
>
>> +               compatible = "qcom,wcd9380-codec";
>> +               #sound-dai-cells = <1>;
>> +
>> +               reset-gpios = <&tlmm 83 GPIO_ACTIVE_HIGH>;
> Where's the pinctrl for GPIO 83?
Okay. Will add it.
>
>
>> +               qcom,rx-device = <&wcd_rx>;
>> +               qcom,tx-device = <&wcd_tx>;
>> +
>> +               vdd-rxtx-supply = <&vreg_l18b_1p8>;
>> +               vdd-io-supply = <&vreg_l18b_1p8>;
>> +               vdd-buck-supply = <&vreg_l17b_1p8>;
>> +               vdd-mic-bias-supply = <&vreg_bob>;
> "vdd-mic-bias-supply" doesn't appear to be in your bindings.
Okay. will add it.
>
>
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
>>   };
>>
>>   &apps_rsc {
>> @@ -496,6 +529,148 @@
>>          drive-strength = <6>;
>>   };
>>
>> +&soc {
>> +       rxmacro: rxmacro@3200000 {
>  From the bindings document, I believe the node name should be
> "codec@3200000", not "rxmacro@..."
Okay.
>
>
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&rx_swr_active>;
>> +               compatible = "qcom,sc7280-lpass-rx-macro";
>> +               reg = <0 0x3200000 0 0x1000>;
> The first two entries should be compatible and reg. Same for many places below.
Okay. will sort it.
>
>> +
>> +               clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
>> +                        <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
>> +                        <&vamacro>;
>> +               clock-names = "mclk", "npl", "fsgen";
> Bindings document shows 5 clocks. You only specify 3. You either need
> the extra clocks or you need to change the binding to allow for fewer.
Okay. will fix it.
>
>
>> +               power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
>> +                               <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
>> +               power-domain-names ="macro", "dcodec";
> Why is power-domain stuff not in the bindings? Oh, I see. It's listed
> as clocks there? You need to sort that out in the bindings.
Okay.
>
>
>> +               #clock-cells = <0>;
>> +               clock-frequency = <9600000>;
>> +               clock-output-names = "mclk";
>> +               #sound-dai-cells = <1>;
>> +       };
>> +
>> +       swr0: soundwire@3210000 {
>> +               reg = <0 0x3210000 0 0x2000>;
>> +               compatible = "qcom,soundwire-v1.6.0";
>> +               interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
>> +               clocks = <&rxmacro>;
>> +               clock-names = "iface";
>> +               label = "RX";
> label is not in the bindings.
Okay. Will remove it as it's not being used.
>
>
>> +               qcom,din-ports = <0>;
>> +               qcom,dout-ports = <5>;
>> +               qcom,swrm-hctl-reg = <0x032a90a0>;
> qcom,swrm-hctl-reg is not in the bindings, right? It also looks like a
> magic value and probably should be broken out into something more
> meaningful.
We have changed it as reset control. will update accordingly.
>
>
>> +               qcom,ports-word-length =        /bits/ 8 <0x01 0x07 0x04 0xFF 0xFF>;
>> +               qcom,ports-sinterval-low =      /bits/ 8 <0x03 0x3F 0x1F 0x03 0x03>;
>> +               qcom,ports-offset1 =            /bits/ 8 <0x00 0x00 0x0B 0x01 0x01>;
>> +               qcom,ports-offset2 =            /bits/ 8 <0x00 0x00 0x0B 0x00 0x00>;
>> +               qcom,ports-lane-control =       /bits/ 8 <0x01 0x00 0x00 0x00 0x00>;
>> +               qcom,ports-block-pack-mode =    /bits/ 8 <0xFF 0x00 0x01 0xFF 0xFF>;
>> +               qcom,ports-hstart =             /bits/ 8 <0xFF 0x03 0xFF 0xFF 0xFF>;
>> +               qcom,ports-hstop =              /bits/ 8 <0xFF 0x06 0xFF 0xFF 0xFF>;
>> +               qcom,ports-block-group-count =  /bits/ 8 <0xFF 0xFF 0xFF 0xFF 0x00>;
>> +
>> +               #sound-dai-cells = <1>;
>> +               #address-cells = <2>;
>> +               #size-cells = <0>;
>> +       };
>> +
>> +       txmacro: txmacro@3220000 {
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&tx_swr_active>;
>> +               compatible = "qcom,sc7280-lpass-tx-macro";
>> +               reg = <0 0x3220000 0 0x1000>;
>> +
>> +               clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
>> +                        <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
>> +                        <&vamacro>;
>> +               clock-names = "mclk", "npl", "fsgen";
>> +
>> +               power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
>> +                               <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
>> +               power-domain-names ="macro", "dcodec";
> Again you've got mismatch w/ the bindings on clocks and power-domains.
Okay.
>
>
>> +               #clock-cells = <0>;
>> +               clock-frequency = <9600000>;
>> +               clock-output-names = "mclk";
>> +               #address-cells = <2>;
>> +               #size-cells = <2>;
> Why address and size cells of 2???
Okay. It seems not required here. will remove it.
>
>
>> +               #sound-dai-cells = <1>;
>> +       };
>> +
>> +       swr1: soundwire@3230000 {
>> +               reg = <0 0x3230000 0 0x2000>;
>> +               compatible = "qcom,soundwire-v1.6.0";
>> +
>> +               interrupts-extended =
>> +                               <&intc GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
>> +                               <&pdc 130 IRQ_TYPE_LEVEL_HIGH>;
>> +               interrupt-names = "swr_master_irq", "swr_wake_irq";
>> +               clocks = <&txmacro>;
>> +               clock-names = "iface";
>> +               label = "TX";
>> +
>> +               qcom,din-ports = <3>;
>> +               qcom,dout-ports = <0>;
>> +               qcom,swrm-hctl-reg = <0x032a90a8>;
>> +
>> +               qcom,ports-sinterval-low =      /bits/ 8 <0x01 0x03 0x03>;
>> +               qcom,ports-offset1 =            /bits/ 8 <0x01 0x00 0x02>;
>> +               qcom,ports-offset2 =            /bits/ 8 <0x00 0x00 0x00>;
>> +               qcom,ports-hstart =             /bits/ 8 <0xFF 0xFF 0xFF>;
>> +               qcom,ports-hstop =              /bits/ 8 <0xFF 0xFF 0xFF>;
>> +               qcom,ports-word-length =        /bits/ 8 <0xFF 0x0 0xFF>;
>> +               qcom,ports-block-pack-mode =    /bits/ 8 <0xFF 0xFF 0xFF>;
>> +               qcom,ports-block-group-count =  /bits/ 8 <0xFF 0xFF 0xFF>;
>> +               qcom,ports-lane-control =       /bits/ 8 <0x00 0x01 0x00>;
>> +               qcom,port-offset = <1>;
>> +
>> +               #sound-dai-cells = <1>;
>> +               #address-cells = <2>;
>> +               #size-cells = <0>;
>> +       };
> Same comments as with swr0.
Okay.
>
>
>> +       vamacro: codec@3370000 {
>> +               compatible = "qcom,sc7280-lpass-va-macro";
>> +               pinctrl-0 = <&dmic01_active>;
>> +               pinctrl-names = "default";
>> +
>> +               reg = <0 0x3370000 0 0x1000>;
>> +               clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>;
>> +               clock-names = "mclk";
>> +
>> +               power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
>> +                               <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
>> +               power-domain-names ="macro", "dcodec";
> Again mismatch w/ bindings on clocks / power-domains.

Okay. will update bindings accordingly

>
>
>> +               #clock-cells = <0>;
>> +               clock-frequency = <9600000>;
>> +               clock-output-names = "fsgen";
>> +               #sound-dai-cells = <1>;
>> +       };
>> +};
>> +
>> +&swr0 {
> This is in the same file, right? Just put it above right under the node.
Okay.
>
>
>> +       wcd_rx: wcd938x-hph-playback {
> Please follow the bindings. Use the node name "codec" and include the
> unit address, so this should be codec@0,4.
Okay.
>
>
>> +               compatible = "sdw20217010d00";
>> +               reg = <0 4>;
>> +               #sound-dai-cells = <1>;
>> +               qcom,rx-port-mapping = <1 2 3 4 5>;
>> +       };
>> +};
>> +
>> +&swr1 {
>> +       wcd_tx: wcd938x-hph-capture {
>> +               compatible = "sdw20217010d00";
>> +               reg = <0 3>;
>> +               #sound-dai-cells = <1>;
>> +               qcom,tx-port-mapping = <1 2 3 4>;
>> +       };
> Same comments as with swr0.
Okay.
