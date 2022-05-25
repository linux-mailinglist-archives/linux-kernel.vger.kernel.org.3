Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DDA53366B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 07:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243980AbiEYFaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 01:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237184AbiEYFat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 01:30:49 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCB3546A8;
        Tue, 24 May 2022 22:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653456649; x=1684992649;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=DsGKeqfSj16RFm5Jn2/AAf0C5X/Pb5reAu370lQ9uQ0=;
  b=Op0vyJ52MfmK4RzOqGj0sYDD8weLxP9nEouqyCBGazok1Sfi5T8iH50M
   4qE61kZ5WaOswl/zg1RT6RYRPgKtFuZVV8CS0nOIk4UUz/ogufp8ou/jo
   mJ+XciY7zHIMZR1t31h3X9F/ya3AoIKcULOSgiPknboV6w7L1whx9dXfW
   E=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 24 May 2022 22:30:48 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 22:30:47 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 24 May 2022 22:30:47 -0700
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 24 May
 2022 22:30:43 -0700
Subject: Re: [PATCH v4 3/3] dt-bindings: remoteproc: qcom: Convert SC7180 MSS
 bindings to YAML
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
CC:     <bjorn.andersson@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <ohad@wizery.com>, <agross@kernel.org>,
        <mathieu.poirier@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <mka@chromium.org>
References: <1652978825-5304-1-git-send-email-quic_sibis@quicinc.com>
 <1652978825-5304-4-git-send-email-quic_sibis@quicinc.com>
 <20220520224011.GA374485-robh@kernel.org>
 <371ce290-1deb-bff2-112b-71be8c005b37@linaro.org>
 <a5ad7884-d2c5-aeb0-405e-0121bb51f0a1@quicinc.com>
 <9badcfce-1db2-5381-bab8-8e52b875cebd@linaro.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <90645ff6-0446-af02-08fe-d8f022de941a@quicinc.com>
Date:   Wed, 25 May 2022 11:00:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9badcfce-1db2-5381-bab8-8e52b875cebd@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/24/22 11:03 PM, Krzysztof Kozlowski wrote:
> On 24/05/2022 04:00, Sibi Sankar wrote:
>> Hey Rob/Krzysztof,
>>
>> On 5/21/22 8:04 PM, Krzysztof Kozlowski wrote:
>>> On 21/05/2022 00:40, Rob Herring wrote:
>>>> On Thu, May 19, 2022 at 10:17:05PM +0530, Sibi Sankar wrote:
>>>>> Convert SC7180 MSS PIL loading bindings to YAML.
>>>>
>>>> I suppose there is a reason the sc7180 is being split out and the only
>>>> one converted, but this doesn't tell me.
>>>
>>> I am also confused, especially that last time I pointed out that there
>>> is work already:
>>> https://lore.kernel.org/all/20220511161602.117772-7-sireeshkodali1@gmail.com/
>>
>> https://lore.kernel.org/all/e3543961-1645-b02a-c869-f8fa1ad2d41c@quicinc.com/#t
>>
>> The reason for the split was discussed on the list ^^, thought it
>> wouldn't make much sense adding any of it to the commit message.
>> Also since Krzysztof said he wanted a alignment between Sireesh/me
>> we did exchange mails saying I'll take care of SC7180/SC7280 (since
>> they had pas compatible which is overridden by mss compatible) and
>> he could continue with the rest.
> 
> 
> Sounds good to me, but Rob's got a point - this background should be
> better explained.
> 

ack

-Sibi

> 
> Best regards,
> Krzysztof
> 
