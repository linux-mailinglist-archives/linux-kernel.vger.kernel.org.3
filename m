Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2E2462CB4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhK3GZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:25:33 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:27317 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbhK3GZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:25:31 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J3Bvb1MkNzbjFD;
        Tue, 30 Nov 2021 14:22:03 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 30 Nov 2021 14:22:09 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Tue, 30 Nov 2021 14:22:08 +0800
Message-ID: <35e4a4cb-29f2-2de6-6350-1358d4968a54@huawei.com>
Date:   Tue, 30 Nov 2021 14:22:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH RFC 1/4] mm: percpu: Generalize percpu related config
Content-Language: en-US
To:     Dennis Zhou <dennis@kernel.org>
CC:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <tj@kernel.org>,
        <gregkh@linuxfoundation.org>, <cl@linux.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <tsbogend@alpha.franken.de>, <mpe@ellerman.id.au>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <davem@davemloft.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-ia64@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
        <sparclinux@vger.kernel.org>, <x86@kernel.org>
References: <20211121093557.139034-1-wangkefeng.wang@huawei.com>
 <20211121093557.139034-2-wangkefeng.wang@huawei.com>
 <YaVV38QSn6LEBKH/@fedora>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <YaVV38QSn6LEBKH/@fedora>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/11/30 6:36, Dennis Zhou wrote:
> Hello,
>
> On Sun, Nov 21, 2021 at 05:35:54PM +0800, Kefeng Wang wrote:
>> The HAVE_SETUP_PER_CPU_AREA/NEED_PER_CPU_EMBED_FIRST_CHUNK/
>> NEED_PER_CPU_PAGE_FIRST_CHUNK/USE_PERCPU_NUMA_NODE_ID configs,
>> which has duplicate definitions on platforms that subscribe it.
>>
>> Move them into mm, drop these redundant definitions and instead
>> just select it on applicable platforms.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   arch/arm64/Kconfig   | 20 ++++----------------
>>   arch/ia64/Kconfig    |  9 ++-------
>>   arch/mips/Kconfig    | 10 ++--------
>>   arch/powerpc/Kconfig | 17 ++++-------------
>>   arch/riscv/Kconfig   | 10 ++--------
>>   arch/sparc/Kconfig   | 12 +++---------
>>   arch/x86/Kconfig     | 17 ++++-------------
>>   mm/Kconfig           | 12 ++++++++++++
>>   8 files changed, 33 insertions(+), 74 deletions(-)
...
>>
> This makes sense and looks good. A series like this is a little tricky.
> The latter patches change the contracts so it'd be easiest to run it
> through my tree. We'd need to get explicit acks from each arch
> maintainer to make sure they're fine with this.

Got it, I will resend without RFC and hope to get ACKs from related arch 
maintainers.


>
> Thanks,
> Dennis
> .
