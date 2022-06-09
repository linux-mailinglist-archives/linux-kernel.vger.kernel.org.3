Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7661B544324
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbiFIFZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238401AbiFIFZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:25:16 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48663289AD;
        Wed,  8 Jun 2022 22:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654752301; x=1686288301;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sQdvDWuWtaQh0Lb0pLm0ipy9rI3cjtx2CKUnt8lhGP8=;
  b=TpyRbqd0yfJ5GFgVuylfa0zxhbkmvHYp6OhsKQHx1osu+pkrS22G7Y0/
   BlM8uCoii3RGWj6caJJDukYthFS8mu0L5dkJzqoG1F4P3NmtXlhXmRvge
   f2y/fqH4y/5dTf+QRyoSJ9y++lHcwJqjv3SKxvsAz8UFLqmbzlRIa83Mo
   g=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Jun 2022 22:25:01 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 22:25:00 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 8 Jun 2022 22:25:00 -0700
Received: from [10.50.19.103] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 8 Jun 2022
 22:24:55 -0700
Message-ID: <915be92d-302a-9149-a525-a375146a3fd9@quicinc.com>
Date:   Thu, 9 Jun 2022 10:54:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V14 8/9] arm64: dts: qcom: pm8008: Add base dts file
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>
References: <1654602615-28849-1-git-send-email-quic_c_skakit@quicinc.com>
 <1654602615-28849-9-git-send-email-quic_c_skakit@quicinc.com>
 <CKJXIE08RHD0.31NM2AKTA8B9V@otso>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
In-Reply-To: <CKJXIE08RHD0.31NM2AKTA8B9V@otso>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,


On 6/7/2022 6:46 PM, Luca Weiss wrote:
> Hi Satya,
>
> On Tue Jun 7, 2022 at 1:50 PM CEST, Satya Priya wrote:
>> Add base DTS file for pm8008.
>>
>> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>> ---
>> Changes in V14:
>>   - None.
>>
>> Changes in V13:
>>   - None.
>>
>> Changes in V12:
>>   - None.
>>
>> Changes in V11:
>>   - Remove intermediate regulators node and add the ldos under
>>     pm8008@8 node.
>>   - change the address cells as 2 for pm8008 parent mfd node.
>>   - add compatible to register the ldos.
>>   - add reg with i2c client offset and address.
>>
>>   arc
>>   arch/arm64/boot/dts/qcom/pm8008.dtsi | 54 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 54 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/pm8008.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/pm8008.dtsi b/arch/arm64/boot/dts/qcom/pm8008.dtsi
>> new file mode 100644
>> index 0000000..6f37e4d
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/pm8008.dtsi
>> @@ -0,0 +1,54 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +// Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> I noticed this file was licensed as BSD-3-Clause in V13 and
> this change was not mentioned in the "Changes" part.
> Any specific reason? Especially newer dts files should be BSD-licensed,
> and having this GPL dtsi included in otherwise BSD dts files is not
> good.


I changed it as per the suggestions of Qualcomm internal review team but 
i see that many of the drivers use BSD license, will change this back to 
BSD-3-Clause.


> Regards
> Luca
