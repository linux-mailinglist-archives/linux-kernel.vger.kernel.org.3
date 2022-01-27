Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F8B49D774
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 02:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiA0BYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 20:24:09 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:32062 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiA0BYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 20:24:08 -0500
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JkjST73cHz1FCyj;
        Thu, 27 Jan 2022 09:20:09 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 09:24:05 +0800
Received: from [10.174.177.69] (10.174.177.69) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 09:24:04 +0800
Message-ID: <675f7ef8-4c59-cfb4-1c46-39c3e7ea27db@huawei.com>
Date:   Thu, 27 Jan 2022 09:24:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: "blk-mq: fix tag_get wait task can't be awakened" causes hangs
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-block@vger.kernel.org>
CC:     <john.garry@huawei.com>, <ming.lei@redhat.com>,
        <martin.petersen@oracle.com>, <hare@suse.de>,
        <akpm@linux-foundation.org>, <bvanassche@acm.org>,
        <linux-kernel@vger.kernel.org>
References: <1643040870.3bwvk3sis4.none.ref@localhost>
 <1643040870.3bwvk3sis4.none@localhost>
 <78cafe94-a787-e006-8851-69906f0c2128@huawei.com>
 <723815a5-f716-499a-acce-15028a629f3a@kernel.dk>
From:   QiuLaibin <qiulaibin@huawei.com>
In-Reply-To: <723815a5-f716-499a-acce-15028a629f3a@kernel.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.69]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

On 2022/1/26 21:38, Jens Axboe wrote:
> On 1/24/22 9:08 PM, QiuLaibin wrote:
>> Hi Alex
>>
>> 1、Please help to import this structure:
>>
>> blk_mq_tags <= request_queue->blk_mq_hw_ctx->blk_mq_tags
>>
>> If there is no kernel dump, help to see the value of
>>
>> cat /sys/block/sda/mq/0/nr_tags
>>                  __ <= Change it to the problem device
>>
>> And how many block devices in total by lsblk.
>>
>> 2、Please describe in detail how to reproduce the issue,
>>
>> And what type of USB device?
>>
>> 3、Please help to try the attachment patch and see if it can be reproduced.
> 
> Any progress on this? I strongly suspect that any QD=1 setup would
> trivially show the issue, based on the reports.
Yes, QD = 1 from Alex Xu's must-see environment. I'm trying to build a 
must-see locally, and I will submit the repaired patch as soon as possible.

> 

BR
Laibin
