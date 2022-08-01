Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E417586271
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237893AbiHACQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbiHACQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:16:15 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8D6F6575
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:16:13 -0700 (PDT)
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxT+NpN+diN_VHAA--.51469S3;
        Mon, 01 Aug 2022 10:16:09 +0800 (CST)
Subject: Re: [PATCH v4 0/4] LoongArch: Support new relocation types
To:     Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev
References: <32a74a218c76611f897fd1df1ad0059068621133.camel@xry111.site>
 <ec52fd49-4a30-15d9-3d32-fd7bc6d8b3f0@loongson.cn>
 <0179679b736aea7258981dec2d83107cce74dfc1.camel@xry111.site>
 <a139a8475fe295ac9f17064269cd0312dca6f96e.camel@xry111.site>
 <6b5d2188f93ed72b67a4bbb7116113f833fe1ee5.camel@xry111.site>
 <d7670b60-2782-4642-995b-7baa01779a66@loongson.cn>
 <7cad6e78014168a8906e130e1cf3809077d2bda7.camel@xry111.site>
 <1d0783b87bda3e454a111862fcc5b5faffcb16b0.camel@xry111.site>
 <00eede4b1380888a500f74b1e818bb25a550632b.camel@xry111.site>
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jinyang He <hejinyang@loongson.cn>,
        Lulu Cheng <chenglulu@loongson.cn>
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <7512ae16-b171-d072-674f-a6b9a5e764d6@loongson.cn>
Date:   Mon, 1 Aug 2022 10:16:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <00eede4b1380888a500f74b1e818bb25a550632b.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxT+NpN+diN_VHAA--.51469S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr13AryUKF1DuFWxXF4fZrb_yoW8tF1UpF
        Z7GFW5Kr4kJr1rAa92yw1293Wjvws8Jr1xWw1FqayjvF9FqFn3Ar4Iv3yrCFy2vr95G3WU
        XrW7A34xXrWrZw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07Al
        zVAYIcxG8wCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUbpwZ7UUUUU==
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao

On 07/30/2022 10:52 AM, Xi Ruoyao wrote:
> On Sat, 2022-07-30 at 10:24 +0800, Xi Ruoyao wrote:
>> On Sat, 2022-07-30 at 01:55 +0800, Xi Ruoyao wrote:
>>> On Fri, 2022-07-29 at 20:19 +0800, Youling Tang wrote:
>>>
>>>> On 07/29/2022 07:45 PM, Xi Ruoyao wrote:
>>>>> Hmm... The problem is the "addresses" of per-cpu symbols are
>>>>> faked: they
>>>>> are actually offsets from $r21.  So we can't just load such an
>>>>> offset
>>>>> with PCALA addressing.
>>>>>
>>>>> It looks like we'll need to introduce an attribute for GCC to
>>>>> make
>>>>> an
>>>>> variable "must be addressed via GOT", and add the attribute into
>>>>> PER_CPU_ATTRIBUTES.
>>>
>>>> Yes, we need a GCC attribute to specify the per-cpu variable.
>>>
>>> GCC patch adding "addr_global" attribute for LoongArch:
>>> https://gcc.gnu.org/pipermail/gcc-patches/2022-July/599064.html
>>>
>>> An experiment to use it:
>>> https://github.com/xry111/linux/commit/c1d5d70
>>
>> Correction: https://github.com/xry111/linux/commit/c1d5d708
>>
>> It seems 7-bit SHA is not enough for kernel repo.
>
> If addr_global is rejected or not implemented (for example, building the
> kernel with GCC 12), *I expect* the following hack to work (I've not
> tested it because I'm AFK now).  Using visibility in kernel seems
> strange, but I think it may make some sense because the modules are some
> sort of similar to an ELF shared object being dlopen()'ed, and our way
> to inject per-CPU symbols is analog to ELF interposition.
>
> arch/loongarch/include/asm/percpu.h:
>
>    #if !__has_attribute(__addr_global__) && defined(MODULE)
>    /* Magically remove "static" for per-CPU variables.  */
>    # define ARCH_NEEDS_WEAK_PER_CPU
>    /* Force GOT-relocation for per-CPU variables.  */
>    # define PER_CPU_ATTRIBUTES __attribute__((__visibility__("default")))
>    #endif
>
> arch/loongarch/Makefile:
>
>    # Hack for per-CPU variables, see PER_CPU_ATTRIBUTES in
>    # include/asm/percpu.h
>    if (call gcc-does-not-support-addr-global)
>      KBUILD_CFLAGS_MODULE += -fPIC -fvisibility=hidden
>    endif
>
Using the old toolchain (GCC 12) can successfully load the nf_tables.ko
module after applying the above patch.

Thanks,
Youling

