Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A996F584E60
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 11:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbiG2Jt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 05:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235763AbiG2JtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 05:49:25 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E35115004A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 02:49:23 -0700 (PDT)
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxL9MhreNiALxBAA--.46055S3;
        Fri, 29 Jul 2022 17:49:21 +0800 (CST)
Subject: Re: [PATCH v4 0/4] LoongArch: Support new relocation types
To:     Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev
References: <32a74a218c76611f897fd1df1ad0059068621133.camel@xry111.site>
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jinyang He <hejinyang@loongson.cn>
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <ec52fd49-4a30-15d9-3d32-fd7bc6d8b3f0@loongson.cn>
Date:   Fri, 29 Jul 2022 17:49:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <32a74a218c76611f897fd1df1ad0059068621133.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxL9MhreNiALxBAA--.46055S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAFy5Aw45XF4fWF18Jw4kCrg_yoWrJr43pF
        W3Crs3Krs3GrnxXF1Sqw10gF1Ykan7W3yaqFW3t34FyrnxWF18ZFW5tr4DJa47Xw4rKr4F
        gFyFga48uF1UA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUSsjbUUUUU=
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao

Tested this series of patches v3 on a CLFS 5.5 system, using the new
cross toolchain,
$ dmesg | head
[    0.000000] Linux version 5.19.0-rc7new-toolchain+ (loongson@linux) 
(loongarch64-unknown-linux-gnu-gcc (GCC) 13.0.0 20220726 (experimental) 
[master revision 
cf7eac5805e:1e0611b64d8:3fb68f2e666d9de7e0326af9f43b12c9e98f19a6], GNU 
ld (GNU Binutils) 2.39.50.20220726) #1 SMP PREEMPT Fri Jul 29 05:24:15 
EDT 2022

Relocation error when manually loading nf_tables.ko module,
$ sudo modprobe nf_tables
odprobe: ERROR: could not insert 'nf_tables': Exec format error

$ dmesg
[   61.506737] kmod: module nf_tables: PCALA offset = 0x90007ffffed8c000 
does not fit in 32-bit signed and is unsupported by kernel! dangerous 
apply_r_larch_pcala_hi20 (71) relocation

Do you have the same problem over there?

Thanks,
Youling

On 07/29/2022 04:38 PM, Xi Ruoyao wrote:
> The version 2.00 of LoongArch ELF ABI specification introduced new
> relocation types, and the development tree of Binutils and GCC has
> started to use them.  If the kernel is built with the latest snapshot of
> Binutils or GCC, it will fail to load the modules because of unrecognized
> relocation types in modules.
>
> Add support for GOT and new relocation types for the module loader, so
> the kernel (with modules) can be built with the "normal" code model and
> function properly.
>
> This series does not break the compatibility with old toolchain using
> stack-based relocation types, so with the patches applied the kernel can
> be be built with both old and new toolchains.
>
> Tested by building the kernel with both Binutils & GCC master branch and
> my system Binutils & GCC (without new relocation type support), running
> both the builds with 35 in-tree modules loaded, and loading one module
> with 20 GOT loads (loaded addresses verified by comparing with
> /proc/kallsyms).
>
> Changes from v3 to v4:
>
> - No code change.  Reword the commit message of the 3rd patch again
>   based on suggestion from Huacai.
>
> Changes from v2 to v3:
>
> - Use `union loongarch_instruction` instead of explicit bit shifts
>   applying the relocation.  Suggested by Youling.
> - For R_LARCH_B26, move the alignment check before the range check to be
>   consistent with stack pop relocations.  Suggested by Youling.
> - Reword the commit message of the 3rd patch.  Suggested by Huacai.
>
> Changes from v1 to v2:
>
> - Fix a stupid programming error (confusion between the number of PLT
>   entries and the number of GOT entries).  (Bug spotted by Youling).
> - Synthesize the _GLOBAL_OFFSET_TABLE_ symbol with module.lds, instead
>   of faking it at runtime.  The 3rd patch from V1 is now merged into
>   the 1st patch because it would be a one-line change.  (Suggested by
>   Jinyang).
> - Keep reloc_rela_handlers[] ordered by the relocation type ID.
>   (Suggested by Youling).
> - Remove -fplt along with -Wa,-mla-* options because it's the default.
>   (Suggested by Youling).
>
> Xi Ruoyao (4):
>   LoongArch: Add section of GOT for kernel module
>   LoongArch: Support R_LARCH_SOP_PUSH_GPREL relocation type in kernel
>     module
>   LoongArch: Remove -fplt and -Wa,-mla-* from CFLAGS
>   LoongArch: Support modules with new relocation types
>
>  arch/loongarch/Makefile                 |  4 --
>  arch/loongarch/include/asm/elf.h        | 37 ++++++++++
>  arch/loongarch/include/asm/module.h     | 23 ++++++
>  arch/loongarch/include/asm/module.lds.h |  1 +
>  arch/loongarch/kernel/head.S            | 10 +--
>  arch/loongarch/kernel/module-sections.c | 51 +++++++++++--
>  arch/loongarch/kernel/module.c          | 96 +++++++++++++++++++++++++
>  7 files changed, 209 insertions(+), 13 deletions(-)
>

