Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BFC46D3F8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbhLHNIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:08:34 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4233 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhLHNId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:08:33 -0500
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J8HMy27vdz67rqf;
        Wed,  8 Dec 2021 21:00:46 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 14:04:59 +0100
Received: from [10.47.91.245] (10.47.91.245) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 8 Dec
 2021 13:04:59 +0000
Subject: Re: [PATCH RFT 0/3] blk-mq: Optimise blk_mq_queue_tag_busy_iter() for
 shared tags
To:     Kashyap Desai <kashyap.desai@broadcom.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ming.lei@redhat.com>, <hare@suse.de>
References: <1635852455-39935-1-git-send-email-john.garry@huawei.com>
 <7fba1b1e-63a6-6315-e5ca-6d5ae9de6dbb@huawei.com>
 <b18285f4aa0e8be796aea19cdfde0293@mail.gmail.com>
 <9859e133-e3b8-4e53-dfad-cbf75ed3102f@huawei.com>
 <9b092ca49e9b5415772cd950a3c12584@mail.gmail.com>
 <fbdf64cd-7d31-f470-b93c-5b42a1e1cf40@huawei.com>
 <e6069080-61e7-4345-8ff3-a26756a1c76c@huawei.com>
 <205b1962196d64a93184dc4023499e2e@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ef0df45a-f248-b729-5fef-393efe68b205@huawei.com>
Date:   Wed, 8 Dec 2021 13:04:40 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <205b1962196d64a93184dc4023499e2e@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.91.245]
X-ClientProxiedBy: lhreml724-chm.china.huawei.com (10.201.108.75) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2021 10:03, Kashyap Desai wrote:
>> note: I will now resend for 5.17 and add your tested-by, please let me
>> know if
>> unhappy about that.
> John - 5.17 should be OK. I am doing additional testing and so far no issue.
> 
> Tested-by: Kashyap Desai<kashyap.desai@broadcom.com>
> 

Hi Kashyap,

On a related topic, you mentioned in an earlier discussion another 
possible regression you saw around 5.11 or 5.12, unrelated to shared 
tags transition:
https://lore.kernel.org/linux-block/e4e92abbe9d52bcba6b8cc6c91c442cc@mail.gmail.com/

Did you come to any conclusion on that?

Thanks,
John
