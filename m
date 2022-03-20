Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36BA4E19FE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 06:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbiCTFea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 01:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiCTFe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 01:34:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11D62630;
        Sat, 19 Mar 2022 22:33:00 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KLmZQ6QXRzfZ8X;
        Sun, 20 Mar 2022 13:31:26 +0800 (CST)
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 20 Mar 2022 13:32:57 +0800
Received: from [10.174.177.133] (10.174.177.133) by
 dggpemm500015.china.huawei.com (7.185.36.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 20 Mar 2022 13:32:57 +0800
Subject: Re: [PATCH 1/2] iio:filter:admv8818: Add depends on REGMAP
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
CC:     "cj.chengjian@huawei.com" <cj.chengjian@huawei.com>,
        "liwei391@huawei.com" <liwei391@huawei.com>,
        "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
References: <20220318025914.2614812-1-bobo.shaobowang@huawei.com>
 <20220318025914.2614812-2-bobo.shaobowang@huawei.com>
 <PH0PR03MB678617206D33B41868D565B499139@PH0PR03MB6786.namprd03.prod.outlook.com>
From:   "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Message-ID: <2781b5e5-ad45-cd90-4bbb-813672098807@huawei.com>
Date:   Sun, 20 Mar 2022 13:32:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <PH0PR03MB678617206D33B41868D565B499139@PH0PR03MB6786.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.133]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2022/3/18 16:45, Sa, Nuno Ð´µÀ:
> Hi Wang,
>
> Thanks for the patch
>
>> -----Original Message-----
>> From: Wang ShaoBo <bobo.shaobowang@huawei.com>
>> Sent: Friday, March 18, 2022 3:59 AM
>> Cc: cj.chengjian@huawei.com; liwei391@huawei.com;
>> bobo.shaobowang@huawei.com; Miclaus, Antoniu
>> <Antoniu.Miclaus@analog.com>; linux-iio@vger.kernel.org; linux-
>> kernel@vger.kernel.org; jic23@kernel.org;
>> Jonathan.Cameron@huawei.com
>> Subject: [PATCH 1/2] iio:filter:admv8818: Add depends on REGMAP
>>
>> [External]
>>
>> Add "depends on REGMAP" to CONFIG_ADMV8818, because
>> admv8818 driver
>> uses structure/symbols such as 'struct regmap_config' which are
>> defined
>> only when CONFIG_REGMAP is set.
>>
>> Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for ADMV8818")
>> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
>> ---
>>   drivers/iio/filter/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/filter/Kconfig b/drivers/iio/filter/Kconfig
>> index 3ae35817ad82..4bbf10f8692c 100644
>> --- a/drivers/iio/filter/Kconfig
>> +++ b/drivers/iio/filter/Kconfig
>> @@ -7,7 +7,7 @@ menu "Filters"
>>
>>   config ADMV8818
>>   	tristate "Analog Devices ADMV8818 High-Pass and Low-Pass
>> Filter"
>> -	depends on SPI && COMMON_CLK && 64BIT
>> +	depends on REGMAP && SPI && COMMON_CLK && 64BIT
> I think the best way is to have select REGMAP_SPI. Hence:
>
>      depends on SPI && COMMON_CLK && 64BIT
>      select REGMAP_SPI
>
> This will automatically default CONFIG_REGMAP to y. with your
> patch, I guess we can still have issues with ' __devm_regmap_init_spi()'
>
> - Nuno S¨¢
> .

Yes, only set REGMAP but REGMAP_SPI may causing __devm_regmap_init_spi 
undeined.

-- wangshaobo

