Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF7346F838
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbhLJBHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:07:17 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:64281 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhLJBHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:07:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639098223; x=1670634223;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GX8+2zIdCqzjzOePDlyWE6qkeEZ7FtSm4Y1naB/0RZs=;
  b=WWUYyXbov6wmZR07G4ZmYkS0/JAeAfsPvkaSHiPl9PFIXq/bRPrQjbIY
   HUp83Vy1+J2KVhCMgoIMgsqcp+9Z5v5vnLnLkCXbnqubQhkwycFB8161N
   TV0BnPLBK075/JyY+6UnN3uuKZNMyzSzKwvv2lRSoiAE2qhFLL0w1iY4O
   I=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 09 Dec 2021 17:03:43 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 17:03:42 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 17:03:42 -0800
Received: from [10.253.38.94] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 9 Dec 2021
 17:03:37 -0800
Message-ID: <4701e5d9-24d5-5d63-cf68-8988d6fbe306@quicinc.com>
Date:   Fri, 10 Dec 2021 09:03:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 6/9] docs: sysfs: coresight: Add sysfs ABI
 documentation for TPDM
Content-Language: en-US
To:     Trilok Soni <quic_tsoni@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
References: <20211209141543.21314-1-quic_jinlmao@quicinc.com>
 <20211209141543.21314-7-quic_jinlmao@quicinc.com>
 <f8553de9-9a28-2624-0257-777f05ef6010@quicinc.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <f8553de9-9a28-2624-0257-777f05ef6010@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trilok,

Thanks for the review.

On 12/10/2021 2:34 AM, Trilok Soni wrote:
>
> Hello Jinlong,
>
> On 12/9/2021 6:15 AM, Mao Jinlong wrote:
>> Add API usage document for sysfs API in TPDM driver.
>>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm     | 12 ++++++++++++
>>   MAINTAINERS                                          |  1 +
>>   2 files changed, 13 insertions(+)
>>   create mode 100644 
>> Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>
>> diff --git 
>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> new file mode 100644
>> index 000000000000..fdd0bd0e1c33
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> @@ -0,0 +1,12 @@
>> +What: /sys/bus/coresight/devices/<tpdm-name>/available_datasets
>> +Date:        December 2021
>> +KernelVersion    5.16
>> +Contact:    Jinlong Mao or Tao Zhang
>
> Just keep one name? I am not sure if we are adding multiple names for 
> other files.

Yes. available_datasets need to be removed here as there is no changes 
for available_dataset.

I forgot to remove it after removing he available_dataset changes. I 
will update in next version.

>
>> +Description:    (Read) Show available datasets for TPDM.
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/integration_test
>> +Date:        December 2020
>>
>
> December 2021?

I will update it.


