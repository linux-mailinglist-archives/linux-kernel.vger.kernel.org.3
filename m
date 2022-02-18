Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419A34BAF3F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 02:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiBRBty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 20:49:54 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiBRBtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 20:49:53 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF8ABF52
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 17:49:36 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K0F2M3T1mz9sht;
        Fri, 18 Feb 2022 09:47:55 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Feb 2022 09:49:34 +0800
Subject: Re: [PATCH] mm/mmu_notifiers: use helper function
 mmu_notifier_synchronize()
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220217110948.35477-1-linmiaohe@huawei.com>
 <20220217155012.GC1037534@ziepe.ca>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <4c7074b4-5d84-d690-d14a-18c06eacc7a0@huawei.com>
Date:   Fri, 18 Feb 2022 09:49:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220217155012.GC1037534@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
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

On 2022/2/17 23:50, Jason Gunthorpe wrote:
> On Thu, Feb 17, 2022 at 07:09:48PM +0800, Miaohe Lin wrote:
>> Use helper function mmu_notifier_synchronize() to ensure all mmu_notifiers
>> are freed. Minor readability improvement.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/mmu_notifier.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> I'm not keen on this, the internal synchronize_srcu's don't have the
> same usage model as described in the comment for
> mmu_notifier_synchronize(). Instead they are doing what their comments
> say.
> 
> Yes, it is the same code, but the purpose is different.
> 

Yep, this is my overlook. Many thanks for reply.

> Jason
> .
> 

