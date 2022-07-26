Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04BE58129D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238409AbiGZMBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiGZMBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:01:42 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CCBBE0D;
        Tue, 26 Jul 2022 05:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658836901; x=1690372901;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Y19Fz65PlnLCYSYXGeKtni8ycM0Z52y7gynxwVIafhU=;
  b=tm9ArRv8SPTzFssb5Cmd9Q5GIxfz3ewtshcsx0z2lcyFaLrlcDSfq9Er
   QdXx15+7S/bWxGcfuFRuvV4GaqMsTfevFwZL5DY8vRYLITms7uPjKpXjS
   aIsF/fImV6otHmTB8IxKtQFA0Y+DVuTWO27FL7wMV4ZBcfeNDUHLwVZb9
   4=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 26 Jul 2022 05:01:41 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 05:01:40 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Jul 2022 05:01:40 -0700
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 26 Jul
 2022 05:01:36 -0700
Subject: Re: [PATCH 10/10] arm64: dts: qcom: sdm845: add LLCC BWMON
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Rajendra Nayak <quic_rjendra@quicinc.com>
References: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
 <20220720192807.130098-11-krzysztof.kozlowski@linaro.org>
 <25673493-4171-62b0-f696-1316d115f388@kali.org>
 <96552a95-8939-3ac2-c9b3-14dabaf53923@linaro.org>
 <d814a6da-b0d7-2fd1-fd14-8f1f3b88666f@kali.org>
 <d89a540f-672d-83de-d19d-00f10e4370d1@kali.org>
 <fec6bd98-5efd-fe34-6d75-1765219acd82@linaro.org>
 <25321f37-dbea-188b-1b11-e983a00701b2@quicinc.com>
Message-ID: <3325c626-f1af-2e95-fc53-68cf3d427a88@quicinc.com>
Date:   Tue, 26 Jul 2022 17:31:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <25321f37-dbea-188b-1b11-e983a00701b2@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/22 5:01 PM, Sibi Sankar wrote:
> On 7/23/22 2:06 PM, Krzysztof Kozlowski wrote:
>> On 23/07/2022 04:37, Steev Klimaszewski wrote:
>>>>
>>>> Currently it's 5.19.0-rc7 (torvalds tree at 4ba1329c) with a few extra
>>>> patches on top, the bwmon set included.  It's possible that secure
>>>> world uses it, but I do not know enough about that to say one way or
>>>> the other.
>>
>> To test patches you should apply them on maintainer's tree or
>> linux-next. Applying on other trees of course might be useful for
>> testing some backports, but it is independent process and different 
>> issue.
>>
>>>>
>>>> -- steev
>>>>
>>> I think you may be right; I just applied this patchset to -next
>>> (20220722) and i do not see the error message there.  On my 5.19-rc7
>>> tree, i am also testing a patchset that enables qcom devices to access
>>> efivars, so possibly we are ending up in secure world there?
>>
>> Actually mapping of IO space should not touch secure world, so this was
>> a long shot assuming you test it on the next.
>>
> 
> The memory region specified in device tree overlaps with the llcc system
> cache controller node. Steev probably had the QCOM_LLCC config enabled 
> when he tested it out on his branch.

 From what I see we can probably get away with restricting the llcc_base
reg region to just llcc0_common region and leave the lcc-bwmon as is.

> 
>>
>> Best regards,
>> Krzysztof
>>
