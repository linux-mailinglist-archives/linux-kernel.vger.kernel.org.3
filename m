Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EF850F037
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 07:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240267AbiDZFlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 01:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236170AbiDZFlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 01:41:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6184829801
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 22:38:09 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KnVy25GdFzfbCX;
        Tue, 26 Apr 2022 13:37:14 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 13:38:07 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 13:38:06 +0800
Message-ID: <a5b58a66-bdc3-94df-6af5-c647da888c17@huawei.com>
Date:   Tue, 26 Apr 2022 13:38:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] mm: use pgprot_val to get value of pgprot
Content-Language: en-US
To:     liusongtang <liusongtang@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <nixiaoming@huawei.com>, <young.liuyang@huawei.com>,
        <trivial@kernel.org>
References: <20220425081736.249130-1-liusongtang@huawei.com>
 <f9e48ed2-0e90-1a2d-c62e-739c33c4cc53@arm.com>
 <22536b1c-f38d-45b1-8187-636c158b8e4b@huawei.com>
 <a22d0e25-cc72-3cf8-c893-e962c0001028@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <a22d0e25-cc72-3cf8-c893-e962c0001028@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/4/25 21:48, liusongtang wrote:
> OK, Shall I add "Suggested-by: Kefeng Wang 
> <wangkefeng.wang@huawei.com>" to these patches?
>
It is unnecessary ；）

> On 2022/4/25 18:40, Kefeng Wang wrote:
>>
>> On 2022/4/25 18:29, Anshuman Khandual wrote:
>>> Should have added 'memory_hotplug' in the subject line. Otherwise
>>> this does not specify where the change is (neither does the commit
>>> message below).
>>>
>>> mm/memory_hotplug: use pgprot_val to get value of pgprot
>>
>>
>> $ git grep "pgprot\.pgprot"
>> arch/ia64/mm/init.c:    if (WARN_ON_ONCE(params->pgprot.pgprot != 
>> PAGE_KERNEL.pgprot))
>> arch/s390/mm/init.c:    if (WARN_ON_ONCE(params->pgprot.pgprot != 
>> PAGE_KERNEL.pgprot))
>> arch/sh/mm/init.c:      if (WARN_ON_ONCE(params->pgprot.pgprot != 
>> PAGE_KERNEL.pgprot))
>> mm/memory_hotplug.c:    if (WARN_ON_ONCE(!params->pgprot.pgprot))
>>
>> You can change other's codes too.
>>
