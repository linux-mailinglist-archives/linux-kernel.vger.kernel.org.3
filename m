Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19504FE1EF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355547AbiDLNPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356788AbiDLNOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:14:10 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C65D2BC;
        Tue, 12 Apr 2022 06:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649768468; x=1681304468;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bifhyOCkRst28z4/YuVYetStnqamZXAtDYuVHvzQJXk=;
  b=IbLkmIQ9b2/KgphnMB4zaDlajpuTi7hTl5MGS2nemVHv7FUFJ4fvSpnd
   Bso+UT2x9Z/4TUoSm1iYe63mt4paqyyVJvyACR2UF8DP3NbX9CO7ECUyw
   WStgSJ9G6P2+WRm8Ukfq2zhjZ0F+Gq31mSSF7g0DyiEgA0oSJKHKrWkJN
   4=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 12 Apr 2022 06:01:07 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 06:01:07 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 12 Apr 2022 06:01:06 -0700
Received: from [10.216.28.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 12 Apr
 2022 06:01:02 -0700
Message-ID: <be05410d-8b68-ca5f-63a6-4565bcd43f66@quicinc.com>
Date:   Tue, 12 Apr 2022 18:30:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6 1/3] arm64: dts: qcom: sc7280: Add nodes for va tx and
 rx macros and external codecs
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <srinivas.kandagatla@linaro.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>,
        <quic_rohkumar@quicinc.com>
References: <1649157220-29304-1-git-send-email-quic_srivasam@quicinc.com>
 <1649157220-29304-2-git-send-email-quic_srivasam@quicinc.com>
 <Yky2Iwt+tvxvu4/S@google.com>
 <8fea1165-c8b6-6ce2-86dc-82274af8c43d@quicinc.com>
 <YlSHPU7XITS2dju/@google.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YlSHPU7XITS2dju/@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/12/2022 1:23 AM, Matthias Kaehlcke wrote:
Thanks for your time Matthias!!!
> On Mon, Apr 11, 2022 at 07:32:33PM +0530, Srinivasa Rao Mandadapu wrote:
>> On 4/6/2022 3:05 AM, Matthias Kaehlcke wrote:
>> Thanks for your time Matthias!!!
>>> On Tue, Apr 05, 2022 at 04:43:38PM +0530, Srinivasa Rao Mandadapu wrote:
>>>> SC7280 has VA, TX and RX macros with SoundWire Controllers to attach with
>>>> codecs like WCD938x, max98360a using soundwire masters and i2s bus.
>>>> Add these nodes for sc7280 based platforms audio use case.
>>>> Add tlmm gpio property in wcd938x node for switching CTIA/OMTP Headset.
>>>>
>>>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>>>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>>>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>>>> ---
>>> A change log would be helpful for reviewers
>> Change log added in cover letter.
>  From my perspective as a reviewer I find it more practical to have a
> change log per patch.
Okay. will do accordingly from next time.
>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
>>>> index de646d9..c6a04c3 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
>>>> @@ -20,6 +20,14 @@
>>>>    #include "sc7280-chrome-common.dtsi"
>>>>    / {
>>>> +	max98360a: audio-codec-0 {
>>>> +		compatible = "maxim,max98360a";
>>>> +		pinctrl-names = "default";
>>>> +		pinctrl-0 = <&amp_en>;
>>>> +		sdmode-gpios = <&tlmm 63 GPIO_ACTIVE_HIGH>;
>>>> +		#sound-dai-cells = <0>;
>>>> +	};
>>>> +
>>> This node shouldn't be at top but with the other device nodes, in
>>> alphabetical order, i.e. before 'pwmleds'.
>> Actually we are sorting as per node name. Hence kept it here. As per
>> previous reviewer comments, sorted accordingly.
>>
>> Please suggest better approach.
> True, I forgot the node names are used for sorting, not the labels.
Okay.
>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>>>> index db74fc3..78ec84c 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>>>> @@ -822,6 +822,127 @@
>>>>    			#power-domain-cells = <1>;
>>>>    		};
>>>> +		rxmacro: codec@3200000 {
>>> These node are not at the correct position. They should be sorted by
>>> address and hence be inserted between 'lpasscc@3000000' and
>>> 'interconnect@3c40000'.
>> Actually we are sorting as per node(codec) name. Hence kept it here. As per
>> previous reviewer comments, sorted accordingly.
> Could you provide a pointer to those comments?
Sorry. it seems we misunderstood.
>
> My understanding is that we are sorting by node name when nodes don't have
> addresses or for overrides in board files/snippets, however the nodes under
> 'soc@0' are sorted by address.
>
> Another nit: 'rx_macro, tx_macro, va_macro' instead of the labels without
> underscore? Not really important, but maybe slightly more readable and
> would match the 'spelling' of the compatible strings.
Okay. Will change accordingly!!!
