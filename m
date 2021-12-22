Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1430B47CA8B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 01:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240047AbhLVAs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 19:48:27 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:58882 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240040AbhLVAs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 19:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640134106; x=1671670106;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+WP+LU8+WfK3VJfOQObpIoPYHVPs4Bx6qCxSDTSMIB8=;
  b=zE05VLVONeuzrhqo9Ho3T/VIWkjYtHPKcBYMMNLVjKqiR4QB5G63Skay
   s6yyWOPnfMK7w1E9O75OaH5aoelS+akcQzkJXCdFl42N92b36ZWM/K5aH
   nGNBNz0p61lmtE6jAf5x5FSiVg6CzXpyIax6f0cLZaGPZZj08OlqFoIQP
   U=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Dec 2021 16:48:26 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 16:48:24 -0800
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 21 Dec 2021 16:48:24 -0800
Received: from [10.231.205.174] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 21 Dec
 2021 16:48:21 -0800
Message-ID: <ab5727dc-1946-2fc3-f946-32a2b8a000c0@quicinc.com>
Date:   Wed, 22 Dec 2021 08:48:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 08/11] bindings: spmi: spmi-pmic-arb: mark interrupt
 properties as optional
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
        <sboyd@kernel.org>, <collinsd@codeaurora.org>,
        <subbaram@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <maz@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1640071211-31462-1-git-send-email-quic_fenglinw@quicinc.com>
 <1640071211-31462-9-git-send-email-quic_fenglinw@quicinc.com>
 <YcHvFKG8NaXzKpgA@robh.at.kernel.org>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <YcHvFKG8NaXzKpgA@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/21 23:13, Rob Herring wrote:
> On Tue, 21 Dec 2021 15:20:06 +0800, Fenglin Wu wrote:
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
>>
> 
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.
> 
I will remember to add the Acked-by/Reviewed-by tags next time when 
sending any update in this series. Thanks for the notice!
