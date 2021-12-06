Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F00469313
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241658AbhLFKBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 05:01:24 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4197 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241662AbhLFKBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 05:01:23 -0500
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J6zMw5682z67LSP;
        Mon,  6 Dec 2021 17:56:12 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 10:57:52 +0100
Received: from [10.47.82.161] (10.47.82.161) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 6 Dec
 2021 09:57:52 +0000
Subject: Re: [PATCH RFT 0/3] blk-mq: Optimise blk_mq_queue_tag_busy_iter() for
 shared tags
From:   John Garry <john.garry@huawei.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ming.lei@redhat.com>, <hare@suse.de>
References: <1635852455-39935-1-git-send-email-john.garry@huawei.com>
 <7fba1b1e-63a6-6315-e5ca-6d5ae9de6dbb@huawei.com>
 <b18285f4aa0e8be796aea19cdfde0293@mail.gmail.com>
 <9859e133-e3b8-4e53-dfad-cbf75ed3102f@huawei.com>
 <9b092ca49e9b5415772cd950a3c12584@mail.gmail.com>
 <fbdf64cd-7d31-f470-b93c-5b42a1e1cf40@huawei.com>
Message-ID: <e6069080-61e7-4345-8ff3-a26756a1c76c@huawei.com>
Date:   Mon, 6 Dec 2021 09:57:39 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <fbdf64cd-7d31-f470-b93c-5b42a1e1cf40@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.82.161]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2021 11:51, John Garry wrote:
>> This patch set improves above call trace even after disk_util=0 is set.
> ok, fine. Thanks for testing.
> 
> So I guess that this is a regression, and you would want this series for 
> v5.16, right? My changes were made with v5.17 in mind.
> 
> I am not sure how Jens feels about it, since the changes are 
> significant. It would be a lot easier to argue for v5.16 if we got to 
> this point earlier in the cycle...
> 

note: I will now resend for 5.17 and add your tested-by, please let me 
know if unhappy about that.

> Anyway, it would be good to have full review first, so please help with 
> that.
> 
> @Ming, can you please give feedback on 3/3 here?

Thanks and also to Hannes for the reviews.

john
