Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A132B5ADD35
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 04:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiIFCQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 22:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiIFCQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 22:16:47 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7D894DB73
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 19:16:43 -0700 (PDT)
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxBOKArRZjpVISAA--.9201S3;
        Tue, 06 Sep 2022 10:16:33 +0800 (CST)
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
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <29cd929b-185b-1c4b-f200-08f2a724b59d@loongson.cn>
Date:   Tue, 6 Sep 2022 10:16:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <d852f590-95b4-3fd1-924a-68c0a6bb1b1b@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxBOKArRZjpVISAA--.9201S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW8GFWxAr15AF4rur4rKrg_yoWrJry5pr
        W5GayUKFsrJF17ZFW0vw10qFWSg3ykGr13Wa1rtry0yF9IvF93tw4Utr43CFy29r1ktF4j
        vrWYqa4I9r1rAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
        WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07Al
        zVAYIcxG8wCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUHWlkUUUUU=
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao & Jinyang

On 09/05/2022 10:52 AM, Youling Tang wrote:
> Hi, Ruoyao
>
> On 09/04/2022 12:53 AM, Xi Ruoyao wrote:
>> On Sun, 2022-09-04 at 00:23 +0800, Jinyang He wrote:
>>> On 2022/9/3 18:49, Xi Ruoyao wrote:
>>>
>>>> On Sat, 2022-09-03 at 09:57 +0800, Youling Tang wrote:
>>>>>>> Unlike (pre-r6) MIPS, LoongArch has a complete support for PIC, and
>>>>>>> currently LoongArch toolchain always produces PIC (except, if
>>>>>>> -Wa,-mla-
>>>>>>> {local,global}-with-abs or la.abs macros are used explicitly).
>>>>>>>
>>>>>>> So would it be easier to review and correct the uses of "la.abs"
>>>>>>> in the
>>>>>>> code, and make the main kernel image a real PIE?  Then we can
>>>>>>> load it
>>>>>>> everywhere w/o any need to do relocation at load time.
>>>>> At the beginning I also wanted to make the main kernel image a real
>>>>> PIE
>>>>> and tried it, some of the "la.abs" can be modified, but I encountered
>>>>> difficulties in modifying the  exception handling code part, the
>>>>> kernel
>>>>> will not  boot after modification :(, I will continue to work hard
>>>>> try.
>>
>>>> I just tried the same thing and get the same result :(.  Will spend
>>>> several hours reading the LoongArch manual about exception...
>>
>> The reason is the handler code is not executed in linker address, but
>> copied elsewhere.  Then PC-relative offset is broken.  I managed to work
>> around it by creating a trampoline and jump into the handler, instead of
>> copy the handler code.  Then I could remove most "la.abs" occurrence
>> (except two in kernel entry point, which seem deliberately used):
>>
>> - https://github.com/xry111/linux/commit/56a433f
>> - https://github.com/xry111/linux/commit/48203e6
>>
>
> Thank you very much.
>
> After applying the above two patches and the following modifications,
> the relocation can be successful after removing the
> apply_r_loongarch_la_rel (for la.abs relocation) implementation. I
> tested it in the qemu environment.
>
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -113,9 +113,11 @@ SYM_CODE_START(smpboot_entry)
>         li.d            t0, CSR_DMW1_INIT       # CA, PLV0
>         csrwr           t0, LOONGARCH_CSR_DMWIN1
>
> -       la.abs          t0, 0f
> -       jr              t0
> -0:
> +       li.d            t0, CACHE_BASE
> +       pcaddi          t1, 0
> +       or              t0, t0, t1
> +       jirl            zero, t0, 0xc
>
> Youling.
>
>> Using the trampoline in handler table will definitely lead to sub-
>> optimal performance. I just use it as a proof-of-concept. Later we may
>> use some assembler trick to generate hard-coded handler table with
>> correct PC-relative offsets.
>>
>>> The following ideas are based on experience, without validation. Patches
>>> show that three types of relocation are needed to be done.
>>> 1, GOT is generated by toolchain, so  I think eliminating them by
>>> toolchain is better.
>>
>> https://gcc.gnu.org/pipermail/gcc-patches/2022-September/600797.html
>>
>> I stop to read the mail here because it's 00:52 AM now :).
>>
>>> 2, Ex_table is generated but striped relocation info. We can plays pcrel
>>> way to resolve this problem. One of ways like follows, (pseudo-code)

Switch to relative exception tables:

https://github.com/tangyouling/linux/commit/6525b8da
https://github.com/tangyouling/linux/commit/b6ac0827

Will switch to the relative exception tables after applying the above
two patches. So there is no need to relocate the exception table
(remove relocate_exception_table).

Now we can remove the relocation of la.abs , got and ex_table, but
still need to relocate LARCH_64. Is there anything else that needs to
be modified to eliminate this relocation?

Thanks,
Youling.

>>
>> /* snip */
>>
>>
>

