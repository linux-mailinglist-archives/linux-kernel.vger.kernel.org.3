Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D958522FC7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiEKJqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiEKJpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:45:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8216B23674D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:45:12 -0700 (PDT)
Received: from kwepemi100002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kyqjp1XY3zfbYM;
        Wed, 11 May 2022 17:43:58 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 kwepemi100002.china.huawei.com (7.221.188.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 17:45:10 +0800
Received: from [10.67.110.164] (10.67.110.164) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 17:45:10 +0800
Subject: Re: [PATCH -next] xtensa/simdisk: fix error handling in
 proc_read_simdisk()
To:     Max Filippov <jcmvbkbc@gmail.com>
CC:     Chris Zankel <chris@zankel.net>, Al Viro <viro@zeniv.linux.org.uk>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, <wangweiyang2@huawei.com>
References: <20220510080533.51032-1-yiyang13@huawei.com>
 <CAMo8BfJr1jSr-K8tOFb6Qkco1L1om2oP30rKt2X+RdCQgOWKSw@mail.gmail.com>
From:   "yiyang (D)" <yiyang13@huawei.com>
Message-ID: <82bf69b5-e5f6-ba08-f40e-299e9a8c7aee@huawei.com>
Date:   Wed, 11 May 2022 17:45:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAMo8BfJr1jSr-K8tOFb6Qkco1L1om2oP30rKt2X+RdCQgOWKSw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.164]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/11 17:04, Max Filippov 写道:
> Hi Yi,
> 
> On Tue, May 10, 2022 at 1:07 AM Yi Yang <yiyang13@huawei.com> wrote:
>>
>> The frist simple_read_from_buffer() will change ppos. if ppos >= 1.
>> The second simple_read_from_buffer() will does not work and return 0.
>>
>> Fixes: a69755b18774 ("xtensa simdisk: switch to proc_create_data()")
>> Signed-off-by: Yi Yang <yiyang13@huawei.com>
>> ---
>>   arch/xtensa/platforms/iss/simdisk.c | 18 +++++++++++++-----
>>   1 file changed, 13 insertions(+), 5 deletions(-)
> 
> Thank you for the fix. I've rearranged the patch a bit, expanding the commit
> message and fixing the build warning that it introduced and have posted v2.
> If there's no objections to it I'll add it to my xtensa tree.
> 

The patch is very nice. Thank for you .

-- 
Yi
