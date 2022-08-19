Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02270599453
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 07:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345416AbiHSFA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 01:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiHSFAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 01:00:52 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF510C926A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 22:00:50 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 351933200657;
        Fri, 19 Aug 2022 01:00:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 19 Aug 2022 01:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660885245; x=
        1660971645; bh=kVazb7lt8vGXQXHDTFxGJ0FYilsP8rMovZpI7sZEpDI=; b=0
        kPY6m+g2DIIy2Kzy3urA/JLxsuuoaJybs5wqRk15UQfoIsIz4ZyRY7af9Jm6sDND
        YMyQO5SnRk8wWDVLXJUKS6TcouFWfVBpMy77GVgXoaB0NrZW8JekT4niwykVNvF1
        uzXqaxmDYx4aVe2bBINBQhreOUel7frdCLAeabYVx2HkBKFtLJLCz8lFzlqRpRAf
        rS39ijTR2GRP+1h3LUxZvZMQgEEDoKgS/Yg7FyYeBB6FY9qPtX2Ir6r1dH3RTHje
        G6MAYcKhNKdNatUXdy12Gp/kT0HUwC8VWanJWkdn87qR2OSYzcF3A7Fr3UVPc/5p
        Xjuge9RZNd/jiz8FKR6+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660885245; x=
        1660971645; bh=kVazb7lt8vGXQXHDTFxGJ0FYilsP8rMovZpI7sZEpDI=; b=D
        AnlOZlaGl8rVLsc1KJgS+85/Lv7roL0km+eiNlVoBAyEc9Kl+7euK3BUPSCtcuLe
        jm/VUT8e88wp4qZUqwmuY7LXOSn7AyRoran5SF5aM6C7ILHSvsk9mS1Dld8J45l+
        oUeQZfLvHyBzhkQqoSgeuKyDNa7K8nMHttHt+l24otYpe8EFpG2b/XCGT4xHz3Mr
        QXXiLBvvri22V2Li5h/rJi+PE8rLUwpWN7PQdSXc/5LP4zeNAtHGuRAW/63mnar7
        6P0C59aN4Sya6Z+satfpNXXZwWKAAfMQAZ+Od+DXDzh/K01U/G38SE+iYm25af7c
        pK/d2WmJb8S4WGUUfhwaw==
X-ME-Sender: <xms:_Bj_YpYid9vEvbkRFADhYxFVVFW1BcJDvUt-eFgaZxOBTAgRXkHzfw>
    <xme:_Bj_YgaaCrl6B7ZT5PwEJNrXqTLoUUCPaAgoMFiAX7CnCqS2xz_T6LKWgz9QJYeNJ
    PR9Ed_2yZ60rdIrFw>
X-ME-Received: <xmr:_Bj_Yr9QzXhMdNLHJgnUJBax59sRzG9Pn6KcZvIQQK74OaRxzfI74rTj_fJqolmepcBLG4qIO7pMgUl4oeSJQmZ91_vsKu-czdvLApwdwOJz1yYB5z0DWD3qUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeitddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfevfhfhkffffgggjggtgfesth
    ekredttdefjeenucfhrhhomhepufgrmhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghl
    sehshhholhhlrghnugdrohhrgheqnecuggftrfgrthhtvghrnhepjeelfedutdeggeevvd
    ekheefjeefvefgfeeiffefgeduieeutdehkeejleegueejnecuffhomhgrihhnpehkvghr
    nhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:_Bj_Ynpn7jwmvBKq_AClh_d6Kt2cf0qqV_dve60f5MfVzFghRt1UUA>
    <xmx:_Bj_YkpvNY8tjzhxoWP-hRI9SorFSJ1EyFYoKItsc6OpSGqc31-1DA>
    <xmx:_Bj_YtR620AmuDJiPGoAXenLtdhQW7XyO9Ra_ZEF8uaou6N-cT828w>
    <xmx:_Rj_Yv9w_mz_TrQ-I1KJQVKgrWbrKcUawKLL72kN-PO6EDOlDclmPQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Aug 2022 01:00:43 -0400 (EDT)
Subject: Re: Re: [PATCH v4] arch/riscv: add Zihintpause support
To:     Conor.Dooley@microchip.com, palmer@dabbelt.com
Cc:     daolu@rivosinc.com, linux-kernel@vger.kernel.org, heiko@sntech.de,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        atishp@atishpatra.org, anup@brainfault.org, guoren@kernel.org,
        jszhang@kernel.org, rdunlap@infradead.org, niklas.cassel@wdc.com,
        panqinglin2020@iscas.ac.cn, alexandre.ghiti@canonical.com,
        robh@kernel.org, research_trasio@irq.a4lg.com,
        yury.norov@gmail.com, linux-riscv@lists.infradead.org
References: <mhng-1b17506c-8dd7-4868-bd58-7df010313902@palmer-ri-x1c9>
 <73c7e97a-ebdc-5509-7e74-4b1dbb62b2bb@microchip.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <ef792dc5-0a9e-7786-0c16-11d7de65f392@sholland.org>
Date:   Fri, 19 Aug 2022 00:00:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <73c7e97a-ebdc-5509-7e74-4b1dbb62b2bb@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/22 11:04 AM, Conor.Dooley@microchip.com wrote:
> On 16/08/2022 16:54, Palmer Dabbelt wrote:
>> On Fri, 12 Aug 2022 00:21:40 PDT (-0700), Conor.Dooley@microchip.com wrote:
>>> On 12/08/2022 07:57, Conor Dooley - M52691 wrote:
>>>> On 11/08/2022 16:17, Palmer Dabbelt wrote:
>>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>>>
>>>>> On Mon, 20 Jun 2022 13:15:25 PDT (-0700), daolu@rivosinc.com wrote:
>>>>>> Implement support for the ZiHintPause extension.
>>>>>>
>>>>>> The PAUSE instruction is a HINT that indicates the current hart’s rate
>>>>>> of instruction retirement should be temporarily reduced or paused.
>>>>>>
>>>>>> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>>>>>> Tested-by: Heiko Stuebner <heiko@sntech.de>
>>>>>> Signed-off-by: Dao Lu <daolu@rivosinc.com>
>>>>>> ---
>>>>>>
>>>>>> v1 -> v2:
>>>>>>  Remove the usage of static branch, use PAUSE if toolchain supports it
>>>>>> v2 -> v3:
>>>>>>  Added the static branch back, cpu_relax() behavior is kept the same for
>>>>>> systems that do not support ZiHintPause
>>>>>> v3 -> v4:
>>>>>>  Adopted the newly added unified static keys for extensions
>>>>>> ---
>>>>>>  arch/riscv/Makefile                     |  4 ++++
>>>>>>  arch/riscv/include/asm/hwcap.h          |  5 +++++
>>>>>>  arch/riscv/include/asm/vdso/processor.h | 21 ++++++++++++++++++---
>>>>>>  arch/riscv/kernel/cpu.c                 |  1 +
>>>>>>  arch/riscv/kernel/cpufeature.c          |  1 +
>>>>>>  5 files changed, 29 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
>>>>>> index 34cf8a598617..6ddacc6f44b9 100644
>>>>>> --- a/arch/riscv/Makefile
>>>>>> +++ b/arch/riscv/Makefile
>>>>>> @@ -56,6 +56,10 @@ riscv-march-$(CONFIG_RISCV_ISA_C)  := $(riscv-march-y)c
>>>>>>  toolchain-need-zicsr-zifencei := $(call cc-option-yn, -march=$(riscv-march-y)_zicsr_zifencei)
>>>>>>  riscv-march-$(toolchain-need-zicsr-zifencei) := $(riscv-march-y)_zicsr_zifencei
>>>>>>
>>>>>> +# Check if the toolchain supports Zihintpause extension
>>>>>> +toolchain-supports-zihintpause := $(call cc-option-yn, -march=$(riscv-march-y)_zihintpause)
>>>>>> +riscv-march-$(toolchain-supports-zihintpause) := $(riscv-march-y)_zihintpause
>>>>>> +
>>>>>>  KBUILD_CFLAGS += -march=$(subst fd,,$(riscv-march-y))
>>>>>>  KBUILD_AFLAGS += -march=$(riscv-march-y)
>>>>>>
>>>>>> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
>>>>>> index e48eebdd2631..dc47019a0b38 100644
>>>>>> --- a/arch/riscv/include/asm/hwcap.h
>>>>>> +++ b/arch/riscv/include/asm/hwcap.h
>>>>>> @@ -8,6 +8,7 @@
>>>>>>  #ifndef _ASM_RISCV_HWCAP_H
>>>>>>  #define _ASM_RISCV_HWCAP_H
>>>>>>
>>>>>> +#include <asm/errno.h>
>>>>>>  #include <linux/bits.h>
>>>>>>  #include <uapi/asm/hwcap.h>
>>>>>>
>>>>>> @@ -54,6 +55,7 @@ extern unsigned long elf_hwcap;
>>>>>>  enum riscv_isa_ext_id {
>>>>>>       RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
>>>>>>       RISCV_ISA_EXT_SVPBMT,
>>>>>> +     RISCV_ISA_EXT_ZIHINTPAUSE,
>>>>>>       RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
>>>>>>  };
>>>>>>
>>>>>> @@ -64,6 +66,7 @@ enum riscv_isa_ext_id {
>>>>>>   */
>>>>>>  enum riscv_isa_ext_key {
>>>>>>       RISCV_ISA_EXT_KEY_FPU,          /* For 'F' and 'D' */
>>>>>> +     RISCV_ISA_EXT_KEY_ZIHINTPAUSE,
>>>>>>       RISCV_ISA_EXT_KEY_MAX,
>>>>>>  };
>>>>>>
>>>>>> @@ -83,6 +86,8 @@ static __always_inline int riscv_isa_ext2key(int num)
>>>>>>               return RISCV_ISA_EXT_KEY_FPU;
>>>>>>       case RISCV_ISA_EXT_d:
>>>>>>               return RISCV_ISA_EXT_KEY_FPU;
>>>>>> +     case RISCV_ISA_EXT_ZIHINTPAUSE:
>>>>>> +             return RISCV_ISA_EXT_KEY_ZIHINTPAUSE;
>>>>>>       default:
>>>>>>               return -EINVAL;
>>>>>>       }
>>>>>> diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/include/asm/vdso/processor.h
>>>>>> index 134388cbaaa1..1e4f8b4aef79 100644
>>>>>> --- a/arch/riscv/include/asm/vdso/processor.h
>>>>>> +++ b/arch/riscv/include/asm/vdso/processor.h
>>>>>> @@ -4,15 +4,30 @@
>>>>>>
>>>>>>  #ifndef __ASSEMBLY__
>>>>>>
>>>>>> +#include <linux/jump_label.h>
>>>>>>  #include <asm/barrier.h>
>>>>>> +#include <asm/hwcap.h>
>>>>>>
>>>>>>  static inline void cpu_relax(void)
>>>>>>  {
>>>>>> +     if (!static_branch_likely(&riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_ZIHINTPAUSE])) {
>>>>>>  #ifdef __riscv_muldiv
>>>>>> -     int dummy;
>>>>>> -     /* In lieu of a halt instruction, induce a long-latency stall. */
>>>>>> -     __asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
>>>>>> +             int dummy;
>>>>>> +             /* In lieu of a halt instruction, induce a long-latency stall. */
>>>>>> +             __asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
>>>>>>  #endif
>>>>>> +     } else {
>>>>>> +             /*
>>>>>> +              * Reduce instruction retirement.
>>>>>> +              * This assumes the PC changes.
>>>>>> +              */
>>>>>> +#ifdef __riscv_zihintpause
>>>>>> +             __asm__ __volatile__ ("pause");
>>>>>> +#else
>>>>>> +             /* Encoding of the pause instruction */
>>>>>> +             __asm__ __volatile__ (".4byte 0x100000F");
>>>>>> +#endif
>>>>>> +     }
>>>>>>       barrier();
>>>>>>  }
>>>>>>
>>>>>> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
>>>>>> index fba9e9f46a8c..a123e92b14dd 100644
>>>>>> --- a/arch/riscv/kernel/cpu.c
>>>>>> +++ b/arch/riscv/kernel/cpu.c
>>>>>> @@ -89,6 +89,7 @@ int riscv_of_parent_hartid(struct device_node *node)
>>>>>>  static struct riscv_isa_ext_data isa_ext_arr[] = {
>>>>>>       __RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
>>>>>>       __RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
>>>>>> +     __RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
>>>>>>       __RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
>>>>>>  };
>>>>>>
>>>>>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>>>>>> index 1b3ec44e25f5..708df2c0bc34 100644
>>>>>> --- a/arch/riscv/kernel/cpufeature.c
>>>>>> +++ b/arch/riscv/kernel/cpufeature.c
>>>>>> @@ -198,6 +198,7 @@ void __init riscv_fill_hwcap(void)
>>>>>>                       } else {
>>>>>>                               SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
>>>>>>                               SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
>>>>>> +                             SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
>>>>>>                       }
>>>>>>  #undef SET_ISA_EXT_MAP
>>>>>>               }
>>>>>
>>>>> Thanks, this is on for-next.  It needs a sparse patch, which I put in as a link.
>>>>
>>>> This breaks the C=1 build for all toolchains, not just new ones as your sparse
>>>> patch suggests. I amn't 100% what my CI is running, but I replicated this on
>>>> my own machine with:
>>>
>>> Argh, I went poking around and my toolchain's binutils etc is newer than I thought.
>>> Good for people searching on lore I suppose...
>>> Sorry!
>>
>> So just to be clear: you're saying this only breaks with new binutils?
> 
> Yes, sorry - I *thought* the binutils in our CI predated Zihintpause but
> it doesn't. It (and so would the Zicbom stuff) breaks the builds in our CI
> as they run with C=1. I manually patched sparse to get that going again & I
> /suspect/ it may have impacted LKP too.
> 
> "New" is relative though - it breaks C=1 for anyone running a toolchain
> from riscv-collab/riscv-gnu-toolchain.
> 
> I guess it's just that Zicbom is newer so not many people will be on a
> toolchain that supports that. My GCC doesn't only my clang-15.
> 
>> I ask because Dao is also seeing some crashes, if it's breaking arbitrary
>> builds too then it's a stronger hint to revert it.
> 
> It is breaking module loading on RISC-V in general from what it seems.
> See:
> https://lore.kernel.org/linux-riscv/728ecbd5-975a-168e-efab-3c0030be21d5@w6rz.net/

This patch also completely breaks the build with CONFIG_CC_OPTIMIZE_FOR_SIZE=y:

In file included from <command-line>:
./arch/riscv/include/asm/jump_label.h: In function 'cpu_relax':
././include/linux/compiler_types.h:285:33: warning: 'asm' operand 0 probably
does not match constraints
  285 | #define asm_volatile_goto(x...) asm goto(x)
      |                                 ^~~
./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of macro
'asm_volatile_goto'
   41 |         asm_volatile_goto(
      |         ^~~~~~~~~~~~~~~~~
././include/linux/compiler_types.h:285:33: error: impossible constraint in 'asm'
  285 | #define asm_volatile_goto(x...) asm goto(x)
      |                                 ^~~
./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of macro
'asm_volatile_goto'
   41 |         asm_volatile_goto(
      |         ^~~~~~~~~~~~~~~~~
make[1]: *** [scripts/Makefile.build:249:
arch/riscv/kernel/vdso/vgettimeofday.o] Error 1
make: *** [arch/riscv/Makefile:128: vdso_prepare] Error 2

Putting a static branch in such a widely-inlined function seems like a bad idea
in general. (A quick measurement of my somewhat-minimal config shows this single
static branch as responsible for 40% of the jump table.)

I don't think it's even necessary in this case. Why can't we unconditionally run
both instructions? If Zihintpause is supported, we trade the nop from the static
branch for a div. If it is unsupported, we trade the jump from the static branch
for a nop.

Regards,
Samuel
