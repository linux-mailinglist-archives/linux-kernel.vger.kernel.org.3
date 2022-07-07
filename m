Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFFE569A2A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbiGGGB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbiGGGB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:01:56 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB6031DC4;
        Wed,  6 Jul 2022 23:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657173716; x=1688709716;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5N4sUKD/BH+dt+9G8dMcKSapNUZdUb+xeJxu31OaD90=;
  b=xhKkMbGcSbCxgKsTRm3ky5mOdTrjj9Eu8/1F1Msw4ADxlZhu9HqpRuhR
   TbQKBHAu/JwENxcx92gGKyJ1s/M0nK6eoD7Gnw/KtuZtTYl5mblSEFUCP
   QxKdIeuAsCJ3cG9SlSaaNe27Uq6ErmetOcYfD1GT7DPrC7CCGx4SCVmNk
   Y=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Jul 2022 23:01:55 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 23:01:55 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 6 Jul 2022 23:01:54 -0700
Received: from [10.216.26.218] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 6 Jul 2022
 23:01:51 -0700
Message-ID: <382a74b1-5026-55ad-0d78-0d3c42e59d3d@quicinc.com>
Date:   Thu, 7 Jul 2022 11:31:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 1/3] dt-bindings: clock: Add resets for LPASS audio
 clock controller for SC7280
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-soc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>,
        <robh+dt@kernel.org>, <mka@chromium.org>
References: <20220614153306.29339-1-quic_tdas@quicinc.com>
 <20220614153306.29339-2-quic_tdas@quicinc.com>
 <20220615195914.D73B9C3411E@smtp.kernel.org>
From:   Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <20220615195914.D73B9C3411E@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 6/16/2022 1:29 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2022-06-14 08:33:04)
>> Add support for LPASS audio clock gating for RX/TX/SWA core bus clocks
>> for SC7280. Update reg property min/max items in YAML schema.
>>
>> Fixes: 4185b27b3bef ("dt-bindings: clock: Add YAML schemas for LPASS clocks on SC7280").
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> ---
>>   .../clock/qcom,sc7280-lpasscorecc.yaml        | 19 ++++++++++++++++---
>>   .../clock/qcom,lpassaudiocc-sc7280.h          |  5 +++++
>>   2 files changed, 21 insertions(+), 3 deletions(-)
> 
> I'm still wondering if the binding is correct, given the overlapping reg
> properties. Should we be removing a compatible or two and adding a DT
> property like "qcom,adsp-bypass-mode" instead?

I can pick this up as cleanup and send it across for review. If you are 
fine now please help pick these up.

-- 
Thanks & Regards,
Taniya Das.
