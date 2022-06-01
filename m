Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5594B539BD1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 05:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349504AbiFADyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 23:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiFADy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:54:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DE255212;
        Tue, 31 May 2022 20:54:26 -0700 (PDT)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LCZxQ6vBnzjXGQ;
        Wed,  1 Jun 2022 11:53:14 +0800 (CST)
Received: from [10.67.111.227] (10.67.111.227) by
 kwepemi500014.china.huawei.com (7.221.188.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 11:54:24 +0800
Subject: Re: linux-next: Tree for May 31 (riscv:
 arch/riscv/kernel/elf_kexec.c)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        <kexec@lists.infradead.org>, Eric Biederman <ebiederm@xmission.com>
References: <20220531145458.39c00988@canb.auug.org.au>
 <8971599c-fc8f-d69c-46b0-07f4c42fb195@infradead.org>
From:   "lizhengyu (E)" <lizhengyu3@huawei.com>
Message-ID: <9292ee27-0ef4-72a5-71ce-7e7336ba563a@huawei.com>
Date:   Wed, 1 Jun 2022 11:54:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8971599c-fc8f-d69c-46b0-07f4c42fb195@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500014.china.huawei.com (7.221.188.232)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 31 May 2022 12:52:28 -0700, Randy Dunlap <rdunlap@infradead.org> 
wrote:
> 838b3e28488f7: RISC-V: Load purgatory in kexec_file
>
>
> On 5/30/22 21:54, Stephen Rothwell wrote:
>> Hi all,
>>
>> Note: please do not add any v5.20 material to your linux-next included
>> branches until after v5.19-rc1 has been related.
>>
>> Changes since 20220527:
>>
> When CONFIG_MODULES is not set/enabled:
> (oh, also CONFIG_MMU is not set)
>
>
> ../arch/riscv/kernel/elf_kexec.c:346:5: error: redefinition of 'arch_kexec_apply_relocations_add'
>    346 | int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>        |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from ../arch/riscv/kernel/elf_kexec.c:17:
> ../include/linux/kexec.h:236:1: note: previous definition of 'arch_kexec_apply_relocations_add' with type 'int(struct purgatory_info *, Elf64_Shdr *, const Elf64_Shdr *, const Elf64_Shdr *)' {aka 'int(struct purgatory_info *, struct elf64_shdr *, const struct elf64_shdr *, const struct elf64_shdr *)'}
>    236 | arch_kexec_apply_relocations_add(struct purgatory_info *pi, Elf_Shdr *section,
>        | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../arch/riscv/kernel/elf_kexec.c: In function 'arch_kexec_apply_relocations_add':
This problem has already solved by Uwe Kleine-König, see 
https://lore.kernel.org/all/20220530074202.pydmbbgvbtaugw5j@pengutronix.de/ 
.
> ../arch/riscv/kernel/elf_kexec.c:353:9: error: unknown type name 'Elf_Rela'; did you mean 'Elf64_Rela'?
>    353 |         Elf_Rela *relas;
>        |         ^~~~~~~~
>        |         Elf64_Rela

Replace Elf_Rela by Elf64_Rela, get

kernel/kexec_core.o: In function `kimage_free':
kexec_core.c:(.text+0xa0c): undefined reference to `machine_kexec_cleanup'
kernel/kexec_core.o: In function `.L0 ':
kexec_core.c:(.text+0xde8): undefined reference to `machine_crash_shutdown'
kexec_core.c:(.text+0xdf4): undefined reference to `machine_kexec'
kernel/kexec_core.o: In function `.L231':
kexec_core.c:(.text+0xe1c): undefined reference to `riscv_crash_save_regs'
kernel/kexec_core.o: In function `.L0 ':
kexec_core.c:(.text+0x119e): undefined reference to `machine_shutdown'
kernel/kexec_core.o: In function `.L312':
kexec_core.c:(.text+0x11b2): undefined reference to `machine_kexec'
kernel/kexec_file.o: In function `.L0 ':
kexec_file.c:(.text+0xb84): undefined reference to `machine_kexec_prepare'
kernel/kexec_file.o: In function `.L177':
kexec_file.c:(.text+0xc5a): undefined reference to `machine_kexec_prepare'

When config KEXEC_FILE=y but config KEXEC is not set.  Fix it by

--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -78,7 +78,7 @@ obj-$(CONFIG_SMP) += cpu_ops_sbi.o
  endif
  obj-$(CONFIG_HOTPLUG_CPU)      += cpu-hotplug.o
  obj-$(CONFIG_KGDB)             += kgdb.o
-obj-$(CONFIG_KEXEC)            += kexec_relocate.o crash_save_regs.o 
machine_kexec.o
+obj-$(CONFIG_KEXEC_CORE)       += kexec_relocate.o crash_save_regs.o 
machine_kexec.o
  obj-$(CONFIG_KEXEC_FILE)       += elf_kexec.o machine_kexec_file.o
  obj-$(CONFIG_CRASH_DUMP)       += crash_dump.o


I will send these patches soon.

> In file included from ../arch/riscv/include/asm/elf.h:11,
>                   from ../include/linux/elf.h:6,
>                   from ../include/linux/module.h:19,
>                   from ../arch/riscv/kernel/elf_kexec.c:15:
> ../arch/riscv/kernel/elf_kexec.c:371:44: error: request for member 'r_info' in something not a structure or union
>    371 |                 sym += ELF64_R_SYM(relas[i].r_info);
>        |                                            ^
> ../include/uapi/linux/elf.h:163:43: note: in definition of macro 'ELF64_R_SYM'
>    163 | #define ELF64_R_SYM(i)                  ((i) >> 32)
>        |                                           ^
> ../arch/riscv/kernel/elf_kexec.c:380:32: error: request for member 'r_offset' in something not a structure or union
>    380 |                 loc += relas[i].r_offset;
>        |                                ^
> ../arch/riscv/kernel/elf_kexec.c:393:32: error: request for member 'r_addend' in something not a structure or union
>    393 |                 val += relas[i].r_addend;
>        |                                ^
> ../arch/riscv/kernel/elf_kexec.c:395:51: error: request for member 'r_offset' in something not a structure or union
>    395 |                 addr = section->sh_addr + relas[i].r_offset;
>        |                                                   ^
> In file included from ../arch/riscv/include/asm/elf.h:11,
>                   from ../include/linux/elf.h:6,
>                   from ../include/linux/module.h:19,
>                   from ../arch/riscv/kernel/elf_kexec.c:15:
> ../arch/riscv/kernel/elf_kexec.c:397:47: error: request for member 'r_info' in something not a structure or union
>    397 |                 r_type = ELF64_R_TYPE(relas[i].r_info);
>        |                                               ^
> ../include/uapi/linux/elf.h:164:43: note: in definition of macro 'ELF64_R_TYPE'
>    164 | #define ELF64_R_TYPE(i)                 ((i) & 0xffffffff)
>        |                                           ^
>
>
> Full randconfig file is attached.
>
