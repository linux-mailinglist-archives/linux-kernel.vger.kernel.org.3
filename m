Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4CF5AC9CF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 07:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbiIEFjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 01:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbiIEFjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 01:39:40 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8428DA473
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 22:39:37 -0700 (PDT)
Received: from [192.168.100.105] (unknown [171.223.99.244])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxPGuSixVj44ARAA--.11094S3;
        Mon, 05 Sep 2022 13:39:31 +0800 (CST)
Message-ID: <b3040de0-9c89-a6ff-517e-6ebec71faaf7@loongson.cn>
Date:   Mon, 5 Sep 2022 13:39:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] LoongArch: Mark kernel stack padding as
 TOP_OF_KERNEL_STACK_PADDING
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, Oleg Nesterov <oleg@redhat.com>,
        loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
References: <1662130897-13156-1-git-send-email-hejinyang@loongson.cn>
 <CAAhV-H4vNpbHbT55z8_ub3q=Kv7eVb--7Q3pXz2te-1DVWhTWA@mail.gmail.com>
From:   Jinyang He <hejinyang@loongson.cn>
In-Reply-To: <CAAhV-H4vNpbHbT55z8_ub3q=Kv7eVb--7Q3pXz2te-1DVWhTWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxPGuSixVj44ARAA--.11094S3
X-Coremail-Antispam: 1UD129KBjvJXoW3JFWfCw17ur4UJF1fAw4xZwb_yoW7uF43pF
        9rA3Z7GF48GF9YyryUtwn8ZFyDJws7Kw129F13KFyrArnFvr1UWr18AFZ8ZF4jqan5Kw40
        gF1SgwnIyay5Ja7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        c2xSY4AK67AK6r4rMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU5l2MUUUUUU==
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/4 20:19, Huacai Chen wrote:

> Hi, Jinyang,
>
> I don't know what scenarios this padding is used and how to use.

To be frankly, I don't know its scenarios on LoongArch. It looks like
the MIPS legacy. This patch only keep this padding, which can be
easily modified if needed in the future. Now we can completely
set it to 0 or remove it.  Actually, it can be thought of as another
buffer for thread_info, while thread_info usually limit to one cache line.

> And
> in x86 there is only TOP_OF_KERNEL_STACK_PADDING but we need
> TOP_OF_KERNEL_STACK_PADDING and _TOP_OF_KERNEL_STACK_PADDING. Two
> macros are hard to maintain.

How about put it into loongarch.h if we need this macro?

Thanks

> On Fri, Sep 2, 2022 at 11:01 PM Jinyang He <hejinyang@loongson.cn> wrote:
>> Mark the top reserved bytes of the kernel stack by a macro. It collects
>> that info so that we can modify or discarded (let it be 0) this padding
>> if needed. Its name is referenced from x86_64. It seems that x86_64
>> think the padding as extension on top of the kernel stack in other mode
>> (normally the top is only pt_regs). Although LoongArch not produce
>> such an extension at present, collect them because of the uncertainty
>> of the future. Note that this patch does not modify macro size. It
>> requires another strict evaluation.
>>
>> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/processor.h  | 3 ++-
>>   arch/loongarch/include/asm/ptrace.h     | 3 ++-
>>   arch/loongarch/include/asm/stackframe.h | 1 +
>>   arch/loongarch/kernel/head.S            | 2 +-
>>   arch/loongarch/kernel/process.c         | 4 ++--
>>   arch/loongarch/kernel/switch.S          | 2 +-
>>   6 files changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/processor.h b/arch/loongarch/include/asm/processor.h
>> index 1c4b43083..6077fd8e3 100644
>> --- a/arch/loongarch/include/asm/processor.h
>> +++ b/arch/loongarch/include/asm/processor.h
>> @@ -193,8 +193,9 @@ static inline void flush_thread(void)
>>
>>   unsigned long __get_wchan(struct task_struct *p);
>>
>> +#define TOP_OF_KERNEL_STACK_PADDING 32
>>   #define __KSTK_TOS(tsk) ((unsigned long)task_stack_page(tsk) + \
>> -                        THREAD_SIZE - 32 - sizeof(struct pt_regs))
>> +                        THREAD_SIZE - TOP_OF_KERNEL_STACK_PADDING - sizeof(struct pt_regs))
>>   #define task_pt_regs(tsk) ((struct pt_regs *)__KSTK_TOS(tsk))
>>   #define KSTK_EIP(tsk) (task_pt_regs(tsk)->csr_era)
>>   #define KSTK_ESP(tsk) (task_pt_regs(tsk)->regs[3])
>> diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
>> index 17838c6b7..cdceeaa60 100644
>> --- a/arch/loongarch/include/asm/ptrace.h
>> +++ b/arch/loongarch/include/asm/ptrace.h
>> @@ -133,7 +133,8 @@ static inline void die_if_kernel(const char *str, struct pt_regs *regs)
>>   #define current_pt_regs()                                              \
>>   ({                                                                     \
>>          unsigned long sp = (unsigned long)__builtin_frame_address(0);   \
>> -       (struct pt_regs *)((sp | (THREAD_SIZE - 1)) + 1 - 32) - 1;      \
>> +       (struct pt_regs *)((sp | (THREAD_SIZE - 1)) + 1 -               \
>> +                          TOP_OF_KERNEL_STACK_PADDING) - 1;            \
>>   })
>>
>>   /* Helpers for working with the user stack pointer */
>> diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
>> index 4ca953062..e9f849b29 100644
>> --- a/arch/loongarch/include/asm/stackframe.h
>> +++ b/arch/loongarch/include/asm/stackframe.h
>> @@ -216,4 +216,5 @@
>>          RESTORE_SP_AND_RET \docfi
>>          .endm
>>
>> +#define _TOP_OF_KERNEL_STACK_PADDING 32
>>   #endif /* _ASM_STACKFRAME_H */
>> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
>> index eb3f641d5..290c53847 100644
>> --- a/arch/loongarch/kernel/head.S
>> +++ b/arch/loongarch/kernel/head.S
>> @@ -75,7 +75,7 @@ SYM_CODE_START(kernel_entry)                  # kernel entry point
>>
>>          la.pcrel        tp, init_thread_union
>>          /* Set the SP after an empty pt_regs.  */
>> -       PTR_LI          sp, (_THREAD_SIZE - 32 - PT_SIZE)
>> +       PTR_LI          sp, (_THREAD_SIZE - _TOP_OF_KERNEL_STACK_PADDING - PT_SIZE)
>>          PTR_ADD         sp, sp, tp
>>          set_saved_sp    sp, t0, t1
>>          PTR_ADDI        sp, sp, -4 * SZREG      # init stack pointer
>> diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
>> index 660492f06..b51cf7975 100644
>> --- a/arch/loongarch/kernel/process.c
>> +++ b/arch/loongarch/kernel/process.c
>> @@ -129,7 +129,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>>          unsigned long clone_flags = args->flags;
>>          struct pt_regs *childregs, *regs = current_pt_regs();
>>
>> -       childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE - 32;
>> +       childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE - TOP_OF_KERNEL_STACK_PADDING;
>>
>>          /* set up new TSS. */
>>          childregs = (struct pt_regs *) childksp - 1;
>> @@ -236,7 +236,7 @@ bool in_task_stack(unsigned long stack, struct task_struct *task,
>>                          struct stack_info *info)
>>   {
>>          unsigned long begin = (unsigned long)task_stack_page(task);
>> -       unsigned long end = begin + THREAD_SIZE - 32;
>> +       unsigned long end = begin + THREAD_SIZE - TOP_OF_KERNEL_STACK_PADDING;
>>
>>          if (stack < begin || stack >= end)
>>                  return false;
>> diff --git a/arch/loongarch/kernel/switch.S b/arch/loongarch/kernel/switch.S
>> index 43ebbc399..1797aceae 100644
>> --- a/arch/loongarch/kernel/switch.S
>> +++ b/arch/loongarch/kernel/switch.S
>> @@ -26,7 +26,7 @@ SYM_FUNC_START(__switch_to)
>>          move    tp, a2
>>          cpu_restore_nonscratch a1
>>
>> -       li.w            t0, _THREAD_SIZE - 32
>> +       li.w            t0, _THREAD_SIZE - _TOP_OF_KERNEL_STACK_PADDING
>>          PTR_ADD         t0, t0, tp
>>          set_saved_sp    t0, t1, t2
>>
>> --
>> 2.31.1
>>

