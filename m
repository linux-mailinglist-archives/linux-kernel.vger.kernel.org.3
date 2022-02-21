Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68C94BD6F6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346215AbiBUH2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:28:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346207AbiBUH2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:28:22 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB5BBF43;
        Sun, 20 Feb 2022 23:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645428480; x=1676964480;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M9i+2mhTxJRCulZFPrtapbNZRjl0XH/uP0SlRqgAJXQ=;
  b=SrV+xGWUOdShLrRnEYef5XGt5hx0+Pjl6mnZV2THEJduqLK7xK/F30si
   EjENTbjBvh2irExc7L96dumdNO/gd6LgUcnsliq6Q/4Fo7kcvBb4qchpZ
   nU4kVbDwMjNkVYFLPFIo3vGbYyinyvTK9kWR68HbwR7f+jytDkpJvbrZW
   w=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Feb 2022 23:27:59 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 23:27:59 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sun, 20 Feb 2022 23:27:58 -0800
Received: from [10.216.3.188] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Sun, 20 Feb
 2022 23:27:54 -0800
Message-ID: <9fb3155e-e23e-fccd-7ab9-88f77de1bb78@quicinc.com>
Date:   Mon, 21 Feb 2022 12:57:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3 4/7] clk: qcom: Add A7 PLL support for SDX65
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1645420953-21176-1-git-send-email-quic_rohiagar@quicinc.com>
 <1645420953-21176-5-git-send-email-quic_rohiagar@quicinc.com>
 <20220221054045.GC15108@thinkpad>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <20220221054045.GC15108@thinkpad>
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


On 2/21/2022 11:10 AM, Manivannan Sadhasivam wrote:
> On Mon, Feb 21, 2022 at 10:52:30AM +0530, Rohit Agarwal wrote:
>> Add support for PLL found in Qualcomm SDX65 platforms which is used to
>> provide clock to the Cortex A7 CPU via a mux. This PLL can provide high
>> frequency clock to the CPU above 1GHz as compared to the other sources
>> like GPLL0.
>>
>> In this driver, the power domain is attached to the cpudev. This is
>> required for CPUFreq functionality and there seems to be no better place
>> to do other than this driver (no dedicated CPUFreq driver).
>>
> This tells what the driver is doing but not essentially what this patch does
> i.e., you need to mention how the SDX65 PLL is added to the driver. Since you
> are reusing the existing driver, this needs to be mentioned.
Will update.
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
>>   drivers/clk/qcom/Kconfig  | 6 +++---
>>   drivers/clk/qcom/a7-pll.c | 1 +
>>   2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 42c8741..5159a1d 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -29,11 +29,11 @@ config QCOM_A53PLL
>>   	  devices.
>>   
>>   config QCOM_A7PLL
>> -	tristate "SDX55 A7 PLL"
>> +	tristate "A7 PLL driver for SDX55 and SDX65"
>>   	help
>> -	  Support for the A7 PLL on SDX55 devices. It provides the CPU with
>> +	  Support for the A7 PLL on SDX55 and SDX65 devices. It provides the CPU with
>>   	  frequencies above 1GHz.
>> -	  Say Y if you want to support higher CPU frequencies on SDX55
>> +	  Say Y if you want to support higher CPU frequencies on SDX55 and SDX65
>>   	  devices.
>>   
>>   config QCOM_CLK_APCS_MSM8916
>> diff --git a/drivers/clk/qcom/a7-pll.c b/drivers/clk/qcom/a7-pll.c
>> index c4a53e5..adb2121 100644
>> --- a/drivers/clk/qcom/a7-pll.c
>> +++ b/drivers/clk/qcom/a7-pll.c
>> @@ -84,6 +84,7 @@ static int qcom_a7pll_probe(struct platform_device *pdev)
>>   
>>   static const struct of_device_id qcom_a7pll_match_table[] = {
>>   	{ .compatible = "qcom,sdx55-a7pll" },
>> +	{ .compatible = "qcom,sdx65-a7pll" },
> I think here also you can just reuse the "qcom,sdx55-a7pll" compatible.
Ok, Will update. Thanks!
>
> Thanks,
> Mani
>
>>   	{ }
>>   };
>>   MODULE_DEVICE_TABLE(of, qcom_a7pll_match_table);
>> -- 
>> 2.7.4
>>
