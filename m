Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF388578B3E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbiGRTsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236338AbiGRTsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:48:46 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A582732446;
        Mon, 18 Jul 2022 12:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658173720; x=1689709720;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+QLW32BMrwF3EtzLa3vht6erk15xYFiOHNVwg4JneaM=;
  b=O02kKZFspdraUEg72DjXtGalIb86bOehL7KObUs2Rt0SR8gnfoF3q/Y6
   hW9NaMp+wXw8ikVWt6EDIKBouZ95WLw65WZdD6chR9FQreFM/goaNEwph
   Wuf/fauI7CpJe1qD4GvXP7PUUqUgTxkDcz4J8j9i5FmHSpqO72B6cA4I9
   M=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 18 Jul 2022 12:48:40 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 12:48:39 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Jul 2022 12:48:39 -0700
Received: from [10.110.0.218] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 18 Jul
 2022 12:48:38 -0700
Message-ID: <e341619e-bac3-710f-8f77-1addfffa9a16@quicinc.com>
Date:   Mon, 18 Jul 2022 12:48:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/2] power: reset: qcom-pon: add support for
 qcom,pmk8350-pon compatible string
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
CC:     <corbet@lwn.net>, <robh+dt@kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <vkoul@kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220713193350.29796-1-quic_amelende@quicinc.com>
 <20220713193350.29796-3-quic_amelende@quicinc.com>
 <20220716215803.r3ldaswyhehfpcip@mercury.elektranox.org>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <20220716215803.r3ldaswyhehfpcip@mercury.elektranox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/2022 2:58 PM, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Jul 13, 2022 at 12:33:51PM -0700, Anjelique Melendez wrote:
>> Add support for the new "qcom,pmk8350-pon" comptaible string.
>>
>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>> ---
>>  drivers/power/reset/qcom-pon.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
>> index 4a688741a88a..16bc01738be9 100644
>> --- a/drivers/power/reset/qcom-pon.c
>> +++ b/drivers/power/reset/qcom-pon.c
>> @@ -82,6 +82,7 @@ static const struct of_device_id pm8916_pon_id_table[] = {
>>  	{ .compatible = "qcom,pm8916-pon", .data = (void *)GEN1_REASON_SHIFT },
>>  	{ .compatible = "qcom,pms405-pon", .data = (void *)GEN1_REASON_SHIFT },
>>  	{ .compatible = "qcom,pm8998-pon", .data = (void *)GEN2_REASON_SHIFT },
>> +	{ .compatible = "qcom,pmk8350-pon", .data = (void *)GEN2_REASON_SHIFT },
>>  	{ }
>>  };
>>  MODULE_DEVICE_TABLE(of, pm8916_pon_id_table);
> 
> No handling of the second register? Why is it needed in DT in the
> first place?
> 
> -- Sebastian

Hi Sebastian,

The handling of the second register takes place in drivers/input/misc/pm8941-pwrkey.c.
The patch that handles this change can be found at:
https://lore.kernel.org/linux-arm-msm/20220422191239.6271-4-quic_amelende@quicinc.com/.
This patch has been applied.

Krzystof and I discuss the need for a new compatible string here:
https://lore.kernel.org/all/99a5d9ac-9c20-b441-44af-26772a0e989d@linaro.org/.

In short, the gen1/gen2/gen3 children pon devices will use the "reg" address(es) defined
from their parent. Currently, "qcom,pm8998-pon" is too generic as it is being used for
both gen1/gen2 and gen3 children. So we must add the new "qcom,pmk8350-pon" compatible
string to be used for gen3 children so that the second register can be defined. 

Thanks,
Anjelique


