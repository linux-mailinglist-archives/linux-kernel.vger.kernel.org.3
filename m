Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8E45ABFC8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 18:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiICQXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 12:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiICQXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 12:23:50 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5E053DF28
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 09:23:48 -0700 (PDT)
Received: from [192.168.100.107] (unknown [171.223.97.96])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx9OGHfxNjBIUQAA--.3628S3;
        Sun, 04 Sep 2022 00:23:36 +0800 (CST)
Message-ID: <fffdd2ac-4ba6-8eb3-f269-b22a3d9c32f6@loongson.cn>
Date:   Sun, 4 Sep 2022 00:23:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] LoongArch: tools: Add relocs tool support
Content-Language: en-US
To:     Xi Ruoyao <xry111@xry111.site>,
        Youling Tang <tangyouling@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <1662113335-14282-1-git-send-email-tangyouling@loongson.cn>
 <1662113335-14282-2-git-send-email-tangyouling@loongson.cn>
 <c9880165f0355fc3be3ec23153b43ad33e558b5d.camel@xry111.site>
 <4df8a26c49a35c1fce36d80c370f738fa71a2bef.camel@xry111.site>
 <f0e77716-9533-724a-2ea9-86bc5b52066c@loongson.cn>
 <78a4a6b0970c309daa336a2329e69d28df486552.camel@xry111.site>
From:   Jinyang He <hejinyang@loongson.cn>
In-Reply-To: <78a4a6b0970c309daa336a2329e69d28df486552.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx9OGHfxNjBIUQAA--.3628S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW8Xr4UZry5Ww4ruFWkXrb_yoW5CFW8pr
        W8GF1UK3ykGr1xXw4jqw1UWryrW3y8W343GFW5tFyFv3WY9F1qqr10qF4j9ryUJr4kJr4Y
        qr1aqr18Zrn8Ar7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
        6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r1j6r
        4UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxv
        r21lc2xSY4AK67AK6r1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf
        9x0JUeGQDUUUUU=
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/3 18:49, Xi Ruoyao wrote:

> On Sat, 2022-09-03 at 09:57 +0800, Youling Tang wrote:
>>>> Unlike (pre-r6) MIPS, LoongArch has a complete support for PIC, and
>>>> currently LoongArch toolchain always produces PIC (except, if -Wa,-mla-
>>>> {local,global}-with-abs or la.abs macros are used explicitly).
>>>>
>>>> So would it be easier to review and correct the uses of "la.abs" in the
>>>> code, and make the main kernel image a real PIE?  Then we can load it
>>>> everywhere w/o any need to do relocation at load time.
>> At the beginning I also wanted to make the main kernel image a real PIE
>> and tried it, some of the "la.abs" can be modified, but I encountered
>> difficulties in modifying the  exception handling code part, the kernel
>> will not  boot after modification :(, I will continue to work hard try.
> I just tried the same thing and get the same result :(.  Will spend
> several hours reading the LoongArch manual about exception...
>
Hi,

The following ideas are based on experience, without validation. Patches
show that three types of relocation are needed to be done.
1, GOT is generated by toolchain, so  I think eliminating them by 
toolchain is better.
2, Ex_table is generated but striped relocation info. We can plays pcrel
way to resolve this problem. One of ways like follows, (pseudo-code)

arch/loongarch/copy_user.S
...
.macro fixup_ex from, to, offset, fix
.if \fix
         .section .fixup, "ax"
\to:    addi.d  a0, a2, \offset
         jr      ra
         .previous
.endif
         .section __ex_table, "a"
         PTR     \from\()b, \to\()b - \from\()b   # fixup use pcrel
         .previous
.endm
...
...

arch/loongarch/mm/extable.c
         ...
         unsigned long era = exception_era(regs);
         fixup = search_exception_tables(era - relocate_offset); // 
Search by orig value
         if (fixup) {
                 regs->csr_era = fixup->fixup + era; // Fixup fixup address.
                 return 1;
         }

         ...

3, The left is the processed relocation table. It collect the relocation
type R_LARCH_ABS* (R_LARCH_MARK_LA?) and R_LARCH_64. Just do
as this patch does. The la.abs is used because of the different exception
entry on each CPUs and better NUMA performance IMHO. We can
do follows way to avoid R_LARCH_ABS* and produce R_LARCH_64, (data in text)

.text
la.pcrel t0,999f
ld.d t0,t0,0
...
PTR do_vint
...

*Not* important. For me, I really wish a bootstrap relocation while this
patch is KALSR. The bootstrap relocation meaning is the boot cpu enter
kernel_entry, check the real address itself, parse the cmdline whether
do kaslr, and then relocate itself. Then kdump capture process is easier.
Some past info links,
https://lore.kernel.org/loongarch/3002b2b3-2c2c-e32e-c474-d3876d3ef9b7@loongson.cn/
https://patchwork.kernel.org/project/linux-mips/patch/1618230494-6207-6-git-send-email-hejinyang@loongson.cn/


