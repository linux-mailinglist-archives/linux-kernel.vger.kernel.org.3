Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1BC4AF37E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbiBIOB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbiBIOB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:01:26 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B681AC061355;
        Wed,  9 Feb 2022 06:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644415289; x=1675951289;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=jaO6ajKfkBLIjW5BN3gE7J2bahUdoXXXJBshGnZI/MY=;
  b=g+hoDqbESqAUiWMHpwiFkaKK8kU0ILt0GbdzFaDkQpa9ROweGbou7Fv7
   01GPxJtt/2x951Vx4oCzM/87Ay/fXqD++POJQ3krnPeVSFbEZJbvxURu9
   uxHoBXSE2et6mHucIzv3HSekLK4nm+MuNMudzJit1EdgqouRO84fNKFKh
   4=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Feb 2022 06:01:29 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 06:01:29 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 06:01:28 -0800
Received: from [10.216.41.35] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 9 Feb 2022
 06:01:24 -0800
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sc7280: add lpass lpi pin
 controller node
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <devicetree@vger.kernel.org>,
        <dianders@chromium.org>, <judyhsiao@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <rohitkr@codeaurora.org>,
        <srinivas.kandagatla@linaro.org>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1644334454-16719-1-git-send-email-quic_srivasam@quicinc.com>
 <1644334454-16719-3-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n52LGY2amCKo+40D4BoSsANs7JeQ0t_4QfeXNC5q64Ccwg@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
Message-ID: <c17e95f7-9c42-657a-8525-3937d4b27fb8@quicinc.com>
Date:   Wed, 9 Feb 2022 19:31:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n52LGY2amCKo+40D4BoSsANs7JeQ0t_4QfeXNC5q64Ccwg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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


On 2/9/2022 2:41 AM, Stephen Boyd wrote:
Thanks for your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-02-08 07:34:13)
>> Add LPASS LPI pinctrl node required for Audio functionality on sc7280
>> based platforms.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 150 +++++++++++++++++++++++++++++++
>>   1 file changed, 150 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index c7d6c46..4704a93 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -638,3 +638,153 @@
>>                  bias-pull-up;
>>          };
>>   };
> Newline here.
Okay.
>
>> +&soc {
>> +       lpass_tlmm: pinctrl@33c0000 {
>> +               compatible = "qcom,sc7280-lpass-lpi-pinctrl";
>> +               reg = <0 0x33c0000 0x0 0x20000>,
>> +                       <0 0x3550000 0x0 0x10000>;
>> +               gpio-controller;
>> +               #gpio-cells = <2>;
>> +               gpio-ranges = <&lpass_tlmm 0 0 15>;
>> +
>> +               #clock-cells = <1>;
> Presumably this doesn't change so it should be moved to the sc7280.dtsi
> file as part of the soc node. It can be marked status = "disabled" if
> it's not commonly used, but I suspect it is commonly used on sc7280?
Okay. will move to common dtsi file.
>
>> +
>> +               dmic01_active: dmic01-active-pins {
> The '-pins' suffix is redundant. Please remove it.
Okay. will remove it.
>
>> +                       clk {
>> +                               pins = "gpio6";
>> +                               function = "dmic1_clk";
>> +                               drive-strength = <8>;
>> +                               output-high;
>> +                       };
> Please be consistent and have a newline between nodes.
Okay.
>
>> +                       data {
>> +                               pins = "gpio7";
>> +                               function = "dmic1_data";
>> +                               drive-strength = <8>;
>> +                               input-enable;
>> +                       };
>> +               };
>> +
>> +               dmic01_sleep: dmic01-sleep-pins {
>> +                       clk {
>> +                               pins = "gpio6";
>> +                               function = "dmic1_clk";
>> +                               drive-strength = <2>;
>> +                               bias-disable;
>> +                               output-low;
>> +                       };
>> +
>> +                       data {
>> +                               pins = "gpio7";
>> +                               function = "dmic1_data";
>> +                               drive-strength = <2>;
>> +                               pull-down;
>> +                               input-enable;
> Why does input-enable matter? It's not a gpio.
Actually the same is fallowed in sm8250.dtsi. Verified without it and 
working fine. Need take call on it.
>
>> +                       };
>> +               };
>> +
>> +               dmic23_active: dmic02-active-pins {
>> +                       clk {
>> +                               pins = "gpio8";
>> +                               function = "dmic2_clk";
>> +                               drive-strength = <8>;
>> +                               output-high;
>> +                       };
>> +                       data {
>> +                               pins = "gpio9";
>> +                               function = "dmic2_data";
>> +                               drive-strength = <8>;
>> +                               input-enable;
>> +                       };
>> +               };
>> +
>> +               dmic23_sleep: dmic02-sleep-pins {
>> +                       clk {
>> +                               pins = "gpio8";
>> +                               function = "dmic2_clk";
>> +                               drive-strength = <2>;
>> +                               bias-disable;
>> +                               output-low;
>> +                       };
>> +
>> +                       data {
>> +                               pins = "gpio9";
>> +                               function = "dmic2_data";
>> +                               drive-strength = <2>;
>> +                               pull-down;
>> +                               input-enable;
>> +                       };
>> +               };
>> +
>> +               rx_swr_active: rx_swr-active-pins {
>> +                       clk {
>> +                               pins = "gpio3";
>> +                               function = "swr_rx_clk";
>> +                               drive-strength = <2>;
>> +                               slew-rate = <1>;
>> +                               bias-disable;
>> +                       };
>> +
>> +                       data {
>> +                               pins = "gpio4", "gpio5";
>> +                               function = "swr_rx_data";
>> +                               drive-strength = <2>;
>> +                               slew-rate = <1>;
>> +                               bias-bus-hold;
>> +                       };
>> +               };
>> +
>> +               rx_swr_sleep: rx_swr-sleep-pins {
>> +                       clk {
>> +                               pins = "gpio3";
>> +                               function = "swr_rx_clk";
>> +                               drive-strength = <2>;
>> +                               input-enable;
>> +                               bias-pull-down;
>> +                       };
>> +
>> +                       data {
>> +                               pins = "gpio4", "gpio5";
>> +                               function = "swr_rx_data";
>> +                               drive-strength = <2>;
>> +                               input-enable;
>> +                               bias-pull-down;
>> +                       };
>> +               };
>> +
>> +               tx_swr_active: tx_swr-active-pins {
>> +                       clk {
>> +                               pins = "gpio0";
>> +                               function = "swr_tx_clk";
>> +                               drive-strength = <2>;
>> +                               slew-rate = <1>;
>> +                               bias-disable;
>> +                       };
>> +
>> +                       data {
>> +                               pins = "gpio1", "gpio2", "gpio14";
>> +                               function = "swr_tx_data";
>> +                               drive-strength = <2>;
>> +                               slew-rate = <1>;
>> +                               bias-bus-hold;
>> +                       };
>> +               };
>> +
>> +               tx_swr_sleep: tx_swr-sleep-pins {
> No underscore in node names.
Okay.
>
>> +                       clk {
>> +                               pins = "gpio0";
>> +                               function = "swr_tx_clk";
>> +                               drive-strength = <2>;
>> +                               input-enable;
>> +                               bias-pull-down;
>> +                       };
>> +
>> +                       data {
>> +                               pins = "gpio1", "gpio2", "gpio14";
>> +                               function = "swr_tx_data";
>> +                               drive-strength = <2>;
>> +                               input-enable;
>> +                               bias-bus-hold;
>> +                       };
>> +               };
>> +       };
>> +};
>> --
>> 2.7.4
>>
