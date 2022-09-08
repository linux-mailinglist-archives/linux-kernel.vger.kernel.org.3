Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6F55B162C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiIHICP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiIHICM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:02:12 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B652311C0F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:02:10 -0700 (PDT)
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxBOJ1oRlji0UUAA--.16486S3;
        Thu, 08 Sep 2022 16:01:58 +0800 (CST)
Subject: Re: [PATCH 1/3] LoongArch: tools: Add relocs tool support
To:     Xi Ruoyao <xry111@xry111.site>, Jinyang He <hejinyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
References: <1662113335-14282-1-git-send-email-tangyouling@loongson.cn>
 <1662113335-14282-2-git-send-email-tangyouling@loongson.cn>
 <c9880165f0355fc3be3ec23153b43ad33e558b5d.camel@xry111.site>
 <4df8a26c49a35c1fce36d80c370f738fa71a2bef.camel@xry111.site>
 <f0e77716-9533-724a-2ea9-86bc5b52066c@loongson.cn>
 <78a4a6b0970c309daa336a2329e69d28df486552.camel@xry111.site>
 <fffdd2ac-4ba6-8eb3-f269-b22a3d9c32f6@loongson.cn>
 <0b2d115c42ff6cb9b8c65d852ec2f0746ca6e8d9.camel@xry111.site>
 <d852f590-95b4-3fd1-924a-68c0a6bb1b1b@loongson.cn>
 <29cd929b-185b-1c4b-f200-08f2a724b59d@loongson.cn>
 <a218373f773ef193903daa528291ec8bb384ddd2.camel@xry111.site>
 <83a7aad8-125b-29b5-715d-0061ce1b0647@loongson.cn>
 <011b5d39-e0cb-69cc-66fd-ed46afe7695e@loongson.cn>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <750719dc-d481-6eba-05c6-50cfdceb871b@loongson.cn>
Date:   Thu, 8 Sep 2022 16:01:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <011b5d39-e0cb-69cc-66fd-ed46afe7695e@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxBOJ1oRlji0UUAA--.16486S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZry5GFyDuw4kuw48Ww1DGFg_yoWrGr1kpF
        W8GFWUKF4rXFyUZFZFqw4jyFyY9wsxAF1xXFy8Jw1kZryqvFySgw12vryakrWDCryxGF42
        qFW5Xryqqr15AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
        IFyTuYvjfU8Z2-UUUUU
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/08/2022 10:44 AM, Youling Tang wrote:
> Hi, Ruoyao
>
> On 09/07/2022 06:19 PM, Youling Tang wrote:
>> Hi, Ruoyao
>>
>> On 09/06/2022 01:17 PM, Xi Ruoyao wrote:
>>> On Tue, 2022-09-06 at 10:16 +0800, Youling Tang wrote:
>>>
>>>> Switch to relative exception tables:
>>>>
>>>> https://github.com/tangyouling/linux/commit/6525b8da
>>>> https://github.com/tangyouling/linux/commit/b6ac0827
>>>>
>>>> Will switch to the relative exception tables after applying the above
>>>> two patches. So there is no need to relocate the exception table
>>>> (remove relocate_exception_table).
>>>>
>>>> Now we can remove the relocation of la.abs , got and ex_table, but
>>>> still need to relocate LARCH_64. Is there anything else that needs to
>>>> be modified to eliminate this relocation?
>>>
>>> You may see the RISC-V patch as a reference:
>>>
>>> https://lore.kernel.org/all/20211009171259.2515351-2-alexandre.ghiti@canonical.com/
>>>
>>>
>>>
>>> Basically, make the linker to generate R_*_RELATIVE instead of R_*_64
>>> for pointers.  And, perform R_*_RELATIVE relocation loading the kernel.
>>>
>>> Something problematic IMO: RISC-V uses "-shared" to trick the linker to
>>> generate R_*_RELATIVE but I consider it ugly (if the kernel is a shared
>>> library, my grandma will be a wagon!)  I prefer "-pie -static", but our
>>> Glibc does not have static-pie support for now.  It won't really affect
>>> the kernel (we are -nostdlib), but we cannot learn how to handle
>>> R_*_RELATIVE in static pie from Glibc then.
>>>
>>
>> After applying all the patches in the link [1], the implementation of
>> the relocs tool can now be removed :).
>>
>> commit: 244fb0971a ... ad45233ef6
>>
>> [1] https://github.com/tangyouling/loongarch-next/commits/loongarch-next
>
> The previous LDFLAGS_vmlinux has not changed,
> LDFLAGS_vmlinux  += -G0 -static -n -nostdlib
>
> When enabling CONFIG_RELOCATABLE to generate the PIE kernel, link
> vmliunx with different flags:
>
> 1）LDFLAGS_vmlinux   += -shared -Bsymbolic -z notext -z norelro
> This way is similar to arm64.
>
> The following warnings appear when linking when using the old toolchain
> (no warnings for the new toolchain):
>
> kernel/kallsyms.o(.text+0x4): warning: R_LARCH_SOP_PUSH_PCREL against
> [undefweak] `kallsyms_offsets':
> Undefweak need to be resolved dynamically, but PLT stub doesn't
> represent.
>
> 2）LDFLAGS_vmlinux  += -pie
> No warnings appear, it looks fine together.
>
> I looked at some commits for arm64, at first arm64 used -pie -shared
> (direct link fails in LoongArch), Removed -pie after link [1] and only
> used -shared.
>
> [1]
> https://github.com/torvalds/linux/commit/3bbd3db86470c701091fb1d67f1fab6621debf50
>


After adding KBUILD_CFLAGS_KERNEL += -mdirect-extern-access, the kernel
will not generate .got, .plt and .got.plt sections (in the new
toolchain), we should unexpectedly detect that the kernel has these
sections, maybe add similar patch [1] to detect, x86_64 has the same
operation.

But when adding LDFLAGS_vmlinux += -pie (or -shared), there will be
.got, .plt and .got.plt sections generated, I don't know how the
toolchain handles it :(?

$ loongarch64-unknown-linux-gnu-readelf -S vmlinux
Section Headers:
   [Nr] Name              Type             Address           Offset
        Size              EntSize          Flags  Link  Info  Align
   [ 4] .plt              PROGBITS         90000000010215e0  00e315e0
        0000000000000040  0000000000000010  AX       0     0     16
   [ 5] .got.plt          PROGBITS         9000000001021620  00e31620
        0000000000000020  0000000000000008  WA       0     0     8
   [ 6] .got              PROGBITS         9000000001021640  00e31640
        0000000000000008  0000000000000008  WA       0     0     8


[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=be2881824ae

Thanks,
Youling

