Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CB4581027
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238285AbiGZJmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiGZJmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:42:47 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E040C2F64A;
        Tue, 26 Jul 2022 02:42:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VKUwL8I_1658828559;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VKUwL8I_1658828559)
          by smtp.aliyun-inc.com;
          Tue, 26 Jul 2022 17:42:40 +0800
Subject: Re: [RESEND PATCH V2 0/5] Fixups to work with crash tool
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     Conor.Dooley@microchip.com
Cc:     alexandre.ghiti@canonical.com, heiko@sntech.de, palmer@dabbelt.com,
        mick@ics.forth.gr, guoren@kernel.org, kexec@lists.infradead.org,
        bhe@redhat.com, linux-doc@vger.kernel.org, vgoyal@redhat.com,
        linux-riscv@lists.infradead.org, dyoung@redhat.com,
        linux-kernel@vger.kernel.org, crash-utility@redhat.com,
        huanyi.xj@alibaba-inc.com, heinrich.schuchardt@canonical.com,
        anup@brainfault.org, corbet@lwn.net, k-hagio-ab@nec.com,
        hschauhan@nulltrace.org, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu
References: <20220725014539.1037627-1-xianting.tian@linux.alibaba.com>
 <51c97da7-422f-1b5b-03d3-dc36c9132c2a@microchip.com>
 <7a395f64-8ec7-e07f-e763-afc1f2611c75@linux.alibaba.com>
 <2301681f-361d-b85b-e255-3bf449ceeaa9@microchip.com>
 <cf00c1f6-b043-a11e-f7a5-bed1e829cb73@linux.alibaba.com>
 <6320e6dd-ebd9-3575-a85f-c3a2f92e9f54@linux.alibaba.com>
Message-ID: <00776b91-6bff-e4b8-f000-5399924cd145@linux.alibaba.com>
Date:   Tue, 26 Jul 2022 17:42:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <6320e6dd-ebd9-3575-a85f-c3a2f92e9f54@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/7/26 下午5:28, Xianting Tian 写道:
>
> 在 2022/7/26 下午4:16, Xianting Tian 写道:
>>
>> 在 2022/7/26 下午4:01, Conor.Dooley@microchip.com 写道:
>>> On 26/07/2022 08:54, tianxianting wrote:
>>>> 在 2022/7/26 上午1:13, Conor.Dooley@microchip.com 写道:
>>>>> That said, this does not apply to riscv/for-next:
>>>>> b4 shazam 20220725014539.1037627-1-xianting.tian@linux.alibaba.com
>>>>> Grabbing thread from 
>>>>> lore.kernel.org/all/20220725014539.1037627-1-xianting.tian%40linux.alibaba.com/t.mbox.gz
>>>>> Checking for newer revisions on https://lore.kernel.org/all/
>>>>> Analyzing 6 messages in the thread
>>>>> Checking attestation on all messages, may take a moment...
>>>>> ---
>>>>>     [PATCH v2 1/5] RISC-V: use __smp_processor_id() instead of 
>>>>> smp_processor_id()
>>>>>     [PATCH v2 2/5] RISC-V: Add arch_crash_save_vmcoreinfo support
>>>>>     [PATCH v2 3/5] riscv: Add modules to virtual kernel memory 
>>>>> layout dump
>>>>>     [PATCH v2 4/5] RISC-V: Fixup getting correct current pc
>>>>>     [PATCH v2 5/5] riscv: crash_core: Export kernel vm layout, 
>>>>> phys_ram_base
>>>>> ---
>>>>> Total patches: 5
>>>>> ---
>>>>> Applying: RISC-V: use __smp_processor_id() instead of 
>>>>> smp_processor_id()
>>>>> Applying: RISC-V: Add arch_crash_save_vmcoreinfo support
>>>>> Patch failed at 0002 RISC-V: Add arch_crash_save_vmcoreinfo support
>>>> patch 2 apply is OK for me, I don't know why you failed :(
>>>> Do you have more detals for this?
>>>>
>>> What did you apply it to? It does not apply for me to riscv/for-next:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/log/?h=for-next 
>>>
>>
>> This 5 patches are based on the master branch of below git:
>>
>> https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git 
>>
>>
>> "git am 0002-RISC-V-Add-arch_crash_save_vmcoreinfo-support.patch" to 
>> this git is ok for me.
>>
>> All is correct?
>
> I figured out the reason, there is one difference in 
> arch/riscv/kernel/Makefile between riscv/for-next and torvalds/linux.
>
> For riscv/for-next, in line 81 of arch/riscv/kernel/Makefile, it is:
>
>     obj-$(CONFIG_KEXEC)        += kexec_relocate.o crash_save_regs.o 
> machine_kexec.o
>
> But for torvalds/linux, in line 81 of arch/riscv/kernel/Makefile, it is:
>
>     obj-$(CONFIG_KEXEC_CORE)        += kexec_relocate.o 
> crash_save_regs.o machine_kexec.o
>
> torvalds/linux is newer than riscv/for-next,  commit 3a66a08759 
> ("RISC-V: kexec: Fix build error without CONFIG_KEXEC") added 
> "CONFIG_KEXEC_CORE" for torvalds/linux, But riscv/for-next
>
> doesn't contain the commit.

Hi Dooley

I think riscv git needs to be updated from linus git, and then I think 
V4 can be applied normally.

V4: https://lkml.org/lkml/2022/7/26/317

>
>
>>
>>>
>>> Thanks,
>>> Conor.
>>>
