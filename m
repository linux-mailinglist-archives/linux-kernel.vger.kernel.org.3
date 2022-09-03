Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA865ABC2F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 03:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiICB5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 21:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiICB5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 21:57:13 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 974D4E114D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 18:57:11 -0700 (PDT)
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxvmtwtBJjM0UQAA--.57569S3;
        Sat, 03 Sep 2022 09:57:05 +0800 (CST)
Subject: Re: [PATCH 1/3] LoongArch: tools: Add relocs tool support
To:     Xi Ruoyao <xry111@xry111.site>, Huacai Chen <chenhuacai@kernel.org>
References: <1662113335-14282-1-git-send-email-tangyouling@loongson.cn>
 <1662113335-14282-2-git-send-email-tangyouling@loongson.cn>
 <c9880165f0355fc3be3ec23153b43ad33e558b5d.camel@xry111.site>
 <4df8a26c49a35c1fce36d80c370f738fa71a2bef.camel@xry111.site>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jinyang He <hejinyang@loongson.cn>
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <f0e77716-9533-724a-2ea9-86bc5b52066c@loongson.cn>
Date:   Sat, 3 Sep 2022 09:57:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <4df8a26c49a35c1fce36d80c370f738fa71a2bef.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxvmtwtBJjM0UQAA--.57569S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWUGrWDXFy5AF13GFW7urg_yoW8CFWrpr
        47Ga45K3WDJa4UXa40va4xZrWSgay3Jry5Ww45KrWrZFy3uFnxKF1vga12va47Cr1UKr1j
        qr40q348KF1YyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CE
        bIxvr21lc2xSY4AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
        ZFpf9x0JUHpB-UUUUU=
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao

On 09/02/2022 07:27 PM, Xi Ruoyao wrote:
> On Fri, 2022-09-02 at 19:10 +0800, Xi Ruoyao wrote:
>> Hi Youling,
>>
>> On Fri, 2022-09-02 at 18:08 +0800, Youling Tang wrote:
>>> This tool is based on the arch/mips/boot/tools/relocs tool.
>>
>> I've dig some history of MIPS relocatable kernel
>> (https://lwn.net/Articles/682020/):
>>
>>    * Kernel is compiled & statically linked as normal, with no position
>>      independent code. MIPS before R6 only has limited relative jump
>>      instructions so the vast majority of jumps are absolute. To compile
>>      the kernel position independent would introduce a highly undesireable
>>      overhead. Relocating the static binary gives a small startup time
>>      penalty but the kernel otherwise perforns normally.
>>
>> Unlike (pre-r6) MIPS, LoongArch has a complete support for PIC, and
>> currently LoongArch toolchain always produces PIC (except, if -Wa,-mla-
>> {local,global}-with-abs or la.abs macros are used explicitly).
>>
>> So would it be easier to review and correct the uses of "la.abs" in the
>> code, and make the main kernel image a real PIE?  Then we can load it
>> everywhere w/o any need to do relocation at load time.

At the beginning I also wanted to make the main kernel image a real PIE
and tried it, some of the "la.abs" can be modified, but I encountered
difficulties in modifying the  exception handling code part, the kernel
will not  boot after modification :(, I will continue to work hard try.

I would be grateful if you all have better suggestions and ideas :).

>
> Arrgh, doing so will need to get rid of GOT (the GCC patch for this is
> still under review) or we still need to relocate the GOT at least :(.

Yes, now all global variable access is via got (la.got) in the new
toolchain, so we need to relocate the GOT in relocate.c. However there
is no need to relocate it in the old toolchain as it is accessed
via la.pcrel.

Thanks,
Youling

>
>

