Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D2B4F75C5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 08:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbiDGGOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 02:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbiDGGOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:14:04 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77759DE098;
        Wed,  6 Apr 2022 23:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649311923; x=1680847923;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nBxEeOwcr6xTw6EPEUZhmjsNBINTTtRUxCKTCYECXjA=;
  b=d0PC2xj2pxaOPHpDy1BU5+q/DY6uhbMwbt9sEhaQ8MGz8yAUvys0aX2S
   HfAEj81lYZI/loDgK7ILqi6qwDWdjcdwadQ3RqSROfEFvpvuygRNHmSzt
   zIVWzsQ6NRaeJYdgN7isk2tNtSOR8AV0rNUGoqTh7aoymI+RyNH3dieIl
   A=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 06 Apr 2022 23:12:01 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 23:12:00 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 6 Apr 2022 23:12:00 -0700
Received: from [10.50.10.231] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 6 Apr 2022
 23:11:56 -0700
Message-ID: <5c87d5d9-66d0-41d9-4adb-53b3ec7cadeb@quicinc.com>
Date:   Thu, 7 Apr 2022 11:41:50 +0530
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
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <CAE-0n51vq_V85SKh+hN1Ueas9t1dV7ZFaFyQsG9vukRBAHUc5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/2022 8:47 PM, Stephen Boyd wrote:
> Quoting Manikanta Pubbisetty (2022-04-06 04:11:01)
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index ecbf2b89d896..f61a3e15fa8b 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -547,3 +547,6 @@ sw_ctrl: sw-ctrl {
>>          };
>>   };
>>
>> +&remoteproc_wpss {
>> +       status = "okay";
>> +};
> 
> This should be before the PINCTRL section in this file. I believe after
> the uart node.

I have not understood your concern, any specific reason as why 
remoteproc_wpss node has to be before PINCTRL section?
There is no problem in moving, just wanted to understand the reason.

Thanks,
Manikanta
