Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425E3580E4D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiGZHy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiGZHy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:54:27 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C682D1D5;
        Tue, 26 Jul 2022 00:54:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VKUPxf0_1658822056;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VKUPxf0_1658822056)
          by smtp.aliyun-inc.com;
          Tue, 26 Jul 2022 15:54:17 +0800
Subject: Re: [RESEND PATCH V2 0/5] Fixups to work with crash tool
To:     Conor.Dooley@microchip.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        heiko@sntech.de, guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net
Cc:     kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        crash-utility@redhat.com, huanyi.xj@alibaba-inc.com,
        heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com,
        hschauhan@nulltrace.org
References: <20220725014539.1037627-1-xianting.tian@linux.alibaba.com>
 <51c97da7-422f-1b5b-03d3-dc36c9132c2a@microchip.com>
From:   tianxianting <xianting.tian@linux.alibaba.com>
Message-ID: <7a395f64-8ec7-e07f-e763-afc1f2611c75@linux.alibaba.com>
Date:   Tue, 26 Jul 2022 15:54:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <51c97da7-422f-1b5b-03d3-dc36c9132c2a@microchip.com>
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


在 2022/7/26 上午1:13, Conor.Dooley@microchip.com 写道:
> On 25/07/2022 02:45, Xianting Tian wrote:
>> [RESEND PATCH V2 0/5] Fixups to work with crash tool
> FWIW, this is not a "resend" - there's at least a commit message
> difference here so this should have been v3. Also your cover letter
> was not the one generated for the patches you actually sent since
> it still mentions "riscv64" in the subject line for patch 5.

Sorry for this, my modification this time is still not thorough enough, 
"riscv64" still exist :(

I will use V4 for next fix.

>
> That said, this does not apply to riscv/for-next:
> b4 shazam 20220725014539.1037627-1-xianting.tian@linux.alibaba.com
> Grabbing thread from lore.kernel.org/all/20220725014539.1037627-1-xianting.tian%40linux.alibaba.com/t.mbox.gz
> Checking for newer revisions on https://lore.kernel.org/all/
> Analyzing 6 messages in the thread
> Checking attestation on all messages, may take a moment...
> ---
>    [PATCH v2 1/5] RISC-V: use __smp_processor_id() instead of smp_processor_id()
>    [PATCH v2 2/5] RISC-V: Add arch_crash_save_vmcoreinfo support
>    [PATCH v2 3/5] riscv: Add modules to virtual kernel memory layout dump
>    [PATCH v2 4/5] RISC-V: Fixup getting correct current pc
>    [PATCH v2 5/5] riscv: crash_core: Export kernel vm layout, phys_ram_base
> ---
> Total patches: 5
> ---
> Applying: RISC-V: use __smp_processor_id() instead of smp_processor_id()
> Applying: RISC-V: Add arch_crash_save_vmcoreinfo support
> Patch failed at 0002 RISC-V: Add arch_crash_save_vmcoreinfo support

patch 2 apply is OK for me, I don't know why you failed :(  Do you have 
more detals for this?

> When you fix that, could you also pick either "riscv" or "RISC-V" as a
> prefix the series?
thanks for the comments, I will fix it in V4.
> Thanks,
> Conor.
>
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> I ever sent the patch 1 in the link:
>> https://patchwork.kernel.org/project/linux-riscv/patch/20220708073150.352830-3-xianting.tian@linux.alibaba.com/
>> And patch 2,3 in the link:
>> https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-2-xianting.tian@linux.alibaba.com/
>> https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-3-xianting.tian@linux.alibaba.com/
>>
>> This patch series just put these patches together, and with two new patch 4, 5.
>> these five patches are the fixups for machine_kexec, kernel mode PC for vmcore
>> and improvements for vmcoreinfo and memory layout dump.
>>
>> The main changes in the five patchs as below,
>> Patch 1: use __smp_processor_id() instead of smp_processor_id() to cleanup
>>           the console prints.
>> Patch 2: Add VM layout, va bits, ram base to vmcoreinfo, which can simplify
>>           the development of crash tool as ARM64 already did
>>           (arch/arm64/kernel/crash_core.c).
>> Patch 3: Add modules to virtual kernel memory layout dump.
>> Patch 4: Fixup to get correct kernel mode PC for vmcore.
>> Patch 5: Updates vmcoreinfo.rst.
>>
>> With these 5 patches(patch 2 is must), crash tool can work well to analyze
>> a vmcore. The patches for crash tool for RISCV64 is in the link:
>> https://lore.kernel.org/linux-riscv/20220718025346.411758-1-xianting.tian@linux.alibaba.com/
>>
>> Changes v1 -> v2:
>>   1, remove the patch "Add a fast call path of crash_kexec()" from this series
>>   of patches, as it already applied to riscv git.
>>   https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/commit/?h=for-next&id=3f1901110a89b0e2e13adb2ac8d1a7102879ea98
>>   2, add 'Reviewed-by' based on the comments of v1.
>>
>> Xianting Tian (5):
>>    RISC-V: use __smp_processor_id() instead of smp_processor_id()
>>    RISC-V: Add arch_crash_save_vmcoreinfo support
>>    riscv: Add modules to virtual kernel memory layout dump
>>    RISC-V: Fixup getting correct current pc
>>    riscv64: crash_core: Export kernel vm layout, phys_ram_base
>>
>>   .../admin-guide/kdump/vmcoreinfo.rst          | 31 +++++++++++++++++++
>>   arch/riscv/kernel/Makefile                    |  1 +
>>   arch/riscv/kernel/crash_core.c                | 29 +++++++++++++++++
>>   arch/riscv/kernel/crash_save_regs.S           |  2 +-
>>   arch/riscv/kernel/machine_kexec.c             |  2 +-
>>   arch/riscv/mm/init.c                          |  4 +++
>>   6 files changed, 67 insertions(+), 2 deletions(-)
>>   create mode 100644 arch/riscv/kernel/crash_core.c
>>
>> --
>> 2.17.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
