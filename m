Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78ED509832
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385523AbiDUHEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242436AbiDUHEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:04:50 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B388A13FB8;
        Thu, 21 Apr 2022 00:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650524521; x=1682060521;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=OFm/LgNQEspfxbhUYvzH/hhuN4GD3iJwCvVkBUNvK/U=;
  b=QCcnjmZRkbKZqfVDPIkFpM9ZIzckiw450QYsQpEZGkT+wyvpqX+eHY6y
   tisPL12MSQFd80x7x0x+5Sl4QSP17AlkNburRsy4XemTWl/6EBg1EdIVU
   XM2hO74O+OmiWLqiNIz7vMxIfhrO5TlK0m8fr8OXJD2RE87MXnPfWfUrr
   Q=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Apr 2022 00:02:01 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 00:02:01 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 21 Apr 2022 00:02:00 -0700
Received: from [10.216.51.211] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 21 Apr
 2022 00:01:55 -0700
Message-ID: <5d4b7c44-62e1-aaa6-3116-f58e1a1b437b@quicinc.com>
Date:   Thu, 21 Apr 2022 12:31:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v8 2/4] arm64: dts: qcom: sc7280: Add nodes for wcd9385
 and max98360a codec
Content-Language: en-US
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1650291252-30398-1-git-send-email-quic_srivasam@quicinc.com>
 <1650291252-30398-3-git-send-email-quic_srivasam@quicinc.com>
 <Yl2VmW18QAJl9v+m@google.com>
 <5ac149ac-4862-e8c9-185c-524c4b111961@quicinc.com>
Organization: Qualcomm
In-Reply-To: <5ac149ac-4862-e8c9-185c-524c4b111961@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/19/2022 4:54 PM, Srinivasa Rao Mandadapu wrote:
>
> On 4/18/2022 10:15 PM, Matthias Kaehlcke wrote:
> Thanks for your time and valuable inputs Matthias!!!
>> On Mon, Apr 18, 2022 at 07:44:10PM +0530, Srinivasa Rao Mandadapu wrote:
>>> Add wcd938x and  max98360a codecs for audio use case on
>>> sc7280 based platforms.
>>> Add tlmm gpio property in wcd938x node for switching CTIA/OMTP Headset.
>>> Add amp_en node for  max98360a codec.
>> General note: I don't think it's a good practice to add stuff like 
>> this to
>> multiple boards in a single patch. Why?
>>
>> First the subject of such a patch tends to be vague ("arm64: dts: qcom:
>> sc7280: Add nodes for wcd9385 and max98360a codec"), in this case it 
>> gives
>> no hint about the boards. If someone was interested in picking changes
>> for a given board they can't easily identify from the subject that the
>> change is relevant for them.
>>
>> Changes touching multiple boards are more likely to cause conflicts when
>> being picked (or reverted), both upstream and in downstream trees (which
>> unfortunately have to exist for product development). Downstream trees
>> might only pick changes for the board(s) they target, patches that touch
>> mutiple boards often cause conflicts due to context deltas in the
>> 'irrelevant' boards.
>>
>> Lastly it's usually easier to get a patch reviewed (in the sense of
>> getting a 'Reviewed-by' tag) and landed that does a single thing.
>
> Yes, agree to your opinion. In a nutshell, we will include board 
> name(ex: herobrine)
>
> in commit message and split the patches per external codec.
>
> Actually, in Initial herobrine boards, EVT and IDP, has both maxim 
> speaker and WCD codec,
>
> hence we included in same patch.
>
>>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts     |  6 ++
>>>   arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  8 +++
>>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 97 
>>> ++++++++++++++++++++++++++
>>>   3 files changed, 111 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts 
>>> b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
>>> index 344338a..aa0bf6e2 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
>>> @@ -87,6 +87,12 @@ ap_ts_pen_1v8: &i2c13 {
>>>       pins = "gpio51";
>>>   };
>>>   +&wcd938x {
>>> +    pinctrl-names = "default";
>>> +    pinctrl-0 = <&us_euro_hs_sel>;
>>> +    us-euro-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
>>> +};
>> Since this is added for the CRD rev3 it probably should also be added to
>> sc7280-herobrine-crd.dts
> Okay. Will add in corresponding latest herobrine CRD dts file also.
>>
>>> +
>>>   &tlmm {
>>>       tp_int_odl: tp-int-odl {
>>>           pins = "gpio7";
>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi 
>>> b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
>>> index d58045d..f247403 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
>>> @@ -20,6 +20,14 @@
>>>   #include "sc7280-chrome-common.dtsi"
>>>     / {
>>> +    max98360a: audio-codec-0 {
>>> +        compatible = "maxim,max98360a";
>>> +        pinctrl-names = "default";
>>> +        pinctrl-0 = <&amp_en>;
>>> +        sdmode-gpios = <&tlmm 63 GPIO_ACTIVE_HIGH>;
>>> +        #sound-dai-cells = <0>;
>>> +    };
>>> +
>>>       chosen {
>>>           stdout-path = "serial0:115200n8";
>>>       };
>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi 
>>> b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>>> index 2f863c0..8dad599 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>>> @@ -20,6 +20,42 @@
>>>           serial1 = &uart7;
>>>       };
>>>   +    max98360a: audio-codec-0 {
>>> +        compatible = "maxim,max98360a";
>>> +        pinctrl-names = "default";
>>> +        pinctrl-0 = <&amp_en>;
>>> +        sdmode-gpios = <&tlmm 63 GPIO_ACTIVE_HIGH>;
>>> +        #sound-dai-cells = <0>;
>>> +    };
>>> +
>>> +    wcd938x: audio-codec-1 {
>> Why 'wcd938x' and not 'wcd9385'?
>
> Actually same driver is used for both wcd9380 and wcd9385. Here we can 
> use specific name as per board.
>
> Will change accordingly.

At present, dt-bindgs also has wcd938x. So will update the name in 
bindings and here post this series.

is it okay?

>
>>
>>> +        compatible = "qcom,wcd9385-codec";
>>> +        pinctrl-names = "default", "sleep";
>>> +        pinctrl-0 = <&wcd_reset_n>;
>>> +        pinctrl-1 = <&wcd_reset_n_sleep>;
>>> +
>>> +        reset-gpios = <&tlmm 83 GPIO_ACTIVE_HIGH>;
>>> +
>>> +        qcom,rx-device = <&wcd_rx>;
>>> +        qcom,tx-device = <&wcd_tx>;
>>> +
>>> +        vdd-rxtx-supply = <&vreg_l18b_1p8>;
>>> +        vdd-io-supply = <&vreg_l18b_1p8>;
>>> +        vdd-buck-supply = <&vreg_l17b_1p8>;
>>> +        vdd-mic-bias-supply = <&vreg_bob>;
>>> +
>>> +        qcom,micbias1-microvolt = <1800000>;
>>> +        qcom,micbias2-microvolt = <1800000>;
>>> +        qcom,micbias3-microvolt = <1800000>;
>>> +        qcom,micbias4-microvolt = <1800000>;
>>> +
>>> +        qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 
>>> 237000 500000 500000
>>> +                              500000 500000 500000>;
>>> +        qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
>>> +        qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
>>> +        #sound-dai-cells = <1>;
>>> +    };
>> Also add this node to sc7280-herobrine-crd.dts?
> Okay. will do accordingly.
>>
>>> +
>>>       gpio-keys {
>>>           compatible = "gpio-keys";
>>>           label = "gpio-keys";
>>> @@ -238,6 +274,19 @@
>>>       modem-init;
>>>   };
>>>   +&lpass_rx_macro {
>>> +    status = "okay";
>>> +};
>>> +
>>> +&lpass_tx_macro {
>>> +    status = "okay";
>>> +};
>>> +
>>> +&lpass_va_macro {
>>> +    status = "okay";
>>> +    vdd-micb-supply = <&vreg_bob>;
>>> +};
>> Enable these also in sc7280-herobrine.dtsi if other nodes are added to
>> sc7280-herobrine-crd.dts.
> Okay.
>>
>>> +
>>>   &pcie1 {
>>>       status = "okay";
>>>       perst-gpio = <&tlmm 2 GPIO_ACTIVE_LOW>;
>>> @@ -298,6 +347,26 @@
>>>       cd-gpios = <&tlmm 91 GPIO_ACTIVE_LOW>;
>>>   };
>>>   +&swr0 {
>>> +    status = "okay";
>> nit: add an empty line between properties and nodes
> Okay.
>>
>>> +    wcd_rx: codec@0,4 {
>>> +        compatible = "sdw20217010d00";
>>> +        reg = <0 4>;
>>> +        #sound-dai-cells = <1>;
>>> +        qcom,rx-port-mapping = <1 2 3 4 5>;
>>> +    };
>>> +};
>>> +
>>> +&swr1 {
>>> +    status = "okay";
>> ditto
> Okay.
>>
>>> +    wcd_tx: codec@0,3 {
>>> +        compatible = "sdw20217010d00";
>>> +        reg = <0 3>;
>>> +        #sound-dai-cells = <1>;
>>> +        qcom,tx-port-mapping = <1 2 3 4>;
>>> +    };
>>> +};
>> Also add these to sc7280-herobrine-crd.dts?
> Okay.
>>
>>> +
>>>   &uart5 {
>>>       compatible = "qcom,geni-debug-uart";
>>>       status = "okay";
>>> @@ -561,6 +630,12 @@
>>>   };
>>>     &tlmm {
>>> +    amp_en: amp-en {
>>> +        pins = "gpio63";
>>> +        bias-pull-down;
>>> +        drive-strength = <2>;
>>> +    };
>>> +
>>>       bt_en: bt-en {
>>>           pins = "gpio85";
>>>           function = "gpio";
>>> @@ -643,6 +718,28 @@
>>>           function = "gpio";
>>>           bias-pull-down;
>>>       };
>>> +
>>> +    us_euro_hs_sel: us-euro-hs-sel {
>>> +        pins = "gpio81";
>>> +        function = "gpio";
>>> +        bias-pull-down;
>>> +        drive-strength = <2>;
>>> +    };
>>> +
>>> +    wcd_reset_n: wcd-reset-n {
>>> +        pins = "gpio83";
>>> +        function = "gpio";
>>> +        drive-strength = <8>;
>>> +        output-high;
>>> +    };
>>> +
>>> +    wcd_reset_n_sleep: wcd-reset-n-sleep {
>>> +        pins = "gpio83";
>>> +        function = "gpio";
>>> +        drive-strength = <8>;
>>> +        bias-disable;
>>> +        output-low;
>>> +    };
>> Also add to sc7280-herobrine-crd.dts if the other nodes are added.
> Okay.
