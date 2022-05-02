Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9405B5170D7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385411AbiEBNrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385431AbiEBNra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:47:30 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0410E1276F;
        Mon,  2 May 2022 06:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651499038; x=1683035038;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TxRhC+xkcMIDEeWKsFRO7rKwaJaujGtLJjq0HY5brGs=;
  b=GWPgJ7Xf21MWoijEsUgftnmCfRLduJvmg31q1iQeuuDrTfrLUXBqQMyp
   V022WtMEgR38v2PN7yOIcbvVJW8i4pL5vU27ywQo31OjN8kOc4peUqzss
   jaQWC9j26b87H0P4X1aqxQ+EqYvNQu61jir+nMJIDertambEgVP2r5gey
   U=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 02 May 2022 06:43:57 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 06:43:56 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 2 May 2022 06:43:56 -0700
Received: from [10.216.10.218] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 2 May 2022
 06:43:52 -0700
Message-ID: <0243675f-2083-f5cc-5570-d880889daa8b@quicinc.com>
Date:   Mon, 2 May 2022 19:13:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v12 4/4] arm64: dts: qcom: sc7280-herobrine: Add lpi
 pinmux properties for CRD 3.0/3.1
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
References: <1651079383-7665-1-git-send-email-quic_srivasam@quicinc.com>
 <1651079383-7665-5-git-send-email-quic_srivasam@quicinc.com>
 <YmsrB6Q89II5w1+9@google.com>
 <CAD=FV=XxeZsiOVVBDK_vmx0nhT7roB2FqcaPXsH3+jzTHFXMxw@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAD=FV=XxeZsiOVVBDK_vmx0nhT7roB2FqcaPXsH3+jzTHFXMxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/29/2022 9:40 PM, Doug Anderson wrote:
Thanks for your time Doug Anderson!!!
> Hi,
>
> On Thu, Apr 28, 2022 at 5:02 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>> On Wed, Apr 27, 2022 at 10:39:43PM +0530, Srinivasa Rao Mandadapu wrote:
>>> Add LPASS LPI pinctrl properties, which are required for Audio
>>> functionality on herobrine based platforms of rev5+
>>> (aka CRD 3.0/3.1) boards.
>>>
>>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> I'm not super firm in pinctrl territory, a few maybe silly questions
>> below.
>>
>>>   arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts | 84 +++++++++++++++++++++++
>>>   1 file changed, 84 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
>>> index deaea3a..dfc42df 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
>>> @@ -111,6 +111,90 @@ ap_ts_pen_1v8: &i2c13 {
>>>    * - If a pin is not hooked up on Qcard, it gets no name.
>>>    */
>>>
>>> +&lpass_dmic01 {
>>> +     clk {
>>> +             drive-strength = <8>;
>>> +     };
> Ugh, I've been distracted and I hadn't realized we were back to the
> two-level syntax. Definitely not my favorite for all the reasons I
> talked about [1]. I guess you took Bjorn's silence to my response to
> mean that you should switch back to this way? :(
>
> Bjorn: can you clarify?
>
> [1] https://lore.kernel.org/r/CAD=FV=VicFiX6QkBksZs1KLwJ5x4eCte6j5RWOBPN+WwiXm2Cw@mail.gmail.com/
Actually Your comment addressed for MI2S pin control nodes, but missed 
here. Will address same here.
>>> +};
>>> +
>>> +&lpass_dmic01_sleep {
>>> +     clk {
>>> +             drive-strength = <2>;
>> Does the drive strength really matter in the sleep state, is the SoC actively
>> driving the pin?
> My understanding is that if a pin is left as an output in sleep state
> that there is a slight benefit to switching it to drive-strength 2.
Okay. Will keep this setting as it is. Please correct me if my 
understanding is wrong.
>
>
>>> +             bias-disable;
>> What should this be in active/default state? If I understand correctly
>> after a transition from 'sleep' to 'default' this setting will remain,
>> since the default config doesn't specify a setting for bias.
> Your understanding matches mine but I haven't tested it and I remember
> sometimes being surprised in this corner of pinmux before. I think
> it's better to put the bias in the default state if it should be that
> way all the time, or have a bias in both the default and sleep state
> if they need to be different.
Okay. Will update accordingly.
