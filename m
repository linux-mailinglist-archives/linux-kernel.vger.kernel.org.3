Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1756C4C6F46
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbiB1OZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiB1OZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:25:53 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40BC69CE4;
        Mon, 28 Feb 2022 06:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646058314; x=1677594314;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=KjNPm8CkcwmZjG9ZCapTIjn+RZ9HMpspNn/kHxvBxHg=;
  b=jzmdPWVVE6ZYTkRjSeGTIKUA+MqtNFn7Rt4PdeqpAXTFMkSAhDZ1q5jU
   B8b0xMgB209xGm1cb7nPKiFdH6vcyMu0uEyafFohf2MKa5OE1f3R7Ycrw
   4d73zrdcQHumqGJ8DZhiH8EO7ernakspW9BmYgrrb08ZYlRHjyh2fnrje
   k=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Feb 2022 06:25:14 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 06:25:14 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 28 Feb 2022 06:25:13 -0800
Received: from [10.216.7.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Mon, 28 Feb
 2022 06:25:09 -0800
Subject: Re: [PATCH V7 5/5] arm64: dts: qcom: sc7280: Add pm8008 support for
 sc7280-idp
To:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_subbaram@quicinc.com>, <quic_jprakash@quicinc.com>
References: <1645182064-15843-1-git-send-email-quic_c_skakit@quicinc.com>
 <1645182064-15843-6-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n509bg6RzieOtYuUvicU14D7bmgH-u02F1TB+hBZ+xH4CA@mail.gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <42570508-ed62-af26-220e-c776418a722e@quicinc.com>
Date:   Mon, 28 Feb 2022 19:55:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n509bg6RzieOtYuUvicU14D7bmgH-u02F1TB+hBZ+xH4CA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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


On 2/19/2022 7:31 AM, Stephen Boyd wrote:
> Quoting Satya Priya (2022-02-18 03:01:03)
>> Add pm8008_infra and pm8008_regulators support for sc7280 idp.
>>
>> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
>> ---
>> Changes in V2:
>>   - As per Stephen's comments, replaced '_' with '-' for node names.
>>
>> Changes in V3:
>>   - Changed the regulator node names as l1, l2 etc
>>   - Changed "pm8008-regulators" to "regulators"
>>   - Changed "qcom,min-dropout-voltage" to "regulator-min-dropout-voltage-microvolt"
>>
>> Changes in V4:
>>   - Moved all common stuff to pm8008.dtsi and added board specific configurations here.
>>
>> Changes in V5:
>>   - Changed the node names as per pm8008.dtsi
>>   - Moved supply nodes to chip level (mfd node).
>>   - Removed the regulator-mindropout property.
>>
>> Changes in V6:
>>   - No changes.
>>
>> Changes in V7:
>>   - No Changes.
>>
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 66 ++++++++++++++++++++++++++++++++
>>   1 file changed, 66 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index ecbf2b8..371ad19 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -263,6 +263,62 @@
>>          };
>>   };
>>
>> +&i2c1 {
> Can we add another phandle?
>
> &pm8008_bus: &i2c1 {

Okay.


>> +       #address-cells = <1>;
>> +       #size-cells = <0>;
>> +       status = "okay";
>> +
>> +       #include "pm8008.dtsi"
>> +};
> And then
>
> #include "pm8008.dtsi"


Okay.


> and have the pm8008.dtsi file add itself as a child of &pm8008_bus? Then
> we can easily see that pm8008 is a child of pm8008_bus without having to
> figure out where the file is included. It also helps avoid polluting the
> i2c node with things that shouldn't be there in case we want to include
> configuration bits in the pm8008.dtsi file that aren't directly related
> to the bus node.
>
>> +
>> +&pm8008_infra {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pm8008_active>;
>> +};
>> +
>> +&pm8008_regulators {
>> +       vdd_l1_l2-supply = <&vreg_s8b_1p2>;
>> +       vdd_l3_l4-supply = <&vreg_s1b_1p8>;
>> +       vdd_l5-supply = <&vreg_bob>;
>> +       vdd_l6-supply = <&vreg_bob>;
>> +       vdd_l7-supply = <&vreg_bob>;
>> +};
>> +
>> +&pm8008_l1 {
>> +       regulator-min-microvolt = <950000>;
>> +       regulator-max-microvolt = <1300000>;
>> +};
>> +
>> +&pm8008_l2 {
>> +       regulator-min-microvolt = <950000>;
>> +       regulator-max-microvolt = <1250000>;
>> +};
>> +
>> +&pm8008_l3 {
>> +       regulator-min-microvolt = <1650000>;
>> +       regulator-max-microvolt = <3000000>;
>> +};
>> +
>> +&pm8008_l4 {
>> +       regulator-min-microvolt = <1504000>;
>> +       regulator-max-microvolt = <1600000>;
>> +};
>> +
>> +&pm8008_l5 {
>> +       regulator-min-microvolt = <2600000>;
>> +       regulator-max-microvolt = <3000000>;
>> +};
>> +
>> +&pm8008_l6 {
>> +       regulator-min-microvolt = <2600000>;
>> +       regulator-max-microvolt = <3000000>;
>> +};
>> +
>> +&pm8008_l7 {
>> +       regulator-min-microvolt = <3000000>;
>> +       regulator-max-microvolt = <3544000>;
>> +};
>> +
>>   &qfprom {
>>          vcc-supply = <&vreg_l1c_1p8>;
>>   };
>> @@ -375,6 +431,16 @@
>>          drive-strength = <2>;
>>   };
>>
>> +&pm8350c_gpios {
>> +       pm8008_active: pm8008_active {
> No underscore in node names. pm8008_active: pm8008-active {


Okay.


>> +               pins = "gpio4";
>> +               function = "normal";
>> +               bias-disable;
>> +               output-high;
> Is this a reset signal? Should the driver be deasserting the reset when
> it is ready? That could be the same time the gpio is acquired.


I didn't get your question exactly.. hope this answers your query

The pm8008 chip needs this gpio to be toggled , in order to come out of 
reset and start any transactions..

Please let me know if you have more queries


>> +               power-source = <0>;
>> +       };
>> +};
