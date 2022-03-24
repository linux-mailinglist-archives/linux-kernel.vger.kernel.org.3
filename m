Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322F34E650B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350839AbiCXO0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346276AbiCXO0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:26:20 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F97F7938C;
        Thu, 24 Mar 2022 07:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648131888; x=1679667888;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jfdfzbsTcUTtwh77rV7zR6hfQLytfhcNraeaEybwRbY=;
  b=faAHdUnYEaNIg1cCN9faVRjvaOv7KezxvLw4btQWqQHtxySuFWSqPTvf
   d3ilyNFvcRglT825zhPV4FL8LHLdccO5lT8+quJ541NdtohTORsSFT1lr
   +hseGXCLHnWtYVyTbWIFh7j2KehbnCRNnrYA7ck5nrMhz0M15fNZNDvS1
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Mar 2022 07:24:48 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 07:24:47 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 24 Mar 2022 07:24:46 -0700
Received: from [10.253.74.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 24 Mar
 2022 07:24:43 -0700
Message-ID: <a49897e1-65cd-a928-99d2-a10d1dd332cd@quicinc.com>
Date:   Thu, 24 Mar 2022 22:24:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v4 06/10] docs: sysfs: coresight: Add sysfs ABI
 documentation for TPDM
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
References: <20220324121734.21531-1-quic_jinlmao@quicinc.com>
 <20220324121734.21531-7-quic_jinlmao@quicinc.com>
 <Yjxjk8bB1ibHT7Ga@kroah.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <Yjxjk8bB1ibHT7Ga@kroah.com>
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


On 3/24/2022 8:26 PM, Greg Kroah-Hartman wrote:
> On Thu, Mar 24, 2022 at 08:17:30PM +0800, Mao Jinlong wrote:
>> Add API usage document for sysfs API in TPDM driver.
>>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm | 5 +++++
>>   1 file changed, 5 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> new file mode 100644
>> index 000000000000..1df2f9b9ade2
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> @@ -0,0 +1,5 @@
>> +What:		/sys/bus/coresight/devices/<tpdm-name>/integration_test
>> +Date:		February 2022
> It is no longer February.
>
>> +KernelVersion	5.17
> 5.17 is long past.
>
>> +Contact:	Jinlong Mao or Tao Zhang
> How do we contact these names?
>
>> +Description:	(Write) Run integration test for tpdm.
> I do not understand this description at all.  Please explain it much
> better.
>
> thanks,
>
> greg k-h

Thanks for the review. I will address your comments in next version.

Thanks
Jinlong Mao
