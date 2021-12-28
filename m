Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD47648057F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 02:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbhL1Bg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 20:36:57 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17303 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbhL1Bg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 20:36:56 -0500
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JNHDb4YjGz91ys;
        Tue, 28 Dec 2021 09:35:59 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 09:36:54 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 09:36:53 +0800
Message-ID: <8f30057e-da61-55b4-adf7-e35d91798806@huawei.com>
Date:   Tue, 28 Dec 2021 09:36:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: (No subject)
Content-Language: en-US
To:     William Kucharski <william.kucharski@oracle.com>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Matthew Wilcox" <willy@infradead.org>
References: <20211227145903.187152-3-wangkefeng.wang@huawei.com>
 <E2C9DE8E-F5D9-46E9-9298-B632A202B080@oracle.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <E2C9DE8E-F5D9-46E9-9298-B632A202B080@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme702-chm.china.huawei.com (10.1.199.98) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/12/28 1:35, William Kucharski wrote:
> You should also fix the existing typo in the documentation (inline):
>
>> On Dec 27, 2021, at 07:49, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>
>> ﻿This patch select HAVE_ARCH_HUGE_VMALLOC to let arm64 support huge
>> vmalloc mappings.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>> Documentation/admin-guide/kernel-parameters.txt | 4 ++--
>> arch/arm64/Kconfig                              | 1 +
>> arch/arm64/kernel/module.c                      | 5 +++--
>> 3 files changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 7b2f900fd243..e3f9fd7ec106 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1639,7 +1639,7 @@
>>             precedence over memory_hotplug.memmap_on_memory.
>>
>>
>> -    hugevmalloc=    [PPC] Reguires CONFIG_HAVE_ARCH_HUGE_VMALLOC
>> +    hugevmalloc=    [KNL,PPC,ARM64] Reguires CONFIG_HAVE_ARCH_HUGE_VMALLOC
>>             Format: { on | off }
>>             Default set by CONFIG_HUGE_VMALLOC_DEFAULT_ENABLED.
> "Reguires" should be "Requires."
Will fix, thanks.
>
>> @@ -3424,7 +3424,7 @@
>>
>>     nohugeiomap    [KNL,X86,PPC,ARM64] Disable kernel huge I/O mappings.
>>
>> -    nohugevmalloc    [PPC] Disable kernel huge vmalloc mappings.
>> +    nohugevmalloc    [KNL,PPC,ARM64] Disable kernel huge vmalloc mappings.
>>
>>     nosmt        [KNL,S390] Disable symmetric multithreading (SMT).
>>             Equivalent to smt=1.
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 3bb0b67292b5..c34bbb4482b0 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -142,6 +142,7 @@ config ARM64
>>     select HAVE_ARCH_AUDITSYSCALL
>>     select HAVE_ARCH_BITREVERSE
>>     select HAVE_ARCH_COMPILER_H
>> +    select HAVE_ARCH_HUGE_VMALLOC
>>     select HAVE_ARCH_HUGE_VMAP
>>     select HAVE_ARCH_JUMP_LABEL
>>     select HAVE_ARCH_JUMP_LABEL_RELATIVE
>> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
>> index 309a27553c87..af7b4cbace2b 100644
>> --- a/arch/arm64/kernel/module.c
>> +++ b/arch/arm64/kernel/module.c
>> @@ -36,7 +36,8 @@ void *module_alloc(unsigned long size)
>>         module_alloc_end = MODULES_END;
>>
>>     p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
>> -                module_alloc_end, gfp_mask, PAGE_KERNEL, VM_DEFER_KMEMLEAK,
>> +                module_alloc_end, gfp_mask, PAGE_KERNEL,
>> +                VM_DEFER_KMEMLEAK | VM_NO_HUGE_VMAP,
>>                 NUMA_NO_NODE, __builtin_return_address(0));
>>
>>     if (!p && IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
>> @@ -55,7 +56,7 @@ void *module_alloc(unsigned long size)
>>          */
>>         p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
>>                 module_alloc_base + SZ_2G, GFP_KERNEL,
>> -                PAGE_KERNEL, 0, NUMA_NO_NODE,
>> +                PAGE_KERNEL, VM_NO_HUGE_VMAP, NUMA_NO_NODE,
>>                 __builtin_return_address(0));
>>
>>     if (p && (kasan_module_alloc(p, size, gfp_mask) < 0)) {
>> -- 
>> 2.26.2
>>
>>
