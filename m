Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4424847D117
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244712AbhLVLf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:35:28 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4318 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236667AbhLVLf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:35:26 -0500
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JJrjl1Wg8z67b01;
        Wed, 22 Dec 2021 19:30:51 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Wed, 22 Dec 2021 12:35:24 +0100
Received: from [10.195.32.222] (10.195.32.222) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 11:35:23 +0000
Subject: Re: [PATCH RFT] blk-mq: optimize queue tag busy iter for shared_tags
To:     Kashyap Desai <kashyap.desai@broadcom.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ming.lei@redhat.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
References: <20211221123157.14052-1-kashyap.desai@broadcom.com>
 <e9174a89-b3a4-d737-c5a9-ff3969053479@huawei.com>
 <7028630054e9cd0e8c84670a27c2b164@mail.gmail.com>
 <e7288bcd-cc4d-8f57-a0c8-eadd53732177@huawei.com>
 <c26b40bac76ec1bfbab2419aece544ca@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e50cfdcd-110b-d778-6e3f-edfed9b1c5a4@huawei.com>
Date:   Wed, 22 Dec 2021 11:35:22 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <c26b40bac76ec1bfbab2419aece544ca@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.32.222]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2021 11:20, Kashyap Desai wrote:
> Yes, above is the same changes I was looking for. I did very basic mistake.
> I applied your above commit while doing megaraid_sas testing.
>   While I move to mpi3mr testing, I did not apply your patch set. 

But I did not think that my patch would help mpi3mr since it does not 
use host_tagset.

> We can drop
> request of this RFT since I tested above series and it serve the same
> purpose.

ok, fine.

And just to confirm, do you now think that we need to fix any older 
kernel with some backport of my changes? I think that we would just need 
to consider 5.16 (when it becomes stable), 5.15, and and 5.10

Thanks,
John
