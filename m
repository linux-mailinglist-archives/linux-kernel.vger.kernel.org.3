Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C05B57DA17
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 08:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbiGVGNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 02:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiGVGNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 02:13:01 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD2065582
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 23:12:59 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LpzYm0q23z1M8DM;
        Fri, 22 Jul 2022 14:10:04 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Jul 2022 14:12:50 +0800
Subject: Re: [PATCH 3/5] hugetlbfs: remove unneeded header file
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     <akpm@linux-foundation.org>, <songmuchun@bytedance.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220721131637.6306-1-linmiaohe@huawei.com>
 <20220721131637.6306-4-linmiaohe@huawei.com> <Ytne1n5qP3ZEyklB@monkey>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2a72c02e-3a08-dd66-146c-1b4da06951dc@huawei.com>
Date:   Fri, 22 Jul 2022 14:12:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Ytne1n5qP3ZEyklB@monkey>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/22 7:18, Mike Kravetz wrote:
> On 07/21/22 21:16, Miaohe Lin wrote:
>> The header file signal.h is unneeded now. Remove it.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  fs/hugetlbfs/inode.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>> index a10156df5726..aa7a5b8fc724 100644
>> --- a/fs/hugetlbfs/inode.c
>> +++ b/fs/hugetlbfs/inode.c
>> @@ -11,7 +11,6 @@
>>  
>>  #include <linux/thread_info.h>
>>  #include <asm/current.h>
>> -#include <linux/sched/signal.h>		/* remove ASAP */
> 
> I see the original '#include <linux/sched.h>' with this 'remove ASAP' comment
> has been there since the initial git repository build.  No idea why it was
> originally added, and can find no reason for it to be there today.

Me too. This might be a historical vestige.

> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Many thank for your reviewing.

> 

