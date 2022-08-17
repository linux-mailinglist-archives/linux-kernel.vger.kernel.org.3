Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B875966FB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 03:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238389AbiHQBrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 21:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbiHQBrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 21:47:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D27979F6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 18:47:05 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M6rRm0p5wzmVqK;
        Wed, 17 Aug 2022 09:44:52 +0800 (CST)
Received: from dggpeml500002.china.huawei.com (7.185.36.158) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 09:47:03 +0800
Received: from [10.67.101.90] (10.67.101.90) by dggpeml500002.china.huawei.com
 (7.185.36.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 17 Aug
 2022 09:47:03 +0800
Subject: Re: [PATCH v8 1/2] drivers/coresight: Add UltraSoc System Memory
 Buffer driver
To:     Randy Dunlap <rdunlap@infradead.org>, <mathieu.poirier@linaro.org>,
        <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <leo.yan@linaro.org>
References: <20220816131634.38195-1-hejunhao3@huawei.com>
 <20220816131634.38195-2-hejunhao3@huawei.com>
 <071ecdab-98a8-1f3b-a442-26668b2da446@infradead.org>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <liuqi115@huawei.com>, <f.fangjian@huawei.com>,
        <prime.zeng@hisilicon.com>
From:   hejunhao <hejunhao3@huawei.com>
Message-ID: <7607df0c-0c47-1cfc-bc8b-6490bbf9eecf@huawei.com>
Date:   Wed, 17 Aug 2022 09:47:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <071ecdab-98a8-1f3b-a442-26668b2da446@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.90]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/17 2:00, Randy Dunlap wrote:

Hi Randy,

Thanks for your comments.

> Hi--
>
> On 8/16/22 06:16, Junhao He wrote:
>> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
>> index 514a9b8086e3..4380eb1a0a73 100644
>> --- a/drivers/hwtracing/coresight/Kconfig
>> +++ b/drivers/hwtracing/coresight/Kconfig
>> @@ -201,4 +201,14 @@ config CORESIGHT_TRBE
>>   
>>   	  To compile this driver as a module, choose M here: the module will be
>>   	  called coresight-trbe.
> Please insert a blank line here like it is done elsewhere.

I will fix it in the next version.
Thanks.

>> +config ULTRASOC_SMB
>> +	tristate "Ultrasoc system memory buffer drivers"
>> +	depends on ACPI && ARM64 && CORESIGHT_LINKS_AND_SINKS
>> +	help
>> +	  This driver provides support for the Ultrasoc system memory buffer (SMB).
>> +	  SMB is responsible for receiving the trace data from Coresight ETM devices
>> +	  and storing them to a system buffer.
>> +
>> +	  To compile this driver as a module, choose M here: the module will be
>> +	  called ultrasoc-smb.
>>   endif
> thanks.

Regards,
Junhao.

