Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0014750CEFD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 05:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbiDXDiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 23:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbiDXDiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 23:38:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9252325D3;
        Sat, 23 Apr 2022 20:35:05 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KmDH13yfMzFr25;
        Sun, 24 Apr 2022 11:32:29 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 24 Apr 2022 11:35:03 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 24 Apr 2022 11:35:03 +0800
Subject: Re: [PATCH 00/20] hwmon: check return value after calling
 platform_get_resource()
To:     Guenter Roeck <linux@roeck-us.net>, <linux-kernel@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>
CC:     <jdelvare@suse.com>
References: <20220422091207.4034406-1-yangyingliang@huawei.com>
 <3896f884-56d9-d0d9-efe6-839c7431e6de@roeck-us.net>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <c40e9bff-e28c-58c3-dc09-1a10f24ad440@huawei.com>
Date:   Sun, 24 Apr 2022 11:35:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3896f884-56d9-d0d9-efe6-839c7431e6de@roeck-us.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/4/22 21:27, Guenter Roeck wrote:
> On 4/22/22 02:11, Yang Yingliang wrote:
>> This patcheset add check after calling platform_get_resource to avoid 
>> null-ptr-deref
>> in drivers/hwmon/.
>>
>> Yang Yingliang (20):
>>    hwmon: (abituguru) check return value after calling
>>      platform_get_resource()
>>    hwmon: (abituguru3) check return value after calling
>>      platform_get_resource()
>>    hwmon: (dme1737) check return value after calling
>>      platform_get_resource()
>>    hwmon: (f71805f) check return value after calling
>>      platform_get_resource()
>>    hwmon: (f71882fg) check return value after calling
>>      platform_get_resource()
>>    hwmon: (it87) check return value after calling 
>> platform_get_resource()
>>    hwmon: (lm78) check return value after calling 
>> platform_get_resource()
>>    hwmon: (nct6683) check return value after calling
>>      platform_get_resource()
>>    hwmon: (nct6775) check return value after calling
>>      platform_get_resource()
>>    hwmon: (sch5627) check return value after calling
>>      platform_get_resource()
>>    hwmon: (sch5636) check return value after calling
>>      platform_get_resource()
>>    hwmon: (sis5595) check return value after calling
>>      platform_get_resource()
>>    hwmon: (smsc47b397) check return value after calling
>>      platform_get_resource()
>>    hwmon: (smsc47m1) check return value after calling
>>      platform_get_resource()
>>    hwmon: (via686a) check return value after calling
>>      platform_get_resource()
>>    hwmon: (vt1211) check return value after calling
>>      platform_get_resource()
>>    hwmon: (vt8231) check return value after calling
>>      platform_get_resource()
>>    hwmon: (w83627ehf) check return value after calling
>>      platform_get_resource()
>>    hwmon: (w83627hf) check return value after calling
>>      platform_get_resource()
>>    hwmon: (w83781d) check return value after calling
>>      platform_get_resource()
>>
>>   drivers/hwmon/abituguru.c  | 6 +++++-
>>   drivers/hwmon/abituguru3.c | 6 +++++-
>>   drivers/hwmon/dme1737.c    | 2 ++
>>   drivers/hwmon/f71805f.c    | 2 ++
>>   drivers/hwmon/f71882fg.c   | 6 +++++-
>>   drivers/hwmon/it87.c       | 2 ++
>>   drivers/hwmon/lm78.c       | 2 ++
>>   drivers/hwmon/nct6683.c    | 2 ++
>>   drivers/hwmon/nct6775.c    | 2 ++
>>   drivers/hwmon/sch5627.c    | 6 +++++-
>>   drivers/hwmon/sch5636.c    | 6 +++++-
>>   drivers/hwmon/sis5595.c    | 2 ++
>>   drivers/hwmon/smsc47b397.c | 2 ++
>>   drivers/hwmon/smsc47m1.c   | 2 ++
>>   drivers/hwmon/via686a.c    | 2 ++
>>   drivers/hwmon/vt1211.c     | 2 ++
>>   drivers/hwmon/vt8231.c     | 2 ++
>>   drivers/hwmon/w83627ehf.c  | 2 ++
>>   drivers/hwmon/w83627hf.c   | 2 ++
>>   drivers/hwmon/w83781d.c    | 2 ++
>>   20 files changed, 55 insertions(+), 5 deletions(-)
>>
>
> This series solves a problem which does not exist in reality and is 
> only theoretic.
> The devices are instantiated from their init functions which always 
> adds the resource.
> Please do not submit such patches.
As you said the resource will be add in init functions, I checked these 
drivers, the driver
sch5627 and sch5636 won't add resource, so need I send patches to fix 
these drivers ?

Thanks,
Yang
>
> Guenter
> .
