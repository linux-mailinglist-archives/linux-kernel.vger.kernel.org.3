Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413D94BEF99
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 03:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbiBVC15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 21:27:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiBVC1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 21:27:55 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2F624580;
        Mon, 21 Feb 2022 18:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645496851; x=1677032851;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z0dCkhFrHYypecMqCx7KI+gQczqt9hRDEfCKOGE+e9k=;
  b=ija/iJlZyhdjwPAY4cm+zY+HGN8JRnZUZdcjlXCa3d+c8dz+x7lokJT9
   lCr/o+lMD9/zjjoJd4IzcgQRUu6XHSNfZiEJthfKrfZEnM9S3jPkrLqk4
   qOIHPfplrngvr2l4w5fZg5leeNwJCqe4XXvSRWa1JRhMuNkIg6FNpN2s7
   E=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Feb 2022 18:27:30 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 18:27:30 -0800
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 21 Feb 2022 18:27:29 -0800
Received: from [10.231.205.174] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Mon, 21 Feb
 2022 18:27:27 -0800
Message-ID: <ab72af9e-b1dc-8562-b2c7-ac329af7a1b2@quicinc.com>
Date:   Tue, 22 Feb 2022 10:26:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 08/10] bindings: spmi: spmi-pmic-arb: mark interrupt
 properties as optional
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>, <collinsd@codeaurora.org>,
        <subbaram@codeaurora.org>, <tglx@linutronix.de>, <maz@kernel.org>
References: <1643178713-17178-1-git-send-email-quic_fenglinw@quicinc.com>
 <1643178713-17178-9-git-send-email-quic_fenglinw@quicinc.com>
 <Yf2qVi8Xj/iYYRNm@robh.at.kernel.org>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <Yf2qVi8Xj/iYYRNm@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/2/5 6:36, Rob Herring wrote:
> On Wed, Jan 26, 2022 at 02:31:50PM +0800, Fenglin Wu wrote:
>> From: David Collins <collinsd@codeaurora.org>
>>
>> Mark all interrupt related properties as optional instead of
>> required.  Some boards do not required PMIC IRQ support and it
>> isn't needed to handle SPMI bus transactions, so specify it as
>> optional.
>>
>> Signed-off-by: David Collins <collinsd@codeaurora.org>
>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt | 2 ++
>>   1 file changed, 2 insertions(+)
> 
> This will collide with converting it to DT schema[1].
> 
> Rob
> 
> [1] https://lore.kernel.org/all/20220131172450.2528065-2-vkoul@kernel.org/
Noticed that, I just didn't know which one would get merged 1st. I can 
update it once the DT schema change get accepted and be present in 
spmi-next branch.
