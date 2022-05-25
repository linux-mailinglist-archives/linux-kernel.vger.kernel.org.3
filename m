Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D08533667
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 07:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243969AbiEYF3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 01:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237184AbiEYF3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 01:29:50 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E400546A8;
        Tue, 24 May 2022 22:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653456589; x=1684992589;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=xdZYTVHwZASJa+Ly0kunQ8InypovC5N70bqFPRLL6XI=;
  b=VwrCjF+nlIlbBQkD+uoBlG8cI9XpVNYCgMtIN8TSPzAZLnmn6zpoZbVL
   Go2rsjRxJMrx3YQPB6zFsy5MBUONT0l+p2hUwNtPsRAGRp6MblGt9uwbM
   3zfkUR7Bvr6Qe6L498SIxrLUxYtRsphqMi6SrrvyaIRmIEEX7p6CynHPd
   8=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 May 2022 22:29:48 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 22:29:48 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 24 May 2022 22:29:47 -0700
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 24 May
 2022 22:29:43 -0700
Subject: Re: [PATCH v4 3/3] dt-bindings: remoteproc: qcom: Convert SC7180 MSS
 bindings to YAML
To:     Rob Herring <robh@kernel.org>
CC:     <bjorn.andersson@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <ohad@wizery.com>, <agross@kernel.org>,
        <mathieu.poirier@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <mka@chromium.org>
References: <1652978825-5304-1-git-send-email-quic_sibis@quicinc.com>
 <1652978825-5304-4-git-send-email-quic_sibis@quicinc.com>
 <20220520224011.GA374485-robh@kernel.org>
 <b495fa6c-6964-d8fa-0baf-acd719cd8779@quicinc.com>
 <20220524140940.GA3687200-robh@kernel.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <fb88821d-489a-d877-f57f-6b3be96af96b@quicinc.com>
Date:   Wed, 25 May 2022 10:59:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220524140940.GA3687200-robh@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Rob,

On 5/24/22 7:39 PM, Rob Herring wrote:
> On Tue, May 24, 2022 at 07:40:51AM +0530, Sibi Sankar wrote:
>> Hey Rob,
>> Thanks for taking time to review the series.
>>
>> On 5/21/22 4:10 AM, Rob Herring wrote:
>>> On Thu, May 19, 2022 at 10:17:05PM +0530, Sibi Sankar wrote:
>>>> Convert SC7180 MSS PIL loading bindings to YAML.
>>>
>>> I suppose there is a reason the sc7180 is being split out and the only
>>> one converted, but this doesn't tell me.
>>
>> https://lore.kernel.org/all/e3543961-1645-b02a-c869-f8fa1ad2d41c@quicinc.com/#t
>>
>> The reason for the split was discussed on the list ^^, thought it
>> wouldn't make much sense adding any of it to the commit message.
> 
> Why not? If you did, then we wouldn't be having this conversation.
> 
> Commit messages, at a minimum, should answer why are you making the
> change. They don't really need to explain what the change is. We can all
> read the diff to understand that.
> 

Sure will add the details in the next re-spin.

-Sibi

> Rob
> 
