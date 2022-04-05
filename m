Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4D44F2269
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 07:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiDEFHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 01:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiDEFH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 01:07:27 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B71483B8;
        Mon,  4 Apr 2022 22:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649135126; x=1680671126;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LkxzEX1anG4s/wmWN5T1Ru9TpO+y0pigaqRc6/MAp74=;
  b=hkTEbrENBz2DxmOhLmhj3UOKp9+PNnIyKTw16MyxdGO3IFoKVhfyVPP2
   47Pt66O04n+IgBNKsYqNzpx6/fjakkM3RKQfcZZD2Pwlhvf+IQ0Q4GRFd
   ThV9O3/9affKK34oi4Y2IhMikdT/so/XcCpMLPwwVavmpi6Q6bY1SRkGI
   k=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 Apr 2022 22:05:26 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 22:05:10 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Apr 2022 22:05:10 -0700
Received: from [10.216.10.223] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 4 Apr 2022
 22:05:06 -0700
Message-ID: <5d2f23a5-e8a9-6be1-cc91-0a80bad68f3a@quicinc.com>
Date:   Tue, 5 Apr 2022 10:35:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 3/3] arm64: dts: qcom: sc7280: add lpass lpi pin
 controller node
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <devicetree@vger.kernel.org>,
        <dianders@chromium.org>, <judyhsiao@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1647863959-3289-1-git-send-email-quic_srivasam@quicinc.com>
 <1647863959-3289-4-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n50xoWpd8S82W=xjbKBjqD-bgyMM8b539PV83=fHBQC7yw@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n50xoWpd8S82W=xjbKBjqD-bgyMM8b539PV83=fHBQC7yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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


On 3/22/2022 1:56 AM, Stephen Boyd wrote:
> Quoting Srinivasa Rao Mandadapu (2022-03-21 04:59:19)
>> Add LPASS LPI pinctrl node required for Audio functionality on sc7280
>> based platforms.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 147 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 147 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 8d8cec5..499299a 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -1987,6 +1987,153 @@
>>                          qcom,bcm-voters = <&apps_bcm_voter>;
>>                  };
>>
>> +               lpass_tlmm: pinctrl@33c0000 {
>> +                       compatible = "qcom,sc7280-lpass-lpi-pinctrl";
>> +                       reg = <0 0x33c0000 0x0 0x20000>,
>> +                               <0 0x3550000 0x0 0x10000>;
>> +                       gpio-controller;
>> +                       #gpio-cells = <2>;
>> +                       gpio-ranges = <&lpass_tlmm 0 0 15>;
>> +
>> +                       #clock-cells = <1>;
>> +
>> +                       dmic01_active: dmic01-active {
>> +                               clk {
>> +                                       pins = "gpio6";
>> +                                       function = "dmic1_clk";
>> +                                       drive-strength = <8>;
>> +                                       output-high;
> The rule of thumb is that drive strength, output/input, and bias
> properties should be in the board file, because the board layout decides
> the drive strength, the output level could be inverted on the board, and
> the biasing could be done externally (or not) via pullup/pulldowns on
> the net. The gpio driver should be able to make pins into inputs
> automatically when the gpio is requested and used so having input or
> output is typically wrong and should be handled by the consumer driver.
Okay. will re arrange accordingly and remove output-high property.
>
>> +                               };
>> +
>> +                               data {
>> +                                       pins = "gpio7";
>> +                                       function = "dmic1_data";
> So in the end I'd expect to only see pins and function properties in the
> SoC dtsi file.
Okay.
>
>> +                                       drive-strength = <8>;
>> +                               };
>> +                       };
>> +
>> +                       dmic01_sleep: dmic01-sleep {
>> +                               clk {
>> +                                       pins = "gpio6";
>> +                                       function = "dmic1_clk";
