Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3510E5AC899
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 03:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbiIEBwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 21:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiIEBwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 21:52:30 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC18926555
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 18:52:28 -0700 (PDT)
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxYOJUVhVjeVsRAA--.7257S3;
        Mon, 05 Sep 2022 09:52:21 +0800 (CST)
Subject: Re: [PATCH 1/3] LoongArch: tools: Add relocs tool support
To:     Jinyang He <hejinyang@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        Huacai Chen <chenhuacai@kernel.org>
References: <1662113335-14282-1-git-send-email-tangyouling@loongson.cn>
 <1662113335-14282-2-git-send-email-tangyouling@loongson.cn>
 <c9880165f0355fc3be3ec23153b43ad33e558b5d.camel@xry111.site>
 <4df8a26c49a35c1fce36d80c370f738fa71a2bef.camel@xry111.site>
 <f0e77716-9533-724a-2ea9-86bc5b52066c@loongson.cn>
 <78a4a6b0970c309daa336a2329e69d28df486552.camel@xry111.site>
 <fffdd2ac-4ba6-8eb3-f269-b22a3d9c32f6@loongson.cn>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <a4ca8831-74f5-1ecc-9f04-20aaee202626@loongson.cn>
Date:   Mon, 5 Sep 2022 09:52:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <fffdd2ac-4ba6-8eb3-f269-b22a3d9c32f6@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxYOJUVhVjeVsRAA--.7257S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW8Cw18Kr1DCryxWFyDWrg_yoW5CFWxpr
        W7KF4UKa1kGr1xZa1jqwnYgFyFg3y8WryfWrW5tryFv3Z09Fn3XF18ta1UuFy7Crn2yr1Y
        vFWSyFn7Zr4YyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07Al
        zVAYIcxG8wCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUHpB-UUUUU=
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jinyang

Thank you very much for some ideas.

On 09/04/2022 12:23 AM, Jinyang He wrote:
> On 2022/9/3 18:49, Xi Ruoyao wrote:
>
>> On Sat, 2022-09-03 at 09:57 +0800, Youling Tang wrote:
>>>>> Unlike (pre-r6) MIPS, LoongArch has a complete support for PIC, and
>>>>> currently LoongArch toolchain always produces PIC (except, if
>>>>> -Wa,-mla-
>>>>> {local,global}-with-abs or la.abs macros are used explicitly).
>>>>>
>>>>> So would it be easier to review and correct the uses of "la.abs" in
>>>>> the
>>>>> code, and make the main kernel image a real PIE?  Then we can load it
>>>>> everywhere w/o any need to do relocation at load time.
>>> At the beginning I also wanted to make the main kernel image a real PIE
>>> and tried it, some of the "la.abs" can be modified, but I encountered
>>> difficulties in modifying the  exception handling code part, the kernel
>>> will not  boot after modification :(, I will continue to work hard try.
>> I just tried the same thing and get the same result :(.  Will spend
>> several hours reading the LoongArch manual about exception...
>>
> Hi,
>
> The following ideas are based on experience, without validation. Patches
> show that three types of relocation are needed to be done.
> 1, GOT is generated by toolchain, so  I think eliminating them by
> toolchain is better.
> 2, Ex_table is generated but striped relocation info. We can plays pcrel
> way to resolve this problem. One of ways like follows, (pseudo-code)
>
> arch/loongarch/copy_user.S
> ...
> .macro fixup_ex from, to, offset, fix
> .if \fix
>         .section .fixup, "ax"
> \to:    addi.d  a0, a2, \offset
>         jr      ra
>         .previous
> .endif
>         .section __ex_table, "a"
>         PTR     \from\()b, \to\()b - \from\()b   # fixup use pcrel
>         .previous
> .endm
> ...
> ...
>
> arch/loongarch/mm/extable.c
>         ...
>         unsigned long era = exception_era(regs);
>         fixup = search_exception_tables(era - relocate_offset); //
> Search by orig value
>         if (fixup) {
>                 regs->csr_era = fixup->fixup + era; // Fixup fixup address.
>                 return 1;
>         }
>
>         ...
Yes, we might be able to make the exception table consists of pairs of
relative offsets, like arm64 and riscv do.

Thanks,
Youling.
>
> 3, The left is the processed relocation table. It collect the relocation
> type R_LARCH_ABS* (R_LARCH_MARK_LA?) and R_LARCH_64. Just do
> as this patch does. The la.abs is used because of the different exception
> entry on each CPUs and better NUMA performance IMHO. We can
> do follows way to avoid R_LARCH_ABS* and produce R_LARCH_64, (data in text)
>
> .text
> la.pcrel t0,999f
> ld.d t0,t0,0
> ...
> PTR do_vint
> ...
>
> *Not* important. For me, I really wish a bootstrap relocation while this
> patch is KALSR. The bootstrap relocation meaning is the boot cpu enter
> kernel_entry, check the real address itself, parse the cmdline whether
> do kaslr, and then relocate itself. Then kdump capture process is easier.
> Some past info links,
> https://lore.kernel.org/loongarch/3002b2b3-2c2c-e32e-c474-d3876d3ef9b7@loongson.cn/
>
> https://patchwork.kernel.org/project/linux-mips/patch/1618230494-6207-6-git-send-email-hejinyang@loongson.cn/
>
>
>

