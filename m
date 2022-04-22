Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F8550B86E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447964AbiDVN3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbiDVN3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:29:44 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5855520C;
        Fri, 22 Apr 2022 06:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650634012; x=1682170012;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ibCD8n+74D25bQ/6Jrl39b9qR5VPuTVM9OJHM9wXnOk=;
  b=ydASwxOyfDaiPRJLLS+1ewfPPyzdDWOg2KxbNRObZccS7Z/cqpjfix6M
   USRLRWmiBPW/Ccf0m4pPaxNlbe5AW5WdiWGu7Mt70CV3TMq60dWuQol3p
   qTv+Zh40tQL3uFPMMHgVrKLi90prSzldCRCCcrkuxOJq5T2izHrmv2otW
   k=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 22 Apr 2022 06:26:51 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 06:26:50 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Apr 2022 06:26:50 -0700
Received: from [10.216.36.2] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 22 Apr
 2022 06:26:44 -0700
Message-ID: <fb53452a-0898-407e-5e86-897aeab446bc@quicinc.com>
Date:   Fri, 22 Apr 2022 18:56:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v8 2/4] arm64: dts: qcom: sc7280: Add nodes for wcd9385
 and max98360a codec
Content-Language: en-US
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
 <5d4b7c44-62e1-aaa6-3116-f58e1a1b437b@quicinc.com>
 <YmF7TRlxUWWQ394e@google.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YmF7TRlxUWWQ394e@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/21/2022 9:12 PM, Matthias Kaehlcke wrote:
Thanks for your time Matthias!!
> On Thu, Apr 21, 2022 at 12:31:52PM +0530, Srinivasa Rao Mandadapu wrote:
>> On 4/19/2022 4:54 PM, Srinivasa Rao Mandadapu wrote:
>>> On 4/18/2022 10:15 PM, Matthias Kaehlcke wrote:
>>> Thanks for your time and valuable inputs Matthias!!!
>>>> On Mon, Apr 18, 2022 at 07:44:10PM +0530, Srinivasa Rao Mandadapu wrote:
>>>>> Add wcd938x and  max98360a codecs for audio use case on
>>>>> sc7280 based platforms.
>>>>> Add tlmm gpio property in wcd938x node for switching CTIA/OMTP Headset.
>>>>> Add amp_en node for  max98360a codec.
>>>> General note: I don't think it's a good practice to add stuff like
>>>> this to
>>>> multiple boards in a single patch. Why?
>>>>
>>>> First the subject of such a patch tends to be vague ("arm64: dts: qcom:
>>>> sc7280: Add nodes for wcd9385 and max98360a codec"), in this case it
>>>> gives
>>>> no hint about the boards. If someone was interested in picking changes
>>>> for a given board they can't easily identify from the subject that the
>>>> change is relevant for them.
>>>>
>>>> Changes touching multiple boards are more likely to cause conflicts when
>>>> being picked (or reverted), both upstream and in downstream trees (which
>>>> unfortunately have to exist for product development). Downstream trees
>>>> might only pick changes for the board(s) they target, patches that touch
>>>> mutiple boards often cause conflicts due to context deltas in the
>>>> 'irrelevant' boards.
>>>>
>>>> Lastly it's usually easier to get a patch reviewed (in the sense of
>>>> getting a 'Reviewed-by' tag) and landed that does a single thing.
>>> Yes, agree to your opinion. In a nutshell, we will include board
>>> name(ex: herobrine)
>>>
>>> in commit message and split the patches per external codec.
>>>
>>> Actually, in Initial herobrine boards, EVT and IDP, has both maxim
>>> speaker and WCD codec,
>>>
>>> hence we included in same patch.
>>>
>>>>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>>>>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>>>>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>>>>> ---
>>>>>    arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts     |  6 ++
>>>>>    arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  8 +++
>>>>>    arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 97
>>>>> ++++++++++++++++++++++++++
>>>>>    3 files changed, 111 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
>>>>> b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
>>>>> index 344338a..aa0bf6e2 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
>>>>> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
>>>>> @@ -87,6 +87,12 @@ ap_ts_pen_1v8: &i2c13 {
>>>>>        pins = "gpio51";
>>>>>    };
>>>>>    +&wcd938x {
>>>>> +    pinctrl-names = "default";
>>>>> +    pinctrl-0 = <&us_euro_hs_sel>;
>>>>> +    us-euro-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
>>>>> +};
>>>> Since this is added for the CRD rev3 it probably should also be added to
>>>> sc7280-herobrine-crd.dts
>>> Okay. Will add in corresponding latest herobrine CRD dts file also.
>>>>> +
>>>>>    &tlmm {
>>>>>        tp_int_odl: tp-int-odl {
>>>>>            pins = "gpio7";
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
>>>>> b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
>>>>> index d58045d..f247403 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
>>>>> @@ -20,6 +20,14 @@
>>>>>    #include "sc7280-chrome-common.dtsi"
>>>>>      / {
>>>>> +    max98360a: audio-codec-0 {
>>>>> +        compatible = "maxim,max98360a";
>>>>> +        pinctrl-names = "default";
>>>>> +        pinctrl-0 = <&amp_en>;
>>>>> +        sdmode-gpios = <&tlmm 63 GPIO_ACTIVE_HIGH>;
>>>>> +        #sound-dai-cells = <0>;
>>>>> +    };
>>>>> +
>>>>>        chosen {
>>>>>            stdout-path = "serial0:115200n8";
>>>>>        };
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>>>>> b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>>>>> index 2f863c0..8dad599 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>>>>> @@ -20,6 +20,42 @@
>>>>>            serial1 = &uart7;
>>>>>        };
>>>>>    +    max98360a: audio-codec-0 {
>>>>> +        compatible = "maxim,max98360a";
>>>>> +        pinctrl-names = "default";
>>>>> +        pinctrl-0 = <&amp_en>;
>>>>> +        sdmode-gpios = <&tlmm 63 GPIO_ACTIVE_HIGH>;
>>>>> +        #sound-dai-cells = <0>;
>>>>> +    };
>>>>> +
>>>>> +    wcd938x: audio-codec-1 {
>>>> Why 'wcd938x' and not 'wcd9385'?
>>> Actually same driver is used for both wcd9380 and wcd9385. Here we can
>>> use specific name as per board.
>>>
>>> Will change accordingly.
>> At present, dt-bindgs also has wcd938x. So will update the name in bindings
>> and here post this series.
>>
>> is it okay?
> I don't think it's strictly necessary to update the binding, as
> 'wcd938x' is only used in the example, and also it's not really
> wrong. Then again, if the example in the binding uses a
> specific wcd version it might make it less likely that the
> wildcard name is used in future board DTs. Up to you :)
Okay. Will update accordingly.
