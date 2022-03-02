Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B0D4C9AB7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 02:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbiCBBvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 20:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiCBBvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 20:51:39 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01810A2531;
        Tue,  1 Mar 2022 17:50:55 -0800 (PST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxSs15zR5iIvgAAA--.3690S3;
        Wed, 02 Mar 2022 09:50:50 +0800 (CST)
Subject: Re: [PATCH v4 0/4] MIPS: Modify mem= and memmap= parameter
To:     Mike Rapoport <rppt@kernel.org>
References: <1646108941-27919-1-git-send-email-yangtiezhu@loongson.cn>
 <Yh3tgr+g/6IElq0P@kernel.org>
 <cfd74b5b-39c3-733a-5226-515991f91f39@loongson.cn>
 <Yh4uUoYT+YS5Jxsv@kernel.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <8956c625-c18d-846e-3e65-7920776b27f3@loongson.cn>
Date:   Wed, 2 Mar 2022 09:50:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <Yh4uUoYT+YS5Jxsv@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9AxSs15zR5iIvgAAA--.3690S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyxZw43Zw1DAr4rZr1rtFb_yoWrCw4fpr
        WSqa4Igr4kJryUZr1xtw1xJr9Iy395CF1vqry2yrn3u3Z0yr1xJr18Ja1j9asrA345Ja4q
        vr48tF9F93WUA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
        4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE
        67vIY487MxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
        73UjIFyTuYvjfUFVyIUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/01/2022 10:31 PM, Mike Rapoport wrote:
> On Tue, Mar 01, 2022 at 07:51:23PM +0800, Tiezhu Yang wrote:
>>
>>
>> On 03/01/2022 05:55 PM, Mike Rapoport wrote:
>>> Hi,
>>>
>>> On Tue, Mar 01, 2022 at 12:28:57PM +0800, Tiezhu Yang wrote:
>>>> In the current code, the kernel command-line parameter mem= and memmap=
>>>> can not work well on MIPS, this patchset refactors the related code to
>>>> fix them.
>>>>
>>>> For kdump on MIPS, if the users want to limit the memory region for the
>>>> capture kernel to avoid corrupting the memory image of the panic kernel,
>>>> use the parameter memmap=limit@base is the proper way, I will submit a
>>>> patch to use memmap=limit@base for kexec-tools after this patchset is
>>>> applied.
>>>
>>> Sorry, apparently I misread the prevoius version.
>>> What's wrong with the current implementation of mem=limit@base for the
>>> kdump case?
>>
>> In the current code, without this patchset, kernel boot hangs when add
>> mem=3G, mem=3G@64M or memmap=3G@64M to the command-line, it means that
>> the parameter mem= and memmap= have bug on mips.
>
> I can see how mem=3G may be wrong when the memory does not start at 0, but
> it seems to do the right thing of mem=3G@64M.
>
> Do you see system hangs with mem=3G@64M?

Yes.

>
> Do you have the logs before the hang?

Here are the logs:

[    0.000000] Linux version 5.17.0-rc3+ (loongson@linux) (gcc (GCC) 
7.3.1 20180303 (Red Hat 7.3.1-6), GNU ld version 
2.28-13.fc21.loongson.6) #1 SMP PREEMPT Wed Mar 2 09:07:39 CST 2022
[    0.000000] CpuClock = 1800000000
[    0.000000] The bridge chip is LS7A
[    0.000000] CP0_Config3: CP0 16.3 (0xdc8030a0)
[    0.000000] CP0_PageGrain: CP0 5.1 (0x28000000)
[    0.000000] NUMA: Discovered 4 cpus on 1 nodes
[    0.000000] Node0: mem_type:1, mem_start:0x200000, mem_size:0xee MB
[    0.000000]        start_pfn:0x80, end_pfn:0x3c00, num_physpages:0x3b80
[    0.000000] Node0: mem_type:2, mem_start:0x90200000, mem_size:0x6fe MB
[    0.000000]        start_pfn:0x24080, end_pfn:0x40000, 
num_physpages:0x1fb00
[    0.000000] Node0: mem_type:2, mem_start:0x120000000, mem_size:0x1600 MB
[    0.000000]        start_pfn:0x48000, end_pfn:0xa0000, 
num_physpages:0x77b00
[    0.000000] Node0's addrspace_offset is 0x0
[    0.000000] Node0: start_pfn=0x80, end_pfn=0xa0000
[    0.000000] NUMA: set cpumask cpu 0 on node 0
[    0.000000] NUMA: set cpumask cpu 1 on node 0
[    0.000000] NUMA: set cpumask cpu 2 on node 0
[    0.000000] NUMA: set cpumask cpu 3 on node 0
[    0.000000] printk: bootconsole [early0] enabled
[    0.000000] CPU0 revision is: 0014c001 (ICT Loongson-3)
[    0.000000] FPU revision is: 00f70501
[    0.000000] MSA revision is: 00060140
[    0.000000] OF: fdt: No chosen node found, continuing without
[    0.000000] MIPS: machine is loongson,loongson64g-4core-ls7a
[    0.000000] User-defined physical RAM map overwrite
[    0.000000] Kernel sections are not in the memory maps
[    0.000000] Initrd not found or empty - disabling initrd


>
> As for memmap= option, it does not specify the memory map but rather alters
> the memory map passed by the firmware. Particularity in MIPS implementation
> it allows to add a single range of available or reserved memory.
>
> AFAIU, for the kdump use-case mem=X@Y should suffice.

We can modify some code to make mem=X@Y work well,
but according to Documentation/admin-guide/kernel-parameters.txt,
the common way is mem=X and memmap=X@Y, so mem=X@Y for mips seems
odd, the intention of this patchset is to make mem= and memmap=
work well and consistent with the other archs.

Thanks,
Tiezhu

>
>> Thanks,
>> Tiezhu
>>
>>>
>>>> v4: Fix some build warnings reported by kernel test robot
>>>>
>>>> v3: Modify patch #3 to maintain compatibility for memmap=limit{$,#,!}base,
>>>>     commented by Mike Rapoport, thank you
>>>>
>>>> v2: Add some new patches to support memmap=limit@base
>>>>
>>>> Tiezhu Yang (4):
>>>>   MIPS: Refactor early_parse_mem() to fix mem= parameter
>>>>   memblock: Introduce memblock_mem_range_remove_map()
>>>>   MIPS: Refactor early_parse_memmap() to fix memmap= parameter
>>>>   MIPS: Remove not used variable usermem
>>>>
>>>>  arch/mips/kernel/setup.c | 69 ++++++++++++++++++++++--------------------------
>>>>  include/linux/memblock.h |  1 +
>>>>  mm/memblock.c            |  9 +++++--
>>>>  3 files changed, 40 insertions(+), 39 deletions(-)
>>>>
>>>> --
>>>> 2.1.0
>>>>
>>>
>>
>

