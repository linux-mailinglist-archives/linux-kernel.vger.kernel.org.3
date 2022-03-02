Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA0D4CA0B5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbiCBJ3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiCBJ3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:29:20 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D7FA2B253;
        Wed,  2 Mar 2022 01:28:35 -0800 (PST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxsM67OB9iLz8BAA--.6653S3;
        Wed, 02 Mar 2022 17:28:27 +0800 (CST)
Subject: Re: [PATCH v4 0/4] MIPS: Modify mem= and memmap= parameter
To:     Mike Rapoport <rppt@kernel.org>
References: <1646108941-27919-1-git-send-email-yangtiezhu@loongson.cn>
 <Yh3tgr+g/6IElq0P@kernel.org>
 <cfd74b5b-39c3-733a-5226-515991f91f39@loongson.cn>
 <Yh4uUoYT+YS5Jxsv@kernel.org>
 <8956c625-c18d-846e-3e65-7920776b27f3@loongson.cn>
 <Yh8kzK7TM7EhaKEQ@kernel.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <ab104917-d370-cbf3-6017-6e8e40221860@loongson.cn>
Date:   Wed, 2 Mar 2022 17:28:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <Yh8kzK7TM7EhaKEQ@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9BxsM67OB9iLz8BAA--.6653S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw1xKFy3Kry3tw17Jr18Xwb_yoW3CrWfpF
        WxX3Wjgr4kJryUAr1xtw17Jr9Iy34FkF1DXr13trn7Z3Z8trnrJw1UJr1Uua47Ary5JF1q
        vF48tF9F9w4UAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxkIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JU4BT5UUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/02/2022 04:03 PM, Mike Rapoport wrote:
> On Wed, Mar 02, 2022 at 09:50:49AM +0800, Tiezhu Yang wrote:
>>
>>
>> On 03/01/2022 10:31 PM, Mike Rapoport wrote:
>>> On Tue, Mar 01, 2022 at 07:51:23PM +0800, Tiezhu Yang wrote:
>>>>
>>>>
>>>> On 03/01/2022 05:55 PM, Mike Rapoport wrote:
>>>>> Hi,
>>>>>
>>>>> On Tue, Mar 01, 2022 at 12:28:57PM +0800, Tiezhu Yang wrote:
>>>>>> In the current code, the kernel command-line parameter mem= and memmap=
>>>>>> can not work well on MIPS, this patchset refactors the related code to
>>>>>> fix them.
>>>>>>
>>>>>> For kdump on MIPS, if the users want to limit the memory region for the
>>>>>> capture kernel to avoid corrupting the memory image of the panic kernel,
>>>>>> use the parameter memmap=limit@base is the proper way, I will submit a
>>>>>> patch to use memmap=limit@base for kexec-tools after this patchset is
>>>>>> applied.
>>>>>
>>>>> Sorry, apparently I misread the prevoius version.
>>>>> What's wrong with the current implementation of mem=limit@base for the
>>>>> kdump case?
>>>>
>>>> In the current code, without this patchset, kernel boot hangs when add
>>>> mem=3G, mem=3G@64M or memmap=3G@64M to the command-line, it means that
>>>> the parameter mem= and memmap= have bug on mips.
>>>
>>> I can see how mem=3G may be wrong when the memory does not start at 0, but
>>> it seems to do the right thing of mem=3G@64M.
>>>
>>> Do you see system hangs with mem=3G@64M?
>>
>> Yes.
>>
>>>
>>> Do you have the logs before the hang?
>>
>> Here are the logs:
>>
>> [    0.000000] Linux version 5.17.0-rc3+ (loongson@linux) (gcc (GCC) 7.3.1
>> 20180303 (Red Hat 7.3.1-6), GNU ld version 2.28-13.fc21.loongson.6) #1 SMP
>> PREEMPT Wed Mar 2 09:07:39 CST 2022
>> [    0.000000] CpuClock = 1800000000
>> [    0.000000] The bridge chip is LS7A
>> [    0.000000] CP0_Config3: CP0 16.3 (0xdc8030a0)
>> [    0.000000] CP0_PageGrain: CP0 5.1 (0x28000000)
>> [    0.000000] NUMA: Discovered 4 cpus on 1 nodes
>> [    0.000000] Node0: mem_type:1, mem_start:0x200000, mem_size:0xee MB
>> [    0.000000]        start_pfn:0x80, end_pfn:0x3c00, num_physpages:0x3b80
>> [    0.000000] Node0: mem_type:2, mem_start:0x90200000, mem_size:0x6fe MB
>> [    0.000000]        start_pfn:0x24080, end_pfn:0x40000,
>> num_physpages:0x1fb00
>> [    0.000000] Node0: mem_type:2, mem_start:0x120000000, mem_size:0x1600 MB
>> [    0.000000]        start_pfn:0x48000, end_pfn:0xa0000,
>> num_physpages:0x77b00
>> [    0.000000] Node0's addrspace_offset is 0x0
>> [    0.000000] Node0: start_pfn=0x80, end_pfn=0xa0000
>> [    0.000000] NUMA: set cpumask cpu 0 on node 0
>> [    0.000000] NUMA: set cpumask cpu 1 on node 0
>> [    0.000000] NUMA: set cpumask cpu 2 on node 0
>> [    0.000000] NUMA: set cpumask cpu 3 on node 0
>> [    0.000000] printk: bootconsole [early0] enabled
>> [    0.000000] CPU0 revision is: 0014c001 (ICT Loongson-3)
>> [    0.000000] FPU revision is: 00f70501
>> [    0.000000] MSA revision is: 00060140
>> [    0.000000] OF: fdt: No chosen node found, continuing without
>> [    0.000000] MIPS: machine is loongson,loongson64g-4core-ls7a
>> [    0.000000] User-defined physical RAM map overwrite
>> [    0.000000] Kernel sections are not in the memory maps
>> [    0.000000] Initrd not found or empty - disabling initrd
>
> Can you please also send the log with "memblock=debug" added to the kernel
> command line?

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
[    0.000000] memblock_add: [0x0000000000200000-0x000000000231185f] 
setup_arch+0x140/0x794
[    0.000000] memblock_reserve: [0x0000000001260520-0x0000000001262560] 
setup_arch+0x148/0x794
[    0.000000] Initrd not found or empty - disabling initrd
[    0.000000] memblock_alloc_try_nid: 8257 bytes align=0x40 nid=-1 
from=0x0000000000000000 max_addr=0x0000000000000000 
early_init_dt_alloc_memory_arch+0x30/0x60
[    0.000000] memblock_reserve: [0x0000000004000000-0x0000000004002040] 
memblock_alloc_range_nid+0xf0/0x178
[    0.000000] memblock_alloc_try_nid: 37972 bytes align=0x8 nid=-1 
from=0x0000000000000000 max_addr=0x0000000000000000 
early_init_dt_alloc_memory_arch+0x30/0x60
[    0.000000] memblock_reserve: [0x0000000004002048-0x000000000400b49b] 
memblock_alloc_range_nid+0xf0/0x178

>
>>> As for memmap= option, it does not specify the memory map but rather alters
>>> the memory map passed by the firmware. Particularity in MIPS implementation
>>> it allows to add a single range of available or reserved memory.
>>>
>>> AFAIU, for the kdump use-case mem=X@Y should suffice.
>>
>> We can modify some code to make mem=X@Y work well,
>> but according to Documentation/admin-guide/kernel-parameters.txt,
>> the common way is mem=X and memmap=X@Y, so mem=X@Y for mips seems
>> odd, the intention of this patchset is to make mem= and memmap=
>> work well and consistent with the other archs.
>
> These options are anyway not consistent on different architectures.
> arm, mips and x86 implement mem= one way and arm64, powerpc and riscv in
> another so there is no common way to use mem=.
>
> Your changes will break the existing systems that use mem= and memmap=
> options because they change the semantics of their MIPS implementation.

Thank you, I know your opinion.
Let's wait for Thomas's review to get some more feedbacks.

Thanks,
Tiezhu

>
> For kexec/kdump use-cases modern architectures usually do not pass mem= but
> rather prepare the memory map for the kexeced kernel to use. I believe this
> would be the right solution.
>
>> Thanks,
>> Tiezhu
>>
>>>
>>>> Thanks,
>>>> Tiezhu
>>>>
>>>>>
>>>>>> v4: Fix some build warnings reported by kernel test robot
>>>>>>
>>>>>> v3: Modify patch #3 to maintain compatibility for memmap=limit{$,#,!}base,
>>>>>>     commented by Mike Rapoport, thank you
>>>>>>
>>>>>> v2: Add some new patches to support memmap=limit@base
>>>>>>
>>>>>> Tiezhu Yang (4):
>>>>>>   MIPS: Refactor early_parse_mem() to fix mem= parameter
>>>>>>   memblock: Introduce memblock_mem_range_remove_map()
>>>>>>   MIPS: Refactor early_parse_memmap() to fix memmap= parameter
>>>>>>   MIPS: Remove not used variable usermem
>>>>>>
>>>>>>  arch/mips/kernel/setup.c | 69 ++++++++++++++++++++++--------------------------
>>>>>>  include/linux/memblock.h |  1 +
>>>>>>  mm/memblock.c            |  9 +++++--
>>>>>>  3 files changed, 40 insertions(+), 39 deletions(-)
>>>>>>
>>>>>> --
>>>>>> 2.1.0
>>>>>>
>>>>>
>>>>
>>>
>>
>

