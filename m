Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A63C4C8B1F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 12:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbiCALwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 06:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiCALwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:52:17 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AFA581180;
        Tue,  1 Mar 2022 03:51:35 -0800 (PST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn8+7CB5iY2MAAA--.2269S3;
        Tue, 01 Mar 2022 19:51:23 +0800 (CST)
Subject: Re: [PATCH v4 0/4] MIPS: Modify mem= and memmap= parameter
To:     Mike Rapoport <rppt@kernel.org>
References: <1646108941-27919-1-git-send-email-yangtiezhu@loongson.cn>
 <Yh3tgr+g/6IElq0P@kernel.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <cfd74b5b-39c3-733a-5226-515991f91f39@loongson.cn>
Date:   Tue, 1 Mar 2022 19:51:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <Yh3tgr+g/6IElq0P@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxn8+7CB5iY2MAAA--.2269S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw18Jr1DCr45uFW7Xr4rGrg_yoW8Ww17pw
        1Sqayayr4kXr1IvF1I9w1xXry5Jw18tr97Gry2yrWrCr4YkF1Iqr4xXan5ZFyqv34fGa47
        WrsxtF909w1UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxkIecxEwVAFwVW8KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
        UI43ZEXa7VUjDKsUUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/01/2022 05:55 PM, Mike Rapoport wrote:
> Hi,
>
> On Tue, Mar 01, 2022 at 12:28:57PM +0800, Tiezhu Yang wrote:
>> In the current code, the kernel command-line parameter mem= and memmap=
>> can not work well on MIPS, this patchset refactors the related code to
>> fix them.
>>
>> For kdump on MIPS, if the users want to limit the memory region for the
>> capture kernel to avoid corrupting the memory image of the panic kernel,
>> use the parameter memmap=limit@base is the proper way, I will submit a
>> patch to use memmap=limit@base for kexec-tools after this patchset is
>> applied.
>
> Sorry, apparently I misread the prevoius version.
> What's wrong with the current implementation of mem=limit@base for the
> kdump case?

In the current code, without this patchset, kernel boot hangs when add
mem=3G, mem=3G@64M or memmap=3G@64M to the command-line, it means that
the parameter mem= and memmap= have bug on mips.

Thanks,
Tiezhu

>
>> v4: Fix some build warnings reported by kernel test robot
>>
>> v3: Modify patch #3 to maintain compatibility for memmap=limit{$,#,!}base,
>>     commented by Mike Rapoport, thank you
>>
>> v2: Add some new patches to support memmap=limit@base
>>
>> Tiezhu Yang (4):
>>   MIPS: Refactor early_parse_mem() to fix mem= parameter
>>   memblock: Introduce memblock_mem_range_remove_map()
>>   MIPS: Refactor early_parse_memmap() to fix memmap= parameter
>>   MIPS: Remove not used variable usermem
>>
>>  arch/mips/kernel/setup.c | 69 ++++++++++++++++++++++--------------------------
>>  include/linux/memblock.h |  1 +
>>  mm/memblock.c            |  9 +++++--
>>  3 files changed, 40 insertions(+), 39 deletions(-)
>>
>> --
>> 2.1.0
>>
>

