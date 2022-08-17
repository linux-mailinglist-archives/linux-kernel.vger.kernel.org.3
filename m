Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110DD5970A6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239890AbiHQOFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiHQOEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:04:52 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD7266A65;
        Wed, 17 Aug 2022 07:04:10 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M78rV4shxz67Pn6;
        Wed, 17 Aug 2022 22:03:54 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 16:04:08 +0200
Received: from [10.48.158.152] (10.48.158.152) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 15:04:07 +0100
Message-ID: <743867a6-b266-58e4-a8a6-542757916f0a@huawei.com>
Date:   Wed, 17 Aug 2022 15:04:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [ata] 0568e61225: stress-ng.copy-file.ops_per_sec -15.0%
 regression
To:     Oliver Sang <oliver.sang@intel.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <linux-ide@vger.kernel.org>, <lkp@lists.01.org>, <lkp@intel.com>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <zhengjun.xing@linux.intel.com>, <fengwei.yin@intel.com>
References: <1f498d4a-f93f-ceb4-b713-753196e5e08d@opensource.wdc.com>
 <3451fa5a-6229-073f-ae18-0c232cd48ed5@huawei.com>
 <e4106ffa-3842-45c0-9756-5226cfcfa17d@opensource.wdc.com>
 <YvXeuCAK780OuJPz@xsang-OptiPlex-9020>
 <2e9cf5a6-c043-5ccf-e363-097c6c941891@huawei.com>
 <f1c3d717-339d-ba2b-9775-fc0e00f57ae3@huawei.com>
 <Yvs/w93KUkgD9f7/@xsang-OptiPlex-9020>
 <aabf7ed8-8d4d-dc68-1b8b-c91653701def@huawei.com>
 <43eaa104-5b09-072c-56aa-6289569b0015@opensource.wdc.com>
 <28d6e48b-f52f-9467-8260-262504a1a1ff@huawei.com>
 <YvzyZJUblfqN6Xj3@xsang-OptiPlex-9020>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <YvzyZJUblfqN6Xj3@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.158.152]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2022 14:51, Oliver Sang wrote:

Hi Oliver,

>> v5.19 + 0568e61225 : 512/512
>> v5.19 + 0568e61225 + 4cbfca5f77 : 512/512
>> v5.19: 1280/32767
>>
>> They are want makes sense to me, at least.
>>
>> Oliver, can you confirm this? Thanks!
> I confirm below two:
> v5.19 + 0568e61225 : 512/512
> v5.19: 1280/32767 (as last already reported)

ack

> 
> but below failed to build:
> v5.19 + 0568e61225 + 4cbfca5f77
> 
> build_errors:
>    - "drivers/scsi/scsi_transport_sas.c:242:33: error: implicit declaration of function 'dma_opt_mapping_size'; did you mean 'dma_max_mapping_size'? [-Werror=implicit-function-declaration]"
>    - "drivers/scsi/scsi_transport_sas.c:241:24: error: 'struct Scsi_Host' has no member named 'opt_sectors'; did you mean 'max_sectors'?"
> 
> not sure if I understand this correctly?
> for this, I just cherry-pick 0568e61225 upon v5.19,
> then cherry-pick 4cbfca5f77 again.
> so my branch looks like:
> 
> a11d8b97c3ecb8 v5.19 + 0568e61225 + 4cbfca5f77
> 1b59440cf71f99 v5.19 + 0568e61225
> 3d7cb6b04c3f31 (tag: v5.19,
> 
> did I do the right thing?

Sorry but I was not really interested in 4cbfca5f77 and I see where that 
build error is coming, but don't be concerned with it. However, for 
avoidance of doubt, if you have results for vanilla v6.0-rc1 then that 
would be appreciated.

I will also send a separate patch for testing if you don't mind.

thanks,
John

