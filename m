Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8534C3ED9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 08:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238041AbiBYHRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 02:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238034AbiBYHRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 02:17:18 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AE1657F;
        Thu, 24 Feb 2022 23:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645773400; x=1677309400;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Eha8UfFU5sTXgWjY6/4IUTMY/kkCOwxcj1l/44F5h+U=;
  b=as9waMjut2vhMOAY3TXveAsWvwMzZkNvXC+CyIiUhA9mP8bYgYYtK8V1
   AW9hAc3vLx2a8mSmVMK2VNPrF6/TfGdjO1Dj+S2fq6lKeHoY4vrAH85X0
   IJiMqQxQ3bJyyWRY6qrzNoGZ7TB7KgHDaoanLZs7UEoejXmn2gzteitVw
   U=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Feb 2022 23:16:39 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 23:16:39 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 24 Feb 2022 23:16:39 -0800
Received: from [10.216.57.207] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Thu, 24 Feb
 2022 23:16:35 -0800
Message-ID: <b9205016-1f33-74fd-c314-c307412bfca3@quicinc.com>
Date:   Fri, 25 Feb 2022 12:46:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] ARM: dts: qcom: Add chosen node information for SDX65.
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <agross@kernel.org>, <robh+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1644574845-23248-1-git-send-email-quic_rohiagar@quicinc.com>
 <YhfgAL8z6rO+zU3w@builder.lan>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <YhfgAL8z6rO+zU3w@builder.lan>
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


On 2/25/2022 1:14 AM, Bjorn Andersson wrote:
> On Fri 11 Feb 04:20 CST 2022, Rohit Agarwal wrote:
>
>> Add chosen node in the base dtsi file of SDX65.
>>
> While this happens to be the same on most boards, it is still a
> board-specific decision which UART is the debug uart, or if there is one
> at all...
>
> So this property should remain in the dts.
>
> Thanks,
> Bjorn

Without the chosen node in base dtsi, the device is not booting up.
Can we have an empty chosen node in the base dtsi and the board-specific 
details
updated in the respective dts file. The device boots up with this.

Thanks,
Rohit

>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
>>   arch/arm/boot/dts/qcom-sdx65-mtp.dts | 4 ----
>>   arch/arm/boot/dts/qcom-sdx65.dtsi    | 4 ++++
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
>> index 59457da..3a75c21 100644
>> --- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
>> +++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
>> @@ -14,10 +14,6 @@
>>   	aliases {
>>   		serial0 = &blsp1_uart3;
>>   	};
>> -
>> -	chosen {
>> -		stdout-path = "serial0:115200n8";
>> -	};
>>   };
>>   
>>   &blsp1_uart3 {
>> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
>> index 796641d..653df15 100644
>> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
>> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
>> @@ -17,6 +17,10 @@
>>   	qcom,msm-id = <458 0x10000>, <483 0x10000>, <509 0x10000>;
>>   	interrupt-parent = <&intc>;
>>   
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>>   	memory {
>>   		device_type = "memory";
>>   		reg = <0 0>;
>> -- 
>> 2.7.4
>>
