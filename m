Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59544BF155
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 06:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiBVFa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 00:30:58 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiBVFa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 00:30:29 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DCE7084E;
        Mon, 21 Feb 2022 21:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645507804; x=1677043804;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=dyGCqEWolvHRVduWhviEQyQaBM1jwneMhkEEEZgRg3s=;
  b=Q+H4CnPYpO3k1/j0tItfEbW4nOwV5EPuHE54o7wM9187M6bxH8SbB3Gw
   BWGXoc0uibP8yorS/Rs09qbF4BGl32SW3wJhq+hYzpfgF9lJFqunlGOPq
   n+HkMlKSYe8M47eqiHqXlCLW9YfiyTs5zzLYbB9YqvponjhgANzO1+Fp0
   A=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Feb 2022 20:45:56 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 20:45:55 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 21 Feb 2022 20:45:55 -0800
Received: from [10.216.54.2] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Mon, 21 Feb
 2022 20:45:51 -0800
Subject: Re: [PATCH V3 2/4] leds: Add pm8350c support to Qualcomm LPG driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, <mka@chromium.org>,
        <swboyd@chromium.org>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        satya priya <skakit@codeaurora.org>
References: <1635507893-25490-1-git-send-email-quic_c_skakit@quicinc.com>
 <1635507893-25490-3-git-send-email-quic_c_skakit@quicinc.com>
 <Yg7LjJFi51cmDUQr@ripper>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <d6dada9f-3b81-01c4-47a6-0750dafa2864@quicinc.com>
Date:   Tue, 22 Feb 2022 10:15:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Yg7LjJFi51cmDUQr@ripper>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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

On 2/18/2022 3:56 AM, Bjorn Andersson wrote:

> On Fri 29 Oct 04:44 PDT 2021, Satya Priya wrote:
>
>> From: satya priya <skakit@codeaurora.org>
>>
>> Add pm8350c compatible and lpg_data to the driver.
>>
>> Signed-off-by: satya priya <skakit@codeaurora.org>
> Sorry for the OCD, but I would really like for you to capitalize 's' and
> 'p' in your name.


I had corrected this in the v3-resend version.

https://patchwork.kernel.org/project/linux-arm-msm/patch/1637917920-22041-3-git-send-email-quic_c_skakit@quicinc.com/


>
>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>> ---
>> Changes in V2:
>>   - Added const for lpg_channel_data[] struct.
>>
>> Changes in V3:
>>   - Correct the num_channels and add respective base addresses.
>>
>>   drivers/leds/rgb/leds-qcom-lpg.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
>> index 45ef4ec..ad99a9b 100644
>> --- a/drivers/leds/rgb/leds-qcom-lpg.c
>> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
>> @@ -1275,9 +1275,22 @@ static const struct lpg_data pm8150l_lpg_data = {
>>   	},
>>   };
>>   
>> +static const struct lpg_data pm8350c_pwm_data = {
>> +	.pwm_9bit_mask = BIT(2),
> As you might have seen in v12 I dropped pwm_9bit_mask.


Yeah, I'll drop this.


>> +
> Afaict there's a tri-channel current sink in pm8350c as well, so you
> should have:
>
>          .triled_base = 0xef00,
>
> And then associated .triled_mask in the relevant channels.


Okay, I'll add them.


> Regards,
> Bjorn
>
>> +	.num_channels = 4,
>> +	.channels = (const struct lpg_channel_data[]) {
>> +		{ .base = 0xe800 },
>> +		{ .base = 0xe900 },
>> +		{ .base = 0xea00 },
>> +		{ .base = 0xeb00 },
>> +	},
>> +};
>> +
>>   static const struct of_device_id lpg_of_table[] = {
>>   	{ .compatible = "qcom,pm8150b-lpg", .data = &pm8150b_lpg_data },
>>   	{ .compatible = "qcom,pm8150l-lpg", .data = &pm8150l_lpg_data },
>> +	{ .compatible = "qcom,pm8350c-pwm", .data = &pm8350c_pwm_data },
>>   	{ .compatible = "qcom,pm8916-pwm", .data = &pm8916_pwm_data },
>>   	{ .compatible = "qcom,pm8941-lpg", .data = &pm8941_lpg_data },
>>   	{ .compatible = "qcom,pm8994-lpg", .data = &pm8994_lpg_data },
>> -- 
>> 2.7.4
>>
