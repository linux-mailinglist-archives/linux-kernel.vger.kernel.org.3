Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4EE5576B8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiFWJf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiFWJf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:35:57 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F09904969B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:35:55 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxaeT6M7RiVkRWAA--.36340S3;
        Thu, 23 Jun 2022 17:35:54 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Make compute_return_era() return void
To:     Huacai Chen <chenhuacai@kernel.org>
References: <1655541551-3997-1-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H5oaCnRyi0xpzzoUs-VemuQtSEStHHzerZFoAQmEabCdw@mail.gmail.com>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        LKML <linux-kernel@vger.kernel.org>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <c9123763-a72e-ce2a-83e3-b3e46cec15b3@loongson.cn>
Date:   Thu, 23 Jun 2022 17:35:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5oaCnRyi0xpzzoUs-VemuQtSEStHHzerZFoAQmEabCdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9BxaeT6M7RiVkRWAA--.36340S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4ktF1kKw17WF18WFyUZFb_yoW8Cw13pF
        17AFyDCFWrWr95CFyDtwn8Zry7Jrs3Cr4293Z29asYkF42vr1DXr10grsrZF10yayrKr40
        qF4rKF1a9F43X3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUOo7ZUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/23/2022 05:26 PM, Huacai Chen wrote:
> Hi, Tiezhu,
>
> On Sat, Jun 18, 2022 at 4:39 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> compute_return_era() always returns 0, make it return void,
>> and then no need to check its return value for its callers.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>  arch/loongarch/include/asm/branch.h | 3 +--
>>  arch/loongarch/kernel/traps.c       | 3 +--
>>  2 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/branch.h b/arch/loongarch/include/asm/branch.h
>> index 3f33c89..9a133e4 100644
>> --- a/arch/loongarch/include/asm/branch.h
>> +++ b/arch/loongarch/include/asm/branch.h
>> @@ -12,10 +12,9 @@ static inline unsigned long exception_era(struct pt_regs *regs)
>>         return regs->csr_era;
>>  }
>>
>> -static inline int compute_return_era(struct pt_regs *regs)
>> +static inline void compute_return_era(struct pt_regs *regs)
>>  {
>>         regs->csr_era += 4;
>> -       return 0;
>>  }
>>
>>  #endif /* _ASM_BRANCH_H */
>> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
>> index e4060f8..1bf58c6 100644
>> --- a/arch/loongarch/kernel/traps.c
>> +++ b/arch/loongarch/kernel/traps.c
>> @@ -475,8 +475,7 @@ asmlinkage void noinstr do_ri(struct pt_regs *regs)
>>
>>         die_if_kernel("Reserved instruction in kernel code", regs);
>>
>> -       if (unlikely(compute_return_era(regs) < 0))
>> -               goto out;
>> +       compute_return_era(regs);
> Maybe it is better to simply remove the compute_return_era() function?

Good idea, if so, I think we can also remove exception_era(), and then
arch/loongarch/include/asm/branch.h can be removed.

If you are OK, I will send a v2 patch to remove
arch/loongarch/include/asm/branch.h

Thanks,
Tiezhu

>
> Huacai
>>
>>         if (unlikely(get_user(opcode, era) < 0)) {
>>                 status = SIGSEGV;
>> --
>> 2.1.0
>>

