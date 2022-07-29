Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD695849B2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbiG2CXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiG2CX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:23:29 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2619E7AB09
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:23:27 -0700 (PDT)
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn9GcRONiRspAAA--.45504S3;
        Fri, 29 Jul 2022 10:23:25 +0800 (CST)
Subject: Re: [PATCH v3 0/4] LoongArch: Support new relocation types
To:     Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev
References: <bb7824d39a694b13069718c2b8193379f79229b4.camel@xry111.site>
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jinyang He <hejinyang@loongson.cn>
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <879dc428-0407-3280-617d-840352aa6d08@loongson.cn>
Date:   Fri, 29 Jul 2022 10:23:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <bb7824d39a694b13069718c2b8193379f79229b4.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxn9GcRONiRspAAA--.45504S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1xCFyxtr48JrWrJFW5ZFb_yoW8uw13pr
        9xCrn5JFZ7Grn3Xa1aq3WUWF15Ga97G3yaqay3t34rArnxXF1UCF15tw15AFy7Xws3KF40
        gFyaga409a1UAwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjc
        xK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxv
        r21lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
        UI43ZEXa7IU5Ssj5UUUUU==
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao

On 07/29/2022 10:07 AM, Xi Ruoyao wrote:
> The version 2.00 of LoongArch ELF ABI specification introduced new
> relocation types, and the development tree of Binutils and GCC has
> started to use them.  If the kernel is built with the latest snapshot of
> Binutils or GCC, it will fail to load the modules because of unrecognized
> relocation types in modules.
>
> Add support for GOT and new relocation types for the module loader, so
> the kernel (with modules) can be built with the "normal" code model and
> function properly.
>
> This series does not break the compatibility with old toolchain using
> stack-based relocation types, so with the patches applied the kernel can
> be be built with both old and new toolchains.
>
> Tested by building the kernel with both Binutils & GCC master branch and
> my system Binutils & GCC (without new relocation type support), running
> both the builds with 35 in-tree modules loaded, and loading one module
> with 20 GOT loads (loaded addresses verified by comparing with
> /proc/kallsyms).
>
> Changes from v2 to v3:
>
> - Use `union loongarch_instruction` instead of explicit bit shifts
>   applying the relocation.  Suggested by Youling.
> - For R_LARCH_B26, move the alignment check before the range check to be
>   consistent with stack pop relocations.  Suggested by Youling.
> - Reword the commit message of the 3rd patch.  Suggested by Huacai.

The log of changes from v1 to v2 should be preserved.

Thanks,
Youling
>
> Xi Ruoyao (4):
>   LoongArch: Add section of GOT for kernel module
>   LoongArch: Support R_LARCH_SOP_PUSH_GPREL relocation type in kernel
>     module
>   LoongArch: Remove -fplt and -Wa,-mla-* from CFLAGS
>   LoongArch: Support modules with new relocation types
>
>  arch/loongarch/Makefile                 |  4 --
>  arch/loongarch/include/asm/elf.h        | 37 ++++++++++
>  arch/loongarch/include/asm/module.h     | 23 ++++++
>  arch/loongarch/include/asm/module.lds.h |  1 +
>  arch/loongarch/kernel/head.S            | 10 +--
>  arch/loongarch/kernel/module-sections.c | 51 +++++++++++--
>  arch/loongarch/kernel/module.c          | 96 +++++++++++++++++++++++++
>  7 files changed, 209 insertions(+), 13 deletions(-)
>

