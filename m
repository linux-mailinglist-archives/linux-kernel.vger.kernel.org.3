Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEA85ADF65
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 08:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbiIFGJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 02:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiIFGJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 02:09:39 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BA8D6279
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 23:09:36 -0700 (PDT)
Received: from [192.168.100.101] (unknown [171.223.99.244])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxvmsb5BZjvHsSAA--.64189S3;
        Tue, 06 Sep 2022 14:09:31 +0800 (CST)
Message-ID: <b8963a16-436b-912b-6b2b-2b12f448748d@loongson.cn>
Date:   Tue, 6 Sep 2022 14:09:31 +0800
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
 <b3040de0-9c89-a6ff-517e-6ebec71faaf7@loongson.cn>
 <CAAhV-H5PA6n9a8A9unEitXEowUMEkrrHQoJXdBoOLZJ559-UDg@mail.gmail.com>
From:   Jinyang He <hejinyang@loongson.cn>
In-Reply-To: <CAAhV-H5PA6n9a8A9unEitXEowUMEkrrHQoJXdBoOLZJ559-UDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Dxvmsb5BZjvHsSAA--.64189S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw47Jw48KFW8tr4xGFWrGrg_yoW3GF15pF
        9rA3ZrGF4UWF1Fyryjqwn8ZFyDtwsrKw12g3W3K34SyrnFvF1UWr10yFWDuF1jqw1kKF40
        gF1Fqwsavay5Ja7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU92b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY
        1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_GF1l42xK82IYc2Ij64vIr41l4I8I3I0E4I
        kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
        WwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
        0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
        JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYx
        BIdaVFxhVjvjDU0xZFpf9x07bFyCAUUUUU=
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Huacai,

On 2022/9/5 14:21, Huacai Chen wrote:
> Hi, Jinyang,
>
> On Mon, Sep 5, 2022 at 1:39 PM Jinyang He <hejinyang@loongson.cn> wrote:
>> On 2022/9/4 20:19, Huacai Chen wrote:
>>
>>> Hi, Jinyang,
>>>
>>> I don't know what scenarios this padding is used and how to use.
>> To be frankly, I don't know its scenarios on LoongArch. It looks like
>> the MIPS legacy. This patch only keep this padding, which can be
>> easily modified if needed in the future. Now we can completely
>> set it to 0 or remove it.  Actually, it can be thought of as another
>> buffer for thread_info, while thread_info usually limit to one cache line.
> We should make it clear how MIPS use it at least, then we can make a
> decision whether to remove it or not, otherwise it may break
> something.
I think it is related to shadow parameters area of MIPS o32 Calling 
Convention.
This happened a long time ago, starting is 24, then 4*SZREG, and now 32.
But there are few commit-logs I can find. See links. I guess these changes
are due to the ABI, the macro SZREG in [2] is referenced to check stack
alignment. And pt_regs and sigframe also have padding. If we can't find
what will be broken, then we should cancel it rather than keeping it.
We wouldn't have these paddings if we weren't inspired by MIPS.

[1] https://elixir.bootlin.com/linux/1.1.82/source/arch/mips/kernel/head.S
[2] https://elixir.bootlin.com/linux/2.1.44/source/arch/mips/kernel/head.S
[3] https://elixir.bootlin.com/linux/2.1.73/source/arch/mips/kernel/head.S
[4] 
https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit?id=484889fc85a223ef56edc31828b86751b2296b7c
>>> And
>>> in x86 there is only TOP_OF_KERNEL_STACK_PADDING but we need
>>> TOP_OF_KERNEL_STACK_PADDING and _TOP_OF_KERNEL_STACK_PADDING. Two
>>> macros are hard to maintain.
>> How about put it into loongarch.h if we need this macro?
> That is good because we only need one macro, but you can research
> whether there is a better place.

As asm and C code need it, how about put it in output_thread_info_defines?

Thanks,

Jinyang

>>> On Fri, Sep 2, 2022 at 11:01 PM Jinyang He <hejinyang@loongson.cn> wrote:
>>>> Mark the top reserved bytes of the kernel stack by a macro. It collects
>>>> that info so that we can modify or discarded (let it be 0) this padding
>>>> if needed. Its name is referenced from x86_64. It seems that x86_64
>>>> think the padding as extension on top of the kernel stack in other mode
>>>> (normally the top is only pt_regs). Although LoongArch not produce
>>>> such an extension at present, collect them because of the uncertainty
>>>> of the future. Note that this patch does not modify macro size. It
>>>> requires another strict evaluation.
>>>>
>>>> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
>>>> ---
>>>>    arch/loongarch/include/asm/processor.h  | 3 ++-
>>>>    arch/loongarch/include/asm/ptrace.h     | 3 ++-
>>>>    arch/loongarch/include/asm/stackframe.h | 1 +
>>>>    arch/loongarch/kernel/head.S            | 2 +-
>>>>    arch/loongarch/kernel/process.c         | 4 ++--
>>>>    arch/loongarch/kernel/switch.S          | 2 +-
>>>>    6 files changed, 9 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/arch/loongarch/include/asm/processor.h b/arch/loongarch/include/asm/processor.h
>>>> index 1c4b43083..6077fd8e3 100644
>>>> --- a/arch/loongarch/include/asm/processor.h
>>>> +++ b/arch/loongarch/include/asm/processor.h
>>>> @@ -193,8 +193,9 @@ static inline void flush_thread(void)
>>>>
>>>>    unsigned long __get_wchan(struct task_struct *p);
>>>>
>>>> +#define TOP_OF_KERNEL_STACK_PADDING 32
>>>>    #define __KSTK_TOS(tsk) ((unsigned long)task_stack_page(tsk) + \
>>>> -                        THREAD_SIZE - 32 - sizeof(struct pt_regs))
>>>> +                        THREAD_SIZE - TOP_OF_KERNEL_STACK_PADDING - sizeof(struct pt_regs))
>>>>    #define task_pt_regs(tsk) ((struct pt_regs *)__KSTK_TOS(tsk))
>>>>    #define KSTK_EIP(tsk) (task_pt_regs(tsk)->csr_era)
>>>>    #define KSTK_ESP(tsk) (task_pt_regs(tsk)->regs[3])
>>>> diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
>>>> index 17838c6b7..cdceeaa60 100644
>>>> --- a/arch/loongarch/include/asm/ptrace.h
>>>> +++ b/arch/loongarch/include/asm/ptrace.h
>>>> @@ -133,7 +133,8 @@ static inline void die_if_kernel(const char *str, struct pt_regs *regs)
>>>>    #define current_pt_regs()                                              \
>>>>    ({                                                                     \
>>>>           unsigned long sp = (unsigned long)__builtin_frame_address(0);   \
>>>> -       (struct pt_regs *)((sp | (THREAD_SIZE - 1)) + 1 - 32) - 1;      \
>>>> +       (struct pt_regs *)((sp | (THREAD_SIZE - 1)) + 1 -               \
>>>> +                          TOP_OF_KERNEL_STACK_PADDING) - 1;            \
>>>>    })
>>>>
>>>>    /* Helpers for working with the user stack pointer */
>>>> diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
>>>> index 4ca953062..e9f849b29 100644
>>>> --- a/arch/loongarch/include/asm/stackframe.h
>>>> +++ b/arch/loongarch/include/asm/stackframe.h
>>>> @@ -216,4 +216,5 @@
>>>>           RESTORE_SP_AND_RET \docfi
>>>>           .endm
>>>>
>>>> +#define _TOP_OF_KERNEL_STACK_PADDING 32
>>>>    #endif /* _ASM_STACKFRAME_H */
>>>> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
>>>> index eb3f641d5..290c53847 100644
>>>> --- a/arch/loongarch/kernel/head.S
>>>> +++ b/arch/loongarch/kernel/head.S
>>>> @@ -75,7 +75,7 @@ SYM_CODE_START(kernel_entry)                  # kernel entry point
>>>>
>>>>           la.pcrel        tp, init_thread_union
>>>>           /* Set the SP after an empty pt_regs.  */
>>>> -       PTR_LI          sp, (_THREAD_SIZE - 32 - PT_SIZE)
>>>> +       PTR_LI          sp, (_THREAD_SIZE - _TOP_OF_KERNEL_STACK_PADDING - PT_SIZE)
>>>>           PTR_ADD         sp, sp, tp
>>>>           set_saved_sp    sp, t0, t1
>>>>           PTR_ADDI        sp, sp, -4 * SZREG      # init stack pointer
>>>> diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
>>>> index 660492f06..b51cf7975 100644
>>>> --- a/arch/loongarch/kernel/process.c
>>>> +++ b/arch/loongarch/kernel/process.c
>>>> @@ -129,7 +129,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>>>>           unsigned long clone_flags = args->flags;
>>>>           struct pt_regs *childregs, *regs = current_pt_regs();
>>>>
>>>> -       childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE - 32;
>>>> +       childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE - TOP_OF_KERNEL_STACK_PADDING;
>>>>
>>>>           /* set up new TSS. */
>>>>           childregs = (struct pt_regs *) childksp - 1;
>>>> @@ -236,7 +236,7 @@ bool in_task_stack(unsigned long stack, struct task_struct *task,
>>>>                           struct stack_info *info)
>>>>    {
>>>>           unsigned long begin = (unsigned long)task_stack_page(task);
>>>> -       unsigned long end = begin + THREAD_SIZE - 32;
>>>> +       unsigned long end = begin + THREAD_SIZE - TOP_OF_KERNEL_STACK_PADDING;
>>>>
>>>>           if (stack < begin || stack >= end)
>>>>                   return false;
>>>> diff --git a/arch/loongarch/kernel/switch.S b/arch/loongarch/kernel/switch.S
>>>> index 43ebbc399..1797aceae 100644
>>>> --- a/arch/loongarch/kernel/switch.S
>>>> +++ b/arch/loongarch/kernel/switch.S
>>>> @@ -26,7 +26,7 @@ SYM_FUNC_START(__switch_to)
>>>>           move    tp, a2
>>>>           cpu_restore_nonscratch a1
>>>>
>>>> -       li.w            t0, _THREAD_SIZE - 32
>>>> +       li.w            t0, _THREAD_SIZE - _TOP_OF_KERNEL_STACK_PADDING
>>>>           PTR_ADD         t0, t0, tp
>>>>           set_saved_sp    t0, t1, t2
>>>>
>>>> --
>>>> 2.31.1
>>>>

