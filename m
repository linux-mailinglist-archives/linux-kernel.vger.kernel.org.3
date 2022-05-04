Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0715196F0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 07:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343937AbiEDFjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 01:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238209AbiEDFjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 01:39:14 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8191B23BFE;
        Tue,  3 May 2022 22:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651642539; x=1683178539;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HERzZ8fE5BhLt+64mZr7M8chYHgaQz+gAR/fUV9fewc=;
  b=vpHSV8q43KJwTTOkDbtakd9QELbYSEhtPtfP76JYxz6i7NQfD+3SaJHd
   Mxw5LgDnoO8JrH679TIKp+6N8Bk5ouvppECCPxQ54wPw2AEYnCZyVGTb6
   1SatCxtMAovMNJdxcV3K1W9zTHrbgtJV0n8hE+Mc31WARwGAQWA5qLE3M
   8=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 03 May 2022 22:35:38 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 22:35:38 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 3 May 2022 22:35:38 -0700
Received: from [10.216.1.126] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 3 May 2022
 22:35:35 -0700
Message-ID: <e74aacdf-3ff7-261d-997f-5b6566b66207@quicinc.com>
Date:   Wed, 4 May 2022 11:05:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v4] arm64: dts: qcom: sc7280: Add lpasscore & lpassaudio
 clock controllers
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220503113246.13857-1-quic_tdas@quicinc.com>
 <CAE-0n53QZn8VYB-dxzwccYDURU-0qW3ZwsuOEECwrKGAhYzwgw@mail.gmail.com>
From:   Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <CAE-0n53QZn8VYB-dxzwccYDURU-0qW3ZwsuOEECwrKGAhYzwgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

On 5/4/2022 12:40 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2022-05-03 04:32:46)
>> Add the low pass audio clock controller device nodes. Keep the lpasscc
>> clock node disabled and enabled for lpass pil based devices.
> 
> Does it mean that we're going to have overlapping reg ranges between
> nodes in DT for clk controllers? That is not proper DT style, indicating
> that we should combine the overlapping nodes and then have some
> compatible or DT property telling us how to treat the clks in the audio
> subsystem.
> 

In the case where PIL based LPASS node would be used, we would disable 
the other lpass clock controller nodes. Does that seem fine or I would 
need to map the complete range in the current PIL driver if that works.

>>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> ---
>> [v4]
>>   * Mark lpasscc[lpasscc@3000000] device node as "disabled".

-- 
Thanks & Regards,
Taniya Das.
