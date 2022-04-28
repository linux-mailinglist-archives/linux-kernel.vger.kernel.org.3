Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C07513279
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345494AbiD1Ldm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345468AbiD1Ldj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:33:39 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E765BF6D;
        Thu, 28 Apr 2022 04:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651145424; x=1682681424;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vHjhbXl//o4Hu6Mh0eKgnHacLrcQQU36BJWzEebX/W8=;
  b=REtoaExG8V2teP1uNga+nw/yVKsCVxbBCj0OtOU4tsl2KuGefxMT73qD
   5cg46AJFFxsb1R6ZLMjDAOQ732+Y9/UNRWRRYex+Gjoz8YPwYeVGE7/vP
   Et4La0xy+ASLGz+pGlIwx5dRdhtsfOgtYZdKmb65tZk1Aabj7rpHNOHw0
   8=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Apr 2022 04:30:15 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 04:30:15 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Apr 2022 04:30:14 -0700
Received: from [10.50.42.7] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 28 Apr
 2022 04:30:10 -0700
Message-ID: <fcae4553-66b7-2194-8aa0-9d3f0f09732d@quicinc.com>
Date:   Thu, 28 Apr 2022 17:00:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv12 8/9] serial: qcom_geni_serial: Disable MMIO tracing for
 geni serial
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <arnd@arndb.de>, <catalin.marinas@arm.com>, <rostedt@goodmis.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <maz@kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_tsoni@quicinc.com>, <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <cover.1651139070.git.quic_saipraka@quicinc.com>
 <3fef68a94e4947d58a199709929d30e0e2bf2e44.1651139070.git.quic_saipraka@quicinc.com>
 <Ympxa0ZY0VxZGEjA@kroah.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <Ympxa0ZY0VxZGEjA@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/2022 4:20 PM, Greg KH wrote:
> On Thu, Apr 28, 2022 at 03:25:31PM +0530, Sai Prakash Ranjan wrote:
>> Disable MMIO tracing for geni serial driver as it is a high
>> frequency operation for serial driver with many register reads/
>> writes and not very useful to log all MMIO traces and prevent
>> excessive logging.
>>
>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
>> ---
>>   drivers/tty/serial/qcom_geni_serial.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
>> index 1543a6028856..5b48e6c2bf3c 100644
>> --- a/drivers/tty/serial/qcom_geni_serial.c
>> +++ b/drivers/tty/serial/qcom_geni_serial.c
>> @@ -1,5 +1,11 @@
>>   // SPDX-License-Identifier: GPL-2.0
>> -// Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
>> +/*
>> + * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
> I strongly disagree that adding a single line here warrants a copyright
> update.  If your lawyers will sign off on this change, I am willing to
> reconsider.
>

You are right, I checked with them and they mentioned copyright update is not
required for a one line change.

>> +
>> +/* Disable MMIO tracing */
> Please say why in the comment, not just what.
>

Hmm the changelog describes it but I can add a comment as well.

Thanks,
Sai
