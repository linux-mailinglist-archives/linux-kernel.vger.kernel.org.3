Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72EA4AF31C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbiBINmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbiBINmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:42:45 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3CEC0613C9;
        Wed,  9 Feb 2022 05:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644414168; x=1675950168;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ah1QRhwUGWPd0/YL2BGoTuq+YFwA+ZsHMG7MjzrAM0c=;
  b=KqPIv1KJr4npF2QuHeHaVeli+cXeTISJLZAZQYb5XpvjhB8Ew6foS0nQ
   ppOPnV90sekjh/HaJv5PCmKx7h6Gdahz67R/rFdpsQMARfmQGJm2Aa/dW
   LBKwnK/fdlR2lPsGIu+5fa2cQ8C0a6DQQB758R4MLhz0zl/h8Y2wNNe9t
   8=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 09 Feb 2022 05:42:48 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 05:42:47 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 05:42:47 -0800
Received: from [10.216.41.35] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 9 Feb 2022
 05:42:43 -0800
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: sc7280: Add pinmux for I2S
 speaker and Headset
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <devicetree@vger.kernel.org>,
        <dianders@chromium.org>, <judyhsiao@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <rohitkr@codeaurora.org>,
        <srinivas.kandagatla@linaro.org>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1644334454-16719-1-git-send-email-quic_srivasam@quicinc.com>
 <1644334454-16719-2-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n50PAtGfvHXjNrvQYe6edNEfJvEc1uYZFUeW2KHxn6fsBA@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
Message-ID: <30805a84-b523-842c-d223-bc0d2043fa00@quicinc.com>
Date:   Wed, 9 Feb 2022 19:12:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n50PAtGfvHXjNrvQYe6edNEfJvEc1uYZFUeW2KHxn6fsBA@mail.gmail.com>
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


On 2/9/2022 2:38 AM, Stephen Boyd wrote:
Thanks for your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-02-08 07:34:12)
>> Add AMP enable node and pinmux for primary and secondary I2S
>> for SC7280 based platforms.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 40 ++++++++++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi     | 40 ++++++++++++++++++++++++++++++++
>>   2 files changed, 80 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index d623d71..c7d6c46 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -436,6 +436,39 @@
>>                  qcom,drive-strength = <3>;
>>          };
>>   };
> Newline here
Okay. will remove it.
>
>> +&pri_mi2s_data0 {
>> +       drive-strength = <6>;
>> +};
>> +
>> +&pri_mi2s_data1 {
>> +       drive-strength = <6>;
>> +};
>> +
>> +&pri_mi2s_mclk {
>> +       drive-strength = <6>;
>> +};
>> +
>> +&pri_mi2s_sclk {
>> +       drive-strength = <6>;
>> +};
>> +
>> +&pri_mi2s_ws {
>> +       drive-strength = <6>;
>> +};
>> +
>> +&sec_mi2s_data0 {
>> +       drive-strength = <6>;
>> +       bias-disable;
>> +};
>> +
>> +&sec_mi2s_sclk {
>> +       drive-strength = <6>;
>> +       bias-disable;
>> +};
>> +
>> +&sec_mi2s_ws {
>> +       drive-strength = <6>;
>> +};
> Please sort these nodes alphabetically on node name.
Okay.
>
>>   &qspi_cs0 {
>>          bias-disable;
>> @@ -491,6 +524,13 @@
>>   };
>>
>>   &tlmm {
>> +       amp_en: amp-en {
>> +               pins = "gpio63";
>> +               function = "gpio";
>> +               bias-disable;
> Is there an external pull?
I think no external pull. In trogdor mentioned bias-pull-down but you 
suggested to remove it.
>
>> +               drive-strength = <2>;
>> +       };
>> +
>>          nvme_pwren: nvme-pwren {
>>                  function = "gpio";
>>          };
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 937c2e0..76e73e9 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -3461,6 +3461,46 @@
>>                                  };
>>                          };
>>
>> +                       pri_mi2s_data0: pri-mi2s-data0 {
>> +                               pins = "gpio98";
>> +                               function = "mi2s0_data0";
>> +                       };
>> +
>> +                       pri_mi2s_data1: pri-mi2s-data1 {
>> +                               pins = "gpio99";
>> +                               function = "mi2s0_data1";
>> +                       };
>> +
>> +                       pri_mi2s_mclk: pri-mi2s-mclk {
>> +                               pins = "gpio96";
>> +                               function = "pri_mi2s";
>> +                       };
>> +
>> +                       pri_mi2s_sclk: pri-mi2s-sclk {
>> +                               pins = "gpio97";
>> +                               function = "mi2s0_sck";
>> +                       };
>> +
>> +                       pri_mi2s_ws: pri-mi2s-ws {
>> +                               pins = "gpio100";
>> +                               function = "mi2s0_ws";
>> +                       };
>> +
>> +                       sec_mi2s_data0: sec-mi2s-data0 {
>> +                               pins = "gpio107";
>> +                               function = "mi2s1_data0";
>> +                       };
>> +
>> +                       sec_mi2s_sclk: sec-mi2s-sclk {
>> +                               pins = "gpio106";
>> +                               function = "mi2s1_sck";
>> +                       };
>> +
>> +                       sec_mi2s_ws: sec-mi2s-ws {
>> +                               pins = "gpio108";
>> +                               function = "mi2s1_ws";
>> +                       };
> Please sort these nodes alphabetically on node name.
Okay.
