Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C5255C9AB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240070AbiF1AO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 20:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiF1AOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 20:14:54 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC8A6636F;
        Mon, 27 Jun 2022 17:14:52 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxb0_1R7pixpBgAA--.6993S3;
        Tue, 28 Jun 2022 08:14:46 +0800 (CST)
Subject: Re: [PATCH v2] MIPS: Loongson64: Fix section mismatch warning
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <1656313633-1713-1-git-send-email-yangtiezhu@loongson.cn>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <a93e5cbe-deb8-c760-685a-6d3171d651f3@loongson.cn>
Date:   Tue, 28 Jun 2022 08:14:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1656313633-1713-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxb0_1R7pixpBgAA--.6993S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF15uF4xWFyrGF4ktrWDurg_yoW8ArWxpa
        yrCw4UWr4rKr4kJ3Z3GryUZryxJa4rGFZ3A3y7CrykXrZFg3sYvr1IkF48ZFyDtr1FyF4r
        XFn3WrZ5Z3W0yrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CE
        bIxvr21lc2xSY4AK67AK6w1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
        UI43ZEXa7VUU_cTDUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc Masahiro Yamada <masahiroy@kernel.org>

On 06/27/2022 03:07 PM, Tiezhu Yang wrote:
> prom_init_numa_memory() is annotated __init and not used by any module,
> thus don't export it.
>
> Remove not needed EXPORT_SYMBOL for prom_init_numa_memory() to fix the
> following section mismatch warning:
>
>   LD      vmlinux.o
>   MODPOST vmlinux.symvers
> WARNING: modpost: vmlinux.o(___ksymtab+prom_init_numa_memory+0x0): Section mismatch in reference
> from the variable __ksymtab_prom_init_numa_memory to the function .init.text:prom_init_numa_memory()
> The symbol prom_init_numa_memory is exported and annotated __init
> Fix this by removing the __init annotation of prom_init_numa_memory or drop the export.
>
> This is build on Linux 5.19-rc4.
>
> Fixes: 6fbde6b492df ("MIPS: Loongson64: Move files to the top-level directory")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>
> v2: update the commit message and add Fixes tag
>
>  arch/mips/loongson64/numa.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/mips/loongson64/numa.c b/arch/mips/loongson64/numa.c
> index 69a5331..8f61e93 100644
> --- a/arch/mips/loongson64/numa.c
> +++ b/arch/mips/loongson64/numa.c
> @@ -196,7 +196,6 @@ void __init prom_init_numa_memory(void)
>  	pr_info("CP0_PageGrain: CP0 5.1 (0x%x)\n", read_c0_pagegrain());
>  	prom_meminit();
>  }
> -EXPORT_SYMBOL(prom_init_numa_memory);
>
>  pg_data_t * __init arch_alloc_nodedata(int nid)
>  {
>

Hi Masahiro,

Please review this patch, I think it is related with the following 
issue, thank you.

https://lore.kernel.org/lkml/CAHk-=wgcsUU-TNoLS7Q6YF3RCSVAKwNM7gFOwqnPQTiU_oGEWA@mail.gmail.com/

Thanks,
Tiezhu

