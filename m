Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A42F4FCF10
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 07:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348282AbiDLFs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 01:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiDLFsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 01:48:25 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D6E28E21;
        Mon, 11 Apr 2022 22:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649742366; x=1681278366;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jsdy9u9+KISajB9c0j8gNH1SrGcFBDcQb+MHTS1cdWc=;
  b=UleOYA4A4iXYNVQnn7LdnR9EuJ1gky+ICI8aBIR8TdnTy4G/2cOLP8cY
   myPqOdGxylZ5cmLNe3T5Xoy0lIda7PdzJXh0I7xPRLvO8IwwVjpWh6y+t
   I5tXOiZIrqkRqe4QTbLNuACzU/7wFKdGor/930H/LMy5r0gZ1msbJvVJW
   E=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 Apr 2022 22:46:05 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 22:46:05 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Apr 2022 22:46:05 -0700
Received: from [10.50.41.188] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 11 Apr
 2022 22:46:01 -0700
Message-ID: <c5d10dc4-a76f-fdab-0ca3-2850871f36b3@quicinc.com>
Date:   Tue, 12 Apr 2022 11:15:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v11] arm64: dts: qcom: sc7280: Add WPSS remoteproc node
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_sibis@quicinc.com>,
        <kuabhs@chromium.org>, <quic_pillair@quicinc.com>
References: <20220406111101.27412-1-quic_mpubbise@quicinc.com>
 <CAE-0n51vq_V85SKh+hN1Ueas9t1dV7ZFaFyQsG9vukRBAHUc5A@mail.gmail.com>
 <5c87d5d9-66d0-41d9-4adb-53b3ec7cadeb@quicinc.com>
 <CAE-0n51PheX1poksttyYVEOVe2amWbWwZSQMwguTUxajSHm6bQ@mail.gmail.com>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <CAE-0n51PheX1poksttyYVEOVe2amWbWwZSQMwguTUxajSHm6bQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

On 4/7/2022 11:46 PM, Stephen Boyd wrote:
> Quoting Manikanta Pubbisetty (2022-04-06 23:11:50)
>>
>>
>> On 4/6/2022 8:47 PM, Stephen Boyd wrote:
>>> Quoting Manikanta Pubbisetty (2022-04-06 04:11:01)
>>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>>>> index ecbf2b89d896..f61a3e15fa8b 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>>>> @@ -547,3 +547,6 @@ sw_ctrl: sw-ctrl {
>>>>           };
>>>>    };
>>>>
>>>> +&remoteproc_wpss {
>>>> +       status = "okay";
>>>> +};
>>>
>>> This should be before the PINCTRL section in this file. I believe after
>>> the uart node.
>>
>> I have not understood your concern, any specific reason as why
>> remoteproc_wpss node has to be before PINCTRL section?
>> There is no problem in moving, just wanted to understand the reason.
>>
> 
> It's a style that this file is following. The end of the file is for
> pinctrl configurations. Before that section is where soc nodes are
> modified. There are different sections of the file with comments
> delineating them.
> 
> Furthermore, adding things to the end of the file is a recipe for
> conflicts when applying patches as a maintainer. This is another reason
> why we sort the nodes. I suspect having different sections helps here so
> that we don't sort everything alphabetically and have pinctrl settings
> scattered throughout the file.

Thanks for the explanation, I'll send out a revised patch.

Manikanta
