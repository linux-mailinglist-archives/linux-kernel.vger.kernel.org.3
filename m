Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A2058F608
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 04:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbiHKCyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiHKCyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:54:32 -0400
Received: from out199-6.us.a.mail.aliyun.com (out199-6.us.a.mail.aliyun.com [47.90.199.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918BB883EC;
        Wed, 10 Aug 2022 19:54:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0VLxOlmu_1660186462;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VLxOlmu_1660186462)
          by smtp.aliyun-inc.com;
          Thu, 11 Aug 2022 10:54:23 +0800
Subject: Re: [PATCH V5 0/6] RISC-V fixups to work with crash tool
To:     Conor.Dooley@microchip.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        heiko@sntech.de, guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net
Cc:     kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        crash-utility@redhat.com, huanyi.xj@alibaba-inc.com,
        heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com,
        hschauhan@nulltrace.org, yixun.lan@gmail.com
References: <20220802121818.2201268-1-xianting.tian@linux.alibaba.com>
 <b79ab47e-a1e2-eb21-0611-bcbc8b7802c5@linux.alibaba.com>
 <b3184653-7ef4-eec3-9ef6-a8449fe24323@microchip.com>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <5afbd9b6-37c5-8a8d-6fdf-bca721ebd25e@linux.alibaba.com>
Date:   Thu, 11 Aug 2022 10:54:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <b3184653-7ef4-eec3-9ef6-a8449fe24323@microchip.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/8/10 上午5:24, Conor.Dooley@microchip.com 写道:
> On 09/08/2022 07:58, Xianting Tian wrote:
>> Hi Palmer
>>
>> Could you please help review this patch set?  thanks.
> Hey Xianting,
>
> Obviously I am not Palmer, but I left some comments on the
> patchset. Sorry for the delay in getting back onto you on your
> latest version, I got confused as to which versions I had reviewed.

You ever reviewed this version patch set,

https://lore.kernel.org/lkml/20220725014539.1037627-1-xianting.tian@linux.alibaba.com/ 
<https://lore.kernel.org/lkml/20220725014539.1037627-1-xianting.tian@linux.alibaba.com/>

>
> Conor.
>
>>   
>> Crash-utility patch set is ready(acked by HAGIO KAZUHITO), now waiting the kernel patch set merged firstly.
>>
>> 在 2022/8/2 下午8:18, Xianting Tian 写道:
>>> I ever sent the patch 1 in the link:
>>> https://patchwork.kernel.org/project/linux-riscv/patch/20220708073150.352830-3-xianting.tian@linux.alibaba.com/
>>> And patch 2,3 in the link:
>>> https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-2-xianting.tian@linux.alibaba.com/
>>> https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-3-xianting.tian@linux.alibaba.com/
>>>
>>> This patch set just put these patches together, and with three new patch 4, 5, 6.
>>> these six patches are the fixups for machine_kexec, kernel mode PC for vmcore
>>> and improvements for vmcoreinfo, memory layout dump and fixup chedule out issue
>>> in machine_crash_shutdown().
>>>
>>> The main changes in the six patchs as below,
>>> Patch 1: use __smp_processor_id() instead of smp_processor_id() to cleanup
>>>            the console prints.
>>> Patch 2: Add VM layout, va bits, ram base to vmcoreinfo, which can simplify
>>>            the development of crash tool as ARM64 already did
>>>            (arch/arm64/kernel/crash_core.c).
>>> Patch 3: Add modules to virtual kernel memory layout dump.
>>> Patch 4: Fixup to get correct kernel mode PC for vmcore.
>>> Patch 5: Updates vmcoreinfo.rst.
>>> Patch 6: Fixup schedule out issue in machine_crash_shutdown()
>>>
>>> With these six patches(patch 2 is must), crash tool can work well to analyze
>>> a vmcore. The patches for crash tool for RISCV64 is in the link:
>>> https://lore.kernel.org/linux-riscv/20220801043040.2003264-1-xianting.tian@linux.alibaba.com/
>>>
>>> ------
>>> Changes v1 -> v2:
>>>    1, remove the patch "Add a fast call path of crash_kexec()" from this series
>>>    of patches, as it already applied to riscv git.
>>>    https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/commit/?h=for-next&id=3f1901110a89b0e2e13adb2ac8d1a7102879ea98
>>>    2, add 'Reviewed-by' based on the comments of v1.
>>> Changes v2 -> v3:
>>>    use "riscv" instead of "riscv64" in patch 5 subject line.
>>> Changes v3 -> v4:
>>>    use "riscv" instead of "riscv64" in the summary of patch 5 subject line.
>>> Changes v4 -> v5:
>>>    add a new patch "RISC-V: Fixup schedule out issue in machine_crash_shutdown()"
>>>
>>> Xianting Tian (6):
>>>     RISC-V: use __smp_processor_id() instead of smp_processor_id()
>>>     RISC-V: Add arch_crash_save_vmcoreinfo support
>>>     riscv: Add modules to virtual kernel memory layout dump
>>>     RISC-V: Fixup getting correct current pc
>>>     riscv: crash_core: Export kernel vm layout, phys_ram_base
>>>     RISC-V: Fixup schedule out issue in machine_crash_shutdown()
>>>
>>>    .../admin-guide/kdump/vmcoreinfo.rst          | 31 +++++++++++++++++++
>>>    arch/riscv/kernel/Makefile                    |  1 +
>>>    arch/riscv/kernel/crash_core.c                | 29 +++++++++++++++++
>>>    arch/riscv/kernel/crash_save_regs.S           |  2 +-
>>>    arch/riscv/kernel/machine_kexec.c             | 28 ++++++++++++++---
>>>    arch/riscv/mm/init.c                          |  4 +++
>>>    6 files changed, 89 insertions(+), 6 deletions(-)
>>>    create mode 100644 arch/riscv/kernel/crash_core.c
>>>
