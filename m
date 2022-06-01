Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032F4539A97
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 03:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348892AbiFABFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 21:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348866AbiFABFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 21:05:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554B94ECDE
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 18:05:51 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LCW8f5kbPzRhXZ;
        Wed,  1 Jun 2022 09:02:42 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 09:05:29 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 09:05:28 +0800
Message-ID: <01b16b0a-ab3b-08e2-b141-2a2cbd89466f@huawei.com>
Date:   Wed, 1 Jun 2022 09:05:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 4/6] mm: ioremap: Add arch_ioremap/iounmap()
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>
References: <20220519082552.117736-1-wangkefeng.wang@huawei.com>
 <20220519082552.117736-5-wangkefeng.wang@huawei.com>
 <CAK8P3a1DbNY6NzcwzjVFvd9yw6L3YBHQos_hmE=nG=6cuv1DAg@mail.gmail.com>
 <4c848b48-6ddf-664a-6296-d85ab49a694d@huawei.com>
 <CAK8P3a19S8CFxJKQo_8UXSKA0L8J40DsjL+u649oDhqUPHSW7A@mail.gmail.com>
 <f9bbfe38-ce1d-b4c4-6acf-4b81e6587e2d@huawei.com>
 <YpWx7w01ySsqECmE@infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <YpWx7w01ySsqECmE@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/5/31 14:13, Christoph Hellwig wrote:
> On Tue, May 24, 2022 at 10:53:54PM +0800, Kefeng Wang wrote:
>> Christoph  suggested in the first version,
>>
>> https://lore.kernel.org/linux-arm-kernel/Ymq2uX%2FY15HlIpo7@infradead.org/
> Yeah, mostly to eventually also covers mips.  But if this causes
> problems now please just dumb it down and we can revisit the interface
> when actually needed.
> .
OK， will rethink the return value and resend after 5.19-rc1， thanks all.
