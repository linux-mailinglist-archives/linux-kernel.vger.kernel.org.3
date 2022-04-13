Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169544FF933
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbiDMOox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbiDMOou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:44:50 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B823862BE5;
        Wed, 13 Apr 2022 07:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649860949; x=1681396949;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/WQofjNq2TS+ZBTx8OaoW/RzTpZcHfSOiBcFEhOVikw=;
  b=Y0aa5jQWBLkQn6hDxuOKnV4lLfoYoog1Wd8s/wYYS8rMyBAXWjVmqBIy
   69ZeVj+t1peM50ieLkX2vqCjx2Q9ixszjORxZhPMh4Phr7Uo53DTyrJQS
   LFWsyg0pDsC4g1D4UUxkrPJan+7+KlTkuzMGMCguaKCmNxk0A/DcKCKVf
   c=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 13 Apr 2022 07:42:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 07:42:28 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 07:42:27 -0700
Received: from [10.216.55.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 13 Apr
 2022 07:42:23 -0700
Message-ID: <478125e6-7b8f-a69d-4ffb-00344611229d@quicinc.com>
Date:   Wed, 13 Apr 2022 20:12:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v7 2/2] arm64: dts: qcom: sc7280: add lpass lpi pin
 controller node
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1649685184-8448-1-git-send-email-quic_srivasam@quicinc.com>
 <1649685184-8448-3-git-send-email-quic_srivasam@quicinc.com>
 <YlSCWC47tITuW/BZ@google.com>
 <9bacee6d-ab44-2975-c523-38164d016af5@quicinc.com>
 <be8c6dae-20b1-3ba1-db3f-119da1e4ebfe@quicinc.com>
 <YlYSe5/wm06oTJej@google.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YlYSe5/wm06oTJej@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/13/2022 5:29 AM, Matthias Kaehlcke wrote:
Thanks for your time and valuable suggestions Matthias!!!
> On Tue, Apr 12, 2022 at 06:41:25PM +0530, Srinivasa Rao Mandadapu wrote:
>> On 4/12/2022 6:18 PM, Srinivasa Rao Mandadapu wrote:
>>> On 4/12/2022 1:02 AM, Matthias Kaehlcke wrote:
>>> Thanks for your time Matthias!!!
>>>> On Mon, Apr 11, 2022 at 07:23:04PM +0530, Srinivasa Rao Mandadapu wrote:
>>>>> Add LPASS LPI pinctrl node required for Audio functionality on sc7280
>>>>> based platforms.
>>>>>
>>>>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>>>>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>>>>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>>>>> ---
>>>>>    arch/arm64/boot/dts/qcom/sc7280-idp.dtsi |  84
>>>>> ++++++++++++++++++++++++
>>>>>    arch/arm64/boot/dts/qcom/sc7280.dtsi     | 107
>>>>> +++++++++++++++++++++++++++++++
>>>>>    2 files changed, 191 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>>>>> b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>>>>> index 4ba2274..ea751dc 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>>>>> @@ -238,6 +238,90 @@
>>>>>        modem-init;
>>>>>    };
>>>>>    +&dmic01 {
>>>> Shouldn't these nodes be in the PINCTRL section at their respective
>>>> positions in alphabetical order?
>>> These are not part of tlmm pin control section. These are part of
>>> lpass_tlmm section.
>>>
>>> In your previous comment you asked to remove &lpass_tlmm. Hence brought
>>> out.
>>>
>>>> nit: since you are keeping the groups the group names are a bit
>>>> generic IMO.
>>>> e.g. it is fairly obvious that 'dmic01_clk' refers to a clock pin,
>>>> however
>>>> just 'dmic01' is a bit vague. You could consider adding the prefix
>>>> 'lpass_'
>>>> to the group names for more clarity.
>>> as dmic01 has both clk and data section, I don't think keeping clk is
>>> appropriate here.
>> As these nodes are part of SC7280, i.e. qcom specific chipset, I feel lpass_
>> is redundant.
> It helps to provide some context about the pins which might not be evident
> from their short names like 'dmic01' or 'rx_swr'. A nice side effect is that
> the pins/groups would grouped automatically together in alphabetic ordering.
>
> In terms of 'redundancy' it is similar to 'qup_' prefix for the I2C/SPI/UART
> pins.
Agree. Will change accordingly. similarly will append lpass_ torx/tx/va 
mcro device node names.
>
>> If we add lpass_ to all dmic nodes, some node names are too lengthy.
> The longest would be like 'lpass_dmic01_sleep' or 'lpass_rx_swr_sleep', which
> doesn't seem outrageous.
>
> In any case it's not super important. If it bothers someone enough later
> on they can always send a patch that changes it.
Okay.
