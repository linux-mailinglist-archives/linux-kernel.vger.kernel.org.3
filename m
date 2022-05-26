Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6372F534DEE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345470AbiEZLRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbiEZLRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:17:08 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CD395DD2;
        Thu, 26 May 2022 04:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653563827; x=1685099827;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=jl+F2eJ4nE5XySB40dAzATocGz6c62UCpxl8Gn1FUcA=;
  b=mRFznUDzBIsyBtiz+JLuf77x100bQDEVvZSw7Oxi6LvFTVY2aabyAYwT
   04uFG2dFZx42nISgDHSfr8qm23XVBCMMvYsNNu9nFmvpRGFsCn6OkemBJ
   uF0TQFal/t6KUyW2nMAsFg9ESbtC1LDasTdV18n2VzWYZBZBGoJcfUpRU
   Y=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 May 2022 04:17:06 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 04:17:06 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 26 May 2022 04:17:06 -0700
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 26 May
 2022 04:17:02 -0700
Subject: Re: [PATCH v4 1/3] arm64: dts: qcom: sc7280: Add proxy interconnect
 requirements for modem
To:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <ohad@wizery.com>, <agross@kernel.org>,
        <mathieu.poirier@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mka@chromium.org>
References: <1652978825-5304-1-git-send-email-quic_sibis@quicinc.com>
 <1652978825-5304-2-git-send-email-quic_sibis@quicinc.com>
 <YoaqDcB6wkd4zOWR@ripper> <031ebead-4b0d-8493-d8f8-96f2ff9d938a@quicinc.com>
 <CAE-0n53hDDoetQW0Bz7noq4peuNCyrGsXaJdjFj=4sMkGeZFgw@mail.gmail.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <3e7e8263-fdc1-ffa8-7b7f-188bb027fadf@quicinc.com>
Date:   Thu, 26 May 2022 16:46:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n53hDDoetQW0Bz7noq4peuNCyrGsXaJdjFj=4sMkGeZFgw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/21/22 12:37 AM, Stephen Boyd wrote:
> Quoting Sibi Sankar (2022-05-20 11:08:52)
>> Hey Bjorn,
>> Thanks for taking time to review the series.
>>
>> On 5/20/22 2:05 AM, Bjorn Andersson wrote:
>>> On Thu 19 May 09:47 PDT 2022, Sibi Sankar wrote:
>>>
>>>> Add interconnects that are required to be proxy voted upon during modem
>>>> bootup on SC7280 SoCs.
>>>
>>> This looks reasonable, but how come the vote is only for DDR frequency?
>>> What about the buses between modem and ddr?
>>
>> The proxy votes that are put in aren't for perf related reasons, the
>> modem was getting llcc timeouts while trying to read contents from
>> memory. The hw team recommended the proxy votes as the fix.
> 
> Presumably the bootloader sets up some initial modem and ddr bus
> bandwidth requests? Or the modem bootloader stage (MSA?) handles that
> part?

Stephen/Bjorn,
Sorry for the delay, took a while to dig this up. The modem interconnect
is connected directly to gemnoc ddr. The path info from modem --> ddr is
split up into modem --> llcc and llcc --> ddr (Similar to CPUs) i.e. in
the end scaling of the path involves scaling of the two clocks, gemnoc
and ddr. There isn't any default vote for modem --> llcc as such but it
gets implicitly scaled when we vote max for llcc --> ddr path due to
dependency maintained between the two clocks by rpmh.

-Sibi

> 
