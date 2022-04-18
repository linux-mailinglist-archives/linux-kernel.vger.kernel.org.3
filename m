Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4FC505A72
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245318AbiDRPEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245435AbiDRPEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:04:08 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894A864FC;
        Mon, 18 Apr 2022 06:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650290071; x=1681826071;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=acwXphJFeX2V8q+QY3YwXSKjv1k9OMNV8xD3S9oFEMo=;
  b=MMr3hV5tR69ce/zdTVcn/K7UnEp1KxRcQDD0IYIkEb3CH/zVPY8wFwHf
   TamVdx8atjyQZ3Mrcyp+7+VYY87LfhYKeIaBFwNHDHqwz5rSkCYRrljnF
   jqQD0N7LAS0NE0RTuVNpY2ocYHesO8+SZ9MYkxMf8QmwaF8Kj2ImcrCFb
   o=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 18 Apr 2022 06:54:30 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 06:54:30 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Apr 2022 06:54:29 -0700
Received: from [10.216.27.177] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 18 Apr
 2022 06:54:25 -0700
Message-ID: <39ad1f0a-fb34-c81a-82c3-d14f0b830ee2@quicinc.com>
Date:   Mon, 18 Apr 2022 19:24:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v7 1/4] arm64: dts: qcom: sc7280: Add nodes for soundwire
 and va tx rx digital macro codecs
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
 <1649863277-31615-2-git-send-email-quic_srivasam@quicinc.com>
 <YlccZmu8T1Puu9Vt@google.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YlccZmu8T1Puu9Vt@google.com>
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


On 4/14/2022 12:24 AM, Matthias Kaehlcke wrote:
Thanks for your time Matthias!!!
> On Wed, Apr 13, 2022 at 08:51:14PM +0530, Srinivasa Rao Mandadapu wrote:
>> SC7280 has VA, TX and RX macros with SoundWire Controllers to attach with
>> external codecs using soundwire masters. Add these nodes for sc7280 based
>> platforms audio use case.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 122 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 122 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 50fea0e..c0f127f 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -1980,6 +1980,128 @@
>>   			#clock-cells = <1>;
>>   		};
>>   
>> +		lpass_rx_macro: codec@3200000 {
>> +			compatible = "qcom,sc7280-lpass-rx-macro";
>> +			reg = <0 0x03200000 0 0x1000>;
>> +
>> +			status = "disabled";
> nit: this is easily missed here inmidst of the other stuff, best place
> it at the end of the node as many other nodes do.
Okay. will place accordingly.
>
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&lpass_rx_swr>;
>> +
>> +			clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
>> +				 <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
>> +				 <&lpass_va_macro>;
>> +			clock-names = "mclk", "npl", "fsgen";
>> +
>> +			power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,p
>> +					<&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
>> +			power-domain-names ="macro", "dcodec";
> add space after '='.
Okay.
>
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
>> +			clocks = <&lpass_rx_macro>;
>> +			clock-names = "iface";
>> +
>> +			qcom,din-ports = <0>;
>> +			qcom,dout-ports = <5>;
>> +
>> +			resets = <&lpass_audiocc LPASS_AUDIO_SWR_RX_CGCR>;
>> +			reset-names = "swr_audio_cgcr";
> The resets aren't mentioned in the binding, should they be added?
Yes. They are to be added. Mentioned same in the cover letter dependencies.
>
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
> in difference to the other nodes the soundwire ones don't have
> 'status = "disabled"', should they be disabled by default?
Okay. will add accordingly.
>
>> +		};
>> +
>> +		lpass_tx_macro: codec@3220000 {
>> +			compatible = "qcom,sc7280-lpass-tx-macro";
>> +			reg = <0 0x03220000 0 0x1000>;
>> +
>> +			status = "disabled";
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&lpass_tx_swr>;
>> +
>> +			clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
>> +				 <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
>> +				 <&lpass_va_macro>;
>> +			clock-names = "mclk", "npl", "fsgen";
>> +
>> +			power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
>> +					<&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
>> +			power-domain-names ="macro", "dcodec";
> add space after '='
Okay.
>
>> +
>> +			#clock-cells = <0>;
>> +			#sound-dai-cells = <1>;
>> +		};
>> +
>> +		swr1: soundwire@3230000 {
>> +			compatible = "qcom,soundwire-v1.6.0";
>> +			reg = <0 0x03230000 0 0x2000>;
>> +
>> +			interrupts-extended = <&intc GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
>> +					      <&pdc 130 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "swr_master_irq", "swr_wake_irq";
>  From the binding
>
>    - interrupt-names:
>          Usage: Optional
>          Value type: boolean
>          Value type: <stringlist>
>          Definition: should be "core" for core and "wakeup" for wake interrupt.
>
> Does the binding need an update?
Here interrupt names are not being used. Will remove here.
>
>> +			clocks = <&lpass_tx_macro>;
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
>> +			qcom,ports-word-length =	/bits/ 8 <0xff 0x00 0xff>;
>> +			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0xff 0xff>;
>> +			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff>;
>> +			qcom,ports-lane-control =	/bits/ 8 <0x00 0x01 0x00>;
>> +			qcom,port-offset = <1>;
>> +
>> +			#sound-dai-cells = <1>;
>> +			#address-cells = <2>;
>> +			#size-cells = <0>;
>> +		};
>> +
>> +		lpass_va_macro: codec@3370000 {
>> +			compatible = "qcom,sc7280-lpass-va-macro";
>> +			reg = <0 0x03370000 0 0x1000>;
>> +
>> +			status = "disabled";
>> +			pinctrl-0 = <&lpass_dmic01>;
>> +			pinctrl-names = "default";
>> +
>> +			clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>;
>> +			clock-names = "mclk";
>> +
>> +			power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
>> +					<&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
>> +			power-domain-names ="macro", "dcodec";
> add space after '='.
Okay.
>
>> +
>> +			#clock-cells = <0>;
>> +			#sound-dai-cells = <1>;
>> +		};
>> +
>>   		lpass_ag_noc: interconnect@3c40000 {
>>   			reg = <0 0x03c40000 0 0xf080>;
>>   			compatible = "qcom,sc7280-lpass-ag-noc";
>> -- 
>> 2.7.4
>>
