Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDF1587563
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 04:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbiHBCBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 22:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbiHBCB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 22:01:26 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFABA18E3C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 19:01:22 -0700 (PDT)
Received: from [10.130.0.63] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx4M5rhehieO0AAA--.5051S3;
        Tue, 02 Aug 2022 10:01:16 +0800 (CST)
Subject: Re: [PATCH 3/4] LoongArch: Add stacktrace support
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jinyang He <hejinyang@loongson.cn>
References: <20220801121726.9681-1-zhangqing@loongson.cn>
 <20220801121726.9681-4-zhangqing@loongson.cn>
 <CAAhV-H6Az_X1afvAO+JxnDaW-Ey_8wmozehd++qOZoGmimM+6g@mail.gmail.com>
 <3cc6aebc-87e7-f0d0-2a88-e7e742e1e5ee@loongson.cn>
 <CAAhV-H61ZXvF2xvXsyrxRYj6impet0w83svkt94FUhJhzj-2EQ@mail.gmail.com>
From:   Qing Zhang <zhangqing@loongson.cn>
Message-ID: <59d9ef26-d378-b311-82a9-95fc8d14a8a6@loongson.cn>
Date:   Tue, 2 Aug 2022 10:01:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H61ZXvF2xvXsyrxRYj6impet0w83svkt94FUhJhzj-2EQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dx4M5rhehieO0AAA--.5051S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF15Ar13AFW5JrWkZFW7twb_yoW5Kr43pF
        ykAF1DGF4kGryfCryavw1j9r1Utwn7Gr12qF9rKFy5ArnFvF12qr4kGF1DuFWjqws8GayI
        9FWfKrZIg3WUJw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07Al
        zVAYIcxG8wCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjfUOyCGUUUUU
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/2 上午9:30, Huacai Chen wrote:
> Hi, Qing,
> 
> On Tue, Aug 2, 2022 at 9:20 AM zhangqing <zhangqing@loongson.cn> wrote:
>>
>>
>>
>> On 2022/8/1 下午11:30, Huacai Chen wrote:
>>> Hi, Qing,
>>>
>>> On Mon, Aug 1, 2022 at 8:17 PM Qing Zhang <zhangqing@loongson.cn> wrote:
>>>>
>>>> Use common arch_stack_walk infrastructure to avoid duplicated code and
>>>> avoid taking care of the stack storage and filtering.
>>>> Add sra (means __schedule return address) and scfa (means __schedule call
>>>> frame address) to thread_info and store it in switch_to().
>>>>
>>>> Now we can print the process stack by cat /proc/*/stack and can better
>>>> support ftrace.
>>>>
>>>> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
>>>> ---
>>>>    arch/loongarch/Kconfig                 |  5 ++++
>>>>    arch/loongarch/include/asm/processor.h |  9 +++++++
>>>>    arch/loongarch/include/asm/switch_to.h | 14 ++++++----
>>>>    arch/loongarch/include/asm/uaccess.h   |  4 +--
>>>>    arch/loongarch/kernel/Makefile         |  1 +
>>>>    arch/loongarch/kernel/asm-offsets.c    |  2 ++
>>>>    arch/loongarch/kernel/process.c        |  3 +++
>>>>    arch/loongarch/kernel/stacktrace.c     | 37 ++++++++++++++++++++++++++
>>>>    arch/loongarch/kernel/switch.S         |  2 ++
>>>>    9 files changed, 70 insertions(+), 7 deletions(-)
>>>>    create mode 100644 arch/loongarch/kernel/stacktrace.c
>>>>
>>>> diff --git a/arch/loongarch/include/asm/uaccess.h b/arch/loongarch/include/asm/uaccess.h
>>>> index 2b44edc604a2..a8ae2af4025a 100644
>>>> --- a/arch/loongarch/include/asm/uaccess.h
>>>> +++ b/arch/loongarch/include/asm/uaccess.h
>>>> @@ -229,13 +229,13 @@ extern unsigned long __copy_user(void *to, const void *from, __kernel_size_t n);
>>>>    static inline unsigned long __must_check
>>>>    raw_copy_from_user(void *to, const void __user *from, unsigned long n)
>>>>    {
>>>> -       return __copy_user(to, from, n);
>>>> +       return __copy_user(to, (__force const void *)from, n);
>>>>    }
>>>>
>>>>    static inline unsigned long __must_check
>>>>    raw_copy_to_user(void __user *to, const void *from, unsigned long n)
>>>>    {
>>>> -       return __copy_user(to, from, n);
>>>> +       return __copy_user((__force void *)to, from, n);
>>> Why this? Does it have something to do with stacktrace?
>>>
>>> Huacai
>>
>> Hi, huacai
>>
>> This is kernel test robot report sparse warnings:
>> I reproduced locally and found that other architectures calling
>> __copy_user also use __force conversion, Is this modification appropriate?
>>
>> kernel/trace/trace_events_user.c: note: in included file (through
>> include/linux/uaccess.h, include/linux/sched/task.h,
>> include/linux/sched/signal.h, ...):
>>      arch/loongarch/include/asm/uaccess.h:232:32: sparse: sparse:
>> incorrect type in argument 2 (different address spaces) @@     expected
>> void const *from @@     got void const [noderef] __user *from @@
>>      arch/loongarch/include/asm/uaccess.h:232:32: sparse:     expected
>> void const *from
>>      arch/loongarch/include/asm/uaccess.h:232:32: sparse:     got void
>> const [noderef] __user *from
> The modification might be correct, but should it be in this patch?
> 
> Huacai
I will send this patch separately,  it has nothing to do with the series 
patch.

arch/loongarch/kernel/ptrace.c: note: in included file (through 
include/linux/uaccess.h, include/linux/sched/task.h, 
include/linux/sched/signal.h, include/linux/ptrace.h, include/linux/audit.h)

-Qing
>>
>> Thanks,
>> -Qing
>>
>>
>>

