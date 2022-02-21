Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681274BD713
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346166AbiBUHaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:30:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiBUHaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:30:12 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E633D2E7;
        Sun, 20 Feb 2022 23:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645428589; x=1676964589;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6D4yV8bDeMxm5+FUJ/FpEuulvTmINQkkeXa+l9x7HIE=;
  b=AABymVGNKr2E3P14+5d5gEFIQJLd2utnI84hSHH6adTREjOyzEYoKpUi
   a3ODLMiO8mhoOUK4d4bJE+6vR8IzSYnesNeFWe108wwwdl7fxrIs9CIME
   J0damegyWna03ypJoak0MHDtzhRXxHp+sfEqlDUKRwTJ2kkuplgFsImvV
   o=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 Feb 2022 23:29:49 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 23:29:49 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sun, 20 Feb 2022 23:29:49 -0800
Received: from [10.216.3.188] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Sun, 20 Feb
 2022 23:29:45 -0800
Message-ID: <c1d80103-168a-b9eb-938b-4351115a0e08@quicinc.com>
Date:   Mon, 21 Feb 2022 12:59:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3 2/7] mailbox: qcom: Add support for SDX65 APCS IPC
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1645420953-21176-1-git-send-email-quic_rohiagar@quicinc.com>
 <1645420953-21176-3-git-send-email-quic_rohiagar@quicinc.com>
 <20220221053514.GA15108@thinkpad>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <20220221053514.GA15108@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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


On 2/21/2022 11:05 AM, Manivannan Sadhasivam wrote:
> On Mon, Feb 21, 2022 at 10:52:28AM +0530, Rohit Agarwal wrote:
>> In SDX65, the IPC bits are located in the APCS GCC block. Also, this block
>> can provide clock functionality. Hence, add support for IPC with correct
>> offset and name of the clock provider.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
>>   drivers/mailbox/qcom-apcs-ipc-mailbox.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
>> index 9325d2a..54d7659 100644
>> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
>> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
>> @@ -53,6 +53,10 @@ static const struct qcom_apcs_ipc_data sdx55_apcs_data = {
>>   	.offset = 0x1008, .clk_name = "qcom-sdx55-acps-clk"
>>   };
>>   
>> +static const struct qcom_apcs_ipc_data sdx65_apcs_data = {
>> +	.offset = 0x1008, .clk_name = "qcom-sdx55-acps-clk"
>> +};
> What I suggested was reusing the "qcom,sdx55-apcs-gcc" compatible in devicetree.
> So with that, you won't need this specific compatible for SDX65 that essentially
> duplicates SDX55.
Clear. Will update. Thanks!
> Thanks,
> Mani
>
>> +
>>   static const struct regmap_config apcs_regmap_config = {
>>   	.reg_bits = 32,
>>   	.reg_stride = 4,
>> @@ -159,6 +163,7 @@ static const struct of_device_id qcom_apcs_ipc_of_match[] = {
>>   	{ .compatible = "qcom,sm8150-apss-shared", .data = &apps_shared_apcs_data },
>>   	{ .compatible = "qcom,sm6115-apcs-hmss-global", .data = &msm8994_apcs_data },
>>   	{ .compatible = "qcom,sdx55-apcs-gcc", .data = &sdx55_apcs_data },
>> +	{ .compatible = "qcom,sdx65-apcs-gcc", .data = &sdx65_apcs_data },
>>   	{}
>>   };
>>   MODULE_DEVICE_TABLE(of, qcom_apcs_ipc_of_match);
>> -- 
>> 2.7.4
>>
