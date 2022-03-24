Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2214E6527
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347570AbiCXOcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbiCXOcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:32:16 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E134215FFC;
        Thu, 24 Mar 2022 07:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648132245; x=1679668245;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lOc8RNcui7yAjd2ZB4PWlz7S09gUkQKjknF6hIGlRPY=;
  b=PVFFSYryWPB6CUjd/A+I8gE6cJkKDlAZOkJ+iUguDCSLdsIoMag8304M
   kycdudpS4uDn5q/iEMd1jyWkB4vDfKz0dJuC3BUKdxFQqLK8pgoQSqElx
   UyXeKUhfg77JIiQqg2ikhWTDFH1nz6nfhUkgKyTD6/i4CgbWZ8KIXW73r
   I=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 24 Mar 2022 07:30:44 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 07:30:44 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 24 Mar 2022 07:30:43 -0700
Received: from [10.253.74.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 24 Mar
 2022 07:30:40 -0700
Message-ID: <22de32f4-7a3f-ca2d-ba5e-0d0c9adefe3d@quicinc.com>
Date:   Thu, 24 Mar 2022 22:30:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v4 05/10] coresight-tpdm: Add integration test support
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
 <20220324121734.21531-6-quic_jinlmao@quicinc.com>
 <Yjxj02nl+hwoYb9C@kroah.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <Yjxj02nl+hwoYb9C@kroah.com>
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

Hi Greg,

On 3/24/2022 8:28 PM, Greg Kroah-Hartman wrote:
> On Thu, Mar 24, 2022 at 08:17:29PM +0800, Mao Jinlong wrote:
>> Integration test for tpdm can help to generate the data for
>> verification of the topology during TPDM software bring up.
>>
>> Sample:
>> echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
>> echo 1 > /sys/bus/coresight/devices/tpdm1/enable_source
>> echo 1 > /sys/bus/coresight/devices/tpdm1/integration_test
>> echo 2 > /sys/bus/coresight/devices/tpdm1/integration_test
>> cat /dev/tmc_etf0 > /data/etf-tpdm1.bin
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   drivers/hwtracing/coresight/Kconfig          |  9 ++++
>>   drivers/hwtracing/coresight/coresight-tpdm.c | 56 +++++++++++++++++++-
>>   drivers/hwtracing/coresight/coresight-tpdm.h |  8 +++
>>   3 files changed, 72 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
>> index 5c506a1cd08f..60248fef4089 100644
>> --- a/drivers/hwtracing/coresight/Kconfig
>> +++ b/drivers/hwtracing/coresight/Kconfig
>> @@ -214,4 +214,13 @@ config CORESIGHT_TPDM
>>   	  To compile this driver as a module, choose M here: the module will be
>>   	  called coresight-tpdm.
>>   
>> +config CORESIGHT_TPDM_INTEGRATION_TEST
>> +	bool "Enable CoreSight Integration Test For TPDM"
>> +	depends on CORESIGHT_TPDM
>> +	help
>> +	  This option adds support for the CoreSight integration test on this
>> +	  devie. Coresight architecture provides integration control modes of
>> +	  operation to facilitate integration testing and software bringup
>> +	  and/or to instrument topology discovery. The TPDM utilizes integration
>> +	  mode to accomplish integration testing and software bringup.
> Why is this a Kconfig option?  Why would you never not want this?
I refer to "CONFIG_CORESIGHT_CTI_INTEGRATION_REGS" for integration mode.
>
>>   endif
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index a8d257a591f3..cddd398be0cd 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -124,7 +124,60 @@ static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
>>   			__set_bit(i, drvdata->datasets);
>>   	}
>>   	CS_LOCK(drvdata->base);
>> - }
>> +}
>> +
>> +#ifdef CONFIG_CORESIGHT_TPDM_INTEGRATION_TEST
> Try to keep #ifdefs out of .c files please.
I will check to see if it is possible for the integration test function.
>> +static ssize_t integration_test_store(struct device *dev,
>> +					  struct device_attribute *attr,
>> +					  const char *buf,
>> +					  size_t size)
>> +{
>> +	int i, ret = 0;
>> +	unsigned long val;
>> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +	ret = kstrtoul(buf, 10, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (val != 1 && val != 2)
>> +		return -EINVAL;
>> +
>> +	if (!drvdata->enable)
>> +		return -EINVAL;
>> +
>> +	if (val == 1)
>> +		val = ATBCNTRL_VAL_64;
>> +	else
>> +		val = ATBCNTRL_VAL_32;
>> +	CS_UNLOCK(drvdata->base);
>> +	writel_relaxed(0x1, drvdata->base + TPDM_ITCNTRL);
>> +
>> +	for (i = 1; i < 5; i++)
>> +		writel_relaxed(val, drvdata->base + TPDM_ITATBCNTRL);
>> +
>> +	writel_relaxed(0, drvdata->base + TPDM_ITCNTRL);
>> +	CS_LOCK(drvdata->base);
>> +	return size;
>> +}
>> +static DEVICE_ATTR_WO(integration_test);
>> +#endif /* CORESIGHT_TPDM_INTEGRATION_TEST */
>> +
>> +static struct attribute *tpdm_attrs[] = {
>> +#ifdef CONFIG_CORESIGHT_TPDM_INTEGRATION_TEST
>> +	&dev_attr_integration_test.attr,
>> +#endif /* CORESIGHT_TPDM_INTEGRATION_TEST */
>> +	NULL,
>> +};
>> +
>> +static struct attribute_group tpdm_attr_grp = {
>> +	.attrs = tpdm_attrs,
>> +};
>> +
>> +static const struct attribute_group *tpdm_attr_grps[] = {
>> +	&tpdm_attr_grp,
>> +	NULL,
>> +};
> ATTRIBUTE_GROUPS()?
>
> thanks,
>
> greg k-h

Thanks

Jinlong Mao


